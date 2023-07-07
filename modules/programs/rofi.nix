{ pkgs,... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland.override { symlink-dmenu = true; };
    theme = ../../config/rofi/drakula.rasi;
  };
  }
