local vars = require("config.vars")

return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "all" },
        })
      end,
    },
  },
  keys = function()
    return {}
  end,
  build = function()
    if vars.getOSLowerCase():match("windows") then
      return "make install_jsregexp"
    end
  end,
  opts = {
    enable_autosnippets = true,
  },
  config = function(_, opts)
    local luasnip = require("luasnip")

    -- local opts = { noremap = true, silent = true }

    local path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/snippets"

    -- require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = path })
    require("luasnip.loaders.from_snipmate").lazy_load()
    -- require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "all" } })

    luasnip.filetype_extend("lua", { "luadoc" })
    -- luasnip.filetype_extend("rust", { "rustdoc" })
    luasnip.filetype_extend("cs", { "csharpdoc" })
    luasnip.filetype_extend("c", { "cdoc" })
    luasnip.filetype_extend("cpp", { "cppdoc" })
    luasnip.filetype_extend("sh", { "shelldoc" })
    -- luasnip.filetype_extend("sql", { "sqldoc" })
    -- luasnip.filetype_extend("markdown", { "mddoc" })
    luasnip.filetype_extend("gdscript", { "gdscriptdoc" })
    -- luasnip.filetype_extend("unrealengine", { "unrealdoc" })

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
    require("luasnip").setup(opts)
  end,
}
