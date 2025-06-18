return {
	"emmanueltouzery/apidocs.nvim",
	dependencies = { "folke/snacks.nvim" },
	cmd = { "ApidocsSearch", "ApidocsInstall", "ApidocsOpen", "ApidocsSelect", "ApidocsUninstall" },
	init = function()
		local co = coroutine.create(function()
			-- command for get available (nu)
			-- http get https://devdocs.io/docs.json | select slug type version release --ignore-errors
			local ensure_installed = {
				"astro",
				"bash",
				"css",
				"date_fns",
				"docker",
				"express",
				"fastapi",
				"git",
				"go",
				"html",
				"http",
				"javascript",
				"jq",
				"latex",
				"leaflet~2.0",
				"man",
				"lua~5.4",
				"markdown",
				"nextjs",
				"nix",
				"node",
				"nushell",
				"pandas~2",
				"playwright",
				"postgresql~17",
				"postgresql~16",
				"postgresql~15",
				"python~3.13",
				"python~3.12",
				"react",
				"rust",
				"sqlite",
				"svelte",
				"svg",
				"tailwindcss",
				"typescript",
				"typescript~5.1",
			}
			require("apidocs").ensure_install(ensure_installed)
		end)
		coroutine.resume(co)
	end,
	config = function()
		require("apidocs").setup()
	end,
	keys = {
		{ "<leader>fd", "<cmd>ApidocsOpen<cr>", desc = "Search Api Doc" },
	},
}
