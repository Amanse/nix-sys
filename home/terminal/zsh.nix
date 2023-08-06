{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    sessionVariables = {EDITOR = "nvim";};

    initExtra = ''

      bindkey -v


      function get_shell_info() {
      if [[ -v SOME_VARIABLE ]]; then
        echo "";
      else
        echoti bel;
      fi
      }

    '';

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "sha256-DWVFBoICroKaKgByLmDEo4O+xo6eA8YO792g8t8R7kA=";
        };
      }
    ];
  };

  #command_not_found integration
  programs.nix-index.enable = true;
}
