{
  layout = {
    gaps = 10;
    insert-hint.enable = false;

    center-focused-column = "never";
    background-color = "transparent";

    preset-column-widths = [
      { proportion = 0.33333; }
      { proportion = 0.5; }
      { proportion = 0.66667; }
    ];

    default-column-width = {
      proportion = 0.5;
    };

    shadow = {
      enable = true;
      softness = 10;
      spread = 5;
      offset = {
        x = 0;
        y = 0;
      };
    };
  };

  # workspaces = {
  #   "1".name = "terminal";
  #   "2".name = "code";
  #   "3".name = "personal";
  #   "4".name = "gaming";
  # };
}
