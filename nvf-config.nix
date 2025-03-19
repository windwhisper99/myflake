{ pkgs, lib, ... }: {
  vim.theme.enable = true;
  vim.theme.name = "gruvbox";
  vim.theme.style = "dark";

  vim.language.nix.enable = true;
}
