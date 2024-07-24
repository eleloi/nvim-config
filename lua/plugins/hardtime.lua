local function enable()
	vim.g.hardtime_enabled = true
	require("hardtime").enable()
end

local function disable()
	vim.g.hardtime_enabled = false
	require("hardtime").disable()
end

local function toggle()
	if vim.g.hardtime_enabled then
		disable()
	else
		enable()
	end
end

return {
	"m4xshen/hardtime.nvim",
	keys = {
		{
			"<leader>ht",
			toggle,
			desc = "⚒️  Toggle Hardtime!",
		},
	},
	config = true,
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
}
