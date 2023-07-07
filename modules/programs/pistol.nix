{ pkgs, ... }: {

  programs.pistol = {
    enable = true;
    associations = [ ];
  };

  home.packages = with pkgs; [
  ];
}
