{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      bindkey -v

      export PATH="''${HOME}/.cargo/bin:''${HOME}/.local/bin:''${HOME}/go/bin:''${HOME}/.npm/bin:''${PATH}"
      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
      export EDITOR=nvim

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
                              tar xvf "$n"       ;;
                          *.lzma)      unlzma ./"$n"      ;;
                          *.bz2)       bunzip2 ./"$n"     ;;
                          *.cbr|*.rar) unrar x -ad ./"$n" ;;
                          *.gz)        gunzip ./"$n"      ;;
                          *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
                          *.z)         uncompress ./"$n"  ;;
                          *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                              7z x ./"$n"        ;;
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
      }

      n ()
{
    # Block nesting of nnn in subshells
    if [[ "$NNNLVL" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

    '';

    shellAliases = {
      edit = "nvim ~/nix-sys/";
      update = "sudo nixos-rebuild switch --flake '/home/me/nix-sys#nixxy'";
      upgrade = "cd ~/nix-sys/ && nix flake update && update";
      hmu = "home-manager switch --flake 'path:/home/me/nix-sys/nixpkgs#me' --impure";
      hme = "nvim ~/nix-sys/nixpkgs";
      m = "mkdir -p";
      ls = "ls --color=yes";
      cat = "${pkgs.lib.getExe pkgs.bat}";
      sc = "sudo systemctl";
      grep = "${pkgs.lib.getExe pkgs.ripgrep}";
      rs = "rsync --progress";
    };

    plugins = with pkgs; [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
    ];
  };
}
