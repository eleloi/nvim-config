-- View notifications less invasively

return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	opts = {
		notification = {
			override_vim_notify = true,
		},
	},
	config = true,
}
