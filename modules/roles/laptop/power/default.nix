{
  config,
  lib,
  pkgs,
  ...
}: let
  MHz = x: x * 1000;
  role = config.host.role;
in
  with lib; {
    config = mkIf (role == "laptop" || role == "hybrid") {
      boot = {
        kernelModules = ["acpi_call"];
        extraModulePackages = with config.boot.kernelPackages; [
          acpi_call
          cpupower
          pkgs.cpupower-gui
        ];
      };

      environment.systemPackages = with pkgs; [
        acpi
        powertop
      ];

      hardware.acpilight.enable = true;

      services = {
        acpid = {
          enable = true;
          # lidEventCommands = ''
          #   export PATH=$PATH:/run/current-system/sw/bin

          #   lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
          #   if [ $lid_state = "closed" ]; then
          #       systemctl suspend
          #   fi
          # '';

          powerEventCommands = ''
            systemctl suspend
          '';
        };

        # superior power management
        auto-cpufreq.enable = true;
        #power-profiles-daemon.enable = !config.host.features.powermanagement.laptop.enable;

        logind = {
          lidSwitch = "ignore";
          extraConfig = ''
            HandlePowerKey=ignore
          '';
        };

        # temperature target on battery
        undervolt = {
          tempBat = 65; # deg C
          package = pkgs.undervolt;
        };

        udev.extraRules = ''
          SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="0",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
          SUBSYSTEM=="power_supply",ENV{POWER_SUPPLY_ONLINE}=="1",RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
          SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${pkgs.tlp}/bin/tlp ac"
          SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${pkgs.tlp}/bin/tlp bat"
        '';

        upower = {
          enable = true;
          percentageLow = 15;
          percentageCritical = 5;
          percentageAction = 3;
          criticalPowerAction = "HybridSleep";
        };
      };
    };
  }
