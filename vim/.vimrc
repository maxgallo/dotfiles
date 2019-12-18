" Enable Pathogen
execute pathogen#infect()
filetype plugin indent on
syntax on

" Use bash as shell (without this one it uses fish and fugitive is crazy slow)
    set shell=/bin/bash

" General
    set timeoutlen=1000 ttimeoutlen=0 " Eliminate the delays on ESC
    set number                        " Show line number

" Powerline
    set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/
    set laststatus=2
    set t_Co=256

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
    nnoremap <silent> ] :vertical resize +10<CR>
    nnoremap <silent> [ :vertical resize -10<CR>

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

" Ale
    "let g:ale_linters = ['stylelint', 'eslint'] " This avoid automatic detection of typescript
    let g:ale_linters = {'javascript': ['eslint'], 'css': ['stylelint'], 'typescript': ['tsserver']}
    " let g:ale_linters = {'javascript': ['eslint'], 'css': ['stylelint'], 'typescript': ['tslint']}
    let g:ale_linters_explicit = 1 " Only run linters I specified

    " let g:ale_fixers = { 'javascript': ['prettier']}
    " let g:ale_fix_on_save = 0 " don't run prettier on save
    " let g:ale_javascript_prettier_use_local_config = 1

    let g:ale_open_list = 1
    let g:ale_list_window_size = 5

   " close list when closing buffer
   " https://github.com/w0rp/ale/issues/1306
   autocmd QuitPre * if empty(&bt) | lclose | endif

" CSS3 Syntax
    augroup VimCSS3Syntax
        autocmd!

        autocmd FileType css setlocal iskeyword+=-
    augroup END

" Remove the window with function definition
    set completeopt=menu

" TypeSCript
    " autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    " autocmd BufEnter *.tsx set filetype=typescript
    " autocmd BufEnter *.tsx set filetype=javascript.jsx

" Tries to fixes bash completition
    set isfname-==

" You Complete Me
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    " This was checkin for errors same way ALE already is doing, and I want to
    " use Ale for this
    let g:ycm_show_diagnostics_ui = 0

    " Don't ask me why but jsx files are disabled by default
    let g:ycm_filepath_blacklist = {
      \}

    " Suggest me things after 2 chars
    let g:ycm_semantic_triggers = {
    \   'javascript': [ 're!\w{2}' ],
    \   'typescript': [ 're!\w{2}' ]
    \ }

    "Smart GoTo it overrides tab navigation!
    nnoremap <C-]> :YcmCompleter GoTo<CR>
    "nnoremap <C-[> :tab split \| YcmCompleter GoToDefinition<CR>

" Remove Trailing spaces on save
    autocmd BufWritePre <buffer> %s/\s\+$//e

" Vim Airline
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#formatter = 'unique_tail'

" Other command
    " Use 'gb' lie Ctrl-o to go back after a navigation
    nnoremap <silent> gb <C-o>
