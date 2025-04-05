local max_height = 30

return {
  {
    "xzbdmw/colorful-menu.nvim",
    lazy = false,
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({
        ls = {
          -- If provided, the plugin truncates the final displayed text to
          -- this width (measured in display cells). Any highlights that extend
          -- beyond the truncation point are ignored. When set to a float
          -- between 0 and 1, it'll be treated as percentage of the width of
          -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
          -- Default 60.
          max_width = 120,
        },
      })
    end,
  },
  {
    "Saghen/blink.cmp",
    lazy = false,
    event = { "BufReadPre", "InsertEnter", "CursorMoved", "TextChanged" },
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      {
        "saghen/blink.compat",
        lazy = false,
        opts = { enable_events = true, impersonate_nvim_cmp = true },
        config = function()
          require("blink.compat").setup()
        end,
      },
      {
        "Exafunction/codeium.nvim",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
          virtual_text = { enabled = true },
          enable_chat = true,
        },
        config = function()
          require("codeium").setup()
        end,
      },
    },
    version = "*",
    opts = {
      completion = {
        -- trigger = {
        -- show_in_snippet = false,
        -- },
        documentation = {
          window = { border = "rounded", max_height = max_height },
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          max_height = max_height,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "source_name", gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = true,
              },
              kind = {
                ellipsis = true,
              },
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        ghost_text = { enabled = true, show_without_selection = true },
      },
      cmdline = {
        completion = { menu = { auto_show = true } },
        keymap = {
          preset = "none",
          ["<Tab>"] = {
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "show_and_insert",
            "select_next",
          },

          ["<S-Tab>"] = { "show_and_insert", "select_prev" },

          ["<C-y>"] = { "select_and_accept" },
          ["<C-e>"] = { "cancel" },
        },
      },
      keymap = {
        preset = "none",
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() or cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "fallback",
        },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<C-f>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },

        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        kind_icons = {
          Variable = "󰀫",

          Class = "󰠱",
          Interface = "",
          Module = "󰆦",

          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          EnumMember = "",

          Snippet = "",
          File = "󰈙",
          Operator = "󰆕",
          TypeParameter = "",

          codeium = "",
        },
      },
      -- Merge custom sources with the existing ones from LazyVim
      -- Requires the LazyVim blink.cmp extra
      snippets = {
        preset = "luasnip",
        -- use_show_condition = true,
        -- show_autosnippets = true,
        -- expand = function(snippet)
        --   require("luasnip").lsp_expand(snippet)
        -- end,
        -- active = function(filter)
        --   if filter and filter.direction then
        --     return require("luasnip").jumpable(filter.direction)
        --   end
        --   return require("luasnip").in_snippet()
        -- end,
        -- jump = function(direction)
        --   require("luasnip").jump(direction)
        -- end,
      },
      sources = {
        default = {
          "codeium",
          "snippets",
          "lsp",
          "lazydev",
          "buffer",
          "path",
          "omni",
          "emoji",
          "ripgrep",
        },
        -- per_filetype = {
        --   org = { "orgmode" },
        -- },
        providers = {
          -- orgmode = {
          --   name = "Orgmode",
          --   module = "orgmode.org.autocompletion.blink",
          --   fallbacks = { "bugger" },
          -- },
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 100,
            enabled = true,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = " "
              end
              return items
            end,
          },
          snippets = {
            name = "[snip]",
            score_offset = 95,
          },
          lazydev = {
            name = "[LazyDev]",
            module = "lazydev.integrations.blink",
            score_offset = 90,
          },
          lsp = {
            name = "[LSP]",
            score_offset = 80,
            async = true,
          },
          buffer = {
            name = "[buf]",
            score_offset = 60,
          },
          path = {
            name = "[path]",
            score_offset = 60,
          },
          omni = {
            score_offset = 50,
          },
          emoji = {
            name = "[emoji]",
            module = "blink-emoji",
            score_offset = 50,
          },
          ripgrep = {
            name = "[ripgrep]",
            module = "blink-ripgrep",
            score_offset = 40,
          },
        },
      },
      signature = {
        enabled = true,
        trigger = {
          -- show_on_trigger_character = false,
          show_on_insert = true,
        },
        window = { border = "rounded", max_height = max_height },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}

