{osConfig,config,pkgs,lib, ...}:
{
    home.packages = with pkgs; [
        zip
        unzip
        gcc
        ripgrep
        bat

        brave
        google-chrome
        heroic
        #lutris
        lokinet
        logseq
        transmission
    ];
}
