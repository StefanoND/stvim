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

-- Probably won't use it
M.kmOpts = { noremap = true, silent = true, remap = false }

return M
