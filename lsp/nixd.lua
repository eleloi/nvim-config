return {
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
}
