{config, lib, pkgs, ... }:

{
    users = {
        motd = "Welcome to my Laptop.\n If your not me fuck off!!";
        users = {
            craig = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" "lp" "scanner" "syncthing"]; # Enable ‘sudo’ for the user.
                packages = with pkgs; [
                    tree
                    bitwarden-desktop
                    vscodium
                    libreoffice
                    coreutils
                    chromium
                    signal-desktop
                    whatsapp-for-linux
                ];
            };
        };
        
  };
}