{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule {
  pname = "gogpt";
  version = "1";

  src = fetchFromGitHub {
    owner = "Nemoden";
    repo = "gogpt";
    rev = "4cb75685290aa9deb84318da39021b7a52af9719";
    hash = "sha256-O43X7gqWfu3LBymGK6cpa8Dbvk966bIRx5poCCDySqg=";
  };


  vendorHash = "sha256-GZd7jrNFf10TbK5YJi/sRYUsZ9dMEcUimV9Cr05fDJ4=";




  meta = with lib; {
    description = "chatgpt in commandline";
    homepage = "https://github.com/Nemoden/gogpt";
  };
}
