{ pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      package =
        (pkgs.firefox.override {
          extraPolicies = {
            DontCheckDefaultBrowser = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DisplayBookmarksToolbar = "always";
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
            FirefoxHome = {
              Search = false;
              TopSites = false;
              SponsoredTopSites = false;
              Highlights = false;
              Pocket = false;
              SponsoredPocket = false;
              Snippets = false;
              Locked = true;
            };
            UserMessaging = {
              WhatsNew = false;
              ExtensionRecommendations = false;
              FeatureRecommendations = false;
              UrlbarInterventions = false;
              SkipOnboarding = true;
              MoreFromMozilla = false;
            };
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            SearchSuggestEnabled = false;
            # StartDownloadsInTempDirectory = true;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            ExtensionSettings = {
              # catpuccin theme 
              "{8446b178-c865-4f5c-8ccc-1d7887811ae3}" = {
                "allowed_types" = "theme";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-lavender-git/latest.xpi";
              };
              # vimium c 
              "vimium-c@gdh1995.cn" = {
                "allowed_types" = "theme";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
              };
              # darkreader
              "addon@darkreader.org" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              };
              # violentmonkey
              "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
              };
              # local cdn
              "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/localcdn-fork-of-decentraleyes/latest.xpi";
              };
              # bing chat for all browsers
              "{a9cb10b9-75e9-45c3-8194-d3b2c25bb6a2}" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/bing-chat-for-all-browsers/latest.xpi";
              };
              # tree style tabs
              "treestyletab@piro.sakura.ne.jp" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
              };
              # i don't care about cookies
              "jid1-KKzOGWgsW3Ao4Q@jetpack" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/i-dont-care-about-cookies/latest.xpi";
              };
              # ublock origin
              "uBlock0@raymondhill.net" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              };
              # youtube sponsor block
              "sponsorBlocker@ajay.app" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              };
              # clear urls
              "{74145f27-f039-47ce-a470-a662b129930a}" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
              };
              # adblocker for youtube
              "jid1-q4sG8pYhq8KGHs@jetpack" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/adblock-for-youtube/latest.xpi";
              };
              # imagus (image enlarger)
              "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
              };
              # swift selection
              "jid1-KdTtiCj6wxVAFA@jetpack" = {
                "allowed_types" = "extension";
                "installation_mode" = "force_installed";
                "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/swift-selection-search/latest.xpi";
              };
            };
            Preferences = {
              "browser.crashReports.unsubmittedCheck.autoSubmit2" = {
                Value = false;
                Status = "locked";
              };
              "browser.selfsupport.url" = {
                Value = "";
                Status = "locked";
              };
              "browser.aboutConfig.showWarning" = {
                Value = false;
                Status = "locked";
              };
              "browser.aboutHomeSnippets.updateUrl" = {
                Value = "";
                Status = "locked";
              };
              "browser.startup.homepage_override.mstone" = {
                Value = "ignore";
                Status = "locked";
              };
              "browser.startup.homepage_override.buildID" = {
                Value = "";
                Status = "locked";
              };
              "browser.tabs.firefox-view" = {
                Value = false;
                Status = "locked";
              };
              "dom.event.contextmenu.enabled" = {
                Value = false;
                Status = "locked";
              };
              "dom.event.clipboardevents.enabled" = {
                Value = false;
                Status = "locked";
              };
              "dom.security.https_only_mode" = {
                Value = true;
                Status = "locked";
              };
              "extensions.htmlaboutaddons.recommendations.enabled" = {
                Value = false;
                Status = "locked";
              };
              "extensions.recommendations.themeRecommendationUrl" = {
                Value = "";
                Status = "locked";
              };
              "network.IDN_show_punycode" = {
                Value = true;
                Status = "locked";
              };
              "browser.startup.homepage" = {
                Value = "/home/aruna/testfolder/anniversary-gift/index.html";
                Status = "locked";
		};
              "media.peerconnection.enabled" = {
                Value = false;
                Status = "locked";
              };
            };
          };
        });
      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;


        settings = {
          "app.shield.optoutstudies.enabled" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.firstparty.isolate" = true;
          "startup.homepage_welcome_url" = "";
          "startup.homepage_welcome_url.additional" = "";
          "startup.homepage_override_url" = "";

          #userChrome settings 
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "layout.css.overflow-overlay.enabled" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = ''#TabsToolbar
{
    visibility: collapse;
}


/* #nav-bar {
	visibility: collapse !important;
}
*/

 #PersonalToolbar{ --uc-bm-height: 20px; --uc-bm-padding: 4px; --uc-autohide-toolbar-delay: 200s; --uc-autohide-toolbar-focus-rotation: 0deg; --uc-autohide-toolbar-hover-rotation: 0deg; }

    :root[uidensity="compact"] #PersonalToolbar{ --uc-bm-padding: 1px }
    :root[uidensity="touch"] #PersonalToolbar{ --uc-bm-padding: 7px }

    #PersonalToolbar:not([customizing]){ position: relative; margin-bottom: calc(0px - var(--uc-bm-height) - 2 * var(--uc-bm-padding)); transform: rotateX(90deg); transform-origin: top; z-index: 1; }

    #PlacesToolbarItems > .bookmark-item{ padding-block: var(--uc-bm-padding) !important; }

    #nav-bar:focus-within + #PersonalToolbar{ margin-top: 61px; margin-bottom: -61px; transform: rotateX(var(--uc-autohide-toolbar-focus-rotation,0)); }

    #navigator-toolbox:hover > #PersonalToolbar{ margin-top: 61px; margin-bottom: -61px; transform: rotateX(var(--uc-autohide-toolbar-hover-rotation,0)); }

    #navigator-toolbox:hover > #nav-bar:focus-within + #PersonalToolbar {  margin-top: 61px; margin-bottom: -61px; transform: rotateX(0); }

    #nav-bar:not([customizing="true"]):not([inFullscreen]) { min-height: 0px !important; max-height: 0px !important; margin-top: 0px !important; margin-bottom: -1px !important; z-index: -5 !important; }

    #navigator-toolbox:hover:not([inFullscreen]) :-moz-any(#nav-bar), 
    #navigator-toolbox:focus-within :-moz-any(#nav-bar) {
     min-height: 38px !important; max-height: 38x !important; margin-top: 0px !important; margin-bottom: -61px !important; z-index: 5 !important; }

        #urlbar { --urlbar-toolbar-height: 38px !important; }



#back-button > .toolbarbutton-icon{
  --backbutton-background: transparent !important;
  border: none !important;
}

'';

      };
    };
  };
}
