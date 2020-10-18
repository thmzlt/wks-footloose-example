{ pkgsRef ? "5a71d9619ad9499c51be052cb9aaafba3d5a31b9"
, pkgs ? import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${pkgsRef}.tar.gz") {}
}:

let
  footloose = pkgs.buildGoModule rec {
    pname = "footloose";
    version = "0.6.4";

    src = pkgs.fetchFromGitHub {
      owner = "weaveworks";
      repo = pname;
      rev = "${version}";
      sha256 = "07lmyj8ga5i6pzkfjhyin4af5rynsx0ninwvzzbgypgp2gz6jrah";
    };

    vendorSha256 = "1ah0cv20qiw4r5xygqc6pj98d3nqwqrhxjgbsd8bpsfaar3lxnd0";

    doCheck = false;
  };

  gotk = pkgs.buildGoModule rec {
    pname = "gotk";
    version = "0.1.6";

    src = pkgs.fetchFromGitHub {
      owner = "fluxcd";
      repo = "toolkit";
      rev = "v${version}";
      sha256 = "0afwirysy933af6ih6hjrrz8fjg1cdi403czz40p5ydj82w9pdyb";
    };

    vendorSha256 = "084v4bqj8lnprhq8milyhpq3rfp34zwfaxp3wjkybicmf8sgqy7l";

    doCheck = false;
  };

  wksctl = pkgs.buildGoModule rec {
    pname = "wksctl";
    version = "0.9.0-alpha.4";

    src = pkgs.fetchFromGitHub {
      owner = "weaveworks";
      repo = pname;
      rev = "v${version}";
      sha256 = "0z2zfcdp9ml5jh8wiikds3rk1vyp7cyjs8sxwpz0dlwwbafylgh8";
    };

    vendorSha256 = "0mrrcvq31473spn6mzbapkvdzigfk6d0rsfd3v94p9frc892c28m";

    doCheck = false;
  };
in

pkgs.mkShell {
  buildInputs = [
    gotk
    footloose
    pkgs.k9s
    pkgs.kubectl
    wksctl
  ];

  shellHook = ''
  '';
}
