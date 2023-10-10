{ lib
, stdenvNoCC
, makeWrapper
, libnotify
, imagemagick
, swww
, jq
, curl
, rename
}:
stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    cp py.sh $out/bin/py
    chmod +x $out/bin/py

    cp chpaper.sh $out/bin/chpaper
    chmod +x $out/bin/chpaper

    cp filecheck.sh $out/bin/filecheck
    chmod +x $out/bin/filecheck

    cp clone.sh $out/bin/clone
    chmod +x $out/bin/clone

    cp shell.sh $out/bin/shell
    chmod +x $out/bin/shell

    cp rofi-pass.sh $out/bin/rofi-pass
    chmod +x $out/bin/rofi-pass

    cp check_for_existing_window.sh $out/bin/cf
    chmod +x $out/bin/cf

    cp utilities.sh $out/bin/ut
    chmod +x $out/bin/ut

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [imagemagick libnotify swww]}
    wrapProgram $out/bin/filecheck --prefix PATH : ${lib.makeBinPath [ rename ]}
  '';

}
