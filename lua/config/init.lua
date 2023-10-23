local M = {}
M.defaults = {
  colorscheme = "gruvbox",
}

function M.setup(opts)
  M.icons = require("config.icons")
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

  M.load_options()
  local group = vim.api.nvim_create_augroup("LazyVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      M.load_module("autocmds")
      M.load_module("keymaps")
      M.load_module("envs")
    end,
  })

  require("config.lazy").setup()


  M.load_theme()
end

function M.load_options()
  require("config.options").setup(M.options)
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
