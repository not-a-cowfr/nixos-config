{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "__ROOT_PART__";

      content = {
        type = "gpt";

        partitions = builtins.fromJSON ''
          {
            ${
              if __ESP_PART__ != null then
                ''
                  "ESP": {
                    "size": "512M",
                    "type": "EF00",
                    "content": {
                      "type": "filesystem",
                      "format": "vfat",
                      "mountpoint": "/boot",
                      "mountOptions": ["umask=0077"]
                    }
                  },
                ''
              else
                ""
            }

            "root": {
              "size": "100%",
              "content": {
                "type": "btrfs",
                "extraArgs": ["-f"],
                "subvolumes": {
                  "@root": { "mountpoint": "/", "mountOptions": ["compress=zstd","noatime"] },
                  "@nix":  { "mountpoint": "/nix", "mountOptions": ["compress=zstd","noatime"] },
                  "@home": { "mountpoint": "/home", "mountOptions": ["compress=zstd"] },
                  "@swap": { "mountpoint": "/.swapvol", "swap": { "swapfile": { "size": "8G" } } }
                }
              }
            }
          }
        '';
      };
    };
  };
}
