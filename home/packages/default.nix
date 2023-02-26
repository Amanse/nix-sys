{osConfig,config,pkgs,lib, ...}:
let bemoji = pkgs.callPackage ./bemoji.nix {};
in
{
    home.packages = with pkgs; [
        zip
        unzip
        unrar
        p7zip
        gcc
        ripgrep
        bat
        lokinet
        transmission
        playerctl

        brave
        google-chrome
        heroic
        lutris
        sioyek
        logseq
        bemoji
    ];
}
