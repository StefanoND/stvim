local vars = require("config.vars")

return {
  "L3MON4D3/LuaSnip",
  build = vars.getOSLowerCase():match("windows") ~= 0 and "make install_jsregexp" or nil,
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  keys = function()
    return {}
  end,
  opts = {
    enable_autosnippets = true,
  },
  config = function(_, opts)
    local luasnip = require("luasnip")
    if opts then
      luasnip.setup(opts)
    end

    -- local opts = { noremap = true, silent = true }

    local path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/snippets"

    require("luasnip.loaders.from_lua").lazy_load({ paths = path })
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.filetype_extend("lua", { "luadoc" })
    luasnip.filetype_extend("markdown", { "mddoc" })
    luasnip.filetype_extend("sh", { "shelldoc" })

    -- vim.keymap.set("i", "<C-s>e", function()
    --   luasnip.expand()
    -- end, opts)
    -- vim.keymap.set({ "i", "s" }, "<C-s>,", function()
    --   luasnip.jump(1)
    -- end, opts)
    -- vim.keymap.set({ "i", "s" }, "<C-s>.", function()
    --   luasnip.jump(-1)
    -- end, opts)
    -- vim.keymap.set({ "i", "s" }, "<C-s>c", function()
    --   if luasnip.choice_active() then
    --     luasnip.change_choice(1)
    --   end
    -- end, opts)
  end,
}
