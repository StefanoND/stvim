return {
  "stevearc/conform.nvim",
  lazy = true,
  cmd = "ConformInfo",
  config = function()
    require("conform").setup({
      formatters = {
        biome = {
          require_cwd = true,
        },
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
        sqlfluff = {
          args = { "format", "--dialect=ansi", "-" },
        },
      },
      formatters_by_ft = {
        bash = { "shellharden" },
        c = { "clang-format" },
        cc = { "clang-format" },
        cmake = { "cmake-format" },
        cpp = { "clang-format" },
        cs = { "csharpier" },
        csharp = { "csharpier" },
        lua = { "stylua" },
        gdscript = { "gdtoolkit" },
        nwscript = { "clang-format" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
        opencl = { "clang-format" },
        json = { "biome" },
        jsonc = { "biome" },
        sql = { "sqlfluff" },
        mysql = { "sqlfluff" },
        plsql = { "sqlfluff" },
        ["markdown"] = { "biome", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "biome", "markdownlint-cli2", "markdown-toc" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        ["javascript.jsx"] = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        ["typescript.tsx"] = { "biome" },
        -- Stop searching after finding first formatter
        -- name = { "formatter1", "formatter2", stop_after_first = true },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
