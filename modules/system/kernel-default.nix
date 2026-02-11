_: {
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  boot.tmp.cleanOnBoot = true;
}
