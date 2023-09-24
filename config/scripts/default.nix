{
  lib,
  stdenvNoCC,
  makeWrapper,
   libnotify,
  # rofi-wayland,
  # tmux,
  # kitty,
   imagemagick,
  # hyprland,
   swww,
  jq,
  curl,
  rename,
  # ytfzf,
}:
stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin

    cp py.sh $out/bin/py
    chmod +x $out/bin/py

    # cp tmux-sessions.sh $out/bin/tmux-sessions
    # chmod +x $out/bin/tmux-sessions
    #
     cp chpaper.sh $out/bin/chpaper
     chmod +x $out/bin/chpaper
    #
     cp wallhaven.sh $out/bin/wallhaven
     chmod +x $out/bin/wallhaven

     cp filecheck.sh $out/bin/filecheck
     chmod +x $out/bin/filecheck

    cp clone.sh $out/bin/clone
    chmod +x $out/bin/clone

    cp wallpaper.sh $out/bin/wallpaper
    chmod +x $out/bin/wallpaper

    cp shell.sh $out/bin/shell
    chmod +x $out/bin/shell

    cp rofi-pass.sh $out/bin/rofi-pass
    chmod +x $out/bin/rofi-pass

    cp check_for_existing_window.sh $out/bin/cf
    chmod +x $out/bin/cf

     runHook postInstall
  '';

   postInstall = ''
     wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [imagemagick libnotify swww]}
     wrapProgram $out/bin/wallhaven --prefix PATH : ${lib.makeBinPath [imagemagick libnotify jq curl]}
     wrapProgram $out/bin/filecheck --prefix PATH : ${lib.makeBinPath [ rename ]}
     wrapProgram $out/bin/wallpaper --prefix PATH : ${lib.makeBinPath [imagemagick libnotify swww]}
   '';

  #   wrapProgram $out/bin/youtube --prefix PATH : ${lib.makeBinPath [kitty ytfzf rofi-wayland]}
  #   wrapProgram $out/bin/power-menu --prefix PATH : ${lib.makeBinPath [libnotify rofi-wayland hyprland]}
  #   wrapProgram $out/bin/tmux-sessions --prefix PATH : ${lib.makeBinPath [tmux kitty rofi-wayland]}
}
