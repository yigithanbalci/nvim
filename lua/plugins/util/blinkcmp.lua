return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local f = ls.function_node

      -- get Git username
      local function git_username()
        local handle = io.popen("git config user.name")
        if handle then
          local result = handle:read("*a")
          handle:close()
          return result:gsub("\n", "")
        end
        return "unknown"
      end

      -- get current date
      local function current_date()
        return os.date("%Y-%m-%d")
      end

      -- get line comment string for current filetype
      local function line_comment()
        local commentstring = vim.bo.commentstring
        if commentstring == "" then
          return "// " -- fallback
        end
        return commentstring:gsub("%%s", "")
      end

      ls.add_snippets("all", {
        s("todo", {
          f(line_comment, {}), -- dynamic comment prefix
          t("TODO "),
          f(git_username, {}),
          t(" "),
          f(current_date, {}),
          t(": "),
        }),
        s("note", {
          f(line_comment, {}),
          t("NOTE "),
          f(git_username, {}),
          t(" "),
          f(current_date, {}),
          t(": "),
        }),
      })

      return opts
    end,
  },
}
