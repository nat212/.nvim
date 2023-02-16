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
			require("catppuccin").setup({
				flavor = "mocha",
				transparent_background = true,
				integrations = {
					notify = true,
					telescope = true,
					symbols_outline = true,
					treesitter = true,
					treesitter_context = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					dap = {
						enabled = true,
						enable_ui = true,
					},
					cmp = true,
					mason = true,
					gitsigns = true,
					fidget = true,
					dashboard = true,
					hop = true,
					lsp_trouble = true,
					navic = {
						enabled = true,
						custom_bg = "NONE",
					},
					neogit = true,
					barbar = true,
					barbecue = {
						dim_dirname = true,
					},
					mini = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
		requires = { "folke/lsp-colors.nvim" },
	})
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
			vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>", { silent = true, noremap = true })
		end,
	})
	use({
		"utilyre/barbecue.nvim",
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		after = "nvim-web-devicons", -- keep this if you're using NvChad
		config = function()
			require("barbecue").setup({
				theme = "catppuccin",
			})
		end,
	})
	-- use({
	--     "SmiteshP/nvim-navic",
	--     requires = "neovim/nvim-lspconfig",
	--     config = function()
	--       require("nvim-navic").setup({})
	--     end,
	-- })
	use({
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({})
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			local hop = require("hop")
			hop.setup({ keys = "etovxqpdygfblzhckisuran" })

			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "<leader>hf", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
			end, { remap = true })
			vim.keymap.set("", "<leader>hF", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
			end, { remap = true })
			vim.keymap.set("", "<leader>ht", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "<leader>hT", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
			end, { remap = true })
		end,
	})
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	})
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"feline-nvim/feline.nvim",
		config = function()
			local ctp_feline = require("catppuccin.groups.integrations.feline")
			ctp_feline.setup({})

			require("feline").setup({
				components = ctp_feline.get(),
			})

			local navic_exists, navic = pcall(require, "nvim-navic")
			if navic_exists then
				local winbar_components = {
					active = {},
					inactive = {},
				}
				table.insert(winbar_components.active, {})
				table.insert(winbar_components.active[1], {
					provider = function()
						return navic.get_location()
					end,
					enabled = function()
						return navic.is_available()
					end,
				})
				require("feline").winbar.setup({
					components = winbar_components,
				})
			end
		end,
		requires = { "kyazdani42/nvim-web-devicons", "catppuccin/nvim" },
	})
	-- use({
	--     "folke/noice.nvim",
	--     config = function()
	--       require("noice").setup({
	--           lsp = {
	--               -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	--               override = {
	--                   ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--                   ["vim.lsp.util.stylize_markdown"] = true,
	--                   ["cmp.entry.get_documentation"] = true,
	--               },
	--           },
	--           -- you can enable a preset for easier configuration
	--           presets = {
	--               bottom_search = true, -- use a classic bottom cmdline for search
	--               command_palette = true, -- position the cmdline and popupmenu together
	--               long_message_to_split = true, -- long messages will be sent to a split
	--               inc_rename = false, -- enables an input dialog for inc-rename.nvim
	--               lsp_doc_border = false, -- add a border to hover docs and signature help
	--           },
	--       })
	--     end,
	--     requires = {
	--         "MunifTanjim/nui.nvim",
	--         "rcarriga/nvim-notify",
	--     },
	-- })

	-- Packer
	-- use({
	-- 	"akinsho/bufferline.nvim",
	-- 	tag = "v3.*",
	-- 	config = function()
	-- 		require("natashz.tabs")
	-- 	end,
	-- })
	use({
		"romgrk/barbar.nvim",
		requires = "nvim-web-devicons",
		config = function()
			require("natashz.tabs").setup()
		end,
	})
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	})

	-- Git
	-- use({
	-- 	"tpope/vim-fugitive",
	-- 	"junegunn/gv.vim",
	-- })
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				popup = {
					kind = "vsplit",
				},
				commit_popup = {
					kind = "vsplit",
				},
			})
			vim.keymap.set("n", "<leader>gs", neogit.open)
			vim.keymap.set("n", "<leader>gc", function()
				require("neogit").open({ "commit" })
			end)
		end,
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
	-- use({
	-- 	"voldikss/vim-floaterm",
	-- 	config = function()
	-- 		require("natashz.floaterm")
	-- 	end,
	-- })

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
	})
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
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
	use({
		"nvim-treesitter/nvim-treesitter-context",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({})
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

	-- Mini
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			require("mini.align").setup()
			require("mini.comment").setup()
			-- require("mini.completion").setup({
			--     lsp_completion = {
			--         source_func = "omnifunc",
			--         auto_setup = false,
			--     },
			-- })
		end,
	})

	-- Project
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	})
	-- use({
	--     "echasnovski/mini.ai",
	--     config = function()
	--       require("mini.ai").setup()
	--     end,
	-- })
	-- use({
	--     "echasnovski/mini.align",
	--     config = function()
	--       require("mini.align").setup()
	--     end,
	-- })
	-- use("echasnovski/mini.comment")

	-- Wakatime
	use({ "wakatime/vim-wakatime" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
