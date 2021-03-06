with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  buildInputs = [
    nodejs-6_x
    elmPackages.elm
    git
  ];
}
