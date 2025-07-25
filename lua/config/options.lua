vim.cmd("syntax on")
vim.opt.autoread = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3

vim.opt.ignorecase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.clipboard = "unnamedplus"

-- highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = false}")

-- explicit python3 path
vim.g.python3_host_prog = "/usr/bin/python3"

-- keymaps
vim.g.mapleader = " "

vim.leader = "<Space>"
vim.keymap.set("n", "<leader>z", "<cmd>w<CR>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprev<CR>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- window navigation
vim.keymap.set("n", "<C-w>|", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<C-w>-", "<cmd>split<CR>")
vim.keymap.set("n", "<C-w><C-l>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-w><C-h>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-w><C-j>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<C-w><C-k>", "<cmd>resize -5<CR>")

-- only
vim.keymap.set("n", "<leader>o", "<CMD>only<CR>")

-- repace all instances of word under cursor
vim.keymap.set("n", "<C-s>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>")

-- exit terminal mode
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-e>", "<C-\\><C-n>")

-- yank buffer
vim.keymap.set("n", "<leader>Y", "<cmd>%y+<CR>")

-- reload configuration
vim.keymap.set("n", "<leader>R", ":so $MYVIMRC<CR>")

-- detect typ files as typst instead of sql
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.typ" },
	callback = function()
		vim.bo.filetype = "typst"
	end,
})

-- detect hurl files as hurl instead of conf
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.hurl" },
	callback = function()
		vim.bo.filetype = "hurl"
	end,
})

-- fold
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
-- fix bug with blink
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 6
vim.keymap.set("n", "z1", "zMzr")
vim.keymap.set("n", "z2", "zMzrzr")
vim.keymap.set("n", "z3", "zMzrzrzr")
vim.keymap.set("n", "z4", "zMzrzrzrzr")
vim.keymap.set("n", "z5", "zMzrzrzrzrzr")
