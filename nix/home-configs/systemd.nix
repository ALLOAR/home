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
      ExecStart = "/home/alloar/nix/home-configs/scripts/swww.sh";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.git = {
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
#------battery---------------------------------------------------------------------
  systemd.user.services.battery = {
    Unit = {
      Description = "checking battery and give advice";
      Wants = [ "battery.timer" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "/home/alloar/nix/home-configs/scripts/battery.sh";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.battery = {
    Unit = {
      Description = "Run checking battery and give advice";
    };

    Timer = {
      OnCalendar = "*:0/1";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
