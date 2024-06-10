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
  programs.nixvim.plugins.cmp-buffer.enable = true;
  programs.nixvim.plugins.cmp-nvim-lsp.enable = true;
  programs.nixvim.plugins.cmp-path.enable = true;
  programs.nixvim.plugins.cmp-treesitter.enable = true;

  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      clangd.enable = true;
      html.enable = true;
      nixd.enable = true;
      pyright.enable = true;
      rust-analyzer.enable = true;
      solargraph.enable = true;
      ocamllsp.enable = true;
    };
  };
  programs.nixvim.plugins.lsp-lines.enable = true;
  programs.nixvim.plugins.lint = {
    enable = true;
  };

  programs.nixvim.plugins.airline.enable = true;

  programs.nixvim.plugins.indent-blankline.enable = true;
  programs.nixvim.plugins.neo-tree.enable = true;
  programs.nixvim.plugins.nix.enable = true;

  programs.nixvim.plugins.nvim-autopairs.enable = true;
  programs.nixvim.plugins.nvim-autopairs.settings.check_ts = true;

  programs.nixvim.plugins.rainbow-delimiters.enable = true;

  programs.nixvim.plugins.telescope.enable = true;
  programs.nixvim.plugins.telescope.keymaps = {
    "<leader>ff" = "find_files";
    "<leader>fg" = "live_grep";
  };
  programs.nixvim.plugins.treesitter.enable = true;
}
