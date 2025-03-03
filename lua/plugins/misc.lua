return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local devicons = require("nvim-web-devicons")

      devicons.set_icon({
        gql = {
          icon = " ",
          color = "#e535ab",
          cterm_color = "199",
          name = "GraphQL",
        },
      })

      devicons.setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "echasnovski/mini.icons",
        version = false,
        config = function()
          require("mini.icons").setup()
        end,
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      -- Config here
    },
  },
  {
    "mbbill/undotree",
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  "ThePrimeagen/git-worktree.nvim",
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup()
      -- require("notify").setup({
      --   background_colour = "#000000",
      --   enabled = false,
      -- })
    end,
  },
  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = require("rainbow-delimiters").strategy["global"],
          commonlisp = require("rainbow-delimiters").strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
  {
    "ThePrimeagen/vim-be-good",
    config = function()
      vim.keymap.set("n", "<leader>vb", ":VimBeGood<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "szw/vim-maximizer",
    keys = {
      {
        "<leader>sm",
        "<cmd>MaximizerToggle<cr>",
        { desc = "Maximize/Minimize a split", noremap = true, silent = true },
      },
    },
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
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
      -- "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
}
