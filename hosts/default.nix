# profile types (laptop or vm) used to build Nixos

#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix
#       └─ ./laptop OR ./vm
#             └─ ./default.nix
#     

{ home-manager, nixpkgs, inputs, user, location, stable, impermanence, nixvim, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit user location inputs;
    };
    modules = [
      ./configuration.nix
      ./laptop

      ({ config, pkgs, ... }:
        let
          overlay-unstable = final: prev: {
            stable = stable.legacyPackages.x86_64-linux;
          };
        in
        {
          nixpkgs.overlays = [
            overlay-unstable
            (import ../overlays)
          ];
        })

      impermanence.nixosModules.impermanence


      home-manager.nixosModules.home-manager
      {
        home-manager.users.${user} = {
          imports = [
            impermanence.nixosModules.home-manager.impermanence
            nixvim.homeManagerModules.nixvim
          ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs location; };
    modules = [
      ./configuration.nix
      ./vm

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
  iso = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit user inputs location; };
    modules = [
      (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      ./iso

      home-manager.nixosModules.home-manager
      {
        home-manager.users.${user} = {
          imports = [
            # impermanence.nixosModules.home-manager.impermanence
            nixvim.homeManagerModules.nixvim
          ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}

