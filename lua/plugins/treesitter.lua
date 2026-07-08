-- Parsers are the heart of treesitter. They are libraries that treesitter will
-- search for in the `parser` runtime directory.
--
-- Nvim includes these parsers:
--
-- - C
-- - Lua
-- - Markdown
-- - Vimscript
-- - Vimdoc
-- - Treesitter query files |ft-query-plugin|
--
-- You can install more parsers manually, or with a plugin like
-- https://github.com/nvim-treesitter/nvim-treesitter .

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
})

local ensure_installed = {
  "astro",
  "bash",
  "css",
  "dockerfile",
  "fish",
  "git_rebase",
  "gitcommit",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "http",
  "hurl",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "nu",
  "python",
  "sql",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "typst",
  "vimdoc",
  "vue",
  "yaml",
  "kdl",
  "templ",
}

require("nvim-treesitter").install(ensure_installed)

for _, lang in ipairs(ensure_installed) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { lang },
    callback = function()
      -- enable highlight
      vim.treesitter.start()
      -- foldmethod
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end,
  })
end

require("treesitter-context").setup({
  enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
})
