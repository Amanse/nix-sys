{config, ...}: {
  networking.hostName = "jotaro";

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPorts = [41641];
      # 24070 = steam wifi sharing games
      allowedTCPPorts = [24070];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };

    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };

  time.timeZone = "Asia/Kolkata";
  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
  };

  # Disable NetworkManager-wait-online to increase boot times (adds upto 11s to booting for me)
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.bluetooth.enable = false;
  systemd.services.tailscale.enable = false;
}
