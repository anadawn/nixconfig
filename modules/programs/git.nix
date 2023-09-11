{ pkgs, ... }: {

  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    # signing = {
    #   key = null;
    #   signByDefault = true;
    # };

    userName = "anadawn";
    userEmail = "arunapallickal@gmail.com";
  };

  # home.packages = with pkgs; [ git-crypt ];

}
