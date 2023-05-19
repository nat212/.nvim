local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins/init.lua source <afile>
  augroup end
]])

vim.cmd([[
augroup packer_notify
  autocmd!
  autocmd User PackerComplete lua vim.notify("Packer install complete", "Packer")
  autocmd User PackerCompileDone lua vim.notify("Packer compilation complete", "Packer")
augroup end
]])

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- ~ Aesthetics ~
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("natashz.plugins.configs.catppuccin").setup()
    end,
    requires = { "folke/lsp-colors.nvim" },
  })

  use({
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("natashz.plugins.configs.rose-pine").setup()
    end,
  })

  use({
    "stevearc/dressing.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("natashz.plugins.configs.dressing").setup()
    end,
  })

  use({ "kyazdani42/nvim-web-devicons" })

  use({
    "rcarriga/nvim-notify",
    config = function()
      require("natashz.plugins.configs.notify").setup()
    end,
  })

  -- Status/Winbar
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    after = "nvim-web-devicons",
    config = function()
      require("natashz.plugins.configs.barbecue").setup()
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    config = function()
      require("natashz.plugins.configs.feline").setup()
    end,
    requires = { "kyazdani42/nvim-web-devicons", "catppuccin" },
  })

  -- Navigation
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("natashz.plugins.configs.neotree").setup()
    end,
  })

  use({
    "romgrk/barbar.nvim",
    requires = "nvim-web-devicons",
    config = function()
      require("natashz.plugins.configs.barbar").setup()
    end,
  })

  -- Language Utils
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("natashz.plugins.configs.trouble").setup()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("natashz.plugins.configs.toggleterm").setup()
    end,
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("natashz.plugins.configs.fidget").setup()
    end,
  })

  use({
    "stevearc/overseer.nvim",
    requires = {
      "mfussenegger/nvim-dap",
      "akinsho/toggleterm.nvim",
    },
    config = function()
      require("natashz.plugins.configs.overseer").setup()
    end,
  })

  -- VCS
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("natashz.plugins.configs.gitsigns").setup()
    end,
  })

  use({
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("natashz.plugins.configs.neogit").setup()
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "FeiyouG/command_center.nvim",
      "LinArcX/telescope-changes.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "AckslD/nvim-neoclip.lua",
    },
    config = function()
      require("natashz.plugins.configs.telescope").setup()
    end,
  })

  use({
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("natashz.plugins.configs.neoclip").setup()
    end,
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("natashz.plugins.configs.todo-comments").setup()
    end,
  })

  -- Movement/Editing
  use({ "mg979/vim-visual-multi", branch = "master" })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-sleuth" })
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("natashz.plugins.configs.autopairs").setup()
    end,
  })

  use({
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("natashz.plugins.configs.hop").setup()
    end,
  })
  use({ "andymass/vim-matchup" })

  -- LSP Stuff
  use({
    "mfussenegger/nvim-jdtls",
    config = function()
      require("natashz.plugins.configs.jdtls").setup()
    end,
    ft = "java",
  })

  use({
    "akinsho/flutter-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
    config = function()
      require("natashz.plugins.configs.flutter-tools").setup()
    end,
  })

  use({
    "williamboman/mason.nvim",
    config = function()
      require("natashz.plugins.configs.mason").setup()
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("natashz.plugins.configs.mason-lspconfig").setup()
    end,
    after = "nvim-lspconfig",
    requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  })

  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("natashz.plugins.configs.lspconfig").setup()
    end,
    after = "mason.nvim",
  })

  use({
    "folke/neodev.nvim",
    config = function()
      require("natashz.plugins.configs.neodev").setup()
    end,
    after = "nvim-lspconfig",
  })

  use({
    "doxnit/cmp-luasnip-choice",
    config = function()
      require("natashz.plugins.configs.cmp-luasnip-choice").setup()
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("natashz.plugins.configs.luasnip").setup()
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "neovim/nvim-lspconfig",
      "L3MON4D3/LuaSnip",
      "folke/neodev.nvim",
    },
    config = function()
      require("natashz.plugins.configs.cmp").setup()
    end,
  })

  use("rafamadriz/friendly-snippets")

  use({
    "simrat39/symbols-outline.nvim",
    config = function()
      require("natashz.plugins.configs.symbols-outline").setup()
    end,
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("natashz.plugins.configs.null-ls").setup()
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("natashz.plugins.configs.treesitter").setup()
    end,
  })

  use({
    "nvim-treesitter/nvim-treesitter-context",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("natashz.plugins.configs.treesitter-context").setup()
    end,
  })

  use({
    "windwp/nvim-ts-autotag",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("natashz.plugins.configs.nvim-ts-autotag").setup()
    end,
    after = "nvim-treesitter",
    ft = { "html", "typescriptreact", "javascriptreact", "vue", "svelte", "xml" },
  })

  -- Debugging
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("natashz.plugins.configs.dap-ui").setup()
    end,
  })

  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("natashz.plugins.configs.dap").setup()
    end,
  })

  use({
    "theHamsta/nvim-dap-virtual-text",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("natashz.plugins.configs.dap-virtual-text").setup()
    end,
  })

  use({
    "leoluz/nvim-dap-go",
    config = function()
      require("natashz.plugins.configs.dap-go").setup()
    end,
  })

  -- Other language stuff
  use({ "rust-lang/rust.vim" })
  use({ "editorconfig/editorconfig-vim" })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    ft = { "markdown" },
  })

  -- Mini
  use({
    "echasnovski/mini.nvim",
    config = function()
      require("natashz.plugins.configs.mini").setup()
    end,
  })

  -- Wakatime
  use({ "wakatime/vim-wakatime" })

  -- Devcontainers
  use({
    "esensar/nvim-dev-container",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("natashz.plugins.configs.nvim-dev-container").setup()
    end,
  })

  -- Testing
  use({
    "nvim-neotest/neotest",
    requires = {
      -- Dependencies
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",

      -- Test adapters
      "sidlatau/neotest-dart",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      require("natashz.plugins.configs.neotest").setup()
    end,
  })

  use({
    "antoinemadec/FixCursorHold.nvim",
    config = function()
      vim.g.cursorhold_updatetime = 50
    end,
  })

  if packer_bootstrap then
    require("packer").sync()
  end
end)
