return {
  "j-morano/buffer_manager.nvim",
  keys = {
    {
      "<leader>.",
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
      desc = "Buffer List",
    },
  },
}
