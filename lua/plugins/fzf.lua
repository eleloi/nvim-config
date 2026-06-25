vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local function disable_blink_maps()
  for _, key in ipairs({ "<C-n>", "<C-p>", "<C-j>", "<C-k>" }) do
    pcall(vim.keymap.del, "t", key, { buffer = true })
    pcall(vim.keymap.del, "i", key, { buffer = true })
  end
end

require("fzf-lua").setup({

  -- Eldritch theme requirements for use with transparent
  fzf_colors = {
    true,
    bg = "-1",
    gutter = "-1",
  },

  fzf_opts = {
    ["--algo"] = "v2",
  },
  winopts = {
    on_create = function()
      vim.b.completion = false
      vim.schedule(disable_blink_maps)
    end,
  },
  keymap = {
    builtin = {
      ["<M-Esc>"]  = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
      ["<F1>"]     = "toggle-help",
      ["<c-f>"]    = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]     = "toggle-preview-wrap",
      ["<c-p>"]    = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<c-r>"]    = "toggle-preview-cw",
      -- Preview toggle behavior default/extend
      ["<F6>"]     = "toggle-preview-behavior",
      -- `ts-ctx` binds require `nvim-treesitter-context`
      ["<F7>"]     = "toggle-preview-ts-ctx",
      ["<F8>"]     = "preview-ts-ctx-dec",
      ["<F9>"]     = "preview-ts-ctx-inc",
      ["<S-Left>"] = "preview-reset",
      ["<S-down>"] = "preview-page-down",
      ["<S-up>"]   = "preview-page-up",
      ["<S-j>"]    = "preview-down",
      ["<S-k>"]    = "preview-up",
    },
    fzf = {
      -- fzf '--bind=' options
      -- true,        -- uncomment to inherit all the below in your custom config
      ["ctrl-z"]     = "abort",
      ["ctrl-u"]     = "unix-line-discard",
      ["ctrl-f"]     = "half-page-down",
      ["ctrl-b"]     = "half-page-up",
      ["ctrl-a"]     = "beginning-of-line",
      ["ctrl-e"]     = "end-of-line",
      ["alt-a"]      = "toggle-all",
      ["alt-g"]      = "first",
      ["alt-G"]      = "last",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]         = "toggle-preview-wrap",
      ["f4"]         = "toggle-preview",
      ["shift-down"] = "preview-page-down",
      ["shift-up"]   = "preview-page-up",
      ["ctrl-q"]     = "select-all+accept",
    },
  },
})

_G.fzf_files = function()
  require("fzf-lua").files()
end

_G.fzf_allfiles = function()
  require("fzf-lua").files({
    fd_opts = [[ --no-ignore-vcs --hidden --exclude .git/ --exclude .jj/ ]],
  })
end

_G.fzf_samedir = function()
  local current_file_path = vim.fs.dirname(vim.fn.expand("%:p"))
  require("fzf-lua").files({ cwd = current_file_path })
end

_G.fzf_resume = function()
  require("fzf-lua").resume()
end
