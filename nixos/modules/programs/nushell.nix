{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nushell;
in
{
  meta.maintainers = with lib.maintainers; [
    c4f3z1n
  ];

  options = {
    programs.nushell = {
      enable = lib.mkEnableOption "Nushell";

      package = lib.mkPackageOption pkgs "nushell" { } // {
        type = lib.types.shellPackage;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [ cfg.package ];

      shells = [
        "/run/current-system/sw${cfg.package.shellPath}"
        cfg.package
      ];
    };
  };
}
