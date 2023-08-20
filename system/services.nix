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
          governor = "ondemand";
          caling_max_freq = "1500000";
          turbo = "auto";
        };
      };
    };

    cpupower-gui.enable = true;

    dbus.packages = [pkgs.gnome.gnome-session];
  };
}
