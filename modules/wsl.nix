{pkgs, ...}: {
  wsl.enable = true;
  wsl.defaultUser = "liribell";

  # VSCode need this
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
