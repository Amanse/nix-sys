{osConfig,config,pkgs,lib, ...}:
{
    home.packages = with pkgs; [
        zip
        unzip
        gcc
        ripgrep
        bat
        lokinet
        transmission

        brave
        google-chrome
        heroic
        lutris
        sioyek
        logseq
    ];
}
