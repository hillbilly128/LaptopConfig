{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        ariang
        kdePackages.plasma-browser-integration
        aria2
        vdhcoapp
    ];

    systemd.services.generateRandomFile = {
        description = "Generate a file with random characters";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "/bin/sh -c 'head /dev/urandom | tr -dc \"A-Za-z0-9\" | head -c 100 > /etc/aria2.rpc'";
            RemainAfterExit = true;
        };
        enable = false;
    };


    services.aria2 = {
        enable = true;
        rpcSecretFile = "/etc/aria2.rpc";
    };

    programs.firefox ={
        enable = true;
        wrapperConfig = {pipewireSupport = true;};
        # nativeMessagingHosts.packages = with pkgs; [
        #     kdePackages.plasma-browser-integration
        #     aria2
        # ];
        #languagePacks = "en-GB";
        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
                Value= true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
            DisablePocket = true;
            DisableFirefoxScreenshots = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            DontCheckDefaultBrowser = true;
            DisableFormHistory = true;
            HardwareAcceleration = true;
            DisableBuiltinPDFViewer = true;
            SearchEngines = {
                Default = "DuckDuckGo";
            };
            SkipTermsOfUse = true;
            ExtensionSettings = {
                #Plasma Browser Intergration
                "plasma-browser-integration@kde.org" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-browser-integration@kde.org/latest.xpi";
                    private_browsing = false;
                };
                #Aria 2 download manager
                "{e2488817-3d73-4013-850d-b66c5e42d505}" = {
                    installation_mode = "normal_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/{e2488817-3d73-4013-850d-b66c5e42d505}/latest.xpi";
                    private_browsing = true;
                };
                #Bitwarden Password Manager
                "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
                    private_browsing = false;
                };
                #DuckDuckGo Privacy Essentials
                "jid1-ZAdIEUB7XOzOJw@jetpack" = {
                    installation_mode = "force_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/jid1-ZAdIEUB7XOzOJw@jetpack/latest.xpi";
                    private_browsing = true;
                };
                #FoxyProxy
                "foxyproxy@eric.h.jung" = {
                    installation_mode = "normal_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy@eric.h.jung/latest.xpi";
                    private_browsing = true;
                };
                #Simple Tab Groups
                "simple-tab-groups@drive4ik" = {
                    installation_mode = "normal_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups@drive4ik/latest.xpi";
                    private_browsing = false;
                };
                #Obsidian Bookmarks
                "obsidian_website_bookmarks@patrikzudel" = {
                    installation_mode = "normal_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/obsidian_website_bookmarks@patrikzudel/latest.xpi";
                    private_browsing = true;
                };
                #User Agent switcher and manager
                "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
                    installation_mode = "normal_installed";
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}/latest.xpi";
                    private_browsing = true;
                };
            };
            ManagedBookmarks = [
                {
                    "Managed Bookmarks" = "Managed Bookmarks Folder";
                }
                {
                    url = "${pkgs.ariang}/share/ariang/index.html";
                    name = "AriaNG";
                }                
            ];
        };
    };
}