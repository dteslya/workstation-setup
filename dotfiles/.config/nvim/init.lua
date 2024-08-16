-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
})
-- local nvim_lsp = require("lspconfig")
-- require("lspconfig").jinja_lsp.setup({
--   default_config = {
--     cmd = { "/home/admins/dmitry.teslya/.cargo/bin/jinja-lsp" },
--     filetypes = { "jinja" },
--     root_dir = function(fname)
--       -- return "."
--       return nvim_lsp.util.find_git_ancestor(fname)
--     end,
--     settings = {
--       lang = "rust",
--     },
--   },
-- })
local nvim_lsp = require("lspconfig")
local configs = require("lspconfig.configs")
-- local configs
-- if not configs.jinja_lsp then
configs.jinja_lsp = {
  default_config = {
    cmd = { "/home/admins/dmitry.teslya/.cargo/bin/jinja-lsp" },
    filetypes = { "jinja" },
    root_dir = function(fname)
      -- return "."
      return nvim_lsp.util.find_git_ancestor(fname)
    end,
    settings = {
      templates = ".",
      backend = { "." },
      lang = "python",
    },
  },
}
-- end

configs.jinja_lsp.setup({})
