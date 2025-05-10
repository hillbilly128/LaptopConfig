{ config, lib, pkgs, ... }:

{
  imports = [
    
  ];
  services.switcherooControl.enable = true;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit =  true;
      extraPackages = with pkgs; [ intel-vaapi-driver intel-compute-runtime ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      dynamicBoost.enable= false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        intelBusId = "PCI:1:00:0";
        nvidiaBusId = "PCI:00:02:0";
        #sync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    
  ];
}
