_: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
  };
  boot.tmp.cleanOnBoot = true;
}
