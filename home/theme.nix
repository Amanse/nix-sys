{pkgs, ...}: {
  home.sessionVariables = {
    # set GTK theme to the name specified by the gtk theme package

    # gtk applications should use filepickers specified by xdg
    GTK_USE_PORTAL = "true";
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        size = "compact";
        tweaks = ["rimless" "black"];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "blue";
        flavor = "mocha";
      };
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";

    # style = {
    #   name = "Catppuccin-Mocha-Pink-Dark";
    #   package = pkgs.catppuccin-kde.override {
    #     flavour = ["mocha"];
    #     accents = ["pink"];
    #     winDecStyles = ["modern"];
    #   };
    # };
  };
}
