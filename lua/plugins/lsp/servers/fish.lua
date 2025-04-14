local lspconfig = require("config.lsp.setup")

return {
  lspconfig.setupServer("fish_lsp", {
    name = "fish-lsp",
    cmd = { "fish-lsp", "start" },
    cmd_env = {
      -- Enables the fish-lsp handlers (options: 'popups', 'formatting', 'complete', 'hover', 'rename',
      -- 'definition', 'references', 'diagnostics', 'signatureHelp', 'codeAction', 'inlayHint')
      fish_lsp_enabled_handlers = {
        "popups",
        "formatting",
        "complete",
        "hover",
        "rename",
        "definition",
        "references",
        "diagnostics",
        "signatureHelp",
        "codeAction",
        "inlayHint",
      },

      -- Disables the fish-lsp handlers (options: 'popups', 'formatting', 'complete', 'hover', 'rename',
      -- 'definition', 'references', 'diagnostics', 'signatureHelp', 'codeAction', 'inlayHint')
      -- fish_lsp_disabled_handlers = {},

      -- Array of the completion expansion characters. Single letter values only.
      -- Commit characters are used to select completion items, as shortcuts. (default:
      -- {})
      -- fish_lsp_commit_characters = {},

      -- Path to the logging file. An example location could be
      -- '/tmp/fish_lsp_logs.txt' (default: '')
      -- fish_lsp_logfile = "",

      -- Fish file paths to include as workspaces (default: {'/usr/share/fish',
      -- '$HOME/.config/fish'})
      -- fish_lsp_all_indexed_paths = { "/usr/share/fish", "$HOME/.config/fish" },

      -- Fish file paths that can be renamed by the user (default:
      -- {'$HOME/.config/fish'})
      -- fish_lsp_modifiable_paths = { "$HOME/.config/fish" },

      -- Disable diagnostics for matching error codes
      -- (options: 1001, 1002, 1003, 1004, 2001, 2002, 2003, 3001, 3002, 3003) (default: {})
      -- fish_lsp_diagnostic_disable_error_codes = { },

      -- Maximum number of background files to read into buffer
      -- on startup (default: 1000)
      fish_lsp_max_background_files = 1000,

      -- Show popup window notification in the connected client (default: true)
      fish_lsp_show_client_popups = false,
    },
    on_attach = function(client, bufnr)
      print("Hello fish")
    end,
  }),
}
