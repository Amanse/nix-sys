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

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-index-database.comma.enable = true;

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
