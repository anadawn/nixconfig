# My personal Nixos flake 
# this is a flake manages my Nixos Configuration

#  flake.nix *             
#   ├─ ./hosts
#   │    └─ default.nix
{
  description = "My personal Nixos Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/release-22.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, home-manager, nixpkgs, impermanence, stable, nixvim, hyprland, ... }@inputs:
    let
      user = "aruna";
      location = "$HOME/.nixconfig";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user location impermanence nixvim stable hyprland;
        }
      );
    };

}
