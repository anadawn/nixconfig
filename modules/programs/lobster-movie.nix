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
    rev = "7bbd799e585e28753b6cba98ab7c6391de43ba87";
    hash = "sha256-lHynhfs86UAa5tdL5JQN2TnugEEUzjrvPDEb7TUF0Qk=";
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


