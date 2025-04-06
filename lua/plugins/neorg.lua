return {
  "nvim-neorg/neorg",
  version = "*",
  -- lazy = false,
  ft = { "norg", "neorg" },
  -- build = ":Neorg sync-parsers",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "benlubas/neorg-interim-ls",
    "benlubas/neorg-query",
    "mrcapivaro/true-zen.nvim",
  },
  config = function()
    vim.o.conceallevel = 2

    require("neorg").setup({
      load = {
        ["external.query"] = {
          -- Populate the database. Indexing happens on a separate thread, so doesn't block
          -- neovim. Funny enough, this is the only user facing way to trigger a full index of your
          -- workspace at the moment
          index_on_launch = true,

          -- Update the db entry when a file is written
          update_on_change = true,
        },
        ["external.interim-ls"] = { -- Required for external completion engine
          config = {
            completion_provider = {
              -- Enable or disable the completion provider
              enable = true,

              -- Show file contents as documentation when you complete a file name
              documentation = true,

              -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
              categories = true,

              -- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
              -- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
              people = {
                enable = true,

                -- path to the file you're like to use with the `{@x` syntax, relative to the
                -- workspace root, without the `.norg` at the end.
                -- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
                -- Note that this will change with your workspace, so it fails silently if the file
                -- doesn't exist
                path = "~/norg/people",
              },
            },
          },
        },

        -- DEFAULT MODULES (https://github.com/nvim-neorg/neorg/wiki#default-modules)
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.esupports.metagen"] = {
          config = {
            timezone = "local",
            type = "auto",
          },
        },

        ["core.keybinds"] = {
          config = {
            default_keybind = true,
            preset = "neorg",
            neorg_leader = ",",
          },
        },

        -- REQUIREMENTS
        -- TREESITTER INTEGRATION
        ["core.highlights"] = {},

        -- CONCEALER
        ["core.autocommands"] = {},
        ["core.integrations.treesitter"] = {
          config = {
            configure_parsers = true,
            install_parsers = true,
          },
        },

        -- EXPORT
        ["core.export.markdown"] = {
          config = {
            extension = "md",
          },
        },

        -- PRESENTER
        ["core.queries.native"] = {},
        ["core.ui"] = {},

        -- DIRMAN
        ["core.dirman.utils"] = {},
        ["core.storage"] = {
          config = {
            path = "~/norg/neorg.mpack",
          },
        },

        -- MODULES
        ["core.completion"] = {
          config = {
            engine = {
              module_name = "external.lsp-completion", -- Requires "benlubas/neorg-interim-ls"
              name = "[Neorg]",
            },
          },
        },
        ["core.concealer"] = {
          config = {
            folds = false,
            icon_preset = "varied",
            init_open_folds = "always",
          },
        }, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              main = "~/norg",
              learn = "~/norg/learn",
              nwn = os.getenv("NWN_DEV") .. "/norg",
              -- nwn = os.getenv("NWN_STORAGE") .. "/norg",
            },
            default_workspace = "main",
          },
        },
        ["core.export"] = {},
        ["core.fs"] = {},
        ["core.neorgcmd"] = {},
        ["core.neorgcmd.commands.return"] = {},
        ["core.presenter"] = {
          config = {
            zen_mode = "truezen",
            -- zen_mode = "zen-mode",
          },
        },
        ["core.scanner"] = {},
        ["core.summary"] = {},
        ["core.syntax"] = {},
        ["core.tangle"] = {
          config = {
            tangle_on_write = true,
          },
        },
        ["core.tempus"] = {},
        ["core.text-objects"] = {},
      },
    })

    require("config.keymaps.neorg")
  end,
}
