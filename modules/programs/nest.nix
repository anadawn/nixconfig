{ lib
, python3
, ...
}:

{


  my-python-packages = p: with p; [
    # ...
    (
      buildPythonPackage rec {
        pname = "nest";
        version = "0.4.1";
        src = fetchPypi {
          inherit pname version;
          sha256 = "sha256-0000000000000000000000000000000000000000000=";
        };
        doCheck = false;
        propagatedBuildInputs = [
          # Specify dependencies
          pkgs.python3Packages.numpy
          pkgs.python3Packages.aiocoap
          pkgs.python3Packages.tqdm
          pkgs.python3Packages.packaging
          pkgs.python3Packages.matplotlib
          #	pkgs.python3Packages.tqdm
          #pkgs.python3Packages.tqdm
          #pkgs.python3Packages.tqdm
          #pkgs.python3Packages.tqdm
          #pkgs.python3Packages.tqdm
        ];
      }
    )
  ];

}
