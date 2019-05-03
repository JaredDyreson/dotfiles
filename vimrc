set nocompatible
filetype off

" Making sure the vundle settings are working accordingly
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List of our packages

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
"filetype plugin indent on
filetype indent on
syntax on
set autoindent

" This is so I can have proper copy pasting format

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Moving text up and down while holding shift
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Getting essential IDE features into vim wihtout the bloat -> https://realpython.com/vim-and-python-a-match-made-in-heaven/

" Allow for UTF-8 Support
set encoding=utf-8

" Autocomplete
Bundle 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" Moving through the files
inoremap <S-Tab> <C-d>
nnoremap <S-Tab> <<
inoremap <Tab> <C-t>
nnoremap <Tab> >>

" Undo and Redo Support
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>

" Make run
map <F8> :w <CR> !make <CR>

"" Giving VIM a solarized dark look

"" allow for line numbers
set number

"" Spell Checking
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

"" Save and compile markdown
" autocmd BufWritePost *.md !C=notes pmark %:p 

"" Markdown autcomplete star character
