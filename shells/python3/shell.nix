{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    pkgs.python3
    pkgs.python3Packages.pip
    pkgs.python3Packages.virtualenv
    # pkgs.python3Packages.numpy
    # pkgs.python3Packages.pandas
  ];
}
