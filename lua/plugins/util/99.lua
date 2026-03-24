if not vim.g.my_config.ai.ninety_nine.enabled then
  return {}
end
return {
  {
    "ThePrimeagen/99",
    event = "VeryLazy",
    config = function()
      local _99 = require("99")
      _99.setup({
        provider = _99.Providers.ClaudeCodeProvider,
        completion = {
          source = "blink",
        },
      })
    end,
  },
}
