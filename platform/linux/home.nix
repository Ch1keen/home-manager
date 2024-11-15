{ config, pkgs, ... }:

let
  basic_packages = import ../../src/packages.nix { inherit pkgs; };
  clang_packages = import ../../src/clang.nix { inherit pkgs; };
  font_packages  = import ../../src/fonts.nix { inherit pkgs; };
in {

  imports = [ ../light.nix ];

  home.packages = [
    # Utilities
    pkgs.gparted
    pkgs.github-desktop
    pkgs.simple-scan

    # Browser
    pkgs.tor-browser-bundle-bin

    # Messenger & Work
    pkgs.tdesktop
    #pkgs.slack
    #pkgs.vscode
    # slack & vscode require unfree settings, just install it manually:
    # $ NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixos.slack

    # Hacking Related
    pkgs.zap
    pkgs.ghidra
    #pkgs.burpsuite
    pkgs.radare2
    pkgs.gef  # python3.10 ropper is broken on darwin

    # Radio Signal
    #pkgs.gqrx
    #pkgs.sigdigger
  ] ++ basic_packages ++ clang_packages ++ font_packages;

  # Korean Language
  i18n.inputMethod.enabled = "kime";
  i18n.inputMethod.kime.extraConfig = ''
    daemon:
      modules: [Xim,Indicator]

    indicator:
      icon_color: White

    engine:
      hangul:
        layout: sebeolsik-3-90
        #layout: sebeolsik-3sin-p2

    #global_hotkeys.S-Space.behavior.Toggle = ["Hangul" "Latin"];
  '';

  # bluetooth
  services.blueman-applet.enable = true;

  # qutebrowser
  programs.qutebrowser.enable = true;

  # Alacritty
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    shell = "${pkgs.fish}/bin/fish";
    font.size = 8;
  };

  # Picom
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };
}
