{ pkgs, ... }:

let
  basic_packages = import ../src/packages.nix { inherit pkgs; };
in
 {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ch1keen";
  home.homeDirectory = "/home/ch1keen";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  home.packages = basic_packages;

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  imports = [
    #../src/tmux.nix
    ../src/neovide.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    #enableZshIntegration = true;
    #enableFishIntegration = true; (It's enabled by default, and it's read only.)
    nix-direnv.enable = true;
  };

  # Other programs
  fonts.fontconfig.enable = true;
  programs.go.enable = true;
  programs.yt-dlp.enable = true;

  programs.fish.enable = true;
  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;

  programs.zellij.enable = true;
  programs.zellij.enableFishIntegration = true;
  programs.zellij.settings = {
    default_shell = "fish";
    simplified_ui = true;
    copy_command = "xclip -selection clipboard";
  };


  # Modern Unix
  programs.bat.enable = true;
  programs.bat.extraPackages = with pkgs.bat-extras; [ batgrep prettybat ];
  programs.ripgrep.enable = true;
  programs.jq.enable = true;
  programs.eza.enable = true;
  programs.eza.enableFishIntegration = true;
  programs.eza.icons = "auto";
  programs.less.enable = true;

  # opam (OCaml)
  programs.opam = {
    enable = true;
    enableFishIntegration = true;
  };

  # git
  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.gitui.enable = true;

  programs.git.userEmail = "gihoong7@gmail.com";
  programs.git.userName = "Ch1keen";
  programs.git.delta.enable = true;
}
