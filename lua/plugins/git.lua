return {
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", ":DiffviewOpen<cr>", desc = "Diffview" },
        },
    },
    {
        "julienvincent/hunk.nvim",
        cmd = { "DiffEditor" },
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            require("hunk").setup()
        end,
    },
    { "rafikdraoui/jj-diffconflicts" },
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
            signcolumn = false, -- Don't use a separate sign column
            numhl = true, -- Highlight line number
            linehl = false,
            word_diff = false,
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
}
