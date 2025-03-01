{ pkgs, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings.sandbox = false;
  nix.settings.trusted-users = [ "hanjeongjun" ];
  nix.extraOptions = ''
    build-users-group = nixbld
    experimental-features = nix-command flakes
  '';

  users.users.hanjeongjun = {
    name = "hanjeongjun";
    home = "/Users/hanjeongjun";
  };
  #programs.zsh.enable = true;
  programs.fish.enable = true;
  system.stateVersion = 4;
}
