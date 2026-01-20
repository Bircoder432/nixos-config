{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.osatui.homeManagerModules.x86_64-linux.osatui ];
  programs.osatui.enable = true;
  programs.osatui.package = inputs.osatui.packages.${pkgs.system}.osatui;
  programs.osatui.settings = {
    api = {
      url = "https://api.thisishyum.ru/schedule_api/tyumen";
      college_id = 1;
      campus_id = 4;
      group_id = 161;
    };
    app = {
      refresh_interval = 600;
      cache_enabled = true;
      cache_ttl = 1800;
      current_theme = "dark";
    };
    keymap = {
      prev_day = "Left";
      cur_day = "Up";
      next_day = "Right";

      selector = {
        Char = "o";
      };
      settings = {
        Char = "s";
      };
      exit = {
        Char = "q";
      };
    };
  };
}
