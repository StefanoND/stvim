return {
  { "mbbill/undotree" },
  { "mg979/vim-visual-multi" },
  { "tpope/vim-abolish" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "LunarVim/bigfile.nvim", lazy = false },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "2kabhishek/nerdy.nvim", lazy = true, cmd = "Nerdy" },
  { "smjonas/inc-rename.nvim", lazy = false, cmd = "IncRename", opts = {} },
  { "chrisgrieser/nvim-lsp-endhints", dependencies = "nvim-lspconfig", event = "LspAttach", opts = {} },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
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
    lazy = true,
    config = function()
      require("config.keymaps.vim-be-good")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = require("config.keymaps.persistence"),
  },
}
