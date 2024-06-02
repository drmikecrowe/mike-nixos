{...}: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    domainName = "local";
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };
}
