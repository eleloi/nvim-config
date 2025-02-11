-- A Neovim plugin that provides an explanation for regular expressions.

return {
  "tomiis4/Hypersonic.nvim",
  cmd = "Hypersonic",
  keys = {
    { "<leader>ch", "<cmd>Hypersonic<cr>", desc = "Regex Analisys" },
  },
}
