local anim = require("plugins.editor.snacks.animate")
local bigf = require("plugins.editor.snacks.bigfile")
local bufd = require("plugins.editor.snacks.bufdelete")
local dashb = require("plugins.editor.snacks.dashboard")
local dbg = require("plugins.editor.snacks.debug")
local dm = require("plugins.editor.snacks.dim")
local exp = require("plugins.editor.snacks.explorer")
local fil = require("plugins.editor.snacks.picker.files")
local gt = require("plugins.editor.snacks.git")
local gitb = require("plugins.editor.snacks.gitbrowse")
local grp = require("plugins.editor.snacks.picker.grep")
local reg = require("plugins.editor.snacks.picker.register")
local img = require("plugins.editor.snacks.image")
local ind = require("plugins.editor.snacks.indent")
local inp = require("plugins.editor.snacks.input")
local lazyg = require("plugins.editor.snacks.lazygit")
local noti = require("plugins.editor.snacks.notifier")
local notif = require("plugins.editor.snacks.notify")
local prof = require("plugins.editor.snacks.profiler")
local quickf = require("plugins.editor.snacks.quickfile")
local rnm = require("plugins.editor.snacks.rename")
local scp = require("plugins.editor.snacks.scope")
local scrat = require("plugins.editor.snacks.scratch")
local scro = require("plugins.editor.snacks.scroll")
local statusc = require("plugins.editor.snacks.statuscolumn")
local term = require("plugins.editor.snacks.terminal")
local tog = require("plugins.editor.snacks.toggle")
local utl = require("plugins.editor.snacks.util")
local wn = require("plugins.editor.snacks.win")
local wrds = require("plugins.editor.snacks.words")
local zn = require("plugins.editor.snacks.zen")

local int = require("plugins.editor.snacks.snacksinit")

return {
  "folke/snacks.nvim",
  enabled = true,
  version = false,
  priority = 1000,
  lazy = false,
  opts = {
    animate = anim.conf,
    bigfile = bigf.conf,
    bufdelete = bufd.conf,
    dashboard = dashb.conf,
    debug = dbg.conf,
    dim = dm.conf,
    explorer = exp.conf,
    git = gt.conf,
    gitbrowse = gitb.conf,
    image = img.conf,
    indent = ind.conf,
    input = inp.conf,
    lazygit = lazyg.conf,
    notifier = noti.conf,
    notify = notif.conf,
    profiler = prof.conf,
    quickfile = quickf.conf,
    rename = rnm.conf,
    scope = scp.conf,
    scratch = scrat.conf,
    scroll = scro.conf,
    statuscolumn = statusc.conf,
    terminal = term.conf,
    toggle = tog.conf,
    util = utl.conf,
    words = wrds.conf,
    picker = {
      enabled = true,
      cwd = vim.fn.getcwd(),
      formatters = {
        file = {
          truncate = 80,
        },
      },
      sources = {
        explorer = exp.pkr,
        files = fil.pkr,
        grep = grp.pkr,
        register = reg.pkr,
      },
      icons = {
        tree = {
          vertical = "│ ",
          middle = "├╴",
          last = "╰╴",
        },
        ft = {
          nwscript = "",
        },
        filetype = {
          nwscript = "",
        },
        file_type = {
          nwscript = "",
        },
      },
    },
  },
  keys = require("config.keymaps.snacks"),
  init = int.conf,
}
