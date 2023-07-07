{ lib
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation {
  pname = "catppuccin-wallpapers";
  version = "latest";

  src = fetchFromGitHub {
    owner = "Krizdano";
    repo = "wallpapers";
    rev = "ccc9f22f2a8306b9fe5e047e045ab6dd7d62bad4";
    hash = "sha256-37UiaDC/gTFPg2rMfou5QXpsVkwFAtURjlnrUP3nhIk=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers/catppuccin
    find . -type f -regextype egrep -regex ".*\.(jpe?g|png)$" -exec cp {} $out/share/wallpapers/catppuccin/ \;

    runHook postInstall
  '';

  meta = with lib; {
    description = "Wallpapers to match your Catppuccin setups!";
    homepage = "https://github.com/catppuccin/wallpapers";
    license = licenses.mit;
  };
}
