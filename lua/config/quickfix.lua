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

vim.keymap.set("n", "<C-q>", Toggle_qf)

vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
