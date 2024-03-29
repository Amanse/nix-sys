{
  pkgs,
  config,
  ...
}: let
  sessionize = pkgs.writeShellApplication {
    name = "tmux-sessionizer";
    text = ''

      if [[ $# -eq 1 ]]; then
          selected=$1
      else
          selected=$(find ~/windows/Academia ~/stuff/projects  -mindepth 1 -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf)
      fi

      if [[ -z "$selected" ]]; then
          exit 0
      fi

      ${pkgs.zellij}/bin/zellij  -c "$selected"

    '';
  };

  lfcd =
    if config.programs.lf.enable
    then ''      
      function lfcd () {
            # `command` is needed in case `lfcd` is aliased to `lf`
            cd "$(command lf -print-last-dir "$@")"
        } ''
    else "";

  extract = ''
        function extract() {
          if [ -z "$1" ]; then
    # display usage if no parameters given
            echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso>"
              echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
          else
            for n in "$@"
              do
                if [ -f "$n" ] ; then
          case "''${n%,}" in
                  *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    ${pkgs.gnutar}/bin/tar xvf "$n"       ;;
                  *.lzma)     ${pkgs.xz}/bin/unlzma ./"$n"      ;;
                  *.bz2)      ${pkgs.bzip2}/bin/bunzip2 ./"$n"     ;;
                  *.cbr|*.rar)${pkgs.unrar}/bin/unrar x -ad ./"$n" ;;
                  *.gz)        gunzip ./"$n"      ;;
                  *.cbz|*.epub|*.zip) ${pkgs.unzip}/bin/unzip ./"$n"   ;;
                  *.z)         uncompress ./"$n"  ;;
                  *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                    ${pkgs.p7zip}/bin/7z x ./"$n"        ;;
                  *.xz)        unxz ./"$n"        ;;
                  *.exe)       cabextract ./"$n"  ;;
                  *.cpio)      cpio -id < ./"$n"  ;;
                  *.cba|*.ace) unace x ./"$n"     ;;
                  *.zpaq)      zpaq x ./"$n"      ;;
                  *.arc)       arc e ./"$n"       ;;
                  *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                    extract "$n.iso" && \rm -f "$n" ;;
                  *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                    mv ./"$n.tmp" ./"''${n%.*zlib}" && rm -f "$n"   ;;
                  *)
                    echo "extract: '$n' - unknown archive method"
                    return 1
                    ;;
                  esac
                else
                  echo "'$n' - file doesn't exist"
                    return 1
                    fi
                    done
                    fi
        ${pkgs.libnotify}/bin/notify-send "'$n' extracted"
        }

  '';
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "robbyrussell";
    };

    sessionVariables = {EDITOR = "nvim";};

    initExtra = ''
      function get_shell_info() {
        if [[ -v SOME_VARIABLE ]]; then
          echo "";
        else
          echoti bel;
        fi
      }

      ${lfcd}

      ${extract}

      bindkey -v
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
    shellAliases = {
      hmu = "home-manager switch --flake /home/me/nix-sys/home#me";
      du = "${pkgs.lib.getExe pkgs.du-dust}";
      m = "mkdir -p";
      ls = "ls --color=yes";
      cat = "${pkgs.lib.getExe pkgs.bat}";
      grep = "${pkgs.lib.getExe pkgs.ripgrep}";
      npm = ''${pkgs.lib.getExe' pkgs.nodePackages_latest.pnpm "pnpm"}'';
    };
  };

  #command_not_found integration
  programs.nix-index.enable = true;
}
