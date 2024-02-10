{pkgs, ...}: let
  config = {
    games = {
      name = "test";
      exec = "/mnt/iso/setup.exe";
    };
  };
  tomlFormat = pkgs.formats.toml {};
in {
  xdg.configFile."game-rs/nix.toml" = {
    source = tomlFormat.generate "nix.toml" config;
  };
}
