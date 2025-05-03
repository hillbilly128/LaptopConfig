{ config, lib, pkgs, ... }:

{
    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
        settings = {
            options = {
                urAccepted = -1;
                localAnnouceEnabled = true;
            };
            devices = {
                "Phone" = { 
                id = "HVEN3M2-DUSOT3U-HI662VT-XLSIYA6-HYJNE3A-KMUGNOT-JNIWTZV-LIVEUQH"; 
                addresses = [ "tcp4://100.120.58.66:20000" ];
                };
            };
            folders = {
                "Documents" = {
                    path = "/data/sync/Documents";
                    devices = [ "Phone" ];
                    id = "Documents";
                };
                "Camera A" = {
                    path = "/data/Images/Camera";
                    devices = [ "Phone" ];
                    id = "nw1e1-vf9vx";
                    type = "receiveonly";
                };
                "Camera B" = {
                    path = "/data/Images/Camera2";
                    devices = [ "Phone" ];
                    id = "xvohv-pwc5k";
                    type = "receiveonly";
                };
                "Default Folder" = {
                    path = "/data/sync/default-folder";
                    devices = [ "Phone" ];
                    id = "default";
                    type = "sendreceive";
                };
                "Obsidian" = {
                    path = "/data/sync/Obsidian";
                    devices = [ "Phone" ];
                    id = "cjvgc-fwms4";
                    type = "sendreceive";
                };
                "Signal Backups" = {
                    path = "/data/phone/backup/Signal Backups";
                    devices = [ "Phone" ];
                    id = "aqmju-xg0qk";
                    type = "receiveonly";
                    versioning = {
                        type = "simple";
                        params.keep = "10";
                    };
                };
                "Whatsapp Backups" = {
                    path = "/data/phone/backup/Whatsapp";
                    devices = [ "Phone" ];
                    id = "a4m55-vpszg";
                    type = "receiveonly";
                    versioning = {
                        type = "simple";
                        params.keep = "10";
                    };
                };
                "Videos" = {
                    path = "/data/videos";
                    devices = [ "Phone" ];
                    id = "ssjag-ryfdf";
                    type = "sendreceive";
                };
                
            };
        };
    };
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}