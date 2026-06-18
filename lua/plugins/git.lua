vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/wintermute-cell/gitignore.nvim",
  "https://github.com/rafikdraoui/jj-diffconflicts",
  "https://github.com/julienvincent/hunk.nvim",     -- to use in conjuntion with jj
  "https://github.com/MunifTanjim/nui.nvim",        -- dependency of Hunk
  "https://github.com/nvim-tree/nvim-web-devicons", -- dependency of Hunk
  "https://github.com/avm99963/vim-jjdescription",  -- jj syntax highlight
})

require("gitsigns").setup({
  signcolumn = false, -- Don't use a separate sign column
  numhl = true,       -- Highlight line number
  linehl = false,
  word_diff = false,
  max_file_length = 10000,
})

require("hunk").setup()
