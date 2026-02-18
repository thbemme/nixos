{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.vicinae.homeManagerModules.default];
  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      pop_to_root_on_close = true;
      close_on_focus_loss = true;
      favorites = [
        "applications:librewolf"
        "applications:com.mitchellh.ghostty"
        "applications:vscodium"
        "applications:steam"
      ];
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      niri
      nix
    ];
  };
}
