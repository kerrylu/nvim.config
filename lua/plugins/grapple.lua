return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    local grapple = require("grapple")

    grapple.setup({
      scope = "git_worktree",
      scopes = {
        {
          name = "git_worktree",
          desc = "Git repository shared across worktrees",
          fallback = "cwd",
          cache = { event = { "BufEnter", "FocusGained", "DirChanged" }, debounce = 1000 },
          resolver = function()
            local output = vim.fn.systemlist({
              "git",
              "rev-parse",
              "--path-format=absolute",
              "--show-toplevel",
              "--git-common-dir",
            })

            if vim.v.shell_error ~= 0 or #output < 2 then
              return nil, nil, "Not in a git repository"
            end

            local root = vim.fs.normalize(output[1])
            local git_common_dir = vim.fs.normalize(output[2])

            return git_common_dir, root
          end,
        },
      },
    })

    vim.keymap.set("n", "<leader>t", grapple.toggle)
    vim.keymap.set("n", "<leader>pt", grapple.toggle_tags)
  end,
}
