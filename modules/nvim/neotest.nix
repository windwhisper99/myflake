{pkgs, ...}: {
  programs.nixvim = {
    plugins.neotest = {
      enable = true;

      adapters = {
        rust.enable = true;
      };
    };
  };
}
