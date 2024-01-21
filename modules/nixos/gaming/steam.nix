{
  config,
  lib,
  ...
}: let
  cfg = config.myModules.gaming.steam;
  inherit (lib) mkIf mkEnableOption;
in {
  options.myModules.gaming.steam = {
    enable = mkEnableOption "Enable steam";
    gamescopeSession = mkEnableOption "Enable the gamescope steam session";
    xorgPackageOverlay = mkEnableOption "Add xorg packages required to run a few games like doom";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = cfg.gamescopeSession; #steamos like big picture mode session
    };

    # For detecting proton-ge
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    nixpkgs.overlays = mkIf cfg.xorgPackageOverlay [
      (final: prev: {
        steam = prev.steam.override ({extraPkgs ? pkgs': [], ...}: {
          extraPkgs = pkgs':
            (extraPkgs pkgs')
            ++ (with pkgs'; [
              libgdiplus
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              keyutils
            ]);
        });
      })
    ];
  };
}
