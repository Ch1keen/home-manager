{ pkgs }:

let
  # for python
  python-with-my-packages = pkgs.python311.withPackages (import ./python-packages.nix);

  # for ruby
  ruby-with-my-packages = pkgs.ruby.withPackages (import ./ruby-packages.nix);

  rizin-packages = pkgs.rizin.withPlugins (ps: with ps; [ jsdec rz-ghidra sigdb ]);
in [
  pkgs.fd
  pkgs.file
  pkgs.unzip
  pkgs.wget
  pkgs.cmake
  pkgs.gnumake
  pkgs.rlwrap

  # Programming Languages
  pkgs.ghc
  python-with-my-packages
  ruby-with-my-packages
  pkgs.rustup
  pkgs.guile_3_0
  pkgs.chicken
  pkgs.nodejs
  #pkgs.php
  pkgs.purescript
  #pkgs.deno

  # Web Development
  pkgs.static-web-server

  # Hacking Related
  #pkgs.one_gadget   # Collides in dependency hell
  pkgs.gef  # python 3.10 ropper 1.13.8 marked as broken in darwin
  pkgs.pwndbg
  pkgs.upx
  #pkgs.metasploit
  #pkgs.ronin
  pkgs.exiftool
  #pkgs.exiftags
  pkgs.binwalk
  pkgs.socat

  rizin-packages

  # Password Cracker
  pkgs.hashcat
  pkgs.john

  # Virtualisation
  pkgs.qemu
  #pkgs.cloud-utils

  # OCI(Open Container Initiative)
  pkgs.podman-compose
  #pkgs.buildah
  pkgs.podman-tui

  # Eye candy
  pkgs.neofetch
  pkgs.htop
]
