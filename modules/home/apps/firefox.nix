{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DisplayBookmarksToolbar = true;
    };
    profiles = {
      sophia = {
        isDefault = true;

        settings = {
          "browser.startup.homepage" = "https://duckduckgo.com/";
          "extensions.autoDisableScopes" = 0;
          DisableTelemetry = true;
          DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
        };

        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          youtube-shorts-block
          nighttab
        ];

        search = {
        force = true;
        default = "DuckDuckGo";
          engines = {
            "Google" = {
              urls = [{
                template = "https://google.com/search";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "!g" "!google" ];
            };
            "YouTube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results?search_query={searchTerms}";
                  parms = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://www.youtube.com/s/desktop/a7b1ec23/img/favicon_32x32.png";
              definedAliases = [ "!yt" ];
            };
            "Home Manager NixOs" = {
              urls = [
                {
                  template = "https://mipmip.github.io/home-manager-option-search/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "!hm" "!home" ];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "!np" "!pkgs" ];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "!no" "!options" ];
            };
          };
        };
        bookmarks = {
          toolbar = {
            name = "My toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "Nixpkgs";
                tags = [ "nix" "nixos" "pkgs" "search" ];
                keyword = "nixpkgs";
                url = "https://search.nixos.org/packages";
              }

              {
                name = "HM Search";
                tags = [ "nix" "home-manager" "pkgs" "hm" "search" ];
                keyword = "home-manager";
                url = "https://home-manager-options.extranix.com/";
              }

              {
                name = "NUR";
                tags = [ "nix" "pkgs" "search" "users" ];
                keyword = "nur";
                url = "https://nur.nix-community.org/";
              }
            ];
          };
        };

        userChrome = ''
          * Clean Urlbar */

          #urlbar,
          #searchbar {
            font-size: 13px !important;
            margin-top: 1px !important;
          }

          #urlbar-background,
          #searchbar {
            border: none !important;
            background-color: var(--urlbar-background-color) !important;
            animation-name: none !important;
            box-shadow: none !important;
          }

          #urlbar[breakout][breakout-extend]>#urlbar-background {
            background-color: var(--urlbar-background-color) !important;
            background-image: var(--lwt-additional-images) !important;
            background-repeat: var(--lwt-background-tiling) !important;
            background-position: var(--lwt-background-alignment) !important;
          }

          #urlbar[open]>.urlbarView>.urlbarView-body-outer>.urlbarView-body-inner {
            border: none !important;
          }

          .urlbarView-row[selected]>.urlbarView-row-inner,
          .urlbarView-row-inner[selected] {
            background: #3A3941 !important;
          }

          #nav-bar:not([tabs-hidden="true"]) {
            box-shadow: none !important;
          }

          #navigator-toolbox {
            border-bottom: none !important;
          }
        '';
      };
    };
  };
}
