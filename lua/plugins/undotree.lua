return {
  {
    "mbbill/undotree",
    name = "undotree",
    config = function(_, opts)
      -- Check if persistent undo is supported
      if vim.fn.has("persistent_undo") == 1 then
        -- Expand the path to resolve the home directory
        local target_path = vim.fn.expand("~/.undodir")

        -- Create the directory if it does not exist
        if vim.fn.isdirectory(target_path) == 0 then
          -- The equivalent in Lua requires os.execute with mkdir
          os.execute(
            "mkdir -p " .. vim.fn.shellescape(target_path) .. " && chmod 0700 " .. vim.fn.shellescape(target_path)
          )
        end

        -- Set the 'undodir' option
        vim.o.undodir = target_path
        -- Enable undo file
        vim.o.undofile = true
      end
      return opts
    end,
    keys = {
      {
        "<leader>U",
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = "+undotree",
      },
    },
  },
}
