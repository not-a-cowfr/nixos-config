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
      geometry-corner-radius =
        let
          radius = 4.0;
        in
        {
          top-left = radius;
          top-right = radius;
          bottom-left = radius;
          bottom-right = radius;
        };
      clip-to-geometry = true;
      default-column-width.proportion = 1. / 3.;
    }
  ];

  layer-rules = [
    {
      matches = [ ];
      place-within-backdrop = true;
    }
  ];
}
