# Neovim Configuration

This is a personal Neovim configuration.

## Structure

- `init.lua`: The main entry point.
- `lua/`: Contains all the Lua configuration modules.
  - `lua/config/`: Core Neovim settings and plugin manager setup (`lazy.nvim`).
  - `lua/plugins/`: Individual plugin configurations.
- `after/ftplugin/`: Filetype-specific settings.
- `snippets/`: Custom code snippets.

## Installation

To use this configuration, clone it to your Neovim config directory (e.g., `~/.config/nvim`). The plugins will be installed automatically by [lazy.nvim](https://github.com/folke/lazy.nvim) on the first run.
