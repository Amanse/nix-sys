self: super: {
  cemu = let
    name = "cemu";
    version = "2.0-67";
  in
    super.appimageTools.wrapType1 {
      inherit name;

      src = super.fetchurl {
        url = "https://github.com/cemu-project/Cemu/releases/download/v${version}/Cemu-${version}-x86_64.AppImage";
        hash = "sha256-LBCbwbJghiK7AUa5x0GWp+udYSLA9jt1BmWu4+aFZJE=";
      };
    };

  cemu-desktop = super.writeTextDir "share/applications/cemu.desktop" ''
    [Desktop Entry]
    Version=16
    Type=Application
    Name=Cemu
    Exec=cemu
    StartupWMClass=AppRun
  '';
}
