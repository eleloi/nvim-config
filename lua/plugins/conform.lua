vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local formatters = {
  css = { "prettierd" },
  html = { "prettierd" },
  json = { "jq" },
  kdl = { "kdlfmt" },
  lua = { "stylua" },
  markdown = { "prettierd" },
  nix = { "nixfmt" },
  typ = { "typstyle" },
  typescript = { "prettierd" },
  typescriptreact = { "prettierd" },
  typst = { "typstyle" },
  nu = { "nufmt" },
}

require("conform").setup({
  formatters_by_ft = formatters,
  formatters = {
    nufmt = {
      command = "nufmt",
      args = { "--stdin" },
      stdin = true,
    },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
  format_on_save = {
    timeout_ms = 1000,
  },
})
