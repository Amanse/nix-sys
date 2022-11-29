{config, pkgs, ...}:

{

  programs.zsh = {
    enable=true;
    shellAliases = {
	ll = "ls -l";
	update = "sudo nixos-rebuild switch";
	upgrade = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch";
	edit = "sudo nvim /etc/nixos";
	rust-nix = "nix flake init -t ~/flake-templates#rust-nix; nix flake lock;";
    };
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    ohMyZsh = {
        enable = true;
	plugins = ["git"];
	theme="robbyrussell";
    };
  };

  environment.shells = with pkgs; [ zsh ];

}
