local M = {}

local shouldOpenExplorer = function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match("^%a+://") or bufname == "" then
    return true -- There's no opened buffers, open explorer
  end
  return false -- There's a buffer open, don't open explorer
end

local openExplorer = function()
  vim.cmd([[lua require("snacks").explorer.open()]])
end

local checkOpenExplorer = function()
  if shouldOpenExplorer() then
    openExplorer()
  end
end

M.init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      local Snacks = require("snacks")
      -- Disable animations globally
      vim.g.snacks_animate = false

      -- Create some toggle mappings
      local toggleConceal = { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
      -- local toggleBackground = { off = "light", on = "dark", name = "Dark Background" }

      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
      Snacks.toggle.option("conceallevel", toggleConceal):map("<leader>uc")
      -- Snacks.toggle.option("background", toggleBackground):map("<leader>ub")
      Snacks.toggle.inlay_hints():map("<leader>th")

      Snacks.toggle.profiler():map("<leader>ppp") -- Toggle the profiler
      Snacks.toggle.profiler_highlights():map("<leader>pph") -- Toggle the profiler highlights

      checkOpenExplorer()
    end,
  })

  -- Show LSP Progress
  ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
  local progress = vim.defaulttable()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
      if not client or type(value) ~= "table" then
        return
      end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          p[i] = {
            token = ev.data.params.token,
            msg = ("[%3d%%] %s%s"):format(
              value.kind == "end" and 100 or value.percentage or 100,
              value.title or "",
              value.message and (" **%s**"):format(value.message) or ""
            ),
            done = value.kind == "end",
          }
          break
        end
      end

      local msg = {} ---@type string[]
      progress[client.id] = vim.tbl_filter(function(v)
        return table.insert(msg, v.msg) or not v.done
      end, p)

      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
        id = "lsp_progress",
        title = client.name,
        opts = function(notif)
          notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor((vim.uv or vim.loop).hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return M
