-- "tpope/vim-fugitive": Fugitive don't need explanation
--
-- "sindrets/diffview.nvim": A global view of git diff, alternative to fuggitive,
-- I don't be convinced yet.
--
-- "lewis6991/gitsigns.nvim": Plugin for displaying Git signs like added,
-- modified , and removed lines in the sign column.
--
-- "junegunn/gv.vim": Git commit browser, GV! view the commits affecting
-- current file, GV? view in quickfix list
--
-- "rbong/vim-flog": Git branch viewer like git graph

return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", ":DiffviewOpen<cr>", desc = "Diffview" },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    event = "VeryLazy",
    keys = {
      { "<leader>gg", ":tab Git<CR>", desc = "Git" },
    },
    config = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          vim.g.bufhidden = "delete"
        end,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = false,
      numhl = true,
      max_file_length = 10000,
    },
  },
  {
    "junegunn/gv.vim",
    dependencies = {
      "tpope/vim-fugitive",
    },
    cmd = { "GV" },
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    keys = {
      { "<leader>gl", ":Flog<CR>", desc = "Flog" },
    },
  },
}
