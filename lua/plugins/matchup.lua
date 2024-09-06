-- It extends vim's % key to language-specific words instead of just single
-- characters.

local function setMatchParen()
	vim.cmd.hi("MatchWordCur guifg=nil, guibg=nil")
	vim.cmd.hi("MatchWord guifg=red guibg=black")
end

return {
	"andymass/vim-matchup",
	event = "VimEnter",
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.g.matchup_matchparen_enabled = 1
		setMatchParen()
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = setMatchParen,
		})
	end,
}
