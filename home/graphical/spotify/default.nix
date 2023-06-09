{ spicetify-nix, pkgs,... }: {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with  spicetify-nix.packages.${pkgs.system}.default.extensions; [ shuffle fullAppDisplay popupLyrics playNext ];
    enabledCustomApps = with spicetify-nix.packages.${pkgs.system}.default.apps; [ lyrics-plus ];
    theme = spicetify-nix.packages.${pkgs.system}.default.themes.Bloom;
    colorScheme = "dark";
  };
}
