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
        # todo: convert kwin rules to this as close as possible
      ];
      open-floating = true;
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
