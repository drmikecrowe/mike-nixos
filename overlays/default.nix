final: prev: {
  openssh = prev.openssh.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ../patches/openssh.patch ];
    doCheck = false;
  });
  # aws-sso-cli = prev.aws-sso-cli.overrideAttrs (oldAttrs: rec {
  #   version = "1.14.1";
  #   src = prev.fetchFromGitHub {
  #     owner = "synfinatic";
  #     repo = "aws-sso-cli";
  #     rev = "v1.14.1";
  #     sha256 = "sha256-xSCYLqvx7lltvRLeu5Y75sdh4nLv+/mWnlWoc7OnNRI=";
  #   };
  #   vendorSha256 = "";
  # });
}
