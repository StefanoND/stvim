local animate = require("plugins.snacks.animate")
local bigfile = require("plugins.snacks.bigfile")
local bufdelete = require("plugins.snacks.bufdelete")
local dashboard = require("plugins.snacks.dashboard")
local debug = require("plugins.snacks.debug")
local dim = require("plugins.snacks.dim")
local explorer = require("plugins.snacks.explorer")
local files = require("plugins.snacks.picker.files")
local git = require("plugins.snacks.git")
local gitbrowse = require("plugins.snacks.gitbrowse")
local grep = require("plugins.snacks.picker.grep")
local register = require("plugins.snacks.picker.register")
local image = require("plugins.snacks.image")
local indent = require("plugins.snacks.indent")
local input = require("plugins.snacks.input")
local lazygit = require("plugins.snacks.lazygit")
local notifier = require("plugins.snacks.notifier")
local notify = require("plugins.snacks.notify")
local profiler = require("plugins.snacks.profiler")
local quickfile = require("plugins.snacks.quickfile")
local rename = require("plugins.snacks.rename")
local scope = require("plugins.snacks.scope")
local scratch = require("plugins.snacks.scratch")
local scroll = require("plugins.snacks.scroll")
local statuscolumn = require("plugins.snacks.statuscolumn")
local terminal = require("plugins.snacks.terminal")
local toggle = require("plugins.snacks.toggle")
local util = require("plugins.snacks.util")
local win = require("plugins.snacks.win")
local words = require("plugins.snacks.words")
local zen = require("plugins.snacks.zen")

local init = require("plugins.snacks.snacksinit")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = animate.animate,
    bigfile = bigfile.bigfile,
    bufdelete = bufdelete.bufdelete,
    dashboard = dashboard.dashboard,
    debug = debug.debug,
    dim = dim.dim,
    explorer = explorer.explorer,
    git = git.git,
    gitbrowse = gitbrowse.gitbrowse,
    image = image.image,
    indent = indent.indent,
    input = input.input,
    lazygit = lazygit.lazygit,
    notifier = notifier.notifier,
    notify = notify.notify,
    profiler = profiler.profiler,
    quickfile = quickfile.quickfile,
    rename = rename.rename,
    scope = scope.scope,
    scratch = scratch.scratch,
    scroll = scroll.scroll,
    statuscolumn = statuscolumn.statuscolumn,
    terminal = terminal.terminal,
    toggle = toggle.toggle,
    util = util.util,
    words = words.words,
    picker = {
      enabled = true,
      formatters = {
        file = {
          truncate = 80,
        },
      },
      sources = {
        explorer = explorer.picker,
        files = files.picker,
        grep = grep.picker,
        register = register.picker,
      },
    },
  },
  keys = require("config.keymaps.snacks"),
  init = init.init,
}
