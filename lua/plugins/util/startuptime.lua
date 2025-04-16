return {
  "dstein64/vim-startuptime",
  enabled = false,
  version = false,
  cmd = "StartupTime",
  config = function()
    vim.g.startuptime_tries = 10
  end,
}
