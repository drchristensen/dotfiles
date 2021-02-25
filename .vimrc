" Install vim-plug if not already present
" See: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" vim plug-ins
call plug#begin('~/.vim/plugged')

<<<<<<< HEAD
" Customized status line plugin
" See: https://vimawesome.com/plugin/vim-crystalline
Plug 'rbong/vim-crystalline'

" Git integration plugin
" See: https://vimawesome.com/plugin/fugitive-vim
Plug 'tpope/vim-fugitive'

" Per project editor configuration settings
" See: https://vimawesome.com/plugin/editorconfig-vim
Plug 'editorconfig/editorconfig-vim'
=======
" Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-fugitive'
" Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
" Plug 'editorconfig/editorconfig-vim'
>>>>>>> b303053f35566f00499c59f78fa2b97dd8a937b9

" File tree browser
" Use :NERDTree to open file browser window
" See: https://vimawesome.com/plugin/nerdtree-red
Plug 'scrooloose/nerdtree'

" Syntastic sytax checker
" Removed due to complexity of identifying project include files
" See: https://vimawesome.com/plugin/syntastic
"Plug 'scrooloose/syntastic'

" Lucius color scheme
" Removed, deferring to crystalline color scheme
" See: https://vimawesome.com/plugin/lucius
"Plug 'jonathanfilip/vim-lucius'

" Visual indent level plugin
" Removed due to error at startup regarding 'Normal' highlight setting
" https://github.com/nathanaelkane/vim-indent-guides/issues/131
" See: https://vimawesome.com/plugin/indent-guides
"Plug 'nathanaelkane/vim-indent-guides'

call plug#end()



function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

" vim crystalline settings
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'molokai'

" vim behavior changes
set showtabline=2
set guioptions-=e
set laststatus=2
set incsearch     " do incremental searching
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set autowrite     " Automatically :write before running commands
set pastetoggle=<F10>	" Use F10 to toggle between :paste and :nopaste
"set mouse=a       " Enable mouse in all modes
set ttymouse=xterm2

<<<<<<< HEAD
=======
" Color adjustments
syntax enable
set t_Co=256
set background=dark
colorscheme lucius

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

 " When editing a file, always jump to the last known cursor position.
 " Don't do it for commit messages, when the position is invalid, or when
 " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

 " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile .j2 set filetype=jinja2
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Linux kernel defaults
set tabstop=8
set softtabstop=8
set noexpandtab
set shiftwidth=8
set cindent
set colorcolumn=100
autocmd BufWritePre * %s/\s\+$//e	" Clears spaces at the end of a line

" Expand tab to 2 spaces
"set tabstop=2
"set softtabstop=2
"set noexpandtab
"set shiftwidth=2
"set smarttab

" Display extra whitespace and tabs as characters, but not by default
set list
set listchars=tab:\|\ ,trail:·,nbsp:·,eol:$

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=5

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

nnoremap <C-n> <c-w><
nnoremap <C-m> <c-w>>
>>>>>>> b303053f35566f00499c59f78fa2b97dd8a937b9

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" Simpler buffer switching
nnoremap <F5> :buffers<CR>:buffer<Space>

<<<<<<< HEAD

" Map NERDTree viewport to CTRL+t
nnoremap <C-t> :NERDTreeToggle<CR>
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"
" Syntastic configuration
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" Configure syntastic syntax checking to check on open as well as save
" Removed due to complexity of identifying project include files
" let g:syntastic_c_checkers = ['gcc']
" let g:syntastic_c_compiler = 'gcc'
"let g:syntastic_error_symbol = "✗"
"let g:syntastic_warning_symbol = '💩'
"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn

" Auto-enable IndentGuide on vim startup
" https://github.com/nathanaelkane/vim-indent-guides/issues/131
"let g:indent_guides_enable_on_vim_startup = 1

" Colarized color scheme setup
"syntax enable
"set background=dark
"colorscheme solarized
=======
" Always use vertical diffs
set diffopt+=vertical

" Set the statusline
set statusline=%f         " Path to the file
set statusline+=%y        " Filetype of the file
set statusline+=%=        " Switch to the right side
set statusline+=Row:\ %-4l " Display current line
set statusline+=Col:\ %-4c " Dispay current column
set statusline+=%{fugitive#statusline()} " Git status

" map nerdtree viewport to CTRL+n
" map <C-t> :NERDTreeToggle<CR>

" Options for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = '💩'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
>>>>>>> b303053f35566f00499c59f78fa2b97dd8a937b9
