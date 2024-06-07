-- Ensure packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdcommenter'
  use 'gregsexton/MatchTagAlways'
  use 'Yggdroot/indentLine'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- -- Set termguicolors
-- if vim.fn.has("termguicolors") == 1 then
--   vim.opt.termguicolors = true
-- end

-- Highlighting
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

-- Python3 host program
vim.g.python3_host_prog = vim.fn.expand('/usr/bin/python')

-- UI Colors
vim.cmd [[
  hi clear SignColumn
  hi CocErrorFloat ctermfg=0
  hi CocWarningFloat ctermfg=0
  hi CocInfoFloat ctermfg=0
  hi CocErrorVirtualText ctermfg=3
  hi CocWarningVirtualText ctermfg=3
  hi CocInfoVirtualText ctermfg=3
  hi Comment ctermfg=1
]]

-- Leader key
vim.g.mapleader = ','

-- Bad habit fixer
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Left>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Right>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Up>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Down>', '<Nop>', { noremap = true })

-- CoC keybindings
vim.cmd [[
  inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col or getline('.')[col - 1] =~# '\s'
  endfunction
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif
  nmap <leader>h :call CocAction("doHover", ["preview"])<CR>
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references-used)
]]

-- Open terminal on ctrl+n
vim.cmd [[
  function! OpenTerminal()
    vsplit term://zsh
    vertical resize 80
  endfunction
  nnoremap <c-n> :call OpenTerminal()<CR>
]]

-- Find next & replace shortcut
vim.api.nvim_set_keymap('n', '<space><space>', 'cgn', { noremap = true })

-- Clipboard configuration
vim.cmd [[
  set clipboard+=unnamedplus
  nnoremap X "_X
  nnoremap C "_C
  nnoremap S "_S
  nnoremap x "_x
  nnoremap c "_c
  vnoremap c "_c
  vnoremap s "_s
]]

-- Don't conceal JSON quotes
vim.cmd [[
  autocmd FileType json let g:indentLine_setConceal = 0 | let g:vim_json_syntax_conceal = 0
]]

-- Enable mouse
vim.cmd [[
  set mouse=a
]]

-- Bypass enter prompts
vim.cmd [[
  set shortmess+=c
]]

-- Gutter configuration
vim.cmd [[
  set number relativenumber
  set numberwidth=3
  set signcolumn=yes:1
]]

-- Timeouts
vim.cmd [[
  set ttimeout
  set ttimeoutlen=100
  set updatetime=300
]]

-- Matching braces
vim.cmd [[
  set showmatch
]]

-- Ignore save reminders
vim.cmd [[
  set hidden
]]

-- Indentation settings
vim.cmd [[
  set expandtab
  set shiftwidth=4
  set softtabstop=4
]]

-- Fuzzy file management
vim.cmd [[
  set display=truncate
  set path+=**
  set conceallevel=0
]]

-- Syntax highlighting
vim.cmd [[
  syntax on
  filetype plugin indent on
]]

-- Auto pairs multiline close
vim.g.AutoPairsMultilineClose = 0

-- Fold settings
vim.cmd [[
  set foldmethod=manual
  set foldnestmax=5
  augroup foldstuff
    autocmd!
    autocmd BufEnter * setlocal foldmethod=indent
    autocmd BufEnter * normal zR
    autocmd BufEnter * setlocal foldmethod=manual
  augroup END
]]

-- Toggle folds with leader+f
vim.cmd [[
  inoremap <leader>f <C-O>za
  nnoremap <leader>f za
  onoremap <leader>f <C-C>za
  vnoremap <leader>f zf
]]

-- Clear search highlighting
vim.api.nvim_set_keymap('n', '<C-L>', ':nohl<CR>:<backspace>', { noremap = true })

-- Incremental search
if vim.fn.has('reltime') == 1 then
  vim.cmd [[ set incsearch ]]
end

-- Do not recognize octal numbers for Ctrl-A and Ctrl-X
vim.cmd [[ set nrformats-=octal ]]

-- Disable Ex mode
vim.cmd [[ map Q gq ]]

-- Break undo for Ctrl-U in insert mode
vim.cmd [[ inoremap <C-U> <C-G>u<C-U> ]]

-- Prettier configuration
-- vim.cmd [[ nnoremap <leader>P :CocCommand prettier.formatFile ]]

-- VimTex configuration
vim.cmd [[
  let g:tex_flavor='latex'
  let g:vimtex_compiler_method = 'latexmk'
  let g:vimtex_view_method = 'zathura'
  let g:vimtex_compiler_latexmk_engines = {
    \ '_': '-xelatex',
    \ 'pdflatex': '-pdf',
    \ 'dvipdfex': '-pdfdvi',
    \ 'lualatex': '-lualatex',
    \ 'xelatex': '-xelatex',
    \ 'context (pdftex)': '-pdf -pdflatex=texexec',
    \ 'context (luatex)': '-pdf -pdflatex=context',
    \ 'context (xetex)': '-pdf -pdflatex=''texexec --xtx''',
    \}
  autocmd FileType tex VimtexCompile
]]

-- Instant markdown configuration
vim.cmd [[
  filetype plugin on
  " Uncomment to override defaults:
  " let g:instant_markdown_slow = 1
  " let g:instant_markdown_autostart = 0
  " let g:instant_markdown_open_to_the_world = 1
  " let g:instant_markdown_allow_unsafe_content = 1
  " let g:instant_markdown_allow_external_content = 0
  " let g:instant_markdown_mathjax = 1
  " let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
  " let g:instant_markdown_autoscroll = 0
  " let g:instant_markdown_port = 8888
  " let g:instant_markdown_python = 1
]]
