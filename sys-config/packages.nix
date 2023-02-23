{ config, pkgs, unstable,... }:
let
	dbus-sway-environment = pkgs.writeTextFile {
		name = "dbus-sway-environment";
		destination = "/bin/dbus-sway-environment";
		executable = true;

		text = ''
			dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
			systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
			systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
			'';
	};
in
{
  nix = {
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };


  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    #mpv
    #git
    #yt-dlp
    wget

    dbus-sway-environment

    #brave
    #google-chrome
    #lutris
    #direnv
    #nix-direnv
    #lokinet
    #transmission
    #heroic
    #logseq

    gcc
    ripgrep

    rustup
    rust-analyzer
    #tmux


    #hypr
    #alacritty
    #rofi-wayland
    bemenu
    wl-clipboard
    acpi #battery
    #mako
    pulseaudio
    grim
    #playerctl
    wlogout
    hyprpaper
    pavucontrol
    waybar
  ];


  programs.light.enable=true;
  programs.kdeconnect = {
    enable = true;
  };
  programs.adb.enable=true;
  services.flatpak.enable=true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  xdg = {
    portal = {
      wlr.enable=true;
      enable = true;
    };
  };

  # For steam to use proton-ge and other stuff
  environment.sessionVariables = rec {
      XDG_CACHE_HOME  = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME    = "\${HOME}/.local/bin";
      XDG_DATA_HOME   = "\${HOME}/.local/share";
      # Steam needs this to find Proton-GE
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # note: this doesn't replace PATH, it just adds this to it
      PATH = [ 
        "\${XDG_BIN_HOME}"
      ];
  };


  # Window manager firefox
  environment.sessionVariables = {
     MOZ_ENABLE_WAYLAND = "1";
  };

  # Direnv
#  environment.pathsToLink = [
 #   "/share/nix-direnv"
 # ];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];


}
