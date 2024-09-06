-- Automatic closes tags like <div></div>...

return {
	"windwp/nvim-ts-autotag",
	event = "VeryLazy",
	opts = {
		autotag = { enable = true },
	},
}
