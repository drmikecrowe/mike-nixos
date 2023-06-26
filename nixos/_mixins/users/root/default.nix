{ config, pkgs, ...}:
{
  users.users.root = {
    hashedPassword = null;
    openssh.authorizedKeys.keys = [
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1KoDe7aKQU8yUMOuRPOIA7Mqu5vbUSBe9sVs7yyFkuXuHAEEBTABfBYo7ZzwqPUXeltW5uNjJmeZBPBZChxzcZLF4J1vd5BYqFjHBcSLSZzvWZ4BNN1ZBy2ACKOgInHWwoHA7ruJ/A0WvHdiNBiYwg5xMaYE8sYZUA22jvS+gXo46fRo7HfMTBlVap0G3xfNbMEiez1+1W56tnOIsOzcmJ17+YuJtZCDNd4A8Oz6heYjiDwtIDosUi5yU3SAqxi1unYiaYdwSI5vigz6f9dqg7/CVO3cIiJwlt2d2vjXF+k8XfgrjGKJibAhNv4bE1pdP1IDCTXTliA63qRATKSj1
    ];
  };
}
