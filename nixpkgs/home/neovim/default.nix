{...}:
{
  programs.neovim = {
    enable=true;
    extraConfig = 
    ''
    lua << EOF 
    ${builtins.readFile ../../../nvim/init.lua}
    '';
    defaultEditor=true;
  };
}
