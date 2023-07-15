{pkgs, ...}: {
  systemd.user.services.mega_sync = {
    Unit = {
      Description = "megasync";
      After = ["graphical-session-pre.target"];
      PartOf = ["graphical-session.target"];
    };

    Install = {WantedBy = ["graphical-session.target"];};

    Service = {ExecStart = "${pkgs.megacmd}/bin/mega-cmd-server";};
  };
}
