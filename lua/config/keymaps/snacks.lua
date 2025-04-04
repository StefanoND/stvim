return {
  -- BufDelete
  {
    "D",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete Active Buffer"
  },
  -- Explorer
  {
    "<leader>op",
    function()
      Snacks.explorer()
    end,
    desc = "Open CWD File Explorer"
  },
  -- Find
  {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find files"
  },
  {
    "<leader>fs",
    function()
      Snacks.picker.grep()
    end,
    desc = "Find Grep"
  },
  {
    "<leader>fd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Find Diagnostics"
  },
  {
    "<leader>fD",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Find Buffer Diagnostics"
  },
  {
    "<leader>fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Find Buffers"
  },
  {
    "<leader>fh",
    function()
      Snacks.picker.help()
    end,
    desc = "Find Help Pages"
  },
  {
    "<leader>fgf",
    function()
      Snacks.picker.git_files()
    end,
    desc = "Find Git Files"
  },
  {
    "<leader>fm",
    function()
      Snacks.picker.makrs()
    end,
    desc = "Find Marks"
  },
  {
    "<leader>fps",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "Find LSP Symbols"
  },
  {
    "<leader>fws",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = "Find LSP Workspace Symbols"
  },
  {
    "<leader>fn",
    ":Nerdy<CR>",
    desc = "Find Nerdfonts Glyphs"
  },
  -- Git
  {
    "<leader>gS",
    function()
      Snacks.gitbrowse.open(opts)
    end,
    desc = "Open the repository of active file in the browser",
  },
  {
    "<leader>gl",
    function()
      Snacks.lazygit(opts)
    end,
    desc = "Opens lazygit",
  },
  {
    "<leader>gll",
    function()
      Snacks.lazygit.log(opts)
    end,
    desc = "Opens lazygit with the log view",
  },
  {
    "<leader>glf",
    function()
      Snacks.lazygit.log_file(opts)
    end,
    desc = "Opens lazygit with the log of the current file",
  },
  -- Picker
  {
    "<leader>sp",
    function()
      Snacks.picker()
    end,
    desc = "Show all pickers",
  },
  -- Profiler
  {
    "<leader>pps",
    function()
      Snacks.profiler.scratch()
    end,
    desc = "Profiler scratch buffer",
  },
  -- Registers
  {
    '<leader>s"',
    function()
      Snacks.picker.registers()
    end,
    desc = "Registers",
  },
  -- Scratch
  {
    "<leader>.",
    function()
      Snacks.scratch()
    end,
    desc = "Toggle Scratch Buffer",
  },
  {
    "<leader>S",
    function()
      Snacks.scratch.select()
    end,
    desc = "Select Scratch Buffer",
  },
  -- Terminal
  {
    "<leader>tt",
    function()
      Snacks.terminal.toggle()
    end,
    desc = "Toggle terminal",
  },
  -- Words
  {
    "<leader>wj",
    function()
      Snacks.words.jump(1, true)
    end,
    desc = "Jumps to next reference",
  }
}
