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
            vim.fn.getcwd() .. "/src/nss",
            vim.fn.getcwd() .. "/libs/nwn-core-framework/src",
            vim.fn.getcwd() .. "/libs/nwnee/src",
            vim.fn.getcwd() .. "/libs/nwnxee/Plugins",
            vim.fn.getcwd() .. "/libs/nwnxee/Core",
            vim.fn.getcwd() .. "/libs/nwnxee/Compatibility",
            vim.fn.getcwd() .. "/libs/sm-dialogs/src",
            vim.fn.getcwd() .. "/libs/sm-utils/src",
          },
        },
      },
    },
  }),
}
