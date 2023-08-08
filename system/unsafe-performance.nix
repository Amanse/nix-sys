{...}: {
  # https://github.com/kurnevsky/nixfiles/blob/master/modules/unsafe-performance.nixfiles
  # Also chris titus
  boot = {
    kernel.sysctl."kernel.split_lock_mitigate" = 0;
    kernelParams = ["mitigations=off"];
  };
}
