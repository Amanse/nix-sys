{...}: {
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile /home/me/.ssh/id_rsa.pub}";

  programs.git = {
    enable = true;
    userName = "AmanSe";
    userEmail = "amansetiarjp@gmail.com";
    ignores = [
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
      ".envrc"
    ];
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_rsa.pub";
      push.default = "current";
    };
    aliases = {
      s = "status";
      c = "commit";
      cm = "commit -m";
      l = ''log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
      p = "push";
      a = "add .";
    };
  };
}
