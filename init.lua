vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


-- One line configs
require'configs.settings'
require('configs.lualine-config')
require('plugins.plugins')
require'startup'.setup({ theme = 'dashboard'})
require('overseer').setup()
require('Comment').setup()
require'colorizer'.setup()
require('nvim-tree').setup()


-- Deactivate normal diagnostic
-- Only enable lsp_lines
require('lsp_lines').setup()
vim.diagnostic.config({virtual_text = false})


-- Set tab plugin
vim.opt.termguicolors = true
require('bufferline').setup{
	options = {
		indicator = {
			icon = '▎',
			style = 'icon'
		},
		separator_style = 'thick',
	}
}

require('overseer').setup({
	templates = { 'builtin', 'user.cpp_build' },
})


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or 'all'
  ensure_installed = { 'c', 'lua', 'rust', 'python', 'html', 'css', 'javascript', 'cpp', 'markdown', 'bash' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for 'all')
  ignore_install = { 'javascript' },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = '/some/path/to/store/parsers', -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}



-- LSP configs
local lsp = require 'lspconfig'
local coq = require 'coq'

-- Python
lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities())

-- C/C++/Objective C
lsp.clangd.setup(coq.lsp_ensure_capabilities())

-- Rust
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())

-- Bash
lsp.bashls.setup(coq.lsp_ensure_capabilities())


-- Configuring COQ to work with nvim-autopairs
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

