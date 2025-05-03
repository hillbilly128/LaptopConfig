{ config, lib, pkgs, ... }:

{
    services.immich = {
        enable = true;
        mediaLocation = "/data/Images/immich/";
        machine-learning.enable = true;
        settings = {
            newVersionCheck.enabled = false;
        };
    };

    programs.firefox ={
        policies = {
            ManagedBookmarks = [
                {
                    "Managed Bookmarks" = "Managed Bookmarks Folder";
                }
                {
                    url = "http://localhost:2283/";
                    name = "Local Immich";
                }
                
            ];
        };
    };

    users.users.immich.extraGroups = [ "video" "render" ];
}