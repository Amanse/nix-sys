{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.neovim-flake.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    # inputs.hyprland.homeManagerModules.default

    ./packages.nix
    ./terminal
    ./services.nix
    ./programs.nix
    ./graphical
    ./theme.nix
  ];

  home.username = "me";
  home.homeDirectory = "/home/me";

  myHome = {
    startupCmds = [
      # "${getExe' pkgs.onedrive "onedrive"} --monitor"
      "${pkgs.waybar}/bin/waybar"
      "${pkgs.megacmd}/bin/mega-cmd-server"
      "${pkgs.wlsunset}/bin/wlsunset -T 4501"
      "${pkgs.hyprpaper}/bin/hyprpaper"
      "${pkgs.swaynotificationcenter}/bin/swaync"
      "${pkgs.batsignal}/bin/batsignal -b -w 20"
    ];

    services = {
      onedrive = {
        enable = true;
        syncDirs = ["/SaveGames/NBGI" "/Logseq"];
      };

      rclone = {
        enable = true;
        configs = [
          {
            mountDir = "onedrive";
            configName = "onedrive-main";
          }
        ];
      };
    };

    gui = {
      wms = {
        wallpaper.hyprpaper.enable = true;
        sway = {
          enable = true;
          # package = pkgs.swayfx;
        };
        hyprland.enable = true;
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "nemo.desktop";

        # Browser
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/about" = "google-chrome.desktop";
        "x-scheme-handler/unknown" = "google-chrome.desktop";
        "application/pdf" = "org.gnome.Evince.desktop";
        "x-scheme-handler/discord-378612438200877056" = "discord-378612438200877056.desktop";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # is set to something in the nix store by default
  # programs.home-manager.path = "$HOME/nix-sys/home";
  # };
  # home-manager.extraSpecialArgs = {inherit inputs;};
}
