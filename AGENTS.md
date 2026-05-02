# Agent Context: Neovim Configuration

Personal Neovim config written in Lua, managed by `lazy.nvim`. No build, test, or CI — validate changes by running Neovim.

## Entrypoints & Structure

- `init.lua` → `require("config")` → `lua/config/init.lua`
- `lua/config/` — core settings (options, keymaps, lazy bootstrap, quickfix, plugin sub-configs)
- `lua/plugins/` — one file per plugin or plugin group; lazy.nvim auto-discovers via `{ import = "plugins" }`
- `after/ftplugin/` — filetype-specific settings loaded after plugins
- `snippets/` — custom snippets in JSON format
- `lazy-lock.json` — plugin lockfile; commit when adding/updating plugins

## Conventions

- **Leader key**: `<Space>` (`vim.g.mapleader = " "`)
- **Exit insert mode**: `jk`
- **Save**: `<leader>z`; **save without formatting**: `<leader>Z`
- Plugin specs return Lua tables; complex keymaps live in `lua/config/plugins/<plugin>/`
- Colorscheme: `zenbones.nvim` (default `rosebones`); alternatives: `catppuccin`, `rose-pine`; toggle with `<leader>us`
- Filetype detection added for `.typ` → `typst` and `.hurl` → `hurl`

## External Tool Dependencies

- `yazi` — file explorer (replaces netrw; `mini.files` is present but `enabled = false`)
- `jj` (Jujutsu) — version control; `.jj/` coexists with `.git/`. `jj-diffconflicts` and `hunk.nvim` are configured for jj workflows
- `nixd` LSP — hardcoded NixOS/home-manager flake paths in `lua/config/plugins/lsp_tools.lua`; adjust if the host changes
- `opencode` — CLI tool required by `opencode.nvim`
- `cmake` — required to build `telescope-fzf-native.nvim` (uses cmake, not make)

## LSP Quirks

- Uses modern `vim.lsp.config` / `vim.lsp.enable` API (Neovim 0.11+ style)
- `mason-lspconfig` has `automatic_enable = false`; servers are enabled manually in `lua/plugins/lsp.lua`
- Server definitions split between `lsp_tools.mason` (auto-installed) and `lsp_tools.noMason` (external, e.g. `nixd`)
- `yaml-companion.nvim` includes a polyfill for `workspace_did_change_configuration` (removed in nvim 0.10)

## Notable Plugin Choices

- `windsurf.nvim` (Codeium) provides active AI virtual-text completions; `copilot.lua` is present but `enabled = false`
- `telescope.nvim` is pinned to tag `0.1.3`
- `symbol-usage.nvim` is disabled by default
- `snacks.nvim` provides dashboard (custom skull logo), picker, notifier, zen, scratch, and indent guides
- `blink.cmp` is the completion engine

## Clipboard & Environment

- `unnamedplus` clipboard; over SSH uses OSC52 via `vim.ui.clipboard.osc52`
- `python3_host_prog` hardcoded to `/usr/bin/python3`

## VCS Note

This repository is tracked with both **Jujutsu (`jj`) and Git**. Use `jj` for day-to-day operations; git is a secondary mirror.
