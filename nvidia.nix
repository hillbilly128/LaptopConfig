{ config, lib, pkgs, ... }:

{
    hardware.graphics = {
    enable = true;
#    extraPackages = [
#      intel-media-driver
#    ];
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = "PCI:1:00:0";
      nvidiaBusId = "PCI:00:02:0";
      sync.enable = true;
    };
  };
}