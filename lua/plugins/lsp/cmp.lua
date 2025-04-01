return {
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
          ellipsis = true,
          Text = "󰉿 ",
          Method = "󰆧 ",
          Function = "󰊕 ",
          Constructor = "󰒓 ",

          Field = "󰜢 ",
          Variable = "󰀫 ",
          Property = "󰖷 ",

          Class = "󰠱 ",
          Interface = " ",
          Struct = "󱡠 ",
          Module = "󰆦 ",

          Unit = "󰑭 ",
          Value = "󰎠 ",
          Enum = " ",
          EnumMember = " ",

          Keyword = "󰌋 ",
          Constant = "󰏿 ",

          Snippet = " ",
          Color = "󰏘 ",
          File = "󰈙 ",
          Reference = "󰈇 ",
          Folder = "󰉋 ",
          Event = "󱐋 ",
          Operator = "󰆕 ",
          TypeParameter = " ",

          codeium = " ",
        },
      },
      cmdline = {
        completion = {
          -- Don't select by default, auto insert on selection
          list = { selection = { preselect = false, auto_insert = true } },
          menu = {
            draw = {
              columns = {
                { "label", "label_description", grap = 1 },
                -- { "kind_icon", "kind" },
                { "kind_icon", "source_name" },
              },
            },
            auto_show = true,
          },
          ghost_text = { enabled = true },
        },
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

          -- ["<Down>"] = { "select_next" },
          -- ["<Up>"] = { "select_prev" },

          ["<C-y>"] = { "select_and_accept" },
          ["<C-e>"] = { "cancel" },
        },
      },
      -- Merge custom sources with the existing ones from LazyVim
      -- Requires the LazyVim blink.cmp extra
      snippets = {
        preset = "luasnip",
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      completion = {
        keyword = { range = "full" },
        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = {
          window = { border = "rounded" },
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "label", "label_description", grap = 1 },
              -- { "source_name", grap = 1 },
              { "kind_icon", "source_name" },
            },
          },
          auto_show = true,
        },
        ghost_text = { enabled = true },
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
          enabled = true,
          show_on_trigger_character = false,
          show_on_insert = true,
        },
        window = {
          border = "rounded",
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
