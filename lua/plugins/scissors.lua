return {
  "chrisgrieser/nvim-scissors",
  opts = {
    snippetDir = "~/.config/nvim/snippets",
  },
  keys = {
    { "<leader>se", "<CMD>ScissorsEditSnippet<CR>",   desc = "Edit Snippet" },
    { "<leader>sn", "<CMD>ScissorsAddNewSnippet<CR>", desc = "Add Snippet", mode = { "n", "x" } },
  },
}
