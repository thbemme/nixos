{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      #citrix_workspace
    ])
    ++ (with pkgs-unstable; [
      #citrix_workspace
      #alpaca-proxy
    ]);
}
