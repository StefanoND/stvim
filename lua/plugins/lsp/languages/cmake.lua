return {
  {
    "cdelledonne/vim-cmake",
    version = false,
    ft = { "cmake" },
    config = function()
      require("config.keymaps.languages.cmake")
      vim.g.cmake_link_compile_commands = 1
    end,
  },
  {
    "Civitasv/cmake-tools.nvim",
    version = false,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/overseer.nvim",
    },
    ft = { "cmake" },
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load({ plugins = { "cmake-tools.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = function()
      return {
        cmake_build_directory = "build/${variant:buildType}",
      }
    end,
    config = function(_, opts)
      require("cmake-tools").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    ft = { "cmake" },
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_c = {
          {
            function()
              return "CMake:"
            end,
            icon = "",
            separator = "",
            padding = { left = 1, right = 0 },
            cond = function()
              return package.loaded["cmake-tools"] and require("cmake-tools").is_cmake_project()
            end,
            on_click = function(clicks, button)
              if button == "l" and clicks == 1 then
                vim.cmd("CMakeGenerate")
              end
            end,
          },
          {
            function()
              local preset = require("cmake-tools").get_configure_preset()
              return "[" .. (preset and preset or "") .. "]"
            end,
            separator = "",
            cond = function()
              return package.loaded["cmake-tools"]
                and require("cmake-tools").is_cmake_project()
                and require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(clicks, button)
              if button == "l" and clicks == 1 then
                vim.cmd("CMakeSelectConfigurePreset")
              end
            end,
          },
          {
            function()
              local type = require("cmake-tools").get_build_type()
              return "[" .. (type and type or "") .. "]"
            end,
            separator = "",
            cond = function()
              return package.loaded["cmake-tools"]
                and require("cmake-tools").is_cmake_project()
                and not require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(clicks, button)
              if button == "l" and clicks == 1 then
                vim.cmd("CMakeSelectBuildType")
              end
            end,
          },
          {
            function()
              return "Build"
            end,
            icon = "",
            separator = "",
            padding = { left = 1, right = 0 },
            cond = function()
              return package.loaded["cmake-tools"] and require("cmake-tools").is_cmake_project()
            end,
            on_click = function(clicks, button)
              if clicks == 1 and button == "l" then
                vim.cmd("CMakeBuild")
              end
            end,
          },
          {
            function()
              local preset = require("cmake-tools").get_build_preset()
              return "[" .. (preset and preset or "") .. "]"
            end,
            separator = "",
            cond = function()
              return package.loaded["cmake-tools"]
                and require("cmake-tools").is_cmake_project()
                and require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(clicks, button)
              if button == "l" and clicks == 1 then
                vim.cmd("CMakeSelectBuildPreset")
              end
            end,
          },
          {
            function()
              local type = require("cmake-tools").get_build_target()
              return "[" .. (type and type or "") .. "]"
            end,
            cond = function()
              return package.loaded["cmake-tools"] and require("cmake-tools").is_cmake_project()
              -- and not require("cmake-tools").has_cmake_preset()
            end,
            on_click = function(clicks, button)
              if clicks == 1 and button == "l" then
                vim.cmd("CMakeSelectBuildTarget")
              end
            end,
          },
        },
      },
    },
  },
}
