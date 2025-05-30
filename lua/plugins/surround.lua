-- Add, delete, change surroundings

return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      highlight_duration = 500,
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = "ys",      -- Add surrounding in Normal and Visual modes
        delete = "ds",   -- Delete surrounding
        replace = "cs",  -- Replace surrounding
        find = "",       -- Find surrounding (to the right)
        find_left = "",  -- Find surrounding (to the left)
        highlight = "",  -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },
    })
  end,
}
