local M = {}

local wk = require("which-key")
local conform = require("conform")

M.keymaps = wk.add({
  {
    mode = { "n" },
    { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "" },
    { "gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "" },
    { "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", desc = "" },
    { "gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration({ border = 'rounded' })<CR>", desc = "" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "" },
    { "K", "<cmd>lua vim.lsp.buf.hover({ popup_opts = { border = 'rounded' } })<CR>", desc = "" },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "" },
    { "<leader>cA", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", desc = "" },
    -- { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "" },
    { "<leader>cr", ":IncRename " .. vim.fn.expand("<cword>"), desc = "Rename" },

    { "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "" },
    { "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "" },
    { "<leader>wi", "<cmd>print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "" },

    { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "" },
    { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "" },
    { "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "" },
    { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "" },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "" },
    { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "" },

    { "gG", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "" },
    { "gL", "<cmd>lua vim.diagnostic.show_line_diagnostic({ border = 'rounded' })<CR>", desc = "" },
    { "]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", desc = "" },
    { "[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", desc = "" },
    { "<leader>sl", ":LspStop<CR>", desc = "" },

    { "<leader>bc", ":Navbuddy<CR>", desc = "Open breadcrumbs" },

    { "<leader>cL", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens" },

    {
      "<leader>cle",
      function()
        enableCodelens()
      end,
      desc = "Refresh & Display Codelens",
    },

    {
      "<leader>lsc",
      function()
        local buf_ft = api.nvim_get_option_value("filetype", { buf = 0 })
        local clients = vim.lsp.get_clients()
        local lclient_names = {}
        for _, lclient in ipairs(clients) do
          local filetypes = lclient.config.filetypes
          -- if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and lclient.name ~= "null-ls" then
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            -- return client.name
            if lclient and lclient:supports_method(vim.lsp.protocol.Methods.codeLens, buffer) then
              print("True")
              return true
            end
          end
        end
        print("False")
        return false
      end,
      desc = "Check if any attached LSP supports codelens",
    },
  },
  {
    mode = { "i" },
    { "<C-s>", "<cmd>lua vim.lsp.buf.signature_help({ border = 'rounded' })<CR>", desc = "" },
  },
  {
    mode = { "n", "v" },
    { "<leader>cl", vim.lsp.codelens.run, desc = "Run Codelens" },
  },
  {
    mode = { "n", "x" },
    {
      "<leader>cf",
      function()
        conform.format({ bufnr = bufnr })
      end,
      desc = "Format buffer",
    },
  },
})

return M.keymaps
