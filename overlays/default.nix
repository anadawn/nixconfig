self: super:
{
  adi1090x-plymouth = super.callPackage ../modules/programs/plymouth/adi1090x-plymouth { };
  waybar = super.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
  scripts = super.callPackage ../modules/programs/chpaper.nix { }; # set and change wallpaper 
  catppuccin-wallpaper = super.callPackage ../modules/programs/wallpaper.nix { }; # wallpaper repo
  lobster-movie = super.callPackage ../modules/programs/lobster-movie.nix { }; # cli tool for streaming movies and series
  oi = super.callPackage ../modules/programs/oi.nix { }; # cli program for quick google search
  tt = super.callPackage ../modules/programs/tt.nix { }; # cli typing test
  redqu = super.callPackage ../modules/programs/redqu.nix { }; # media centric reddit client 
  gogpt = super.callPackage ../modules/programs/gogpt.nix { }; # media centric reddit client 
  ytfzf = super.callPackage ../modules/programs/ytfzf.nix { }; # media centric reddit client 
}
