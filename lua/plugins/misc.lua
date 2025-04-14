return {
  { "mbbill/undotree", version = false },
  { "mg979/vim-visual-multi", version = false },
  { "tpope/vim-abolish", version = false },
  { "tpope/vim-repeat", version = false, event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", version = false, lazy = true },
  { "MunifTanjim/nui.nvim", version = false, lazy = true },
  -- { "nvim-tree/nvim-web-devicons", version = false, lazy = true },
  { "2kabhishek/nerdy.nvim", version = false, lazy = true, cmd = "Nerdy" },
  {
    "LunarVim/bigfile.nvim",
    version = false,
    lazy = false,
    opts = function()
      return {}
    end,
    config = function(_, opts)
      require("bigfile").setup(opts)
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    version = false,
    lazy = false,
    cmd = "IncRename",
    opts = function()
      return {}
    end,
    config = function(_, opts)
      require("inc_rename").setup(opts)
    end,
  },
  {
    "chrisgrieser/nvim-lsp-endhints",
    version = false,
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = function()
      return {}
    end,
    config = function(_, opts)
      require("lsp-endhints").setup(opts)
    end,
  },
  {
    "dstein64/vim-startuptime",
    version = false,
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    version = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "ThePrimeagen/vim-be-good",
    version = false,
    config = function()
      require("config.keymaps.vim-be-good")
    end,
  },
  {
    "folke/persistence.nvim",
    version = false,
    event = "BufReadPre",
    opts = {},
    keys = require("config.keymaps.persistence"),
  },
}
