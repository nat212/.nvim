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

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- ~ Aesthetics ~
	-- use({ "dracula/vim", as = "dracula", config = "vim.cmd[[colo dracula]]" })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = "vim.cmd[[colo catppuccin-mocha]]",
		requires = { "folke/lsp-colors.nvim" },
	})
	-- use({ "gruvbox-community/gruvbox" })
	use({ "kyazdani42/nvim-web-devicons" })
	-- use({
	-- 	"nvim-lualine/lualine.nvim",
	-- 	config = function()
	-- 		require("natashz.statusline")
	-- 	end,
	-- 	requires = { "kyazdani42/nvim-web-devicons" },
	-- })
	use({
		"feline-nvim/feline.nvim",
		config = function()
			local ctp_feline = require("catppuccin.groups.integrations.feline")
			ctp_feline.setup({})

			require("feline").setup({
				components = ctp_feline.get(),
			})
		end,
		requires = { "kyazdani42/nvim-web-devicons", "catppuccin/nvim" },
	})
	use({
		"stevearc/dressing.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("dressing").setup({
				select = {
					enabled = true,
					telescope = require("telescope.themes").get_cursor(),
					builtin = {
						relative = "cursor",
						start_in_insert = true,
						windblend = 40,
					},
				},
			})
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		config = function()
			require("natashz.tabs")
		end,
	})
	use({
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				background_color = "#000000",
			})
			vim.notify = notify
		end,
	})

	-- Git
	use({
		"tpope/vim-fugitive",
		"junegunn/gv.vim",
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
			requires = { "nvim-lua/plenary.nvim" },
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"FeiyouG/command_center.nvim",
			"LinArcX/telescope-changes.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("natashz.telescope")
		end,
	})

	use({
		"AckslD/nvim-neoclip.lua",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})

	-- Movement/Utilities
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-commentary" })
	use({
		"voldikss/vim-floaterm",
		config = function()
			require("natashz.floaterm")
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("natashz.toggleterm").setup()
		end,
	})

	-- LSP Stuff
	use("mfussenegger/nvim-jdtls")
	use({
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("natashz.flutter").setup()
		end,
	})
	use({
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({})
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({})
			end,
		},
		"neovim/nvim-lspconfig",
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
	use("sbdchd/neoformat")
	use("rafamadriz/friendly-snippets")
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				highlight_hovered_item = true,
				show_guides = true,
				auto_close = true,
			})
		end,
	})
	-- use({
	-- 	"glepnir/lspsaga.nvim",
	-- 	config = function()
	-- 		require("lspsaga").setup({
	-- 			lightbulb = { enable = false },
	-- 		})
	-- 	end,
	-- })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.install").prefer_git = false
			require("nvim-treesitter.install").compilers = { "clang" }
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
			})
		end,
	})

	-- DAP
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("natashz.dap").setup()
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

	-- Null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("natashz.linting").setup()
		end,
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		ft = { "html", "typescriptreact", "javascriptreact", "vue", "svelte" },
	})

	-- Wakatime
	use({ "wakatime/vim-wakatime" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
