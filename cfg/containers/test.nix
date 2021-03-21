# login sudo nixos-container root-login wasabi

{
  containers.wasabi = {
    ephemeral = true;
    autoStart = true;
    config = { config, pkgs, ... }: {
      services.httpd.enable = true;
      services.httpd.adminAddr = "foo@example.org";
      services.httpd.virtualHosts.localhost.documentRoot = "/var/www";
      networking.firewall.allowedTCPPorts = [ 80 ];
    };
    bindMounts = {
      "/var/www" = {
        hostPath = "/srv/wasabi/";
        isReadOnly = false;
      };
    };
  };
}

