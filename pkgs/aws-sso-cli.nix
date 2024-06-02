{
  buildGo121Module,
  fetchFromGitHub,
  lib,
  makeWrapper,
  xdg-utils,
}:
buildGo121Module rec {
  pname = "aws-sso-cli";
  version = "1.15.1";

  src = fetchFromGitHub {
    owner = "synfinatic";
    repo = pname;
    rev = "v${version}";
    hash = "";
  };

  vendorHash = "`";
  nativeBuildInputs = [makeWrapper];

  ldflags = [
    "-X main.Version=${version}"
    "-X main.Tag=nixpkgs"
  ];

  postInstall = ''
    wrapProgram $out/bin/aws-sso \
      --suffix PATH : ${lib.makeBinPath [xdg-utils]}
  '';

  checkFlags = [
    # requires network access
    "-skip=TestAWSConsoleUrl|TestAWSFederatedUrl"
  ];

  meta = with lib; {
    homepage = "https://github.com/synfinatic/aws-sso-cli";
    description = "AWS SSO CLI is a secure replacement for using the aws configure sso wizard";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [devusb];
    mainProgram = "aws-sso";
  };
}
