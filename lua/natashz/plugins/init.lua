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
    autocmd BufWritePost plugins.lua source <afile>
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
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("natashz.plugins.configs.trouble").setup()
		end,
	})
	use({
		"utilyre/barbecue.nvim",
		branch = "fix/E36",
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
		"stevearc/dressing.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("natashz.plugins.configs.dressing").setup()
		end,
	})

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
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("natashz.plugins.configs.hop").setup()
		end,
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("natashz.plugins.configs.fidget").setup()
		end,
	})
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"feline-nvim/feline.nvim",
		config = function()
			require("natashz.plugins.configs.feline").setup()
		end,
		requires = { "kyazdani42/nvim-web-devicons", "catppuccin" },
	})

	use({
		"romgrk/barbar.nvim",
		requires = "nvim-web-devicons",
		config = function()
			require("natashz.plugins.configs.barbar").setup()
		end,
	})
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("natashz.plugins.configs.notify").setup()
		end,
	})

	-- Git
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
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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

	-- Movement/Utilities
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({ "tpope/vim-surround" })

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("natashz.plugins.configs.toggleterm").setup()
		end,
	})

	-- LSP Stuff
	use("mfussenegger/nvim-jdtls")
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
		requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"folke/neodev.nvim",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("natashz.neodev").setup()
			require("natashz.lsp")
		end,
	})

	use({
		"doxnit/cmp-luasnip-choice",
		config = function()
			require("cmp_luasnip_choice").setup({
				auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
			})
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
			require("natashz.neodev").setup()
			require("natashz.lsp")
		end,
	})
	use("rafamadriz/friendly-snippets")

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("natashz.plugins.configs.symbols-outline").setup()
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

	-- DAP
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
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup({
				dap_configurations = {
					{
						type = "go",
						name = "Pocketbase Serve",
						request = "launch",
						program = "${fileDirname}",
						args = { "serve" },
					},
				},
			})
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

	-- Null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("natashz.plugins.configs.null-ls").setup()
		end,
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("natashz.plugins.configs.autopairs").setup()
		end,
	})

	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("natashz.plugins.configs.nvim-ts-autotag").setup()
		end,
		ft = { "html", "typescriptreact", "javascriptreact", "vue", "svelte", "xml" },
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

	if packer_bootstrap then
		require("packer").sync()
	end
end)
