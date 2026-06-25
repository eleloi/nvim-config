local th = require("config.theme")

local function map(m, k, v, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(m, k, v, opts)
end
--
-- quickfix toggle
local function isQfOpened()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      return true
    end
  end
  return false
end

function Toggle_qf()
  print("Toggle qf")
  local qf_exists = false
  print("qf_exists: " .. tostring(qf_exists))
  if isQfOpened() then
    vim.cmd("cclose")
    return
  end
  vim.cmd("copen")
end

-- set leader
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>z", "<cmd>w<CR>", { desc = "save" })
map("n", "<leader>Z", "<cmd>noautocmd w<CR>", { desc = "save without format" })
map("i", "jk", "<ESC>") -- exit insert mode with jk

map("n", "<leader>p", th.switch_theme, { desc = "cycle themes" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search

-- navigation
-- zz centering
map("n", "<c-d>", "<c-d>zz") -- scroll down with centering
map("n", "<c-u>", "<c-u>zz") -- scroll up with centering
map("n", "n", "nzzzv")       -- center after search
map("n", "n", "nzzzv")       -- center after search
-- tabs
map("n", "]t", "<cmd>tabnext<cr>", { desc = "next tab" })
map("n", "[t", "<cmd>tabprev<cr>", { desc = "previous tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "only tab" })
-- buffers
map("n", "<leader>bd", ":lua Snacks.bufdelete()<cr>", { desc = "delete current buffer" })
map("n", "<leader>bD", "<cmd>bufdo bdelete<cr>", { desc = "delete all buffers" })
-- window navigation
map("n", "<c-w>|", "<cmd>vsplit<cr>", { desc = "vertical split" })
map("n", "<c-w>-", "<cmd>split<cr>", { desc = "horizontal split" })
map("n", "<c-w><c-l>", "<cmd>vertical resize +5<cr>", { desc = "vertical resize +" })
map("n", "<c-w><c-h>", "<cmd>vertical resize -5<cr>", { desc = "vertical resize -" })
map("n", "<c-w><c-j>", "<cmd>resize +5<cr>", { desc = "resize +" })
map("n", "<c-w><c-k>", "<cmd>resize -5<cr>", { desc = "resize -" })
map("n", "<leader>o", "<cmd>only<cr>") -- only
-- quickfix
map("n", "]q", "<cmd>cnext<cr>zz", { desc = "next quickfix" })
map("n", "[q", "<cmd>cprev<cr>zz", { desc = "previous quickfix" })
-- diagnostics
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "previous diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "next diagnostic" })
-- flash
map({ "n", "o", "x" }, "s", function()
  require("flash").jump()
end, { desc = "flash" })
map({ "n", "o", "x" }, "S", function()
  require("flash").treesitter()
end, { desc = "flash treesitter" })
-- tmux
map({ "v", "n" }, "<c-h>", "<cmd>tmuxnavigateleft<cr>", { desc = "tmux navigate left" })
map({ "v", "n" }, "<c-j>", "<cmd>tmuxnavigatedown<cr>", { desc = "tmux navigate down" })
map({ "v", "n" }, "<c-k>", "<cmd>tmuxnavigateup<cr>", { desc = "tmux navigate up" })
map({ "v", "n" }, "<c-l>", "<cmd>tmuxnavigateright<cr>", { desc = "tmux navigate right" })
-- quickfix
map("n", "<C-q>", Toggle_qf, { desc = "toggle quickfix" })

-- text editing
-- move lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up" })
-- easy-align
map({ "n", "v" }, "ga", ":EasyAlign<CR>", { desc = "easy align" })
-- splitjoin
map("n", "<leader>j", function()
  require("mini.splitjoin").toggle()
end, { desc = "split-join" })

-- yank, copy
-- copy current file path
map("n", "<leader>P", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.notify("Path copied to clipboard: " .. vim.fn.expand("%:p"), vim.log.levels.INFO)
end, { desc = "copy current file path" })
-- yank buffer
map("n", "<leader>Y", "<cmd>%y+<CR>", { desc = "yank buffer" })
-- search and replace
map("n", "<leader>*", "<cmd>GrugFar<CR>", { desc = "search and replace" })
map("v", "<leader>*", function()
  require("grug-far").with_visual_selection({
    transient = true,
    startInInsertMode = false,
    startCursorRow = 1,
  })
end, { desc = "search and replace" })
-- select and replace all in file
map("v", "<leader>r", "y:%s/<C-r>\"//g<Left><Left>", { desc = "select and replace all in file" })

-- exit terminal mode
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "<A-e>", "<C-\\><C-n>")

-- folds
map("n", "z1", "zMzr", { desc = "fold 1" })
map("n", "z2", "zMzrzr", { desc = "fold 2" })
map("n", "z3", "zMzrzrzr", { desc = "fold 3" })
map("n", "z4", "zMzrzrzrzr", { desc = "fold 4" })
map("n", "z5", "zMzrzrzrzrzr", { desc = "fold 5" })

-- fzf and grep
-- fils
map("n", "<leader>ff", fzf_files, { desc = "find files" })
map("n", "<leader>fF", fzf_allfiles, { desc = "find all files" })
map("n", "<leader>fa", fzf_samedir, { desc = "find files in same dir" })
map("n", "<leader>fr", fzf_resume, { desc = "resume last search" })
-- grep
map("n", "<leader>fg", ":lua require('fzf-lua').live_grep()<CR>", { desc = "grep" })
map("n", "<leader>fw", ":lua require('fzf-lua').grep_cword()<CR>", { desc = "grep word under cursor" })
map("v", "<leader>fw", ":lua require('fzf-lua').grep_visual()<CR>", { desc = "grep visual selection" })
-- buffers
map("n", "<leader>,", ":lua require('fzf-lua').buffers({})<CR>", { desc = "buffers" })
-- jj
map("n", "<leader>.", ":lua require('fzf-lua').jj_files({})<CR>", { desc = "jj files" })
-- lsp
map("n", "gr", ":lua require('fzf-lua').lsp_references()<CR>", { desc = "lsp references" })
map("n", "gd", ":lua require('fzf-lua').lsp_definitions()<CR>", { desc = "lsp definitions" })
map("n", "gi", ":lua require('fzf-lua').lsp_implementations()<CR>", { desc = "lsp implementations" })
map("n", "gt", ":lua require('fzf-lua').lsp_typedefs()<CR>", { desc = "lsp type definitions" })
map("n", "<leader>ca", ":lua require('fzf-lua').lsp_code_actions()<CR>", { desc = "lsp code actions" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "lsp rename" })

map("n", "<leader>fs", ":lua require('fzf-lua').lsp_document_symbols()<CR>", { desc = "lsp document symbols" })
map(
  "n",
  "<leader>fS",
  ":lua require('fzf-lua').lsp_live_workspace_symbols()<CR>",
  { desc = "lsp live workspace symbols" }
)
map("n", "<leader>fd", ":lua require('fzf-lua').lsp_document_diagnostics()<CR>", { desc = "lsp document diagnostics" })
map(
  "n",
  "<leader>fD",
  ":lua require('fzf-lua').lsp_workspace_diagnostics()<CR>",
  { desc = "lsp workspace diagnostics" }
)
map(
  "n",
  "<leader>fc",
  ":lua require('fzf-lua').lsp_workspace_diagnostics()<CR>",
  { desc = "lsp workspace diagnostics" }
)
map("n", "<leader>lc", ":lua print(vim.inspect(vim.lsp.get_clients()))<CR>", { desc = "active lsp clients" })
map("n", "<leader>li", ":checkhealth lsp<CR>", { desc = "lsp info" })
map("n", "<leader>lr", ":lsp restart<CR>", { desc = "lsp restart" })
-- colorschemes
map("n", "<leader>fc", ":lua require('fzf-lua').colorschemes()<CR>", { desc = "colorschemes" })
-- undo
map("n", "<leader>fu", "<cmd>UndotreeToggle<CR>", { desc = "undo" })

-- file-explorer
map("n", "<leader>e", "<cmd>Yazi<CR>", { desc = "file-explorer" })

-- notifications
map("n", "<leader>nn", ":lua Snacks.notifier.show_history()<CR>", { desc = "show notifications" })
map("n", "<leader>un", ":lua Snacks.notifier.hide()<CR>", { desc = "Notifications" })

-- toggle
if _G.toggle_vertical_bar then
  _G.toggle_vertical_bar:map("<leader>ub")
end

if _G.toggle_codeium then
  _G.toggle_codeium:map("<leader>uc")
end

if _G.toggle_completion then
  _G.toggle_completion:map("<leader>u/")
end

if _G.toggle_diagnostics then
  _G.toggle_diagnostics:map("<leader>ud")
end

if _G.toggle_inlay_hints then
  _G.toggle_inlay_hints:map("<leader>ui")
end
