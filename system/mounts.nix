{...}: {
  fileSystems."/mnt/stuff" = {
    device = "/dev/disk/by-label/Stuff";
    fsType = "ntfs-3g";
    options = ["rw" "uid=me"];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-label/Windows";
    fsType = "ntfs-3g";
    options = ["rw" "uid=me"];
  };

  swapDevices = [
    {device = "/dev/disk/by-label/swap";}
  ];

  boot.tmp.useTmpfs = true;
}
