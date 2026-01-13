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
        height = 40;
        margin = "6 6 6 6";
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
          "custom/screencast"
        ];

        modules-right = [
          "cava"
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

        cava = {
          framerate = 30;
          autosens = 1;
          bars = 8;
          source = "auto";
          method = "pipewire";
          stereo = true;
          waves = false;
          bar_delimiter = 0;
          lower_cutoff-freq = 50;
          higher_cutoff_freq = 14000;
          monstercat = false;
          input_delay = 2;
          reverse = false;
          noise-reduction = 0.33;
          hide_on_silence = true;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
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
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
          on-scroll-up = "${pkgs.playerctl}/bin/playerctl next";
          on-scroll-down = "${pkgs.playerctl}/bin/playerctl previous";
        };

        "custom/lessons" = {
          format = "{}";
          exec = "/etc/profiles/per-user/vstor/bin/lessons";
          interval = 60;
          tooltip = false;
        };

        "custom/screencast" = {
          format = "{}";
          exec = "/etc/profiles/per-user/vstor/bin/screencast-status";
          interval = 1;
          tooltip = false;
          on-click = "/etc/profiles/per-user/vstor/bin/screencast";
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
