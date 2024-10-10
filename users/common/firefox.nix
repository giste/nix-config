{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "es-ES" "en-US" ];

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      #DontCheckDefaultBrowser = true;
      #DisablePocket = true;
      SearchBar = "separate";
      OverrideFirstRunPage = "";

      FirefoxHome = # Make new tab only show search
      {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      Preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
      };
    };

    profiles = {
      default = {
        id = 0;
        name = "default";

        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.search.region" = "ES";
          "browser.search.isUS" = false;
          "distribution.searchplugins.defaultLocale" = "es-ES";
          "general.useragent.locale" = "es-ES";
          "intl.locale.requested" = "es-ES,en-US";
          "browser.translations.automaticallyPopup" = false;
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