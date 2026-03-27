let
  pkgs = import <nixpkgs> {
    config.permittedInsecurePackages = [
      "python-2.7.18.12"
    ];
  };
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      python27
    ];
  }
