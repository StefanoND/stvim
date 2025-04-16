local M = {}

M.maxFileSize = 2 * 1024 * 1024

M.highlights = {
  "RainbowDelimiterRed",
  "RainbowDelimiterYellow",
  "RainbowDelimiterBlue",
  "RainbowDelimiterOrange",
  "RainbowDelimiterGreen",
  "RainbowDelimiterViolet",
  "RainbowDelimiterCyan",
}

M.rootPatterns = {
  general = {
    ".git",
    "Makefile",
    "makefile",
  },
  biome = { vim.tbl_deep_extend("force", { general }, { "biome.json", "biome.jsonc" }) },
  cmake = {
    vim.tbl_deep_extend(
      "force",
      { general },
      { "CMakePresets.json", "CTestConfig.cmake", "CMakefile", "build", "cmake" }
    ),
  },
  cpp = {
    vim.tbl_deep_extend("force", { general }, {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac", -- AutoTools
      "*.uproject", -- Unreal Engine
    }),
  },
  c_sharp = { vim.tbl_deep_extend("force", { general }, { "*.sln", "*.fsproj", "*.csproj" }) },
  gdscript = { vim.tbl_deep_extend("force", { general }, { "project.godot" }) },
  json = { general },
  -- json = {
  --   vim.tbl_deep_extend("force", { general }, {}),
  -- },
  lua = {
    vim.tbl_deep_extend("force", { general }, {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
    }),
  },
  markdown = { vim.tbl_deep_extend("force", { general }, { ".marksman.toml" }) },
  nwscript = { vim.tbl_deep_extend("force", { general }, { "nasher.cfg" }) },
  tailwind = {
    vim.tbl_deep_extend("force", { general }, {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
    }),
  },
-- stylua: ignore
 typescript = { vim.tbl_deep_extend("force", { general }, { "tsconfig.json", "jsconfig.json", "package.json" }) },
  -- ".bzr",
  -- ".hg",
  -- ".null-ls-root",
  -- ".svn",
  -- "_darcs",
  -- "build.ninja",
  -- "config.h.in",
  -- "configure.ac",
  -- "configure.in",
  -- "meson.build",
  -- "meson_options.txt",
}

-- Probably won't use it
M.kmOpts = { noremap = true, silent = true, remap = false }

return M
