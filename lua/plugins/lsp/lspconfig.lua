local api = vim.api

return {
  { -- Global/local settings
    "folke/neoconf.nvim",
    cmd = "Neoconf",
    opts = {},
    config = function() end,
  },
  { -- Preview
    "rmagatti/goto-preview",
    lazy = true,
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = function()
      require("goto-preview").setup({
        width = 90, -- Width of the floating window
        height = 20, -- Height of the floating window
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- Border characters of the floating window
        default_mappings = true,
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- references = { -- Configure the telescope UI for slowing the references cycling window.
        --   telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
        -- },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether
      })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")
      navic.setup({
        highlight = true,
        lazy_update_context = true,
        lsp = { auto_attach = true },
        depth_limit = 5,
        icons = require("blink.cmp").kind_icons,
      })
    end,
  },
  { -- Breadcrumbs-like navigation
    "SmiteshP/nvim-navbuddy",
    lazy = true,
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-lint",
      "SmiteshP/nvim-navbuddy",
      "rmagatti/goto-preview",
      "folke/neoconf.nvim",
      "smjonas/inc-rename.nvim",
      { "antosha417/nvim-lsp-file-operations", config = true },
    },
    opts = function()
      local ret = {
        servers = {
          tsserver = { enabled = false },
          ts_ls = { enabled = false },
        },
        setup = {
          tsserver = function()
            return true
          end,
          ts_ls = function()
            return true
          end,
        },
        codelens = {
          enable = true,
        },
        inlay_hints = {
          enabled = true,
          -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
      }
      return ret
    end,
    config = function(_, opts)
      local vars = require("config.vars")
      local maxSize = vars.maxFileSize
      local size = vim.fn.getfsize(vim.fn.expand("%"))
      if size >= maxSize then
        local clients = vim.lsp.get_clients()
        for _, lclient in ipairs(clients) do
          vim.lsp.stop_client(lclient)
        end
        return
      end

      local lgroup = api.nvim_create_augroup("UserLspConfig", {})

      api.nvim_create_autocmd("LspAttach", {
        group = lgroup,
        callback = function(event)
          local buffer = event.data.buffer
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Enable completion triggered by <c-x><c-o>
          -- api.nvim_command("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

          require("config.keymaps.lspconfig")

          -- Codelens
          -- if client and client:supports_method(vim.lsp.protocol.Methods.codeLens) then
          if opts.codelens.enabled and vim.lsp.codelens then
            if client and client:supports_method(vim.lsp.protocol.Methods.codelens, buffer) then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd(
                { "BufWritePost", "BufEnter", "CursorHold", "InsertLeave", "TextChanged" },
                {
                  buffer = buffer,
                  callback = vim.lsp.codelens.refresh,
                }
              )
            end
          end

          -- if client and client:supports_method(vim.lsp.protocol.Methods.inlayHint) then
          --   if
          --     api.nvim_buf_is_valid(bufnr)
          --     and vim.bo[bufnr].buftype == ""
          --     and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
          --   then
          --     vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          --   end
          -- end
        end,
      })

      -- border = "rounded",
      vim.diagnostic.config({
        underline = true,
        update_in_insert = true,
        float = {
          focusable = false,
          border = "rounded",
          style = "minimal",
          source = true,
          header = "",
          prefix = "",
        },
        virtual_text = true,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘ ",
            [vim.diagnostic.severity.WARN] = "▲ ",
            [vim.diagnostic.severity.HINT] = "⚑ ",
            [vim.diagnostic.severity.INFO] = "» ",
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      })
    end,
  },
}
