local opts = {
  -- Text editing
  ai = { enabled = true }, -- Extend and create a/i textobjects. "sa" and "si"
  align = { enabled = true },
  comment = { enabled = false },
  completion = { enabled = false },
  move = { enabled = true },
  operators = { enabled = true },
  pairs = { enabled = false }, -- Auto-pairs
  snippets = { enabled = false },
  splitjoin = { enabled = true },
  surround = { enabled = true },

  -- General workflow
  basics = { enabled = true },
  bracketed = { enabled = true },
  bufremove = { enabled = false },
  clue = { enabled = true },
  deps = { enabled = false },
  diff = { enabled = true },
  extra = { enabled = false },
  files = { enabled = false },
  git = { enabled = false },
  jump = { enabled = true },
  jump2d = { enabled = true }, -- This will make me lazy
  misc = { enabled = false },
  pick = { enabled = false },
  sessions = { enabled = false },
  visits = { enabled = false },

  -- Appearance
  animate = { enabled = false },
  base16 = { enabled = false },
  colors = { enabled = false },
  cursorword = { enabled = false },
  hipatterns = { enabled = true },
  hues = { enabled = false },
  indentscope = { enabled = false },
  map = { enabled = true },
  notify = { enabled = false },
  starter = { enabled = false },
  statusline = { enabled = false },
  tabline = { enabled = false },
  trailspace = { enabled = true },

  -- Other
  doc = { enabled = false },
  fuzzy = { enabled = false },
  test = { enabled = false },
}

return {
  "echasnovski/mini.nvim",
  enabled = true,
  version = false,
  -- lazy = false,
  event = "VeryLazy",
  config = function()
    -- Text editing
    if opts.ai.enabled then
      require("mini.ai").setup(require("plugins.editor.mini.text.ai"))
    end
    if opts.align.enabled then
      require("mini.align").setup(require("plugins.editor.mini.text.align"))
    end
    if opts.comment.enabled then
      require("mini.comment").setup(require("plugins.editor.mini.text.comment"))
    end
    if opts.completion.enabled then
      require("mini.completion").setup(require("plugins.editor.mini.text.completion"))
    end
    if opts.move.enabled then
      require("mini.move").setup(require("plugins.editor.mini.text.move"))
    end
    if opts.operators.enabled then
      require("mini.operators").setup(require("plugins.editor.mini.text.operators"))
    end
    if opts.pairs.enabled then
      require("mini.pairs").setup(require("plugins.editor.mini.text.pairs"))
    end
    if opts.snippets.enabled then
      require("mini.snippets").setup(require("plugins.editor.mini.text.snippets"))
    end
    if opts.splitjoin.enabled then
      require("mini.splitjoin").setup(require("plugins.editor.mini.text.splitjoin"))
    end
    if opts.surround.enabled then
      require("mini.surround").setup(require("plugins.editor.mini.text.surround"))
    end

    -- General workflow
    if opts.basics.enabled then
      require("mini.basics").setup(require("plugins.editor.mini.general.basics"))
    end
    if opts.bracketed.enabled then
      require("mini.bracketed").setup(require("plugins.editor.mini.general.bracketed"))
    end
    if opts.bufremove.enabled then
      require("mini.bufremove").setup(require("plugins.editor.mini.general.bufremove"))
    end
    if opts.clue.enabled then
      require("mini.clue").setup(require("plugins.editor.mini.general.clue"))
    end
    if opts.deps.enabled then
      require("mini.deps").setup(require("plugins.editor.mini.general.deps"))
    end
    if opts.diff.enabled then
      require("mini.diff").setup(require("plugins.editor.mini.general.diff"))
      -- vim.keymap.set("v", "<leader>to", ":lua require('mini.diff').toggle_overlay()<CR>", kopts)
    end
    if opts.extra.enabled then
      require("mini.extra").setup(require("plugins.editor.mini.general.extra"))
    end
    if opts.files.enabled then
      require("mini.files").setup(require("plugins.editor.mini.general.files"))
    end
    if opts.git.enabled then
      require("mini.git").setup(require("plugins.editor.mini.general.git"))
    end
    if opts.jump.enabled then
      require("mini.jump").setup(require("plugins.editor.mini.general.jump"))
    end
    if opts.jump2d.enabled then
      require("mini.jump2d").setup(require("plugins.editor.mini.general.jump2d"))
    end
    if opts.misc.enabled then
      require("mini.misc").setup(require("plugins.editor.mini.general.misc"))
    end
    if opts.pick.enabled then
      require("mini.pick").setup(require("plugins.editor.mini.general.pick"))
    end
    if opts.sessions.enabled then
      require("mini.sessions").setup(require("plugins.editor.mini.general.sessions"))
    end
    if opts.visits.enabled then
      require("mini.visits").setup(require("plugins.editor.mini.general.visits"))
    end

    -- Appearance
    if opts.animate.enabled then
      require("mini.animate").setup(require("plugins.editor.mini.appearance.animate"))
    end
    if opts.base16.enabled then
      require("mini.base16").setup(require("plugins.editor.mini.appearance.base16"))
    end
    if opts.colors.enabled then
      require("mini.colors").setup(require("plugins.editor.mini.appearance.colors"))
    end
    if opts.cursorword.enabled then
      require("mini.cursorword").setup(require("plugins.editor.mini.appearance.cursorword"))
    end
    if opts.hipatterns.enabled then
      require("mini.hipatterns").setup(require("plugins.editor.mini.appearance.hipatterns"))
    end
    if opts.hues.enabled then
      require("mini.hues").setup(require("plugins.editor.mini.appearance.hues"))
    end
    if opts.indentscope.enabled then
      require("mini.indentscope").setup(require("plugins.editor.mini.appearance.indentscope"))
    end
    if opts.map.enabled then
      require("mini.map").setup(require("plugins.editor.mini.appearance.map"))
      require("mini.map").toggle()
    end
    if opts.notify.enabled then
      require("mini.notify").setup(require("plugins.editor.mini.appearance.notify"))
    end
    if opts.starter.enabled then
      require("mini.starter").setup(require("plugins.editor.mini.appearance.starter"))
    end
    if opts.statusline.enabled then
      require("mini.statusline").setup(require("plugins.editor.mini.appearance.statusline"))
    end
    if opts.tabline.enabled then
      require("mini.tabline").setup(require("plugins.editor.mini.appearance.tabline"))
    end
    if opts.trailspace.enabled then
      require("mini.trailspace").setup(require("plugins.editor.mini.appearance.trailspace"))
    end

    -- Other
    if opts.doc.enabled then
      require("mini.doc").setup(require("plugins.editor.mini.other.doc"))
    end
    if opts.fuzzy.enabled then
      require("mini.fuzzy").setup(require("plugins.editor.mini.other.fuzzy"))
    end
    if opts.test.enabled then
      require("mini.test").setup(require("plugins.editor.mini.other.test"))
    end

    -- Load keymaps
    require("config.keymaps.mini")
  end,
}
