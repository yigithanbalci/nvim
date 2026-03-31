if not _G.yeet.plugins.ai.sidekick.enabled then
  return {}
end
return {
  {
    "folke/sidekick.nvim",
    -- stylua: ignore
    keys = {
      -- Nullify LazyVim sidekick extra defaults to avoid conflicts
      { "<leader>aa", false },
      { "<leader>as", false },
      { "<leader>ad", false },
      { "<leader>at", false },
      { "<leader>af", false },
      { "<leader>av", false },
      { "<leader>ap", false },
      -- nes is also useful in normal mode
      { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      -- TODO yigithanbalci 2026-03-31: will this fuck up default c-. behaviour of nvim?
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        desc = "Sidekick Focus",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>as",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>aSs",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>aSd",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>aSt",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>aSf",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>aSv",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>aSp",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
}
