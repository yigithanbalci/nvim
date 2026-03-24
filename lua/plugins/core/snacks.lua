--- Detect repo platform from git remote URL.
--- Returns "azure", "github", or nil.
local function detect_platform()
  local root = Snacks.git.get_root()
  if not root then
    return nil
  end
  local remote = vim.fn.system("git -C " .. vim.fn.shellescape(root) .. " remote get-url origin 2>/dev/null")
  remote = vim.trim(remote)
  if remote:find("dev%.azure%.com") or remote:find("visualstudio%.com") then
    return "azure"
  elseif remote:find("github%.com") then
    return "github"
  end
  return nil
end

local function github_cmds()
  return {
    {
      title = "Notifications",
      cmd = "gh notify -s -a -n5", --NOTE: this is an extension to gh CLI tool
      action = function()
        vim.ui.open("https://github.com/notifications")
      end,
      key = "n",
      icon = " ",
      height = 5,
      enabled = true,
    },
    {
      title = "Open Issues",
      cmd = "gh issue list -L 3",
      key = "i",
      action = function()
        vim.schedule(function()
          pcall(vim.fn.jobstart, "gh issue list --web", { detach = true })
        end)
      end,
      icon = " ",
      height = 7,
    },
    {
      icon = " ",
      title = "Open PRs",
      cmd = "gh pr list -L 3",
      key = "P",
      action = function()
        vim.schedule(function()
          pcall(vim.fn.jobstart, "gh pr list --web", { detach = true })
        end)
      end,
      height = 7,
    },
  }
end

local function azure_cmds()
  return {
    {
      title = "My Work Items",
      cmd = [[az boards query --wiql "SELECT [System.Id], [System.Title], [System.State] FROM WorkItems WHERE [System.State] <> 'Closed' AND [System.AssignedTo] = @Me ORDER BY [System.ChangedDate] DESC" --output table 2>/dev/null | head -8]],
      key = "i",
      icon = " ",
      height = 7,
    },
    {
      icon = " ",
      title = "Open PRs",
      cmd = "az repos pr list --status active --top 3 --output table 2>/dev/null",
      key = "P",
      height = 7,
    },
  }
end

return {
  {
    "snacks.nvim",
    dependencies = {
      "rmagatti/auto-session",
    },
    opts = {
      dashboard = {
        preset = {
          header = [[


███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          { section = "header" },
          --TODO: Add pokemon colorscript later
          -- {
          --   pane = 2,
          --   section = "terminal",
          --   cmd = "colorscript -e square",
          --   height = 5,
          --   padding = 1,
          -- },
          {
            section = "keys",
            gap = 1,
            padding = 1,
          },
          {
            pane = 2,
            icon = [[

          ]]
          },
          {
            pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            action = function()
              Snacks.gitbrowse()
            end,
          },
          function()
            local platform = detect_platform()
            if not platform then
              return {}
            end

            local cmds = platform == "azure" and azure_cmds() or github_cmds()

            -- Git Status is platform-agnostic
            table.insert(cmds, {
              icon = " ",
              title = "Git Status",
              cmd = "GIT_PAGER=cat git diff --stat -B -M -C",
              height = 10,
            })

            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 2,
                section = "terminal",
                enabled = true,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
          { section = "startup" },
        },
      },
    },
  },
}
