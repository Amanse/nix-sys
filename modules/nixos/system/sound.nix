{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkMerge;
  cfg = config.myModules.sound;
in {
  options.myModules.sound = {
    enable = mkEnableOption "enable sound(with pipewire)";
    bluetoothAudioFix = mkEnableOption "Enable the bluetooth connection/audio fix i found on internet";
    headphoneFix = mkEnableOption "Enale the wired headphone mic fix";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      sound.enable = true;
      hardware = {
        pulseaudio.enable = false;
        bluetooth = {
          enable = true;
          settings = {
            General = {
              Enable = "Source,Sink,Media,Socket";
            };
          };
        };
      };
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
        wireplumber = {
          inherit (config.services.pipewire) enable;
          configPackages = lib.optionals cfg.bluetoothAudioFix [
            (pkgs.writeTextDir "share/bluetooth.lua.d/51-bluez-config.lua" ''
              bluez_monitor.properties = {
                ["bluez5.enable-sbc-xq"] = true,
                ["bluez5.enable-msbc"] = true,
                ["bluez5.enable-hw-volume"] = true,
                ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
              }
            '')
          ];
        };
      };
    }

    (mkIf cfg.headphoneFix {
      boot.extraModprobeConfig = ''
        options snd-hda-intel model=dell-headset-multi
      '';
    })

    # (mkIf cfg.bluetoothAudioFix {
    #   # @TODO find if this is updated
    #   # https://github.com/NixOS/nixpkgs/pull/292115
    #   # Borked
    #   # environment.etc = {
    #   #   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
    #   #     bluez_monitor.properties = {
    #   #     	["bluez5.enable-sbc-xq"] = true,
    #   #     	["bluez5.enable-msbc"] = true,
    #   #     	["bluez5.enable-hw-volume"] = true,
    #   #     	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
    #   #     }
    #   #   '';
    #   # };
    # })
  ]);
}
