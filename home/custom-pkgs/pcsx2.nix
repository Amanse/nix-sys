self: super: {
  pcsx2 = let
    name = "pcsx2";
    version = "1.7.5600";
  in
    super.appimageTools.wrapType1 {
      inherit name;

      src = super.fetchurl {
        url = "https://github.com/PCSX2/pcsx2/releases/download/v${version}/pcsx2-v${version}-linux-appimage-x64-Qt.AppImage";
        hash = "sha256-/BHbWNSa7eNXOdG/Ku6gzU+Y/GXdM17f2gLsf1IoaO4=";
      };
    };

  pcsx2-desktop = super.writeTextDir "share/applications/pcsx2.desktop" ''
    [Desktop Entry]
    Version=16
    Type=Application
    Name=PCSX2
    Exec=env QT_PLUGIN_PATH= pcsx2
    StartupWMClass=AppRun
  '';
}
