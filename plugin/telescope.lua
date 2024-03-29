local has_tl, tl = pcall(require, "telescope")
if not has_tl then return end

-- This will be removed when https://github.com/nvim-telescope/telescope-file-browser.nvim/pull/6 is fixed
local function fb_action(f) return function(b) require"telescope".extensions.file_browser.actions[f](b) end end

require"project_nvim".setup {
	update_cwd = true,
	update_focused_file = {enable = true, update_cwd = true, ignore_lsp = {"efm"}}
}

local themes = require "telescope.themes"
local action_layout = require("telescope.actions.layout")
tl.setup {
	defaults = themes.get_dropdown {
		winblend = 10,
		path_display = {"truncate"},
		mappings = {
			i = {["<esc>"] = "close", ["<c-space>"] = action_layout.toggle_preview}
		}
	},
	pickers = {
		lsp_code_actions = {theme = "cursor"},
		oldfiles = {previewer = false},
		buffers = {
			previewer = false,
			mappings = {i = {["<C-d>"] = "delete_buffer"}, n = {["<C-d>"] = "delete_buffer"}}
		}
	},
	extensions = {
		fzf = {fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case"},
		file_browser = {
			theme = "ivy",
			layout_config = {height = .5},
			mappings = {
				i = {["<C-v>"] = fb_action "move_file", ["<C-x>"] = fb_action "remove_file", ["<C-d>"] = "preview_scrolling_down"}
			}
		},
		packer = {theme = "ivy", previewer = false, layout_config = {height = .5, mirror = true, preview_width = .4}}
	}
}
tl.load_extension "fzf"
tl.load_extension "lsp_handlers"
tl.load_extension "file_browser"
tl.load_extension "projects"
tl.load_extension "packer"
