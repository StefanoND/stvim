return { -- C++
  { "bfrg/vim-cpp-modern", ft = { "c", "cc", "cpp", "objc", "objcpp", "opencl" } },
  { "ranjithshegde/ccls.nvim", ft = { "c", "cc", "cpp", "objc", "objcpp", "opencl" } },
  {
    "p00f/clangd_extensions.nvim",
    -- dependencies = { "mortepau/codicons.nvim" },
    -- lazy = true,
    ft = { "c", "cc", "cpp", "objc", "objcpp", "opencl" },
    opts = function()
      return {
        ast = {
          --These require codicons (https://github.com/microsoft/vscode-codicons)
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },
          highlights = {
            detail = "Comment",
          },
        },
        memory_usage = {
          border = "Rounded",
        },
        symbol_info = {
          border = "Rounded",
        },
      }
    end,
    config = function(_, opts)
      require("clangd_extensions").setup(opts)
    end, -- avoid duplicate setup call.
  },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = function()
      local options = {
        preview = {
          quit = "q", -- optional keymapping for quit preview
          accept = "<tab>", -- optional keymapping for accept preview
        },
        header_extension = "h", -- optional
        source_extension = "cpp", -- optional
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
          },
          --[[
                <your impl function custom command name> = {
                    output_handle = function (str, context)
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
        },
      }
      return options
    end,
    -- End configuration
    config = true,
  },
}
