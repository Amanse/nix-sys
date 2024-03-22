{...}: {
  imports = [./graphics ./sound.nix ./boot ./gui ./impermanence ./common ./locale.nix];

  ## COMMON THINGS I WANT EVERYWHERE
  ## @TODO: MOVE TO A SEPERATE FILE
  boot.kernelParams = ["intel_pstat=passive"];
  # boot.kernelParams = ["intel_pstate=disable" "acpi=force"];

  # boot.supportedFilesystems = ["ntfs"];
  console.earlySetup = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.localBinInPath = true;
}
