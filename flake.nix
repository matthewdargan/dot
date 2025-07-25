{
  description = "home config";
  inputs = {
    epify = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:matthewdargan/epify";
    };
    firefox-addons = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };
    ghostty = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ghostty-org/ghostty";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixvim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
    };
    parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/pre-commit-hooks.nix";
    };
    src = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:matthewdargan/src";
    };
    u9fs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:justinrubek/u9fs";
    };
  };
  outputs = {parts, ...} @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./home/configurations
        inputs.pre-commit-hooks.flakeModule
        ./nixos/configurations
        ./packages
        ./parts
      ];
      systems = ["x86_64-linux"];
    };
}
