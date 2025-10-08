if not vim.g.my_config.langs.ocaml.enabled then
  return {}
end
--TODO yigithanbalci 08-10-2025: Investigate that the below configs are needed or not
--for now it seems they are not included in lazyvim
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
