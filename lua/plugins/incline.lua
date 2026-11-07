-- Floating statuslines for Neovim

vim.pack.add({
  "https://github.com/b0o/incline.nvim",
})

require("incline").setup({

  hide = {
    -- Hide the tag when the cursor reaches the line it sits on
    cursorline = true,
  },
  window = {
    placement = {
      vertical = "top",
      horizontal = "right",
    },
    margin = { horizontal = 0, vertical = 0 },
    padding = 0,
  },
  render = function(props)
    local full_path = vim.api.nvim_buf_get_name(props.buf)
    local filename = vim.fn.fnamemodify(full_path, ":t")

    if filename == "" then
      return { { "[No Name]", gui = "italic" } }
    end

    local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
    local modified = vim.bo[props.buf].modified and " [+]" or ""

    return {
      { (ft_icon or "") .. " ", guifg = ft_color },
      { filename,               gui = "bold" },
      { modified,               guifg = "#e67e80" },
      { " ",                    guibg = "none" },
    }
  end,
})
