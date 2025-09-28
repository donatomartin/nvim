{
  description = "Donato Martín's NixVim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url  = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixvim, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    nixvimCfg = import ./config.nix;
  in {
    packages.${system}.default =
      nixvim.legacyPackages.${system}.makeNixvim nixvimCfg;

    apps.${system}.nixvim = {
      type = "app";
      program = "${self.packages.${system}.default}/bin/nvim";
    };
  };
}
