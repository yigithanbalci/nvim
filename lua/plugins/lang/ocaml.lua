if not vim.g.my_config.langs.ocaml.enabled then
  return {}
end
return {
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "ocamlearlybird",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ocaml = { "ocamlformat " },
      },
    },
  },
}
