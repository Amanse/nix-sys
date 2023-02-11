{
  pkgs,
  lib,
  config,
  inputs,
  osConfig,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 5e81acd2)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';

  xdg-desktop-portal-hyprland = inputs.xdph.packages.${prev.system}.default.override {
  hyprland-share-picker = inputs.xdph.packages.${prev.system}.hyprland-share-picker.override {inherit hyprland;};
};

in {
     home.packages = with pkgs; [
		alacritty
    		rofi
    		wl-clipboard
    		acpi
    		mako
    		pulseaudio
    		waybar
    		grim
    		playerctl
    		wlogout
    		hyprpaper
    		pavucontrol
    ];

    wayland.windowManager.hyprland = {
      enable = true;
   #   package = inputs.hyprland.packages.${pkgs.system}.default.override {
    #    nvidiaPatches = true;
     # };
      systemdIntegration = true;
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    systemd.user.services = {
      swaybg =  mkService{
        Unit.Description = "Wallpaper chooser service";
        Service = {
          ExecStart = "${lib.getExe pkgs.swaybg} -i ${./wall.png}";
          Restart = "always";
        };
      };
   };

}
