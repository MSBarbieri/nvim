local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local previewers = require('telescope.previewers')
local config = require('telescope.config').values
local utils = require('util')

vim.api.nvim_create_user_command('ChangeCase', function()
  local lines = vim.api.nvim_get_current_line()
  print(lines)
  pickers.new(nil, {
    finder = finders.new_table({
      results = {
        { name = "snake_case", value = 'snake' },
        { name = "PascalCase", value = 'pascal' },
        { name = "CamelCase",  value = 'camel' },
      },
      entry_maker = function(entry)
        return {
          display = entry.name,
          ordinal = entry.name,
          value = entry.value
        }
      end,
    }),
    sorter = config.generic_sorter(),
    previewer = previewers.new_buffer_previewer({
      title = 'change text case',
      define_preview = function(self, entry)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true,
          vim.tbl_flatten({ entry.value, lines }))
      end
    })
  }):find()
end, {})
