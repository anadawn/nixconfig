  {...}: {


  #encryption
  boot.initrd.luks.devices = {
   nixos = {
    allowDiscards = true;
    bypassWorkqueues = true;
    device = "/dev/disk/by-partlabel/SYSTEM";
    preLVM = true;
   };
   };


  fileSystems."/" =
    { device = "/dev/vg0/nix";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "/dev/vg0/nix";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/vg0/nix";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/persist" =
    { device = "/dev/vg0/nix";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/vg0/swap"; }
    ];

}
  
