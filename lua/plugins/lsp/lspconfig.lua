--@diagnostic disable: missing.fields

return {
  {
    "bfrg/vim-cpp-modern",
  },
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "mortepau/codicons.nvim" },
    -- lazy = true,
    config = function() end, -- avoid duplicate setup call.
  },
  {
    "habamax/vim-godot",
  },
  {
    "OmniSharp/omnisharp-vim",
    dependencies = {
      "ctrlpvim/ctrlp.vim",
    },
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function()
          require("goto-preview").setup({
            width = 90, -- Width of the floating window
            height = 15, -- Height of the floating window
            border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
            default_mappings = true,
            debug = false, -- Print debug information
            opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
            resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
            post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
            references = { -- Configure the telescope UI for slowing the references cycling window.
              telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
            },
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
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
      { "williamboman/mason-lspconfig.nvim" },
      { "antosha417/nvim-lsp-file-operations", config = true },
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      -- { "OmniSharp/omnisharp-vim" },
      -- { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    opts = function()
      local ret = {
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        codelens = {
          enabled = true,
        },
      }
      return ret
    end,
    config = function(_, opts)
      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local lgroup = vim.api.nvim_create_augroup("UserLspConfig", {})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = lgroup,
        callback = function(event)
          -- Enable completion triggered by <c-x><c-o>
          -- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.api.nvim_command("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

          local buffer = event.data.buffer
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- vim.cmd("TwilightEnable")
          local lopts = { buffer = bufnr, noremap = true, remap = false }

          -- Codelens
          if client and client.supports_method(vim.lsp.protocol.Methods.codeLens) then
            local enableCodelens = function()
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd("User", {
                pattern = "LspAttach",
                once = true,
                callback = vim.lsp.codelens.refresh,
              })
              vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave", "TextChanged" }, {
                buffer = buffer,
                callback = vim.lsp.codelens.refresh,
              })
            end

            if opts.codelens.enabled and vim.lsp.codelens then
              enableCodelens()
            end
            vim.keymap.set(
              { "n", "v" },
              "<leader>cl",
              vim.lsp.codelens.run,
              vim.tbl_deep_extend("force", lopts, { desc = "Run Codelens" })
            )

            vim.keymap.set(
              "n",
              "<leader>cL",
              vim.lsp.codelens.refresh,
              vim.tbl_deep_extend("force", lopts, { desc = "Refresh & Display Codelens" })
            )

            vim.keymap.set("n", "<leader>cle", function()
              enableCodelens()
            end, vim.tbl_deep_extend("force", lopts, { desc = "Refresh & Display Codelens" }))
          end

          -- Toggle inlay hints in your code, if the language server you are using supports them
          -- This may be unwanted, since they displace some of your code
          -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          -- main.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if client and client.supports_method(vim.lsp.protocol.Methods.inlayHint) then
            if
              vim.api.nvim_buf_is_valid(bufnr)
              and vim.bo[bufnr].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
            then
              vim.keymap.set("n", "<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }))
              end, vim.tbl_deep_extend("force", lopts, { desc = "(t)oggle inlay (h)ints" }))
            end
          end

          vim.keymap.set(
            "n",
            "gpd",
            "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
            lopts
          )
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", lopts)
          vim.keymap.set(
            "n",
            "gpD",
            "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
            lopts
          )
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", lopts)
          vim.keymap.set(
            "n",
            "gpi",
            "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
            lopts
          )
          vim.keymap.set("n", "gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", lopts)
          vim.keymap.set("n", "gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", lopts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", lopts)
          vim.keymap.set(
            "n",
            "gpr",
            "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
            lopts
          )
          vim.keymap.set("n", "gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", lopts)
          vim.keymap.set(
            "n",
            "gpt",
            "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
            lopts
          )
          vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", lopts)
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", lopts)
          vim.keymap.set("i", "<C-s>h", "<cmd>lua vim.lsp.buf.signature_help()<CR>", lopts)
          vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", lopts)
          vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", lopts)

          vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", lopts)
          vim.keymap.set(
            { "n", "x" },
            "<leader>cf",
            "<cmd>lua vim.lsp.buf.format({ async = true, timeout_ms = 10000 })<CR>",
            lopts
          )

          -- C# Adventures
          if client and client.name ~= "omnisharp" then
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", lopts)
          end
        end,
      })

      vim.diagnostic.config({
        update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          -- source = "always",
          source = true,
          header = "",
          prefix = "",
        },
        virtual_text = true,
      })
    end,
  },
  -- { import = "plugins.lsp.servers" },
}
