{ config, lib, ... }:
let
  cfg = config.features.programs.cli.btop;
in
{
  options.features.programs.cli.btop.enable = lib.mkEnableOption "btop";

  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;

      settings = {
        update_ms = 1000;
        temp_scale = "fahrenheit";
        proc_sorting = "memory";

        save_config_on_exit = false;
      };
    };
  };
}
