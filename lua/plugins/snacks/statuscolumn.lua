local M = {}

M.statuscolumn = {
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

