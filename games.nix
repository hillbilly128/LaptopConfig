{config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        lutris
        wine-wayland
        wineWowPackages.full
        winetricks
        pkgs.vulkan-tools
        pkgs.dxvk
        pkgs.vkd3d-proton
        pkgs.libGL
        cabextract
        gnutls
        pkgs.freetype
    ];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
        gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
}