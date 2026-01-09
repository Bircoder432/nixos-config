{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Сервис systemd для запуска waybar
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "always";
      RestartSec = "0.5";
      KillMode = "process";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 6;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/media" # кастомный модуль media
          "custom/keyboard"
          "pulseaudio"
          "network"
          "tray"
          # кастомный модуль keyboard
        ];

        # -------------------
        # Настройки модулей
        # -------------------

        # Clock
        clock = {
          format = " {:%H:%M:%S}"; #  — Nerd Font clock
          tooltip-format = "{:%A, %d %B}";
          interval = 1;
        };

        # Pulseaudio
        pulseaudio = {
          format = " {volume}%"; #  — динамик Nerd Font
          format-muted = " mute";
          scroll-step = 5;
        };

        # Network
        network = {
          format-connected = " {essid}"; #  — Wi-Fi
          format-disconnected = "";
        };

        # Tray (иконки)
        tray = {
          icons = "nerdfont";
        };

        # -------------------
        # Кастомные модули
        # -------------------

        "custom/media" = {
          format = "♪ {}"; #  — музыка
          tooltip = "Media player info";
          exec = "${pkgs.playerctl}/bin/playerctl metadata --format '{{title}} - {{artist}}'";
          interval = 1;
        };

        "custom/keyboard" = {
          format = " {}"; #  — иконка клавиатуры Nerd Font
          tooltip = "Current keyboard layout";
          exec = ''
            ${pkgs.niri}/bin/niri msg -j keyboard-layouts | \
            ${pkgs.jq}/bin/jq -r '.names[.current_idx]'
          '';
          interval = 1;
        };
      };
    };
  };
}
