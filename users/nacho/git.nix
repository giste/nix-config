{ ... }:

{
  imports = [
    ../common/git.nix
  ];

  programs.git = {
    userName = "giste";
    userEmail = "giste.trappiste@gmail.com";
  };
}