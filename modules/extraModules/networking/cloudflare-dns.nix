{
  config,
  lib,
  ...
}: {
  options.myModules.networking.cloudflareDns = lib.mkEnableOption "Use the cloudflare 1.1.1.1 dns instead of network provided";

  config = lib.mkIf config.myModules.networking.cloudflareDns {
    networking.nameservers = ["1.1.1.1"];
    networking.networkmanager.dns = "none";
  };
}
