" vim-plug

    " Install vim-plug if not available (https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation)
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " https://github.com/junegunn/vim-plug
    "
    " Plugin Begin
    call plug#begin('~/.vim/plugged')

    " Search
    Plug 'rking/ag.vim'               " Silver Searcher
    Plug 'kien/ctrlp.vim'
    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    " Edit
    Plug 'terryma/vim-multiple-cursors'  " Edit multiple lines in one go
    Plug 'tpope/vim-surround'            " Add, delete or change surrounding parentheses in pairs
    Plug 'jiangmiao/auto-pairs'          " Add parentheses automatically
    Plug 'roryokane/detectindent'        " enables :DetectIndent
    Plug 'preservim/nerdcommenter'

    " UI & Windows
    Plug 'vim-airline/vim-airline'
    Plug 'scrooloose/nerdtree'
    " Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'flazz/vim-colorschemes'

    " Language specific
    Plug 'pangloss/vim-javascript'
    Plug 'hashivim/vim-terraform'
    Plug 'leafgarland/typescript-vim'
    Plug 'mxw/vim-jsx'
    Plug 'prettier/vim-prettier' " format using :Prettier
    Plug 'hail2u/vim-css3-syntax'
    Plug 'heavenshell/vim-jsdoc'
    Plug 'posva/vim-vue'

    "Autocompletion & Syntax
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Git
    " Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    call plug#end()
    " Plugin End


" General
    set timeoutlen=1000 ttimeoutlen=0 " Eliminate the delays on ESC
    set number                        " Show line number

    set laststatus=2
    set t_Co=256

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Use bash as shell (without this one it uses fish and fugitive is crazy slow)
    set shell=/bin/bash


" Text Formatting
    set autoindent
    set tabstop=4     " The width of a TAB is 4, but it's still \t
    set softtabstop=4 " Set the number of columns for a TAB
    set shiftwidth=4  " Indents will have a width of 4
    set shiftround
    set expandtab     " On pressing TAB, insert 4 spaces
    set smarttab
    set nowrap
    set listchars=tab:>-,trail:-
    set list

" allow backspacing over everything in insert mode
    set backspace=indent,eol,start

" NERDTree configuration
    " `wincmd p` will move the focus on the main window, not on nerdtree
    " !=# means case-sensitive
    autocmd VimEnter * if &filetype !=# 'pullrequest' && &filetype != 'gitcommit' | NERDTree | wincmd p | endif
    let NERDTreeIgnore=['\.git$', '\.DS_Store']

" NERDCommenter
    let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default

" CtrlP
    let g:NERDTreeChDirMode       = 2
    let g:ctrlp_working_path_mode = 'rw'
    let g:ctrlp_custom_ignore     = {
        \ 'dir':  '\v[\/](\.git|node_modules|\.sass-cache|bower_components|build|_site)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }

" The Silver Searcher
    if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor
        " Use ag in CtrlP for listing files. Lightning fast and
        " respects .gitignore
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

        " ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    endif

    let g:ackprg = 'ag --nogroup --nocolor --column'

" FZF
let g:fzf_command_prefix = 'Fzf'
" command! -bang -nargs=* Agg
  " \ call fzf#vim#ag(<q-args>,
  " \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  " \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  " \                 <bang>0)


if exists('LIVE_CODING')
    " 'LIVE_CODING' passed from ~/.config/fish/config.fish 'vimlight' alias
    " 'vimlight' is an alias for: vim --cmd 'let LIVE_CODING=1'
    set background=light
    " colorscheme pencil
    colorscheme PaperColor
    " let s:dark_blue = { "gui": "#008EC4", "cterm": "4"   }
    " call s:h("Function",    {"fg": s:dark_blue})
    hi! link Function Identifier

    autocmd VimEnter * GitGutterDisable " disable git icons
    autocmd VimEnter * ALEDisable       " disable syntax check
    autocmd VimEnter * NERDTreeClose    " close NERDTree
    autocmd VimEnter * set laststatus=0 " remove Vim Airplane
else
    " Colours
    set background=dark
    colorscheme OceanicNext

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes
endif

" Cursor Line
    set cursorline
    hi CursorLine gui=none
    hi CursorLine cterm=none

" vim-jsx
    let g:jsx_ext_required = 0 " no mandatory .jsx for files

" Enabling CSS autocomplete on .scss .css file
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType scss set omnifunc=csscomplete#CompleteCSS

" View navigation
    "Resize vertical view splits with + & -
    nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
    " Resize horizontal view splits with
    " commented out since they conflicts with [c ]c in diff
    " nnoremap <silent> ] :vertical resize +10<CR>
    " nnoremap <silent> [ :vertical resize -10<CR>

    "Cycle to views with double tab
    nnoremap <silent> <Tab><Tab> <C-w>w

    "Navigating through windows
    nnoremap <silent> <Tab><Up> :wincmd k<CR>
    nnoremap <silent> <Tab><Down> :wincmd j<CR>
    nnoremap <silent> <Tab><Left> :wincmd h<CR>
    nnoremap <silent> <Tab><Right> :wincmd l<CR>
    nnoremap <silent> <Tab>k :wincmd k<CR>
    nnoremap <silent> <Tab>j :wincmd j<CR>
    nnoremap <silent> <Tab>h :wincmd h<CR>
    nnoremap <silent> <Tab>l :wincmd l<CR>

" Vim + Ctags Ctrlp
    nnoremap <leader>. :CtrlPTag<cr>

" CSS3 Syntax
    augroup VimCSS3Syntax
        autocmd!

        autocmd FileType css setlocal iskeyword+=-
    augroup END

" Remove the window with function definition
    set completeopt=menu

" TypeSCript
    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    autocmd BufEnter *.tsx set filetype=typescript
    autocmd BufEnter *.tsx set filetype=javascript.jsx

" Tries to fixes bash completition
    set isfname-==

" Remove Trailing spaces on save
    autocmd BufWritePre <buffer> %s/\s\+$//e

" Vim Airline
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#formatter = 'unique_tail'

" COC, Conquer of Completition
    let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint', 'coc-git', 'coc-vetur']
    " let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
    " let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
    endfunction

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " remove airline integration
    let g:airline#extensions#coc#enabled = 0

    " This set of things fixes coc-definiti froze
    set hidden
    set nobackup
    set nowritebackup
    set shortmess+=c
