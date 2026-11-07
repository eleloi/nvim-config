-- Oil: file explorer (replaces netrw and yazi)

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons", -- dependency
})

local M = {}

local MAX_WIDTH = 200
local PADDING = 2
-- Minimum width for the float to be split side by side with the preview
local MIN_WIDTH_FOR_SIDE_BY_SIDE = 120

-- Keep only the tail of long paths so the window title stays readable
local function shorten_path(path)
  if #path > 20 then
    return "…" .. path:sub(-17)
  end
  return path
end

-- Width of the oil float, mirroring oil's own calculation
local function float_width()
  local width = vim.o.columns - 2 * PADDING - 2 -- border consumes one column per side
  return math.min(width, MAX_WIDTH)
end

-- Preview on the right when there is horizontal room, below when the window is narrow
local function preview_split()
  return float_width() >= MIN_WIDTH_FOR_SIDE_BY_SIDE and "right" or "below"
end

require("oil").setup({
  -- Take over directory buffers (netrw)
  default_file_explorer = true,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  -- Renaming/moving a file asks the LSP to update imports and saves the result
  lsp_file_methods = {
    enabled = true,
    autosave_changes = true,
  },
  -- Editing the buffer is enough, no confirmation popups
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = false,
  keymaps = {
    ["q"] = { "actions.close", mode = "n" },
  },
  view_options = {
    show_hidden = true,
  },
  float = {
    max_width = MAX_WIDTH,
    border = "rounded",
    preview_split = preview_split(),
    get_win_title = function(winid)
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
      local _, path = require("oil.util").parse_url(bufname)
      local title = path and vim.fn.fnamemodify(path, ":~") or bufname
      return shorten_path(title)
    end,
  },
  preview_win = {
    update_on_cursor_moved = true,
  },
})

---Open the file explorer as a float with a live preview
M.open = function()
  -- Recompute on every open, the editor may have been resized
  require("oil.config").float.preview_split = preview_split()
  require("oil").open_float(nil, { preview = { vertical = true } })
end

return M
