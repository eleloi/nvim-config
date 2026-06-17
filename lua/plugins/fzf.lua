vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

local function disable_blink_maps()
    for _, key in ipairs({ "<C-n>", "<C-p>", "<C-j>", "<C-k>" }) do
        pcall(vim.keymap.del, "t", key, { buffer = true })
        pcall(vim.keymap.del, "i", key, { buffer = true })
    end
end

require("fzf-lua").setup({
    fzf_opts = {
        ["--algo"] = "v2",
    },
    winopts = {
        on_create = function()
            vim.b.completion = false
            vim.schedule(disable_blink_maps)
        end,
    },
})

_G.fzf_files = function()
    require("fzf-lua").files()
end

_G.fzf_allfiles = function()
    require("fzf-lua").files({
        fd_opts = [[ --no-ignore-vcs --hidden --exclude .git/ --exclude .jj/ ]],
    })
end

_G.fzf_samedir = function()
    local current_file_path = vim.fs.dirname(vim.fn.expand("%:p"))
    require("fzf-lua").files({ cwd = current_file_path })
end

_G.fzf_resume = function()
    require("fzf-lua").resume()
end
