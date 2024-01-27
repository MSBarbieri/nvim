local Util = require("util")
return function(map)
  if vim.fn.executable("lazygit") == 1 then
    -- map("n", "<leader>g", { sections.g }) TODO: add Git to which-key
    map("n", "<leader>gg", function()
      local worktree = Util.file_worktrees()

      local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
      Util.toggle_term_cmd("lazygit " .. flags)
    end, { desc = "ToggleTerm lazygit" })
    map("n", "<leader>tl", "<leader>gg")
  end

  -- map("n", "<leader>gb", function()
  --   require("telescope.builtin").git_branches({ use_file_path = true })
  -- end, { desc = "Git branches" })
  -- map("n", "<leader>gc", function()
  --   require("telescope.builtin").git_commits({ use_file_path = true })
  -- end, { desc = "Git commits (repository)" })
  -- map("n", "<leader>gC", function()
  --   require("telescope.builtin").git_bcommits({ use_file_path = true })
  -- end, { desc = "Git commits (current file)" })
  -- map("n", "<leader>gt", function()
  --   require("telescope.builtin").git_status({ use_file_path = true })
  -- end, { desc = "Git status" })

  -- Navigation Git
  map("n", "]g", function()
    require("gitsigns").next_hunk()
  end, { desc = "Next Git hunk" })
  map("n", "[g", function()
    require("gitsigns").prev_hunk()
  end, { desc = "Previous Git hunk" })
  map("n", "<leader>gl", function()
    require("gitsigns").next_hunk()
  end, { desc = "Next Git hunk" })
  map("n", "<leader>gh", function()
    require("gitsigns").prev_hunk()
  end, { desc = "Previous Git hunk" })

  map("n", "<leader>ge", function()
    require("gitsigns").blame_line()
  end, { desc = "View Git blame" })
  map("n", "<leader>gE", function()
    require("gitsigns").blame_line({ full = true })
  end, { desc = "View full Git blame" })
  map("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
  end, { desc = "Preview Git hunk" })

  map("n", "<leader>gi", function()
    require("gitsigns").stage_hunk()
  end, { desc = "Stage Git hunk" })
  map("n", "<leader>gi", function()
    require("gitsigns").stage_buffer()
  end, { desc = "Stage Git buffer" })
  map("n", "<leader>gu", function()
    require("gitsigns").undo_stage_hunk()
  end, { desc = "Unstage Git hunk" })

  map("n", "<leader>gd", function()
    require("gitsigns").diffthis()
  end, { desc = "View Git diff" })
end
