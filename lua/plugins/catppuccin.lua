return { -- colorscheme
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      integrations = {
        blink_cmp = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        fidget = true,
        gitgutter = false,
        gitsigns = true,
        harpoon = false,
        lsp_trouble = true,
        mason = true,
        notify = true,
        nvimtree = false,
        rainbow_delimiters = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,

        mini = {
          enabled = true,
          indentscope_color = "mauve", -- catppuccin color (eg. `lavender`) Default: text
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = {
          enabled = true,
          custom_bg = "#1e1e2e", -- "lualine" will set background to mantle (#181825)
        },
        snacks = {
          enabled = true,
          indent_scope_color = "mauve", -- catppuccin color (eg. `lavender`) Default: text
        },
      },
    })

    -- Setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
