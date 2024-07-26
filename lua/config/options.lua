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

-- keymaps
vim.g.mapleader = " "

vim.leader = "<Space>"
vim.keymap.set("n", "<Leader>ww", "<cmd>w<CR>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "[Q", "<cmd>cfirst<CR>zz")
vim.keymap.set("n", "]Q", "<cmd>clast<CR>zz")
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>")
vim.keymap.set("n", "[t", "<cmd>tabprev<CR>")
vim.keymap.set("n", "]T", "<cmd>tablast<CR>")
vim.keymap.set("n", "[T", "<cmd>tabfirst<CR>")

-- move lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- window navigation
vim.keymap.set("n", "<C-w>|", "<cmd>vsplit<CR>")
vim.keymap.set("n", "<C-w>-", "<cmd>split<CR>")
vim.keymap.set("n", "<C-w><C-l>", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "<C-w><C-h>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<C-w><C-j>", "<cmd>resize +5<CR>")
vim.keymap.set("n", "<C-w><C-k>", "<cmd>resize -5<CR>")

-- move visual lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
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
