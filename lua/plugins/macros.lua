return {
    "sahilsehwag/macrobank.nvim",
    keys = {
        { "<leader>m",  "<cmd>MacroBankPlay<cr>", desc = "Play macro" },
        { "<leader>fm", "<cmd>MacroBank<cr>",     desc = "Macro Bank" },
    },
    config = function()
        require("macrobank").setup()
    end,
}
