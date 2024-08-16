return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "black" },
      ["puppet"] = { "puppet-lint" },
      ["yaml"] = { "yamllint" },
    },
  },
}
