# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: let
  pt = pkgs.catppuccin-plymouth.override {variant = "mocha";};
in {
  boot.plymouth = {
    enable = true;
    themePackages = [pt];
    theme = "catppuccin-mocha";
  };

  myModules = {
    system.impermanence.enable = true;
    gui = {
      enable = true;
      desktops = [
        "hyprland"
        # "sway"
        # "gnome"
        "plasma"
      ];
      loginManagers = ["sddm"];
      sddmTheme = "catppuccin";
    };
    boot = {
      secure-boot.enable = true;
    };
    gaming = {
      deckSwapVal = true;
      steam = {
        enable = true;
        gamescopeSession = true;
        xorgPackageOverlay = true;
      };
    };
    networking.cloudflareDns = true;
    networking.tailscale = {
      enable = true;
      isClient = true;
    };
    sound = {
      enable = true;
      bluetoothAudioFix = true;
      headphoneFix = true;
    };
    graphics = {
      intel.enable = true;
      nvidia.enable = true;
      nvidia.package = "beta";
    };
    misc = {
      swaylock-fix = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.

  # font
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  environment.shells = [pkgs.zsh];
  # For completion in zsh
  environment.pathsToLink = ["/share/zsh"];
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    isNormalUser = true;
    description = "me";
    extraGroups = ["networkmanager" "wheel" "adbusers" "power" "video" "storage"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      vim
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
