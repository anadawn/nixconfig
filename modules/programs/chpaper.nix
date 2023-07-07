{ lib, makeWrapper, stdenvNoCC, imagemagick, swaybg }:

stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "0.1";
  src = ../../config/scripts;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp chpaper.sh $out/bin/chpaper
    chmod +x $out/bin/chpaper
    wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [ imagemagick swaybg ]}
  '';
}
