{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      #DontCheckDefaultBrowser = true;
      #DisablePocket = true;
      SearchBar = "separate";
    };

    #languagePacks = [ "es-ES" ];
    profiles = {
      default = {
        id = 0;
        name = "default";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";
        };
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = ["DuckDuckGo" "Google"];
        };
      };
    };
  };

}