{ pkgs  }:
pkgs.stdenv.mkDerivation rec {
  name = "bemoji";
  src = pkgs.fetchFromGitHub {
    owner = "marty-oehme";
    repo = "bemoji";
    rev = "0.3.0";
    sha256 = "XXNrUaS06UHF3cVfIfWjGF1sdPE709W2tFhfwTitzNs=";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/bemoji $out/bin/bemoji
    chmod +x $out/bin/bemoji
  '';
}
