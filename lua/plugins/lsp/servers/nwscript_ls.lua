local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities
local vars = require("config.vars")

-- local util = require("lspconfig.util")
-- local navigator = require("navigator")
--
-- return {
--   navigator.setup({
--     lsp = {
--       auto_attach = true,
--       -- servers = { "nwscript_ls" },
--       nwscript_ls = {
--         name = "nwscript_ls",
--         cmd = { "nwscript-ee-language-server" },
--         filetypes = { "nss", "nwscript" },
--         root_dir = util.root_pattern(".git", "nasher.cfg", "Makefile"),
--         capabilities = capabilities,
--         on_attach = function(client, bufnr)
--           print("Hello NWScript")
--         end,
--         settings = {
--           single_file_support = true,
--           ["nwscript-ee-lsp"] = {
--             completion = {
--               addParamsToFunctions = true,
--             },
--             hovering = {
--               addCommentsToFunctions = true,
--             },
--             formatter = {
--               enabled = true,
--               verbose = true,
--               executable = "clang-format",
--             },
--             compiler = {
--               enabled = true,
--               os = vars.getOS(),
--               verbose = true,
--               reportWarnings = true,
--               nwnHome = os.getenv("NWN_HOME"),
--               nwnInstallation = os.getenv("NWN_ROOT"),
--               -- workspaceIncludes = { vim.fn.getcwd() },
--               workspaceIncludes = {
--                 vim.fn.getcwd() .. "/src/nss",
--                 vim.fn.getcwd() .. "/libs/nwn-core-framework/src",
--                 vim.fn.getcwd() .. "/libs/nwnee/src",
--                 vim.fn.getcwd() .. "/libs/nwnxee/Plugins",
--                 vim.fn.getcwd() .. "/libs/nwnxee/Core",
--                 vim.fn.getcwd() .. "/libs/nwnxee/Compatibility",
--                 vim.fn.getcwd() .. "/libs/sm-dialogs/src",
--                 vim.fn.getcwd() .. "/libs/sm-utils/src",
--               },
--             },
--           },
--         },
--       },
--     },
--   }),
-- }

return {
  lspconfig.setupServer("nwscript_ls", {
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- local linter = require("lint")
      --
      -- linter.linters.nwscript_lint = {
      --   cmd = "nwscript-lint -I " .. vim.fn.getcwd() .. " " .. vim.fn.expand("%:p"),
      --   -- stdin = true, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
      --   -- append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
      --   -- args = { vim.fn.expand("%:p") }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
      -- stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
      --   -- ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
      -- env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
      --   parser = require("lint.parser").from_pattern(
      --     "[^:]+:(%d+):(%d+):(%w+):(.+)",
      --     { "lnum", "col", "code", "message" },
      --     {
      --       ["error"] = vim.diagnostic.severity.ERROR,
      --       ["warning"] = vim.diagnostic.severity.WARN,
      --       ["information"] = vim.diagnostic.severity.INFO,
      --       ["hint"] = vim.diagnostic.severity.HINT,
      --     },
      --     { ["source"] = "nwscript_lint" },
      --     {
      --       lnum_offset = 0, -- Offset added to lnum. Defaults to 0
      --       end_lnum_offset = 0, -- Offset added to end_lnum. Defaults to 0
      --       end_col_offset = -1, -- Offset added to end-col. Defaults to -1, assuming that the end-columng position is exclusive
      --     }
      --   ),
      -- }
      --
      -- linter.linters_by_ft = {
      --   nwscript = { "nwscript_lint" },
      -- }
      --
      -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      --   callback = function()
      --     -- try_lint without arguments runs the linters defined in `linters_by_ft`
      --     -- for the current filetype
      --     linter.try_lint()
      --
      --     -- You can call `try_lint` with a linter name or a list of names to always
      --     -- run specific linters, independent of the `linters_by_ft` configuration
      --     -- linter.try_lint("cspell")
      --   end,
      -- })

      print("Hello NWScript")
    end,
    settings = {
      single_file_support = true,
      ["nwscript-ee-lsp"] = {
        completion = {
          addParamsToFunctions = true,
        },
        hovering = {
          addCommentsToFunctions = true,
        },
        formatter = {
          enabled = true,
          verbose = true,
          executable = "clang-format",
        },
        compiler = {
          enabled = true,
          os = vars.getOS(),
          verbose = true,
          reportWarnings = true,
          nwnHome = os.getenv("NWN_HOME"),
          nwnInstallation = os.getenv("NWN_ROOT"),
          -- workspaceIncludes = { vim.fn.getcwd() },
          workspaceIncludes = {
            vim.fn.getcwd(),
            -- vim.fn.getcwd() .. "/src/nss",
            -- vim.fn.getcwd() .. "/libs/nwnxee/Core/NWScript",
            -- vim.fn.getcwd() .. "/libs/nwnxee/Plugins/**/NWScript",
            -- vim.fn.getcwd() .. "/libs/nwnee/src",
            -- vim.fn.getcwd() .. "/libs/nwn-core-framework/src",
            -- vim.fn.getcwd() .. "/libs/sm-dialogs/src",
            -- vim.fn.getcwd() .. "/libs/sm-utils/src",
          },
        },
      },
    },
  }),
}
