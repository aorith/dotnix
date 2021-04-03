{ nixpkgs ? <nixpkgs>, system ? "x86_64-linux", config, pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ git vim mkpasswd ];

  time.timeZone = "Europe/Madrid";
  networking = {
    hostName = "trantor";
    hostId = "e7919205";
    usePredictableInterfaceNames = true;
    interfaces = {
      enp6s0f0 = {
        ipv4.addresses = [{
          address = "192.168.1.7";
          prefixLength = 24;
        }];
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules =
      [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };

  users.extraUsers.root.password = "root";
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
}
