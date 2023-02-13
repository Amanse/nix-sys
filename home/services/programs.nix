{
    config,
    lib,
    pkgs,
    self,
    ...
}:
{
    home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/me/.ssh/id_rsa.pub}";

    programs.direnv = {
        enable=true;
        nix-direnv.enable=true;
    };

    programs.alacritty = {
        enable=true;
        settings={
            import= [ "${./rose-pine.yml}" ];
            window = {
                padding = {
                    x = 4;
                    y = 4;
                };
                dynamic_padding=true;
            };
        };
    };

    programs.mpv = {
        enable=true;
        config={
            force-window=true;
        };
    };

    programs.yt-dlp.enable=true;

    programs.git = {
        enable=true;
        userName="AmanSe";
        userEmail="amansetiarjp@gmail.com";
        ignores=[
            ".cache/"
            ".idea/"
            "*.swp"
            "*.elc"
            ".~lock*"
            "auto-save-list"
            ".direnv/"
            "node_modules"
            "result"
            "result-*"
        ];
        extraConfig={
            commit.gpgsign=true;
            gpg.format="ssh";
            gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
            user.signingkey="~/.ssh/id_rsa.pub";
            push.default="current";
        };
        aliases = {
            s = "status";
            c = "commit";
            cm = "commit -m";
            l = ''
                log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all
            '';
        };
    };

    programs.tmux.enable=true;

    services.syncthing.enable=true;
}
