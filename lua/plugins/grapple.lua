local keys = {}
local binds = 9

for i = 1, binds do
	table.insert(keys, {
		string.format("<leader>%s", i),
		function()
			require("grapple").select({ index = i })
		end,
		desc = "Grapple Select " .. i,
	})
end

table.insert(keys, {
	"<leader>sS",
	function()
		require("grapple").toggle_loaded()
	end,
	desc = "Grapple Loaded Scopes",
	mode = { "n" },
})

table.insert(keys, {
	"<leader>ss",
	function()
		require("grapple").open_tags()
	end,
	desc = "Grapple Tags",
	mode = { "n" },
})

table.insert(keys, {
	"<leader>sa",
	function()
		require("grapple").toggle()
	end,
	desc = "Grapple Toggle anonymous",
	mode = { "n" },
})

table.insert(keys, {
	"[[",
	function()
		require("grapple").cycle_backward()
	end,
	desc = "Grapple cycle backward",
	mode = { "n" },
})
table.insert(keys, {
	"]]",
	function()
		require("grapple").cycle_forward()
	end,
	desc = "Grapple cycle forward",
	mode = { "n" },
})

return {
	"cbochs/grapple.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = keys,
}
