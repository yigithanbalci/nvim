if not _G.yeet.plugins.extras.sonarlint.enabled then
  return {}
end

-- Map config lang keys to sonarlint analyzer jars and filetypes.
-- Only languages with a SonarLint analyzer are included.
local lang_map = {
  typescript = {
    analyzer = "sonarjs.jar",
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
  clangd = {
    analyzer = "sonarcfamily.jar",
    filetypes = { "c", "cpp" },
  },
  java = {
    analyzer = "sonarjava.jar",
    filetypes = { "java" },
  },
  python = {
    analyzer = "sonarpython.jar",
    filetypes = { "python" },
  },
  go = {
    analyzer = "sonargo.jar",
    filetypes = { "go" },
  },
}

local function build_sonarlint_config()
  local analyzers = {}
  local filetypes = {}
  local seen = {}
  local langs = _G.yeet.plugins.langs

  for key, mapping in pairs(lang_map) do
    if langs[key] and langs[key].enabled then
      local jar = vim.fn.expand("$MASON/share/sonarlint-analyzers/" .. mapping.analyzer)
      if not seen[mapping.analyzer] and vim.fn.filereadable(jar) == 1 then
        seen[mapping.analyzer] = true
        table.insert(analyzers, jar)
      end
      for _, ft in ipairs(mapping.filetypes) do
        table.insert(filetypes, ft)
      end
    end
  end

  local cmd = { "sonarlint-language-server", "-stdio", "-analyzers" }
  for _, a in ipairs(analyzers) do
    table.insert(cmd, a)
  end

  return cmd, filetypes
end

-- Build filetypes eagerly for lazy.nvim ft trigger (safe — no $MASON needed)
local ft = {}
local langs = _G.yeet.plugins.langs
for key, mapping in pairs(lang_map) do
  if langs[key] and langs[key].enabled then
    for _, f in ipairs(mapping.filetypes) do
      table.insert(ft, f)
    end
  end
end

return {
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "sonarlint-language-server",
      },
    },
  },
  {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = ft,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local cmd, filetypes = build_sonarlint_config()
      require("sonarlint").setup({
        server = {
          cmd = cmd,
        },
        filetypes = filetypes,
        settings = {
          sonarlint = {},
        },
      })
    end,
  },
}