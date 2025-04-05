return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        bash = { "shellharden" },
        c = { "clang-format" },
        cc = { "clang-format" },
        cmake = { "cmake-format" },
        cpp = { "clang-format" },
        cs = { "csharpier" },
        csharp = { "csharpier" },
        lua = { "stylua" },
        nwscript = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
        opencl = { "clang-format" },
        -- Stop searching after finding first formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
