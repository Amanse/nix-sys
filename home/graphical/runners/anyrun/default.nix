{
  anyrun,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        anyrun.packages.${pkgs.system}.applications
        # anyrun.packages.${pkgs.system}.symbols
      ];
      width = {fraction = 0.3;};
      position = "top";
      verticalOffset = {absolute = 0;};
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = 20;
    };
  };
}
