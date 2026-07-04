{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "TMPlayer";
  version = "0.2.4";

  src = pkgs.fetchFromGitHub {
    owner = "professor-lee";
    repo = "TMPlayer";
    rev = "v${version}";
    sha256 = "sha256-ofgVrBmyaRR5OMR7WIr5904fSarBuS+xf+sp+da6XwY=";
  };

  cargoLock = {
    lockFile = src + "/Cargo.lock";
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
  buildInputs = with pkgs; [
    alsa-lib.dev
    chromaprint
    dbus
  ];
  meta = with pkgs.lib; {
    description = "A Rust-based Linux TUI music player with spectrum visualization";
    homepage = "https://github.com/professor-lee/TMPlayer";
    license = licenses.agpl3Only;
  };
}
