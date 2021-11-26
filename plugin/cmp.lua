local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then return end

local snip = require "luasnip"
local kind = require "lspkind"

cmp.setup {
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.close(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Insert, select = false}
	},
	sources = {
		{name = "nvim_lsp"},
		{name = "nvim_lua"},
		{name = "luasnip"},
		{name = "buffer", keyword_lenght = 5},
		{name = "path"},
		{name = "calc"},
		{name = "spell"}
	},
	formatting = {
		format = kind.cmp_format {
			with_text = true,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				buffer = "[buf]",
				path = "[path]",
				luasnip = "[snip]",
				calc = "[calc]",
				spell = "[spell]"
			}
		}
	},
	snippet = {expand = function(args) snip.lsp_expand(args.body) end},
	experimental = {ghost_text = true}
}

require"lsp_signature".setup {
	bind = true,
	doc_lines = 10,
	floating_window = true,
	fix_pos = true,
	hint_enable = false,
	handler_opts = {border = "none"}
}

vim.cmd [[
imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
]]
