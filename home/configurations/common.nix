{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.alejandra pkgs.go_1_22 pkgs.golangci-lint pkgs.terraform];
  home.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  programs = {
    bash = {
      enable = true;
      historyControl = ["ignoredups" "ignorespace"];
      sessionVariables = {
        PATH = "$HOME/bin:$GOPATH/bin:$PATH";
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      shellAliases = {
        ls = "ls -h --color=auto";
        ll = "ls -alF";
        vim = "nvim";
      };
      initExtra = ''
        function __ps1() {
          local P='$' dir="''${PWD##*/}" B \
            r='\[\e[31m\]' g='\[\e[1;30m\]' h='\[\e[34m\]' \
            u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
            b='\[\e[36m\]' x='\[\e[0m\]'

          [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # Root
          [[ $PWD = / ]] && dir=/
          [[ $PWD = "$HOME" ]] && dir='~'

          B=$(git branch --show-current 2>/dev/null)
          [[ $dir = "$B" ]] && B=.
          [[ $B == master || $B == main ]] && b="$r"
          [[ -n "$B" ]] && B="$g($b$B$g)"
          PS1="$u\u$g@$h\h$g:$w$dir$B$p$P$x "
        }
        PROMPT_COMMAND="__ps1"
        set -o vi
      '';
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
      userEmail = lib.mkDefault "matthewdargan57@gmail.com";
      userName = "Matthew Dargan";
    };
    nixvim = {
      enable = true;
      clipboard.register = "unnamedplus";
      colorschemes.kanagawa = {
        enable = true;
        theme = "wave";
      };
      globals.mapleader = " ";
      keymaps = [
        {
          action = ":bnext<CR>";
          key = "L";
          mode = ["n"];
        }
        {
          action = ":bprev<CR>";
          key = "H";
          mode = ["n"];
        }
      ];
      options = {
        backup = false;
        colorcolumn = "80";
        expandtab = true;
        guicursor = "";
        mouse = "a";
        number = true;
        relativenumber = true;
        scrolloff = 8;
        shiftwidth = 4;
        smartindent = true;
        softtabstop = 4;
        spelllang = "en_us";
        spell = true;
        swapfile = false;
        tabstop = 4;
        termguicolors = true;
        wrap = false;
      };
      plugins = {
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_prev";
              "<leader>k" = "goto_next";
            };
            lspBuf = {
              "K" = "hover";
              "<leader>r" = "rename";
            };
          };
          servers = {
            gopls.enable = true;
            jsonls.enable = true;
            terraformls.enable = true;
            yamlls.enable = true;
          };
        };
        lsp-format.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            "<leader>f" = "find_files";
            "<leader>g" = "live_grep";
            "<leader>b" = "buffers";
            "gd" = "lsp_definitions";
            "gi" = "lsp_implementations";
            "gr" = "lsp_references";
            "gt" = "lsp_type_definitions";
          };
        };
        treesitter = {
          enable = true;
          ensureInstalled = "all";
          moduleConfig = {
            highlight.enable = true;
            indent.enable = true;
          };
          nixGrammars = true;
        };
      };
    };
    readline = {
      enable = true;
      bindings = {
        "\\C-[[A" = "history-search-backward";
        "\\C-[[B" = "history-search-forward";
      };
    };
  };
  xdg.enable = true;
}
