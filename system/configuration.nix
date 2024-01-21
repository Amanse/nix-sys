# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  pkgs,
  ...
}: {
  boot.kernelParams = ["intel_pstat=passive"];
  # boot.kernelParams = ["intel_pstate=disable" "acpi=force"];

  boot.supportedFilesystems = ["ntfs"];
  console.earlySetup = true;

  myModules = {
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
    sound = {
      enable = true;
      bluetoothAudioFix = true;
      headphoneFix = true;
    };
    graphics = {
      intel.enable = true;
      nvidia.enable = true;
    };
    misc = {
      swaylock-fix = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;

  # systemd.services.bluetooth.enable = false;
  # systemd.services.tailscale.enable = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the GNOME Desktop Environment.
  # services.xserver.autorun = false;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "hyprland";
  services.xserver.displayManager.sddm.wayland.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # environment.gnome.excludePackages = with pkgs.gnome; [
  #   gnome-software
  #   geary
  #   totem
  #   gnome-music
  #   epiphany
  # ];
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.displayManager.startx.enable = true;
  # services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.sessionVariables = {
    XDG_CACHE_HOME = "\${HOME}/.cache";

    # chrome + wayland
    NIXOS_OZONE_WL = "1";

    XDG_CONFIG_HOME = "\${HOME}/.config";
    # XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    # note: this doesn't replace PATH, it just adds this to it
    # PATH = [
    #   "\${XDG_BIN_HOME}"
    # ];
  };

  environment.shells = [pkgs.zsh];
  # For completion in zsh
  environment.pathsToLink = ["/share/zsh"];
  environment.localBinInPath = true;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    isNormalUser = true;
    description = "me";
    extraGroups = ["networkmanager" "wheel" "adbusers" "power" "video" "storage"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "me";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # programs.ssh.askPassword = lib.mkForce "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
