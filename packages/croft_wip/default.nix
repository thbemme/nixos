{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "croft";
  version = "0.1.259";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "vitali87";
    repo = "croft";
    rev = "main";
    sha256 = "sha256-ToG4ooXz//fZIVMjnbGxTuUrj2IAk1yIhpFjvDpJcJY=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
    git
    python3
  ];
  buildInputs = with pkgs; [
  ];
  meta = with pkgs.lib; {
    description = "VSCode-style TUI written in Rust ";
    homepage = "https://codeberg.org/vitali87/croft";
    license = licenses.mit;
  };
}
