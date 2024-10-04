{ lib, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = lib.mkDefault "main";
    };
  };
}