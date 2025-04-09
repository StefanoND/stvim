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
  ".bzr",
  ".csproj",
  ".git",
  ".hg",
  ".luarc.json",
  ".marksman.toml",
  ".null-ls-root",
  ".sln",
  ".svn",
  ".uproject",
  "CMakefile",
  "Makefile",
  "_darcs",
  "biome.json",
  "biome.jsonc",
  "build.ninja",
  "compile_commands.json",
  "compile_flags.txt",
  "config.h.in",
  "configure.ac",
  "configure.in",
  "meson.build",
  "meson_options.txt",
  "nasher.cfg",
  "package.json",
  "project.godot",
}

-- Probably won't use it
M.kmOpts = { noremap = true, silent = true, remap = false }

return M
