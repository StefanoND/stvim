return {
  "ThePrimeagen/refactoring.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "Refacotr" },
  opts = {
    prompt_func_return_type = {
      go = false,
      java = false,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    prompt_func_param_type = {
      go = false,
      java = false,
      cpp = true,
      c = true,
      h = true,
      hpp = true,
      cxx = true,
    },
    printf_statements = {},
    print_var_statements = {},
    show_success_message = true, -- shows a message with information about the refactor on success
    -- i.e. [Refactor] Inlined 3 variable occurrences
  },
  config = function(_, opts)
    require("refactoring").setup(opts)
    require("config.keymaps.refactoring")
  end,
}
