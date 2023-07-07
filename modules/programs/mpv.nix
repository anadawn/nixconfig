{ ... }: {

  programs.mpv = {
    enable = true;
    # package = pkgs.unstable.mpv;
    config = {
      hwdec = "auto-safe";
      gpu-context = "wayland";
      # ytdl-format= "bestvideo[height<=?1080]+bestaudio/best";
    };
    defaultProfiles = [ "gpu-hq" ];
    #scripts = with pkgs.mpvScripts; [
    # for mpv scripts
    # youtube-quality
    # ];
  };



}
