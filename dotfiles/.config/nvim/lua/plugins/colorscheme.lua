return {
  { "Mofiqul/vscode.nvim" },
  -- {
  --   "rebelot/kanagawa.nvim", -- You can replace this with your favorite colorscheme
  --   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
  --   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
  --   opts = {
  --     -- Replace this with your scheme-specific settings or remove to use the defaults
  --     -- transparent = true,
  --     background = {
  --       -- light = "lotus",
  --       dark = "wave", -- "wave, dragon"
  --     },
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
      -- colorscheme = "kanagawa",
    },
  },
}
