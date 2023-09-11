{ stdenv
, lib
, makeWrapper
, fetchFromGitHub
, socat
, html-xml-utils
}:


stdenv.mkDerivation {
  pname = "lobster-movie";
  version = "3.0.4";

  src = fetchFromGitHub {
  owner = "justchokingaround";
  repo = "lobster";
  rev = "5f25097b47603b43b440499ada83c302996f59b1";
  hash = "sha256-537zH23WS5sLLruOaAcchE1lMVnFl+HUtR8hrMbEst4=";
};

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    chmod +x lobster.sh
    cp -r lobster.sh $out/bin/lobster 
    wrapProgram $out/bin/lobster --prefix PATH : ${lib.makeBinPath [
       socat html-xml-utils
      ]} 
  '';

  meta = with lib; {
    description = "A cli tool to watch movies and series";
  };

}


