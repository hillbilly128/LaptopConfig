{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc/laptop/default.nix"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/pc/laptop/hdd/default.nix"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/cpu/intel/skylake"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia/prime.nix"
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/common/gpu/nvidia/maxwell"
    ];

    hardware = {
        nvidia = {
            open = false;
            prime = {
                intelBusId = "PCI:1:00:0";
                nvidiaBusId = "PCI:00:02:0";
            };
        };
    };
}
