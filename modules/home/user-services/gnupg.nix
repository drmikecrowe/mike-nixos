{
  custom,
  pkgs,
  lib,
  ...
}: {
  programs = {
    gpg.enable = true;
    gpg.settings = {
      # https://github.com/drduh/YubiKey-Guide
      # https://github.com/drduh/config/blob/master/gpg.conf
      cert-digest-algo = "SHA512";
      charset = "utf-8";
      default-preference-list = ["SHA512" "SHA384" "SHA256" "AES256" "AES192" "AES" "ZLIB" "BZIP2" "ZIP" "Uncompressed"];
      fixed-list-mode = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      no-symkey-cache = true;
      personal-cipher-preferences = ["AES256" "AES192" "AES"];
      personal-compress-preferences = ["ZLIB" "BZIP2" "ZIP" "Uncompressed"];
      personal-digest-preferences = ["SHA512" "SHA384" "SHA256"];
      require-cross-certification = true;
      s2k-cipher-algo = "AES256";
      s2k-digest-algo = "SHA512";
      throw-keyids = true;
      use-agent = true;
      verify-options = "show-uid-validity";
      with-fingerprint = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400; # Resets when used
    defaultCacheTtlSsh = 86400; # Resets when used
    maxCacheTtl = 34560000; # Can never reset
    maxCacheTtlSsh = 34560000; # Can never reset
    pinentryFlavor =
      if custom.gui
      then "qt"
      else "tty";
  };
}
