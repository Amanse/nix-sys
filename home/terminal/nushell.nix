{ ... }:
{
  programs.nushell = {
    enable = true;
    envFile.text= ''
        let-env STARSHIP_SHELL = "nu";
        def create_left_prompt [] {
            starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
        }

        # Use nushell functions to define your right and left prompt
        let-env PROMPT_COMMAND = { create_left_prompt }
        let-env PROMPT_COMMAND_RIGHT = ""
    '';
  };
}
