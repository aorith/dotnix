{ nixpkgs ? <nixpkgs>, system ? "x86_64-linux", config, pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  time.timeZone = "Europe/Madrid";
  networking = {
    hostName = "trantor";
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
  users.extraUsers.root.password = "root";
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCx2MbdR3PwSOrBFAlv4F8W0gNCRUa23b+YmGgRuwFTb9BmspWZ6bqUFZhDmBBLZMIh+1iatg6ZOlZhFmbbzRMXO+X1AX79QuKeRLb7doIdPiLvSgYyydurQZNYvG9/IbfjwpxvAt9sce52ZIuHlea/NGvPqH1J7w5sm1OP/F4iGiAh46j+/ZYXlB7kvDxwwtOx+owLJIXwmPnTgytWzjdt3IbR8aXk4h/ZMlk2s2G9LMhKq+6p/vkgEcJL1eb7R5unk97A6tWDu6lPLagMEDX+ANudl2yaLzlMzyox2BcbLl95zaXrM0VkPynsW/biQufjXbs9HFjp1/h25XAHA2xWkpqEpWGUrWhjP42mt3B4Ai4ILgAppS0JkdU+Iudff662ird5cGgOCcZru7ckDPT7cltzEUz+U3QXRZJe+nd09+zBNfhtdagw3oeXPqilxv+oKG9dgl5yTOCksicpmo2vuqNR6y9jakkvTxqV+TudW3hkSejCtWBsijM1Kwr8Qp0= aomanu@tazenda"
  ];
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };

  environment.systemPackages = with pkgs; [ bash git vim ];
}
