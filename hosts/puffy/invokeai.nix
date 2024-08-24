{ config, inputs, ... }:
{
  imports = [
    inputs.nixified-ai.nixosModules.invokeai-amd
  ];
  services.invokeai = {
    enable = true;
    settings = {
      host = "0.0.0.0";
      root = "/srv/data/ai/invokeai";
    };
  };

}
