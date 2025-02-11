local config = require("config.plugins.telescope")

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.3",
  dependencies = {
    "MaximilianLloyd/adjacent.nvim",
    "fdschmidt93/telescope-egrepify.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    "piersolenski/telescope-import.nvim",
    "stevearc/aerial.nvim",
    "debugloop/telescope-undo.nvim",
    "jmacadie/telescope-hierarchy.nvim",
  },
  event = "VeryLazy",
  keys = config.keys,
  config = function()
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")

    require("telescope").setup({
      defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",

        winblend = 0,

        layout_strategy = "horizontal",
        layout_config = {
          width = 0.95,
          height = 0.85,
          prompt_position = "bottom",

          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.5)
              else
                return math.floor(cols * 0.7)
              end
            end,
          },

          vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
          flex = { horizontal = { preview_width = 0.9 } },
        },

        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        color_devicons = true,

        mappings = {
          i = {
            ["<C-n>"] = "move_selection_next",
            ["<M-p>"] = action_layout.toggle_preview,
            ["<M-m>"] = action_layout.toggle_mirror,
            ["<C-k>"] = actions.cycle_history_next,
            ["<C-j>"] = actions.cycle_history_prev,
          },
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })
    require("telescope").load_extension("media_files")
    require("telescope").load_extension("adjacent")
    require("telescope").load_extension("import")
    require("telescope").load_extension("egrepify")
    require("telescope").load_extension("aerial")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("hierarchy")

    require("aerial").setup()
  end,
}
