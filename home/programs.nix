{
  pkgs,
  config,
  ...
}: {
  programs = {
    mpv = {
      enable = true;
      config = {
        force-window = true;
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
      };
      scripts = with pkgs; [mpvScripts.mpris];
    };

    go.enable = true;

    zellij.enable = true;

    mangohud.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-index-database.comma.enable = true;

    zoxide.enable = true;
    zoxide.options = ["--no-aliases"];
    zsh.initExtra = pkgs.lib.mkIf config.programs.zoxide.enable (pkgs.lib.concatLines ["alias cd='__zoxide_z'" "alias cdi='__zoxide_zi'"]);

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };

    chromium = {
      enable = true;
      package = pkgs.google-chrome;
      commandLineArgs = ["--enable-features=VaapiVideoEncoder,VaapiVideoDecoder"];
    };
  };
}
