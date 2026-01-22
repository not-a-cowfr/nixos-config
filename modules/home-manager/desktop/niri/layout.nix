{
  layout = {
    gaps = 16;

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

    focus-ring = {
      width = 2;
      active = {
        color = "#7fc8ff";
      };
      inactive = {
        color = "#505050";
      };
    };

    shadow = {
      enable = true;
      softness = 30;
      spread = 4;
    };
  };

  # nix doesnt keep this order
  # and niri creates the workspaces in the order it sees them
  # so you might need to fix the order
  # using `niri msg action move-workspace-<up|down>`
  # but then it _should_ be fixed forever
  workspaces = {
    terminal = { };
    code = { };
    personal = { };
    gaming = { };
  };
}
