return {
	"echasnovski/mini.indentscope",
	version = "*",
	config = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		symbol = "▏",
	},
	-- default mappings
	-- mappings = {
	--     -- Textobjects
	--     object_scope = 'ii',
	--     object_scope_with_border = 'ai',
	--
	--     -- Motions (jump to respective border line; if not present - body line)
	--     goto_top = '[i',
	--     goto_bottom = ']i',
	-- },,
}
