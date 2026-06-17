vim.cmd("syntax on")

local options = {
    autoread = true,
    nu = true,
    relativenumber = true,
    numberwidth = 3,
    ignorecase = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    wrap = false,
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    incsearch = true,
    termguicolors = true,
    scrolloff = 8,
    signcolumn = "yes",
    updatetime = 50,
    colorcolumn = "80",
    clipboard = "unnamedplus",
    foldlevel = 99,
    foldlevelstart = 99,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Clipboard over SSH: use OSC52 (requires terminal support + tmux allow-passthrough)
vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

-- explicit python3 path
vim.g.python3_host_prog = "/usr/bin/python3"

-- diagnostics virtual text
vim.diagnostic.config({
    virtual_text = {
        spacing = 4,
        prefix = "■ ",
        source = "if_many",
        -- severity = vim.diagnostic.severity.ERROR,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
})
