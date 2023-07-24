local M = {}
M.defaults = {
  colorscheme = "gruvbox",
}

function M.setup(opts)
  M.icons = require("config.icons")
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

  require("config.lazy").setup()

  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("Setup", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      M.load_options()
      M.load_module("autocmds")
      M.load_module("keymaps")
    end,
  })

  M.load_theme()
end

function M.load_options()
  require("lazy.core.util").try(function()
    require("config.options").setup(M.options)
  end, {
    msg = "failed to load options",
    on_error = function(msg)
      require("lazy.core.util").error(msg)
    end,
  })
end

function M.load_theme()
  require("lazy.core.util").try(function()
    if type(M.options.colorscheme) == "function" then
      M.options.colorscheme()
    else
      vim.cmd.colorscheme(M.options.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      require("lazy.core.util").error(msg)

      vim.cmd.colorscheme("gruvbox")
    end,
  })
end

---@param name "autocmds" | "options" | "keymaps"
function M.load_module(name)
  local Util = require("lazy.core.util")

  local mod = "config." .. name
  Util.try(function()
    -- the real load module
    require(mod)
  end, {
    msg = "Failed loading " .. mod,
    on_error = function(msg)
      local info = require("lazy.core.cache").find(mod)
      if info == nil or (type(info) == "table" and #info == 0) then
        return
      end
      Util.error(msg)
    end,
  })
end

return M
