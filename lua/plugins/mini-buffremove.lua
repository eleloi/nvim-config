-- remove buffer without killing window

local function delete_buffers_but_current()
	local bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, i in ipairs(bufs) do
		if i ~= current_buf then
			vim.api.nvim_buf_delete(i, {})
		end
	end
end

return {
	"echasnovski/mini.bufremove",
	version = "*",
	event = "VeryLazy",
	keys = {
		{
			"<leader>bd",
			function()
				require("mini.bufremove").delete(0, false)
			end,
			desc = "Buffer delete",
			mode = "n",
		},
		{
			"<leader>bD",
			delete_buffers_but_current,
			desc = "Buffer delete all",
			mode = "n",
		},
		{
			"]b",
			"<CMD>bNext<CR>",
			desc = "Buffer next",
			mode = "n",
		},
		{
			"[b",
			"<CMD>bprevious<CR>",
			desc = "Buffer previous",
			mode = "n",
		},
		{
			"]B",
			"<CMD>blast<CR>",
			desc = "Buffer last",
			mode = "n",
		},
		{
			"[B",
			"<CMD>bfirst<CR>",
			desc = "Buffer first",
			mode = "n",
		},
	},
	config = true,
}
