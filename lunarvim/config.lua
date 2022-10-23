local os_platform = vim.loop.os_uname().sysname

-- General
lvim.log.level = "warn"
lvim.use_icons = true
lvim.colorscheme = "tokyonight"

-- Keymappings
lvim.leader = "space"

-- Plugin configuration
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "c_sharp",
  "cmake",
  "comment",
  "cpp",
  "css",
  "dockerfile",
  "fish",
  "go",
  "gomod",
  "html",
  "json",
  "json5",
  "jsonc",
  "llvm",
  "make",
  "regex",
  "rust",
  "scss",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "yaml"
}
lvim.builtin.treesitter.highlight.enable = true

-- LSP Settings
lvim.lsp.installer.automatic_servers_installation = true

-- Formatters setup
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "black",
    filetypes = { "python" }
  },
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact" },
  },
}
lvim.format_on_save = true

-- Additional plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "folke/tokyonight.nvim" },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".on_attach()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline"
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require "colorizer".setup(
        {
          "css";
          "javascript";
          "typescript";
          "typescriptreact";
          "html";
          "scss";
        },
        {
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
        }
      )
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufWinEnter",
    config = function()
      require "illuminate".on_attach()
    end,
  },
}

-- GUI configuration
vim.cmd("let g:neovide_cursor_vfx_mode = \"railgun\"")

if os_platform == "Linux" then
  vim.cmd("set guifont=FiraCode\\ NF:h7.5")
elseif os_platform == "Darwin" then
  vim.cmd("set guifont=FiraCode\\ Nerd\\ Font\\ Mono:h12")
end
