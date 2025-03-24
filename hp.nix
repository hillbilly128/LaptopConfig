{ config, lib, pkgs, ... }:

{
    # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan pkgs.hplipWithPlugin ];
}