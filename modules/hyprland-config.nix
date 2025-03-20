# This store devices specific config
let
  primaryMon = "DP-4";
  secondaryMon = "DP-3";

  mice = "razer-razer-basilisk-v3";
in {
  inherit primaryMon;
  inherit secondaryMon;

  # List of monitors
  monitors = [ primaryMon secondaryMon ];
  monitor = [
    "${primaryMon}, preferred, 0x0, auto"
    "${secondaryMon}, preferred, 1920x0, auto"
  ];
  workspace = [
    "name:primary, monitor:${primaryMon}, default:true"
    "name:doc, monitor:${secondaryMon}"
    "name:discord, monitor:${secondaryMon}, on-created-empty:[float] discord"
  ];

  device = {
    name = mice;
    sensitivity = -0.5;
  };
}
