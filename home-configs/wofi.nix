{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      prompt = "Run:";
      term = "alacritty";
      insensitive = true;
      allow_images = true;
      width = 400;
      height = 300;
      lines = 10;
      columns = 1;
      hide_scroll = true;
      no_actions = true;
      allow_markup = false;
      location = "center";
      anchor = "center";
      always_parse_args = true;
    };

    style = ''
      window {
        background-color: rgba(20, 20, 20, 0.80);
        border: 3px solid #690000;
        border-radius: 12px;
        font-family: JetBrainsMono, monospace;
        font-size: 14px;
        color: #cdd6f4;
      }

      #input {
        margin: 8px;
        border: 2px solid #690000;
        border-radius: 6px;
        padding: 6px;
        background-color: #000000;
        color: #ffffff;
        outline: none;
      }

      #input:focus {
        border: 2px solid #690000;
        background-color: #000000;
        outline: none;
      }

      #entry {
        padding: 6px;
        margin: 2px;
      }

      #entry:selected {
        margin: 4px;
        background-color: #690000;
        color: #cdd6f4;
        border-radius: 6px;
      }
    '';
  };
}
