{ lib, config, pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
    rnnoise
    pavucontrol
    noisetorch
  ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
