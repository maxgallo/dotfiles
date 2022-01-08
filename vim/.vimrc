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
    " Plug 'rking/ag.vim'               " Silver Searcher
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
    Plug 'prettier/vim-prettier' " format using :Prettier
    Plug 'hail2u/vim-css3-syntax'
    Plug 'heavenshell/vim-jsdoc'
    Plug 'posva/vim-vue'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'GutenYe/json5.vim'
    Plug 'jdonaldson/vaxe' " Haxe language support
    Plug 'maxmellon/vim-jsx-pretty'

    " Language Specific
    Plug 'akhaku/vim-java-unused-imports'

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

    " Share clipboard with macOS
    set clipboard=unnamed


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

    :autocmd BufReadPost * :DetectIndent

" Text Formatting Functions (you can use them with `:call UseTwoSpaces()`)
    function! UseTwoSpaces()
        set tabstop=2     " Size of a hard tabstop (ts).
        set shiftwidth=2  " Size of an indentation (sw).
        set expandtab     " Always uses spaces instead of tab characters (et).
        set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
        set autoindent    " Copy indent from current line when starting a new line.
        set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
    endfunction

    function! UseFourSpaces()
        set tabstop=4     " Size of a hard tabstop (ts).
        set shiftwidth=4  " Size of an indentation (sw).
        set expandtab     " Always uses spaces instead of tab characters (et).
        set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
        set autoindent    " Copy indent from current line when starting a new line.
        set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
    endfunction

    function! UseTabs()
        set tabstop=4     " Size of a hard tabstop (ts).
        set shiftwidth=4  " Size of an indentation (sw).
        set noexpandtab   " Always uses tabs instead of space characters (noet).
        set autoindent    " Copy indent from current line when starting a new line (ai).
    endfunction

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
    let g:fzf_layout = { 'down': '~40%' } " make it stick to the bottom
    " Customize fzf colors to match your color scheme
    let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

   " search only in file contents (not file names) and show preview on the right
    command! -bang -nargs=* Ag
        \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%'), <bang>0)

    nnoremap <leader>f :Lines<cr>
    nnoremap <leader>g :Ag<cr>
    nnoremap <leader><leader> :Commands<CR>
    nnoremap <leader>a :Ag <C-R><C-W><CR>
    nnoremap <leader>c :Commits<cr>
    nnoremap <C-p> :Files<cr>

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

" Enabling CSS autocomplete on .scss .css file
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType scss set omnifunc=csscomplete#CompleteCSS

" View navigation
    " Control + Shift + Arrows to resize the windows
    nnoremap <silent> <C-S-Down> :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <C-S-Up> :exe "resize " . (winheight(0) * 2/3)<CR>
    nnoremap <silent> <C-S-Right> :vertical resize +10<CR>
    nnoremap <silent> <C-S-Left> :vertical resize -10<CR>

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

" TypeScript
    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    " autocmd BufEnter *.tsx set filetype=typescript
    " autocmd BufEnter *.tsx set filetype=javascript.jsx
    " This is from coc-tsserver README
    " autocmd BufEnter *.tsx set filetype=typescriptreact

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
    let g:coc_global_extensions = [
        \ 'coc-emmet',
        \ 'coc-css',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-prettier',
        \ 'coc-tsserver',
        \ 'coc-eslint',
        \ 'coc-git',
        \ 'coc-vetur',
        \ 'coc-tabnine'
    \]

    " Use tab for trigger completion with characters ahead and navigate
    " through completions.
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

    " Allows to press Enter to select a competion
    " This is needed to support completions containing spaces (generated from TabNine for example)
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


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

" Markdown Preview
    " set to 1, the nvim will auto close current preview window when change
    " from markdown buffer to another buffer
    " default: 1
    let g:mkdp_auto_close = 0

" Line numbers
    " https://jeffkreeftmeijer.com/vim-number/
    "
    " insert mode -> absolute
    " normal mode -> relative
    :set number relativenumber

    :augroup numbertoggle
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    :augroup END

" Haxe Laguage
    let g:vaxe_enable_airline_defaults = 0

" Git
    " Show git info of selected line (https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/)
    nmap <silent><Leader>b :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
