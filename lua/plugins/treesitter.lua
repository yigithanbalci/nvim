return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        -- Go Tools
        "go",
        "gomod",
        "gowork",
        "gosum",
        -----------
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ocaml",
        "python",
        "query",
        "regex",
        -- Rust Tools
        "rust",
        "ron",
        -------------
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
}
