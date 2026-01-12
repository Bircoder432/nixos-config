{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.osatui.homeManagerModules.osatui ];
  osatui.enable = true;
  osatui.config = {
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
  };
  home.packages = [
    inputs.osatui.defaultPackage
  ];
}
