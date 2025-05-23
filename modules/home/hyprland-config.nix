# This store devices specific config
let
  primaryMon = "DP-3";
  secondaryMon = "DP-4";

  mice = "razer-razer-basilisk-v3";
in {
  inherit primaryMon;
  inherit secondaryMon;

  # List of monitors
  monitors = [primaryMon secondaryMon];
  monitor = [
    "${primaryMon}, preferred, 0x0, auto"
    "${secondaryMon}, preferred, 1920x0, auto"
  ];
  workspace = [
    "1, monitor:${primaryMon}, default:true"
    "2, monitor:${secondaryMon}"
  ];

  device = {
    name = mice;
    sensitivity = -0.5;
  };
}
