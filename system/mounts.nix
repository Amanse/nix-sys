{...}: {
  fileSystems."/mnt/stuff" = {
    device = "/dev/disk/by-label/stuff";
    options = ["noatime"];
  };

  fileSystems."/mnt/stuff2" = {
    device = "/dev/disk/by-label/stuff2";
    options = ["noatime"];
  };

  boot.tmp.useTmpfs = true;
}
