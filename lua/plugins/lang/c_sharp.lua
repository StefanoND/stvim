local apply_vs_text_edit = function(edit)
  local bufnr = vim.api.nvim_get_current_buf()
  local start_line = edit.range.start.line
  local start_char = edit.range.start.character
  local end_line = edit.range["end"].line
  local end_char = edit.range["end"].character

  local newText = string.gsub(edit.newText, "\r", "")
  local lines = vim.split(newText, "\n")

  local placeholder_row = -1
  local placeholder_col = -1

  -- placeholder handling
  for i, line in ipairs(lines) do
    local pos = string.find(line, "%$0")
    if pos then
      lines[i] = string.gsub(line, "%$0", "", 1)
      placeholder_row = start_line + i - 1
      placeholder_col = pos - 1
      break
    end
  end

  vim.api.nvim_buf_set_text(bufnr, start_line, start_char, end_line, end_char, lines)

  if placeholder_row ~= -1 and placeholder_col ~= -1 then
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, { placeholder_row + 1, placeholder_col })
  end
end

local add_dotnet_mappings = function()
  local dotnet = require("easy-dotnet")
  vim.api.nvim_create_user_command("Secrets", function()
    dotnet.secrets()
  end, {})

  vim.keymap.set("n", "<A-t>", function()
    vim.cmd("Dotnet testrunner")
  end, { nowait = true })

  vim.keymap.set("n", "<C-p>", function()
    dotnet.run_with_profile(true)
  end, { nowait = true })

  -- -- Example keybinding
  -- vim.keymap.set("n", "<C-p>", function()
  --   dotnet.run_project()
  -- end)

  vim.keymap.set("n", "<C-b>", function()
    dotnet.build_default_quickfix()
  end, { nowait = true })
end

return { -- C#
  {
    "Issafalcon/neotest-dotnet",
    enabled = true,
    version = false,
    lazy = true,
    ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets", "fsharp", "vb", "razor" },
  },
  {
    "seblyng/roslyn.nvim",
    enabled = true,
    version = false,
    lazy = true,
    ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets", "fsharp", "vb", "razor" },
    -- dependencies = { { "tris203/rzls.nvim", config = function() require("rzls").setup({}) end } },
    dependencies = {
      {
        "tris203/rzls.nvim",
        config = true,
        ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets", "fsharp", "vb", "razor" },
      },
    },
    init = function()
      vim.filetype.add({ extension = { razor = "razor", cshtml = "razor" } })
    end,
    opts = function()
      local documentstore = require("rzls.documentstore")
      local razor = require("rzls.razor")
      local Log = require("rzls.log")
      local roslyn_base_path =
        vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "roslyn", "libexec")
      local rzls_base_path =
        vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "rzls", "libexec")
      local cmd = {
        "dotnet",
        vim.fs.joinpath(roslyn_base_path, "Microsoft.CodeAnalysis.LanguageServer.dll"),
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        -- "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_base_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        -- "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_base_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
      }

      local not_implemented = function(err, result, ctx, config)
        vim.print("Called " .. ctx.method)
        vim.print(vim.inspect(err))
        vim.print(vim.inspect(result))
        vim.print(vim.inspect(ctx))
        vim.print(vim.inspect(config))
        return { "error" }
      end

      local not_supported = function()
        return {}, nil
      end

      return {
        -- args = {
        --   "--stdio",
        --   "--logLevel=Information",
        --   "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        --   "--razorSourceGenerator=" .. vim.fs.joinpath( vim.fn.stdpath("data"), "mason", "packages", "roslyn", "libexec", "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        --   "--razorDesignTimePath=" .. vim.fs.joinpath( vim.fn.stdpath("data"), "mason", "packages", "rzls", "libexec", "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
        -- },
        config = {
          cmd = cmd,
          capabilities = {
            textDocument = {
              _vs_onAutoInsert = { dynamicRegistration = false },
            },
          },
          -- handlers = require("rzls.roslyn_handlers"),
          handlers = {
            ["textDocument/_vs_onAutoInsert"] = function(err, result, _)
              if err or not result then
                return
              end
              apply_vs_text_edit(result._vs_textEdit)
            end,

            -- VS Windows only
            ["razor/inlineCompletion"] = not_implemented,
            ["razor/validateBreakpointRange"] = not_implemented,
            ["razor/onAutoInsert"] = not_implemented,
            ["razor/semanticTokensRefresh"] = not_implemented,
            ["razor/textPresentation"] = not_implemented,
            ["razor/uriPresentation"] = not_implemented,
            ["razor/spellCheck"] = not_implemented,
            ["razor/projectContexts"] = not_implemented,
            ["razor/pullDiagnostics"] = not_implemented,
            ["razor/mapCode"] = not_implemented,

            -- VS Windows and VS Code
            ---@param _err lsp.ResponseError
            ---@param result razor.VBufUpdate
            ["razor/updateCSharpBuffer"] = function(_err, result)
              local buf = documentstore.update_vbuf(result, razor.language_kinds.csharp)
              if buf then
                require("rzls.refresh").diagnostics.add(buf)
              end
            end,
            ---@param _err lsp.ResponseError
            ---@param result razor.VBufUpdate
            ["razor/updateHtmlBuffer"] = function(_err, result)
              documentstore.update_vbuf(result, razor.language_kinds.html)
            end,
            ["razor/provideCodeActions"] = require("rzls.handlers.providecodeactions"),
            ["razor/resolveCodeActions"] = require("rzls.handlers.resolvecodeactions"),
            ["razor/provideHtmlColorPresentation"] = not_supported,
            ["razor/provideHtmlDocumentColor"] = require("rzls.handlers.providehtmldocumentcolor"),
            ["razor/provideSemanticTokensRange"] = require("rzls.handlers.providesemantictokensrange"),
            ["razor/foldingRange"] = require("rzls.handlers.foldingrange"),

            ["razor/htmlFormatting"] = require("rzls.handlers.htmlformatting"),
            ["razor/htmlOnTypeFormatting"] = not_implemented,
            ["razor/simplifyMethod"] = not_implemented,
            ["razor/formatNewFile"] = not_implemented,
            ["razor/inlayHint"] = require("rzls.handlers.inlayhint"),
            ["razor/inlayHintResolve"] = require("rzls.handlers.inlayhintresolve"),

            -- VS Windows only at the moment, but could/should be migrated
            ["razor/documentSymbol"] = not_implemented,
            ["razor/rename"] = not_implemented,
            ["razor/hover"] = not_implemented,
            ["razor/definition"] = not_implemented,
            ["razor/documentHighlight"] = not_implemented,
            ["razor/signatureHelp"] = not_implemented,
            ["razor/implementation"] = not_implemented,
            ["razor/references"] = not_implemented,

            -- Called to get C# diagnostics from Roslyn when publishing diagnostics for VS Code
            ["razor/csharpPullDiagnostics"] = require("rzls.handlers.csharppulldiagnostics"),
            ["razor/completion"] = require("rzls.handlers.completion"),
            ["razor/completionItem/resolve"] = require("rzls.handlers.completionitemresolve"),

            -- Standard LSP methods
            [vim.lsp.protocol.Methods.textDocument_colorPresentation] = not_supported,
            [vim.lsp.protocol.Methods.window_logMessage] = function(_, result)
              Log.rzls = result.message
              return vim.lsp.handlers[vim.lsp.protocol.Methods.window_logMessage]
            end,
          },
          filewatching = "roslyn",
          settings = {
            ["csharp|background_analysis"] = {
              dotnet_analyzer_diagnostics_scope = "fullSolution",
              dotnet_compiler_diagnostics_scope = "fullSolution",
            },
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
              dotnet_enable_tests_code_lens = true,
            },
            ["csharp|formatting"] = {
              dotnet_organize_imports_on_format = true,
            },
            ["csharp|completion"] = {
              dotnet_provide_regex_completions = true,
              dotnet_show_completion_items_from_unimported_namespaces = true,
              dotnet_show_name_completion_suggestions = true,
            },
            ["csharp|symbol_search"] = {
              dotnet_search_reference_assemblies = true,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      require("roslyn").setup(opts)
    end,
  },
  -- {
  --   "GustavEikaas/easy-dotnet.nvim",
  --   enabled = true,
  --   dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  --   config = function()
  --     require("easy-dotnet").setup()
  --   end,
  -- },
  {
    "GustavEikaas/easy-dotnet.nvim",
    enabled = true,
    cmd = "Dotnet",
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    event = "VeryLazy",
    ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets", "fsharp", "vb", "razor" },
    opts = function()
      local function get_secret_path(secret_guid)
        local path = ""
        local home_dir = vim.fn.expand("~")
        if require("easy-dotnet.extensions").isWindows() then
          local secret_path = home_dir
            .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
            .. secret_guid
            .. "\\secrets.json"
          path = secret_path
        else
          local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
          path = secret_path
        end
        return path
      end

      -- local sdkPath = function()
      --   return "/usr/share/dotnet/sdk/8.0.409"
      -- end

      require("config.keymaps.languages.c_sharp")

      local logPath = vim.fn.stdpath("data") .. "/easy-dotnet/build.log"

      return {
        --Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
        -- easy-dotnet will resolve the path automatically if this argument is omitted, for a performance improvement you can add a function that returns a hardcoded string
        -- You should define this function to return a hardcoded path for a performance improvement 🚀
        -- get_sdk_path = sdkPath,
        test_runner = {
          noBuild = false,
          noRestore = false,
          icons = {
            passed = "",
            skipped = "󰒬",
            failed = "✘",
            success = "",
            reload = "",
            test = "",
            sln = "󰘐",
            project = "󰘐",
            dir = "",
            package = "",
          },
          -- mappings = {
          --   run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
          --   filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
          --   debug_test = { lhs = "<leader>d", desc = "debug test" },
          --   go_to_file = { lhs = "g", desc = "got to file" },
          --   run_all = { lhs = "<leader>R", desc = "run all tests" },
          --   run = { lhs = "<leader>r", desc = "run test" },
          --   peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          --   expand = { lhs = "o", desc = "expand" },
          --   expand_node = { lhs = "E", desc = "expand node" },
          --   expand_all = { lhs = "-", desc = "expand all" },
          --   collapse_all = { lhs = "W", desc = "collapse all" },
          --   close = { lhs = "q", desc = "close testrunner" },
          --   refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
          -- },
          --- Optional table of extra args e.g "--blame crash"
          additional_args = {},
        },
        new = {
          project = {
            prefix = "sln", -- "sln" | "none"
          },
        },
        -- terminal = function(path, action, args)
        --   -- stylua: ignore
        --   local commands = {
        --     run = function() return string.format("dotnet run --project %s %s", path, args) end,
        --     test = function() return string.format("dotnet test %s %s", path, args) end,
        --     restore = function() return string.format("dotnet restore %s %s", path, args) end,
        --     build = function() return string.format("dotnet build %s %s", path, args) end,
        --     watch = function() return string.format("dotnet watch --project %s %s", path, args) end,
        --   }
        --
        --   local command = commands[action]() .. "\r"
        --   vim.cmd("vsplit")
        --   vim.cmd("term " .. command)
        -- end,
        terminal = function(path, action, args)
          -- stylua: ignore
          local commands = {
            run = function() return string.format("dotnet run --project %s %s", path, args) end,
            test = function() return string.format("dotnet test %s %s", path, args) end,
            -- restore = function() return string.format("dotnet restore %s %s", path, args) end,
            restore = function() return string.format("dotnet restore --configfile %s %s %s", os.getenv("NUGET_CONFIG"), path, args) end,
            -- build = function() return string.format("dotnet build %s %s", path, args) end,
            build = function() return string.format("dotnet build %s /flp:v=q /flp:logfile=%s %s", path, logPath, args) end,
            watch = function() return string.format("dotnet watch --project %s %s", path, args) end,
          }

          local function filter_warnings(line)
            if not line:find("warning") then
              return line:match("^(.+)%((%d+),(%d+)%)%: (.+)$")
            end
          end

          local overseer_components = {
            { "on_complete_dispose", timeout = 30 },
            "default",
            { "unique", replace = true },
            {
              "on_output_parse",
              parser = {
                diagnostics = {
                  { "extract", filter_warnings, "filename", "lnum", "col", "text" },
                },
              },
            },
            { "on_result_diagnostics_quickfix", open = true, close = true },
          }

          local funcs = require("config.functions")

          if action == "run" or action == "test" then
            table.insert(overseer_components, { "restart_on_save", paths = { funcs.git() } })
          end

          -- local command = commands[action]()
          local command = commands[action]() .. "\r"
          -- vim.cmd("vsplit")
          -- vim.cmd("term " .. command)

          local task = require("overseer").new_task({
            strategy = {
              "toggleterm",
              use_shell = false,
              direction = "horizontal",
              open_on_start = false,
            },
            name = action,
            cmd = command,
            cwd = funcs.git(),
            components = overseer_components,
          })
          task:start()
        end,
        csproj_mappings = true,
        fsproj_mappings = true,
        auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "block_scoped",
          enabled = true,
        },
        -- choose which picker to use with the plugin
        -- possible values are "telescope" | "fzf" | "snacks" | "basic"
        -- if no picker is specified, the plugin will determine
        -- the available one automatically with this priority:
        -- telescope -> fzf -> snacks ->  basic
        picker = "snacks",
      }
    end,
    config = function(_, opts)
      local dotnet = require("easy-dotnet")

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if dotnet.is_dotnet_project() then
            add_dotnet_mappings()
          end
        end,
      })

      dotnet.setup(opts)
    end,
  },
}

-- -- lua/easy-dotnet/dotnet_cli.lua file from easy-dotnet line 21
-- -- function M.list_packages(sln_file_path) return string.format("dotnet solution %s list", sln_file_path) end
-- function M.list_packages(sln_file_path) return string.format("dotnet sln %s list", sln_file_path) end

-- TODO: Add these to "Properties/launchSettings.json" automatically
-- "NeovimDebugProject.Api": {
-- 	"commandName": "Project",
-- 	"dotnetRunMessages": true,
-- 	"launchBrowser": true,
-- 	"launchUrl": "swagger",
-- 	"environmentVariables": {
-- 		"ASPNETCORE_ENVIRONMENT": "Development"
-- 	},
-- 	"applicationUrl": "https://localhost:7073;http://localhost:7071"
-- }
