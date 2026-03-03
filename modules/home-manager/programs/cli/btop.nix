{ ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      update_ms = 1000;
      temp_scale = "fahrenheit";
      proc_sorting = "memory";

      save_config_on_exit = false;
    };
  };
}
