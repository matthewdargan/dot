# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  boot = {
    initrd.availableKernelModules = ["ahci" "sd_mod" "sr_mod" "usbhid" "usb_storage" "xhci_pci"];
    kernelModules = ["kvm-amd"];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/96bf1c60-9865-4ac3-aafd-67bb110d7687";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/31D3-4AE9";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "x86_64-linux";
}