# GEMINI Project Context

## Project Overview

This directory contains a Neovim configuration written in Lua. It is designed to be a modular and extensible setup for the Neovim text editor.

The main entrypoint is `init.lua`, which sets up the environment and loads the core configuration modules. The configuration is organized into several directories:

-   `lua/config`: Core configuration files, including options, keymaps, and the plugin manager setup.
-   `lua/plugins`: Configuration for each individual plugin, organized by functionality.
-   `after/ftplugin`: Filetype-specific settings that are applied after the main configuration is loaded.
-   `snippets`: Custom code snippets.

This configuration uses `lazy.nvim` as its plugin manager, which is configured in `lua/config/lazy.lua`.

## Building and Running

This is a Neovim configuration, so there is no build process. To run Neovim with this configuration, you can use the following command:

```sh
NVIM_APPNAME=nvim nvim
```

The `README.md` file also provides instructions on how to clone this configuration into a separate directory and run it without replacing your default Neovim configuration.

## Development Conventions

The configuration is written in Lua and follows standard Lua best practices. Each plugin's configuration is contained in its own file within the `lua/plugins` directory. This makes it easy to add, remove, or modify plugin configurations without affecting the rest of the setup.

Filetype-specific settings are located in the `after/ftplugin` directory. This ensures that these settings are only loaded for the relevant filetypes and do not clutter the main configuration.
Conventions

The codebase follows a set of conventions that make it easy to manage and extend:

*   **Modular Structure:** Each plugin's configuration is contained in its own file within the `lua/plugins/` directory. This makes it easy to add, remove, or modify plugins without affecting the rest of the configuration.
*   **Lazy Loading:** Plugins are lazy-loaded whenever possible to improve startup time. This is handled by `lazy.nvim`.
*   **Clear Separation of Concerns:**
    *   `lua/config/options.lua`: Contains core Neovim settings.
    *   `lua/config/lazy.lua`: Handles the setup of `lazy.nvim` and the loading of all other plugins.
    *   `lua/plugins/`: Contains individual plugin configurations.
    *   `after/ftplugin/`: Contains filetype-specific settings.
*   **Consistent Coding Style:** The Lua code is written in a consistent style, with clear and concise function and variable names.
