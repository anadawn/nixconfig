{ pkgs, ... }:
let
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${swaylock} -fc 000000 ";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${swaylock} -fc 000000";
      }
      {
        timeout = 600;
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
      }
    ];
  };
}
