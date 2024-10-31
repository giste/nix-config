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
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              widget-overflow-fixed-list = [];
              toolbar-menubar = [ "menubar-items" ];
              PersonalToolbar = [ "personal-bookmarks" ];
              nav-bar =
              [
                "back-button"
                "forward-button"
                "home-button"
                "stop-reload-button"
                "urlbar-container"
                "search-container"
                "bookmarks-menu-button"
                "downloads-button"
                "unified-extensions-button"
              ];
              TabsToolbar =
              [
                "firefox-view-button"
                "tabbrowser-tabs"
                "new-tab-button"
              ];
            };
            currentVersion = 20;
            newElementCount = 3;
          };
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