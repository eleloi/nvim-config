local set = vim.bo

set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.shiftwidth = 2

vim.cmd("packadd nvim-lspconfig")
vim.lsp.config("nixd", {
    cmd = { "nixd" },
    settings = {
        nixpkgs = {
            expr = "import <nixpkgs> { }",
        },
        options = {
            nixos = {
                expr = '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").nixosConfigurations."bob".options',
            },
            home_manager = {
                expr = '(builtins.getFlake "/home/eleloi/nixos-config/flake.nix").homeConfigurations."eleloi".options',
            },
        },
    },
})
vim.lsp.enable("nixd")
