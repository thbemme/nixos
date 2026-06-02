{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "croft";
  version = "0.1.259";

  src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "thbemme";
    repo = "croft";
    rev = "macosTests";
    sha256 = "sha256-7jmxtTMuMZh2TcRcb2ZnMY4LguV2OE3W3ZH0c8ikCZQ";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  buildInputs = with pkgs; [
  ];
  meta = with pkgs.lib; {
    description = "VSCode-style TUI written in Rust ";
    homepage = "https://codeberg.org/vitali87/croft";
    license = licenses.mit;
  };
}
