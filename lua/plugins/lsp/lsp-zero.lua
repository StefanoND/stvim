return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  lazy = true,
  config = function()
    local lsp_zero = require("lsp-zero")
    lsp_zero.set_sign_icons({
      error = "✘",
      warn = "▲",
      hint = "⚑",
      info = "»",
    })

    -- When set to `0` then lsp-zero will not integrate with nvim-cmp
    -- automatically.
    -- vim.g.lsp_zero_extend_cmp = 0

    -- When set to `0` then lsp-zero will not integrate with lspconfig
    -- automatically.
    -- vim.g.lsp_zero_extend_lspconfig = 0

    -- When set to `0` then lsp-zero will only send Neovim's default capabilities
    -- settings to language servers. This means language servers that respect the
    -- `capabilities` settings will stop sending snippets. And also the "extra edits"
    -- may stop working, you will not get things like automatically adding a missing
    -- import for a completion item.
    vim.g.lsp_zero_extend_capabilities = 1

    -- Set the style of border of diagnostic floating window, hover window and
    -- signature help window. Can have one of these: `'none'`, `'single'`,
    -- `'double'`, `'rounded'`, `'solid'` or `'shadow'`. The default value is
    -- `'rounded'`. If set to `0` then lsp-zero will not configure the border
    -- style.
    vim.g.lsp_zero_ui_float_border = 1

    -- When set to `0` the lsp-zero will not configure the space in the gutter
    -- for diagnostics.
    vim.g.lsp_zero_ui_signcolumn = 1

    -- When set to `0` it will supress the warning messages from deprecated
    -- functions. (Note: if you get one of those warnings, know that showing that
    -- message is the only thing they do. They are "empty" functions.)
    vim.g.lsp_zero_api_warnings = 1
  end,
  init = function()
    -- Disable automatic setup, we are doing it manually
    vim.g.lsp_zero_extend_cmp = 0
    vim.g.lsp_zero_extend_lspconfig = 0
  end,
}
