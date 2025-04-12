# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hp.nix
      ./nvidia.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  networking.hostName = "MuggleSpawn"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  services.automatic-timezoned.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
#  console = {
#    font = "Lat2-Terminus16";
#    keyMap = "gb";
#    useXkbConfig = true; # use xkb.options in tty.
#  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  hardware.graphics.enable32Bit = true;

  nixpkgs.config = {
    allowUnfree = true;
  };
  
  #Firewall
  networking.firewall.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.craig = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "lp" "scanner" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      bitwarden-desktop
      vscodium
      (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
      libreoffice
      coreutils
      chromium
    ];
  };

  programs = {
    command-not-found.enable = true;
  };
    
  #Tailscale
  services.tailscale.enable = true;
  networking.nameservers = [ "100.100.100.100" "1.1.1.1" "1.0.0.1"];
  networking.search = [ "tail0ee7d.ts.net" ];

  #Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings = {
      devices = {
        "Phone" = { 
          id = "HVEN3M2-DUSOT3U-HI662VT-XLSIYA6-HYJNE3A-KMUGNOT-JNIWTZV-LIVEUQH"; 
          addresses = [ "tcp4://100.120.58.66:20000" ];
        };
      };
      folders = {
        "Documents" = {
          path = "/home/myusername/Documents";
          devices = [ "Phone" ];
        };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  #Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    gh
    git
    heroic
#    hplip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
  
  
   
  hardware.bluetooth.enable = true;
}
