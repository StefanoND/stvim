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
        opts = { enable_events = true, impersonate_nvim_cmp = true },
      },
      {
        "Exafunction/codeium.nvim",
        event = "BufEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          require("codeium").setup({
            virtual_text = { enabled = true },
            enable_chat = true,
          })
        end,
      },
    },
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-f>"] = { "snippet_forward", "fallback" },
        ["<C-p>"] = { "snippet_backward", "fallback" },
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
          TypeParameter = "󰬛 ",

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
        keymap = { preset = "enter" },
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
          "lazydev",
          "lsp",
          "buffer",
          "path",
          "omni",
          "emoji",
          "ripgrep",
        },
        providers = {
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
