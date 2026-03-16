{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "cli-music-player";
  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "professor-lee";
    repo = "cli-music-player";
    rev = "v${version}";
    sha256 = "sha256-wbaOd4LvGRM1FnsQymWdVmpQWtxX7u8JxbEtXtxnezo=";
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
    description = "A CLI music player";
    homepage = "https://github.com/professor-lee/cli-music-player";
    license = licenses.agpl3Only;
  };
}
