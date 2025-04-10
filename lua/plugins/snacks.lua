local anim = require("plugins.snacks.animate")
local bigf = require("plugins.snacks.bigfile")
local bufd = require("plugins.snacks.bufdelete")
local dashb = require("plugins.snacks.dashboard")
local dbg = require("plugins.snacks.debug")
local dm = require("plugins.snacks.dim")
local exp = require("plugins.snacks.explorer")
local fil = require("plugins.snacks.picker.files")
local gt = require("plugins.snacks.git")
local gitb = require("plugins.snacks.gitbrowse")
local grp = require("plugins.snacks.picker.grep")
local reg = require("plugins.snacks.picker.register")
local img = require("plugins.snacks.image")
local ind = require("plugins.snacks.indent")
local inp = require("plugins.snacks.input")
local lazyg = require("plugins.snacks.lazygit")
local noti = require("plugins.snacks.notifier")
local notif = require("plugins.snacks.notify")
local prof = require("plugins.snacks.profiler")
local quickf = require("plugins.snacks.quickfile")
local rnm = require("plugins.snacks.rename")
local scp = require("plugins.snacks.scope")
local scrat = require("plugins.snacks.scratch")
local scro = require("plugins.snacks.scroll")
local statusc = require("plugins.snacks.statuscolumn")
local term = require("plugins.snacks.terminal")
local tog = require("plugins.snacks.toggle")
local utl = require("plugins.snacks.util")
local wn = require("plugins.snacks.win")
local wrds = require("plugins.snacks.words")
local zn = require("plugins.snacks.zen")

local int = require("plugins.snacks.snacksinit")

return {
  "folke/snacks.nvim",
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
    },
  },
  keys = require("config.keymaps.snacks"),
  init = int.conf,
}
