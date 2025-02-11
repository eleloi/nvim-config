-- Run tests, don't have used it yet

return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  cmd = { "TestFile", "TestNearest", "TestLast", "TestSuite", "TestVisit" },
  keys = {
    { "<leader>tf", ":TestFile<cr>",    desc = "TestFile" },
    { "<leader>tn", ":TestNearest<cr>", desc = "TestNearest" },
    { "<leader>tl", ":TestLast<cr>",    desc = "TestLast" },
    { "<leader>ts", ":TestSuite<cr>",   desc = "TestSuite" },
    { "<leader>tv", ":TestVisit<cr>",   desc = "TestVisit" },
  },
  config = function()
    vim.g["test#strategy"] = "vimux"
  end,
}
