{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "wallust";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
    };
  };
}
