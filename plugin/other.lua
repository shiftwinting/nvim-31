if not pcall(require, "mkdir") then return end

-- Configuration for other small plugins
vim.g.fugitive_legacy_commands = false
require"Comment".setup {ignore = "^$"}
require"surround".setup {mappings_style = "sandwich"}
require"gitsigns".setup {keymaps = {}}
require"colorizer".setup({}, {mode = "foreground"})
require"nvim-autopairs".setup {}
require"hop".setup {jump_on_sole_occurrence = true}
require"indent_blankline".setup {
	filetype_exclude = {"help", "man", "packer"},
	buftype_exclude = {"terminal"},
	bufname_exclude = {"Untitled"},
	show_trailing_blankline_indent = false,
	show_end_of_line = true,
	use_treesitter = true,
	show_first_indent_level = false
}
