{config, lib, pkgs, ... }:

{
    #Tailscale
    services.tailscale.enable = true;
    networking.nameservers = [ "100.100.100.100"];
    networking.search = [ "tail0ee7d.ts.net" ];
}