{
  description = "Home Manager configuration of Ch1keen";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, darwin, nixvim, ... }: {
    # home-manager switch --flake '/home/ch1keen/.config/nixpkgs#ch1keen'
    homeConfigurations.ch1keen = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        platform/linux/home.nix
	nixvim.homeManagerModules.nixvim
	src/nixvim.nix
      ];
    };

    # home-manager switch --flake '/home/ch1keen/.config/nixpkgs#ch1keen-light'
    homeConfigurations.ch1keen-light = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        platform/light.nix
        nixvim.homeManagerModules.nixvim
        {
          programs.nixvim.enable = true;
          programs.nixvim.extraConfigVim = ''
            set nu

            " Indentation
            " https://stackoverflow.com/questions/51995128/setting-autoindentation-to-spaces-in-neovim
            set autoindent
            set expandtab
            set smartindent
            set cindent
            set tabstop=2
            set shiftwidth=0
            filetype plugin indent on
            set spelllang=en_us
            set spell
          '';

          programs.nixvim.autoCmd = [
            {
              event = [ "BufWritePre" ];
              pattern = [ "*" ];
              command = '':%s/\s\+$//e'';
            }
          ];

          programs.nixvim.colorschemes.tokyonight.enable = true;

          programs.nixvim.plugins.cmp.enable = true;
          programs.nixvim.plugins.cmp-nvim-lsp.enable = true;
          programs.nixvim.plugins.cmp-path.enable = true;
          programs.nixvim.plugins.cmp-treesitter.enable = true;

          programs.nixvim.plugins.lsp = {
            enable = true;

            servers = {
              clangd.enable = true;
              nixd.enable = true;
              pyright.enable = true;
              solargraph.enable = true;
              ocamllsp.enable = true;
            };
          };
          programs.nixvim.plugins.lint = {
            enable = true;
          };

          programs.nixvim.plugins.airline.enable = true;
          programs.nixvim.plugins.neo-tree.enable = true;
          programs.nixvim.plugins.nix.enable = true;
          programs.nixvim.plugins.nvim-autopairs.enable = true;
          programs.nixvim.plugins.nvim-autopairs.checkTs = true;
          programs.nixvim.plugins.rainbow-delimiters.enable = true;
          programs.nixvim.plugins.telescope.enable = true;
          programs.nixvim.plugins.telescope.keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
          };
          programs.nixvim.plugins.treesitter.enable = true;
        }
      ];
    };

    # darwin-rebuild switch --flake ~/.config/nix-darwin/
    darwinConfigurations = {
      "hanjeongjun-ui-MacBookPro" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          platform/darwin/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hanjeongjun = import platform/darwin/home.nix;
          }
        ];
      };
    };
  };
}
