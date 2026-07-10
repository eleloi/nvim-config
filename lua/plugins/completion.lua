vim.pack.add({
  "https://github.com/xzbdmw/colorful-menu.nvim", -- adds color to completions
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  -- sources
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
})

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  enabled = function()
    if vim.bo.buftype == "terminal" then
      return false
    end
    local ft = vim.bo.filetype
    if ft == "fzf" or ft == "fzf_lua" or ft:match("^fzf") then
      return false
    end
    return true
  end,
  keymap = {
    preset = "none",
    ["<C-n>"] = { "show", "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-j>"] = { "show", "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
    ["<Tab>"] = { "select_and_accept", "fallback" },

    ["<C-e>"] = { "hide" },
    ["<Esc>"] = { "cancel", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  signature = { enabled = true },
  sources = {
    default = {
      "lsp",
      "lazydev",
      "path",
      "buffer",
      "ripgrep",
    },
    per_filetype = {
      org = { 'orgmode' }
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        score_offset = -10,
      },
      orgmode = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
      },
    },
  },
  cmdline = {
    keymap = {
      ["<Tab>"] = { "show", "accept" },
    },
    completion = { menu = { auto_show = true } },
  },
  completion = {
    ghost_text = { enabled = true },
    trigger = {
      prefetch_on_insert = false,
      show_on_keyword = true,
    },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { "kind_icon",   "label", "label_description", gap = 1 },
          { "source_name", "kind",  gap = 1 },
        },
        treesitter = { "lsp" },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    list = {
      selection = { auto_insert = true, preselect = false },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
    },
  },
})
