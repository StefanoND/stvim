local M = {}

M.excludeAll = {
  -- "Utilities",
  -- "node_modules",
  -- "Utilities/omnisharp*",
  -- ".git",
  -- "dist",
  -- "lazy-lock.json",
}

M.excludeExplorer = {
  -- "Utilities",
  -- "node_modules",
  -- "Utilities/omnisharp*",
  -- ".git",
  -- "dist",
  -- "lazy-lock.json",
}

M.excludeFiles = {
  -- "node_modules",
  -- "Utilities/omnisharp*",
  -- ".git",
  -- "dist",
  -- "lazy-lock.json",
}

M.excludeGrep = {
  -- "node_modules",
  -- "Utilities/omnisharp*",
  -- ".git",
  -- "dist",
  -- "lazy-lock.json",
}

M.win = {
  list = {
    wo = {
      number = true,
      relativenumber = true,
    },
  },
}

M.files = {
  hidden = true,
  ignored = true,
  follow = true,
  show_empty = true,
  win = M.win,
}

return M
