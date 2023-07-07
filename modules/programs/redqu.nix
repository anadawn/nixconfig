{ stdenv
, lib
, fetchFromGitHub
, babashka
}:


stdenv.mkDerivation {
  pname = "redqu";
  version = "1";

  src = fetchFromGitHub {
    owner = "port19x";
    repo = "redqu";
    rev = "32a38cda2d180977a10a75fbf432760449b50cf6";
    hash = "sha256-b0u2QRjxk6lbLiOuJ4Uf1MkLTQ5/TLFviP4ELrH2ZhU=";
  };

  buildInputs = [ babashka ];

  installPhase = ''
    mkdir -p $out/bin
    chmod +x redqu 
    cp -r redqu $out/bin/redqu 
  '';


  meta = with lib; {
    description = "A cli tool to watch movies and series";
  };

}


