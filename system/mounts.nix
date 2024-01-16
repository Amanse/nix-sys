{...}: {
  fileSystems."/mnt/stuff" = {
    device = "/dev/disk/by-label/Stuff";
    fsType = "ntfs-3g";
    options = ["rw" "uid=me"];
  };

  fileSystems."/mnt/stuff2" = {
    device = "/dev/disk/by-label/stuff2";
  };

  fileSystems."/mnt/stuff3" = {
    device = "/dev/disk/by-label/stuff3";
  };

  boot.tmp.useTmpfs = true;
}
