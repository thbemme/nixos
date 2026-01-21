{
  pkgs,
  vars,
  ...
}: {
  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    printing.drivers = [pkgs.hplipWithPlugin];
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      wideArea = false;
    };
  };

  hardware.sane = {
    enable = true; # enables support for SANE scanners
    extraBackends = [pkgs.hplipWithPlugin];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override {gimpSupport = true;};
  };

  users.users.${vars.user} = {
    extraGroups = ["scanner" "lp"];
  };
}
