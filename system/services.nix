{pkgs, ...}: {
  services = {
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "schedutil";
          caling_max_freq = "2000000";
          turbo = "auto";
        };
      };
    };

    # cpupower-gui.enable = true;

    dbus.packages = [pkgs.gnome.gnome-session pkgs.libsForQt5.kdeconnect-kde];
    dbus.enable = true;

    blueman.enable = true;

    # acpid.enable = true;

    openssh.enable = true;

    resilio = {
      enable = true;
      deviceName = "nixxy";
      enableWebUI = true;
    };

    # tailscale.enable = true;

    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_SCALING_GOVERNOR_ON_BAT = "ondemand";
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";

    #     # 100 being the maximum, limit the speed of my CPU to reduce
    #     # heat and increase battery usage:
    #     # CPU_MAX_PERF_ON_AC = 100;
    #     # CPU_MAX_PERF_ON_BAT = 80;
    #   };
    # };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
}
