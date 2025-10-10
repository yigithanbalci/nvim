if vim.g.my_config.search == "telescope" then
  return {}
elseif vim.g.my_config.search == "fzf-lua" then
  return {
    --NOTE: I am using default setting of lazyvim except a couple of keybindings
    {
      "ibhagwan/fzf-lua",
      opts = function(_, opts)
        opts.grep = opts.grep or {}

        local rg_opts = opts.grep.rg_opts or ""

        -- Ensure --line-number is included
        if not rg_opts:match("%-%-line%-number") and not rg_opts:match("%-n") then
          rg_opts = rg_opts .. " --line-number"
        end

        -- Ensure --column is included
        if not rg_opts:match("%-%-column") then
          rg_opts = rg_opts .. " --column"
        end

        -- Append --multiline if not already present
        if not rg_opts:match("%-%-multiline") then
          rg_opts = rg_opts .. " --multiline"
        end

        opts.grep.rg_opts = vim.trim(rg_opts)
        return opts
      end,
      keys = {
        { "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      },
    },
  }
else
  return {}
end
