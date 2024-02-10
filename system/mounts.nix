{...}: {
  fileSystems."/mnt/stuff" = {
    device = "/dev/disk/by-label/stuff";
  };

  fileSystems."/mnt/stuff2" = {
    device = "/dev/disk/by-label/stuff2";
  };

  boot.tmp.useTmpfs = true;
}
