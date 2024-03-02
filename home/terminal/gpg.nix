{config, ...}: {
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 1209600;
    defaultCacheTtlSsh = 1209600;
    maxCacheTtl = 1209600;
    maxCacheTtlSsh = 1209600;
    extraConfig = "allow-preset-passphrase";
    enableZshIntegration = true;
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    mutableKeys = true;
  };
}
