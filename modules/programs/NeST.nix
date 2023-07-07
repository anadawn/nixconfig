{ lib, python3, fetchFromGitLab, ... }:

python3.pkgs.buildPythonPackage rec {
  pname = "nest";
  version = "0.4.1";

  src = fetchFromGitLab {
    owner = "nitk-nest";
    repo = "nest";
    rev = "f8eec8672eb9ba7a3f8125aa80bae3a07b65245e";
    hash = "sha256-Ds/hFGNuP3rI4KiDm4oW0LJQURxNkpVcRXuXKJmYGuQ=";
  };

  doCheck = false;
  propagatedBuildInputs = with python3.pkgs; [ numpy tqdm aiocoap packaging matplotlib ];

  # postPatch = ''
  #  substituteInPlace setup.py --replace "bs4" "beautifulsoup4"
  #'';

  # meta = with lib; {
  # homepage = "https://github.com/mov-cli/mov-cli";
  # description = "A cli tool to browse and watch movies";
  # license = licenses.gpl3Only;
  # maintainers = with maintainers; [ baitinq ];
  #};
}
