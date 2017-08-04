" Enable Pathogen
execute pathogen#infect()
filetype plugin indent on
syntax on

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
    autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | endif

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

" Colours
    set background=dark
    colorscheme OceanicNext

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

" Vim + Ctags Ctrlp
    nnoremap <leader>. :CtrlPTag<cr>

" Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_css_checkers = ['stylelint']

 " CSS3 Syntax
    augroup VimCSS3Syntax
        autocmd!

        autocmd FileType css setlocal iskeyword+=-
    augroup END

" Remove the window with function definition
    set completeopt=menu

" TypeSCript
    "autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    "autocmd BufEnter *.tsx set filetype=typescript
    "autocmd BufEnter *.tsx set filetype=javascript.jsx
    "
" Tries to fixes bash completition
    set isfname-==
