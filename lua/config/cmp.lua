---@diagnostic disable: missing-fields
vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
local cmp = require("cmp")
local defaults = require("cmp.config.default")()

cmp.config.formatting = {
	format = require("tailwindcss-colorizer-cmp").formatter,
}

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end),

		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-l>"] = cmp.mapping.confirm({ select = true }),
		["<S-CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "async_path" },
		{ name = "buffer" },
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "cmp_plugins" },
		{ name = "nvim_lua" },
	}),
	formatting = {
		format = function(entry, item)
			defaults.formatting.format(entry, item)
			return require("tailwindcss-colorizer-cmp").formatter(entry, item)
		end,
	},
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
		native_menu = false,
	},
	sorting = defaults.sorting,
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "async_path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "conventionalcommits" },
	}),
})
