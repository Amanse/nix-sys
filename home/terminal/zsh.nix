{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    zplug = {
      enable = true;
      plugins = [
        {name = "zdharma-continuum/fast-syntax-highlighting";}
        {
          name = "romkatv/powerlevel10k";
          tags = [as:theme depth:1];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
  };
}
