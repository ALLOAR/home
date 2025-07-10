{ config, pkgs, ... }:
{
#------SWWW-------------------------------------------------------------------------------------------------------------------------------------
  systemd.user.services.swww = {
    Unit = {
      Description = "Random wallpaper";
      Wants = [ "swww.timer" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "/home/alloar/nix/home-configs/scripts/swww.sh";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.swww = {
    Unit = {
      Description = "Run swww wallpaper";
    };

    Timer = {
      OnCalendar = "*:0/1";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
#------auto-commit------------------------------------------------------------------------------------------------------------------------------
  systemd.user.services.git = {
    Unit = {
      Description = "auto commit my ~/nix";
      Wants = [ "git.timer" ];
    };

    Service = {
      Type = "simple";
      #ExecStart = "/home/alloar/nix/home-configs/scripts/swww.sh";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.swww = {
    Unit = {
      Description = "Run git auto-commit";
    };

    Timer = {
      OnCalendar = "*:0/5";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };    
}
