{ pkgs, systemSettings, userSettings, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    userName = userSettings.gitName;
    userEmail = userSettings.gitEmail;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = [
        (userSettings.dotFilesDir)
        (userSettings.dotFilesDir + "/.dotfiles/.git")
      ];
    };
  };
}
