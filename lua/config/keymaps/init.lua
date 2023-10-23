vim.notify("Lazy loaded", vim.log.levels.INFO, {
  title = "Lazy",
})
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

require("config.keymaps.core")(map)
require("config.keymaps.git")(map)
require("config.keymaps.terminal")(map)
require("config.keymaps.navigation")(map)
require("config.keymaps.code")(map)
require("config.keymaps.telescope")(map)
require("config.keymaps.dap")(map)
require("config.keymaps.test")(map)
-- Plugin Manager

-- navigation ---------------------------------------------------------------------------------------------
-- harpoon

-- map("n", "<leader>h", { name = "+Harpoon" })
