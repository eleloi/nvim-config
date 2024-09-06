-- Draws a vertical line at each indentation level

return {
	"echasnovski/mini.indentscope",
	version = "*",
	config = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		symbol = "▏",
	},
}
