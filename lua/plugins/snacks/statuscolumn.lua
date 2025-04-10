local M = {}

M.conf = {
  enabled = true,
  left = { "fold", "git" },
  right = { "mark", "sign" },
  folds = {
    open = true,
    git_hl = true,
  },
  git = {
    patterns = { "GitSign", "GitSigns", "MiniDiffSign" },
  },
}

return M
