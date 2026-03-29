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

--- Resolve nvm default node bin directory, ignoring any `nvm use` override.
--- The JS analyzer in sonarlint-language-server spawns node as a subprocess
--- and requires an LTS version (18/20/22). This ensures the server always
--- finds a compatible node regardless of the shell's active nvm version.
local function get_nvm_default_node_bin()
  local nvm_dir = vim.env.NVM_DIR or (vim.env.HOME .. "/.nvm")
  local ok, lines = pcall(vim.fn.readfile, nvm_dir .. "/alias/default")
  if ok and #lines > 0 then
    local major = lines[1]:match("^(%d+)")
    if major then
      local matches = vim.fn.glob(nvm_dir .. "/versions/node/v" .. major .. ".*/bin", true, true)
      if #matches > 0 then
        return matches[#matches]
      end
    end
  end
  return nil
end

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

      -- Override PATH for the server process so the JS analyzer always finds an LTS node
      local cmd_env = nil
      local node_bin = get_nvm_default_node_bin()
      if node_bin then
        cmd_env = { PATH = node_bin .. ":" .. vim.env.PATH }
      end

      require("sonarlint").setup({
        server = {
          cmd = cmd,
          cmd_env = cmd_env,
        },
        filetypes = filetypes,
        settings = {
          sonarlint = {},
        },
      })
    end,
  },
}