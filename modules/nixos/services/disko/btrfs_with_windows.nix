{ configFile, ... }:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = configFile.computer.disk;

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            size = "1000M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          nixos = {
            size = "50%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
                "@swap" = {
                  mountpoint = "/.swapvol";
                  mountOptions = [ "nodatacow" ];
                  swap.swapfile.size = "8G";
                };
              };
            };
          };

          windows = {
            size = "100%";
            type = "0700";
          };
        };
      };
    };
  };
}
