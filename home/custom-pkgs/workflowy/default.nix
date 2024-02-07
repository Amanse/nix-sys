self: super: {
  workflowy = super.appimageTools.wrapType1 {
    name = "workflowy";
    version = "v4.0.2401302113";

    src = super.fetchurl {
      url = "https://github.com/workflowy/desktop/releases/latest/download/WorkFlowy-x86_64.AppImage";
      hash = "sha256-IJTmVrwiGMnAy+/QUkc1RMkIqOtHHrW2FLXMhUO7kdw=";
    };
  };
  workflowy-desktop = super.writeTextDir "share/applications/workflowy.desktop" ''
    [Desktop Entry]
    Version=16
    Type=Application
    Name=workflowy
    Exec=workflowy
    StartupWMClass=AppRun
  '';
}
