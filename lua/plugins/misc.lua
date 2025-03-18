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
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = require("rainbow-delimiters").strategy["global"],
          -- commonlisp = require("rainbow-delimiters").strategy["local"],
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
    "2kabhishek/nerdy.nvim",
    dependencies = {
      "folke/snacks.nvim",
      -- "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
  {
    "tpope/vim-repeat",
    lazy = false,
    -- use function to overwrite default event, otherwise it just merges with the default
    -- and `VeryLazy` keeps existing
    event = function()
      return { "BufReadPost", "BufNewFile" }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local terminal = require("toggleterm")

      terminal.setup({
        persist_size = true,
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<C-t>", "<cmd>lua require'toggleterm'.exec('yazi')<CR>", opts)

      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", opts)
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx and jsx files
        padding = true,
        sticky = true,
        ignore = "nil",
        toggler = { line = "gcc", block = "gbc" },
        opleader = { line = "gc", block = "gb" },
        extra = { above = "gcO", below = "gco", eol = "gcA" },
        mappings = { basic = true, extra = true },
        pre_hook = ts_context_commentstring.create_pre_hook(),
        post_hook = nil,
      })
    end,
  },
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
          {
            -- Match any file starting with ".env".
            -- This can be a table to match multiple file patterns.
            file_pattern = {
              ".env*",
              "wrangler.toml",
              ".dev.vars",
            },
            -- Match an equals sign and any character after it.
            -- This can also be a table of patterns to cloak,
            -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
            cloak_pattern = "=.+",
          },
        },
      })

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>ct", "<cmd>CloakToggle<CR>", opts)
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()

      local opts = { noremap = true, silent = true }

      vim.keymap.set(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.keymap.set(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        opts
      )
      vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
      vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
      vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
      vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
    end,
  },
  {
    "tpope/vim-abolish",
  },
}
