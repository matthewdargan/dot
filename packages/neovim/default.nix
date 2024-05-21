_: {
  perSystem = {
    pkgs,
    inputs',
    ...
  }: let
    inherit (inputs'.ghlink.packages) ghlink;
    inherit (inputs'.nix-go.packages) gopls;
  in {
    packages = {
      neovim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        module = {helpers, ...}: {
          autoCmd = [
            {
              callback = helpers.mkRaw "function() vim.lsp.buf.format() end";
              event = ["BufWritePre"];
            }
          ];
          clipboard = {
            providers = {
              wl-copy.enable = true;
              xclip.enable = true;
            };
            register = "unnamedplus";
          };
          colorschemes.kanagawa.enable = true;
          extraPackages = [ghlink pkgs.ripgrep];
          globals.mapleader = " ";
          imports = [./copilot.nix];
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
          opts = {
            background = "dark";
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
            tabstop = 4;
          };
          plugins = {
            cmp = {
              enable = true;
              settings = {
                mapping = {
                  "<CR>" = "cmp.mapping.confirm({ select = true })";
                  "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                  "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                };
                snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
                sources = [
                  {name = "buffer";}
                  {name = "luasnip";}
                  {name = "nvim_lsp";}
                  {name = "path";}
                  {name = "treesitter";}
                ];
              };
            };
            lastplace.enable = true;
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
                bashls.enable = true;
                gopls = {
                  enable = true;
                  package = gopls;
                };
                jsonls.enable = true;
                nil_ls.enable = true;
                rust-analyzer = {
                  enable = true;
                  installCargo = false;
                  installRustc = false;
                };
                terraformls.enable = true;
                yamlls.enable = true;
              };
            };
            luasnip.enable = true;
            none-ls = {
              enable = true;
              sources = {
                diagnostics.golangci_lint.enable = true;
                formatting = {
                  alejandra.enable = true;
                  gofumpt.enable = true;
                };
              };
            };
            telescope = {
              enable = true;
              keymaps = {
                "<leader>b" = "buffers";
                "<leader>f" = "find_files";
                "<leader>g" = "live_grep";
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
      };
    };
  };
}
