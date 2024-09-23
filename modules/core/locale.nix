{ config, lib, ... }:

{
  # Select internationalization properties.
  i18n.defaultLocale = lib.mkDefault "es_ES.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    keyMap = lib.mkDefault "es";
    useXkbConfig = lib.mkDefault true; # use xkb.options in tty.
  };
}