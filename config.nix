{

  imports = [
    ./snippets.nix
    ./autocmd.nix
    ./common-mappings.nix
    ./plugins/neo-tree.nix
    ./plugins/flash.nix
    ./plugins/persistence.nix
    ./plugins/conform.nix
    ./plugins/cmp.nix
    ./plugins/lsp.nix
    ./plugins/lspsaga.nix
    ./plugins/dap.nix
    ./plugins/undotree.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix
    ./plugins/telescope.nix
    ./plugins/copilot.nix
    ./plugins/gitsigns.nix
    ./plugins/colorizer.nix
    ./plugins/floaterm.nix
    ./plugins/harpoon.nix
    ./plugins/menu.nix
  ];

  # Default Configuration Plugins
  plugins = {
    web-devicons.enable = true; # Icons
    nvim-autopairs.enable = true; # Autopairing
    nvim-surround.enable = true; # Surround
    which-key.enable = true; # Bind hints
    zen-mode.enable = true; # Enable zen mode
    vim-suda.enable = true; # Write files with sudo
    oil.enable = true; # Oil file explorer
    tmux-navigator.enable = true; # Tmux integration
    fugitive.enable = true; # Git integration
    lualine.enable = true; # Statusline
  };

  keymaps = [
    {
      mode = "n";
      key = "<A-h>";
      action = "<cmd>vertical resize +2<CR>";
      options = {
        silent = true;
        desc = "Resize split left";
      };
    }
    {
      mode = "n";
      key = "<A-l>";
      action = "<cmd>vertical resize -2<CR>";
      options = {
        silent = true;
        desc = "Resize split right";
      };
    }
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>resize -2<CR>";
      options = {
        silent = true;
        desc = "Resize split down";
      };
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>resize +2<CR>";
      options = {
        silent = true;
        desc = "Resize split up";
      };
    }
    {
      mode = "n";
      key = "<A-b>";
      action = "<cmd>b#<cr>";
      options = {
        silent = true;
        desc = "Toggle between last two buffers";
      };
    }
        {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>q<CR>";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {
        silent = true;
        desc = "toggle relative number";
      };
    }
    {
      mode = "n";
      key = "<C-c>";
      action = "<cmd>%y+<CR>";
      options = {
        silent = true;
        desc = "copy whole file";
      };
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-N>";
      options = {
        silent = true;
        desc = "Escape terminal mode";
      };
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>noh<CR>";
      options = {
        silent = true;
        desc = "Clear highlights";
      };
    }
    {
      mode = "n";
      key = ";";
      action = "<cmd>lua vim.api.nvim_feedkeys(':! ', 'm', true)<CR>";
      options = {
        silent = true;
        desc = "Execute terminal command";
      };
    }
    {
      mode = "i";
      key = "<C-h>";
      action = "<Left>";
      options = {
        silent = true;
        desc = "Move cursor left in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-l>";
      action = "<Right>";
      options = {
        silent = true;
        desc = "Move cursor right in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-j>";
      action = "<Down>";
      options = {
        silent = true;
        desc = "Move cursor down in insert mode";
      };
    }
    {
      mode = "i";
      key = "<C-k>";
      action = "<Up>";
      options = {
        silent = true;
        desc = "Move cursor up in insert mode";
      };
    }
  ];

  enableMan = true;
  clipboard.register = "unnamedplus,unnamed";
  colorschemes.catppuccin.enable = true;

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  opts = {

    relativenumber = true;
    number = true;
    swapfile = false;
    mouse = "a";
    undofile = true;
    ignorecase = true;
    wrap = false;

    # Indenting
    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

  };

}
