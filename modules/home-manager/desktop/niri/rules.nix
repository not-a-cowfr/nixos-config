{
  window-rules = [
    {
      geometry-corner-radius = {
        bottom-left = 15.0;
        bottom-right = 15.0;
        top-left = 15.0;
        top-right = 15.0;
      };
      clip-to-geometry = true;
    }
    {
      matches = [
        {
          app-id = ".*ghostty.*";
          at-startup = true;
        }
        {
          app-id = ".*github.*";
          at-startup = true;
        }
      ];

      open-on-workspace = "terminal";
    }
    {
      matches = [
        {
          app-id = ".*codium.*";
          at-startup = true;
        }
      ];

      open-on-workspace = "code";
    }
    {
      matches = [
        {
          app-id = ".*zen.*";
          at-startup = true;
        }
        {
          app-id = ".*zoom.*";
          at-startup = true;
        }
      ];

      open-on-workspace = "personal";
    }
    {
      matches = [
        {
          app-id = ".*(leg|dis|equi|ven)cord.*";
          at-startup = true;
        }
        {
          app-id = ".*steam.*";
          at-startup = true;
        }
      ];

      open-on-workspace = "gaming";
    }
  ];

  layer-rules = [
    {
      matches = [
      ];
      place-within-backdrop = true;
    }
  ];
}
