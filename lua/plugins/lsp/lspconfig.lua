--@diagnostic disable: missing.fields

local funcs = require("config.functions")
local api = vim.api

return {
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "rmagatti/goto-preview",
        dependencies = { "rmagatti/logger.nvim" },
        event = "BufEnter",
        config = function()
          require("goto-preview").setup({
            width = 90, -- Width of the floating window
            height = 20, -- Height of the floating window
            border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
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
      { "Saghen/blink.cmp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/lazydev.nvim" },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          {
            "SmiteshP/nvim-navic",
            opts = { lsp = { auto_attach = true } },
            config = function()
              local navic = require("nvim-navic")
              navic.setup({
                highlight = true,
                lsp = {
                  auto_attach = true,
                },
              })
            end,
          },
          "MunifTanjim/nui.nvim",
          "numToStr/Comment.nvim", -- Optional
          -- "nvim-telescope/telescope.nvim", -- Optional
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    opts = function()
      local ret = {
        codeLens = {
          enable = true,
        },
      }
      return ret
    end,
    config = function(_, opts)
      local maxSize = 1.5 * 1024 * 1024 -- 1.5MB
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
          -- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          api.nvim_command("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

          -- vim.cmd("TwilightEnable")
          local lopts = { buffer = bufnr, noremap = true, remap = false }

          local km = function(mode, key, func, opt)
            vim.keymap.set(mode, key, func, opt)
          end
          local kmn = function(key, func, opt)
            km("n", key, func, opt)
          end
          local kmnv = function(key, func, opt)
            km({ "n", "v" }, key, func, opt)
          end
          local kmnx = function(key, func, opt)
            km({ "n", "x" }, key, func, opt)
          end
          local kmi = function(key, func, opt)
            km("i", key, func, opt)
          end
          local ext = function(desc)
            vim.tbl_deep_extend("force", lopts, { desc = desc })
          end
          kmn("<leader>bc", ":Navbuddy<CR>", ext("Open breadcrumbs"))

          kmn("<leader>lsc", function()
            local buf_ft = api.nvim_get_option_value("filetype", { buf = 0 })
            local clients = vim.lsp.get_clients()
            local lclient_names = {}
            for _, lclient in ipairs(clients) do
              local filetypes = lclient.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and lclient.name ~= "null-ls" then
                -- return client.name
                if lclient and lclient:supports_method(vim.lsp.protocol.Methods.codeLens, buffer) then
                  print("True")
                  return true
                end
              end
            end
            print("False")
            return false
          end, ext("Check if any attached LSP supports codelens"))

          -- Codelens
          -- if client and client:supports_method(vim.lsp.protocol.Methods.codeLens) then
          if client and client:supports_method(vim.lsp.protocol.Methods.codeLens, buffer) then
            local enableCodelens = function()
              vim.lsp.codelens.refresh()
              api.nvim_create_autocmd("User", {
                pattern = "LspAttach",
                once = true,
                callback = vim.lsp.codelens.refresh,
              })
              api.nvim_create_autocmd(
                { "BufWritePost", "BufEnter", "CursorHold", "InsertLeave", "TextChanged" },
                {
                  buffer = buffer,
                  callback = vim.lsp.codelens.refresh,
                }
              )
            end

            if opts.codeLens.enabled and vim.lsp.codelens then
              enableCodelens()
            end
            kmnv("<leader>cl", vim.lsp.codelens.run, ext("Run Codelens"))

            kmn("<leader>cL", vim.lsp.codelens.refresh, ext("Refresh & Display Codelens"))

            kmn("<leader>cle", function()
              enableCodelens()
            end, ext("Refresh & Display Codelens"))
          end

          -- Toggle inlay hints in your code, if the language server you are using supports them
          -- This may be unwanted, since they displace some of your code
          -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          -- main.on_supports_method("textDocument/inlayHint", function(client, buffer)
          -- if client and client:supports_method(vim.lsp.protocol.Methods.inlayHint) then
          --   if
          --     api.nvim_buf_is_valid(bufnr)
          --     and vim.bo[bufnr].buftype == ""
          --     and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
          --   then
          --     kmn("<leader>th", function()
          --       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }))
          --     end, ext("(t)oggle inlay (h)ints"))
          --   end
          -- end

          kmn("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", lopts)
          kmn("gr", "<cmd>lua vim.lsp.buf.references()<CR>", lopts)
          kmi("<C-s>", "<cmd>lua vim.lsp.buf.signature_help({ border = 'rounded' })<CR>", lopts)
          kmn("gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", lopts)
          kmn("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", lopts)
          kmn("gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", lopts)
          kmn("gD", "<cmd>lua vim.lsp.buf.declaration({ border = 'rounded' })<CR>", lopts)
          kmn("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", lopts)
          kmn("K", "<cmd>lua vim.lsp.buf.hover({ popup_opts = { border = 'rounded' } })<CR>", lopts)
          kmn("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", lopts)
          kmn("<leader>cA", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", lopts)
          kmn("<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", lopts)

          kmn("<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", lopts)
          kmn("<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", lopts)
          kmn("<leader>wi", "<cmd>print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", lopts)

          kmn("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", lopts)
          kmn("gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", lopts)
          kmn("gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", lopts)
          kmn("gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", lopts)
          kmn("gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", lopts)
          kmn("gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", lopts)

          kmn("gG", "<cmd>lua vim.diagnostic.open_float()<CR>", lopts)
          kmn("gL", "<cmd>lua vim.diagnostic.show_line_diagnostic({ border = 'rounded' })<CR>", lopts)
          kmn("]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", lopts)
          kmn("[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", lopts)
          kmnx("<leader>cf", function()
            funcs.format(bufnr, true)
          end, lopts)

          kmn("<leader>sl", ":LspStop<CR>", lopts)
        end,
      })

      -- border = "rounded",
      vim.diagnostic.config({
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
