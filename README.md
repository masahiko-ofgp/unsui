# unsui ~ 雲水 ~

vim colorscheme (quiet, dark, simple, japonism)

<image src="./images/unsui.png" alt="unsui-screenshot" width="70%">

## Usage

- Copy `unsui.vim`.

- Put your `.vim/colors` directory.

- Write `syntax on` and `color unsui` on `.vimrc`.

My `.vimrc`.
    
    set autoindent
    set smartindent
    set smarttab
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set number
    set statusline=%F
    set cursorline
    set fdm=marker
    
    syntax on
    color unsui
    
    inoremap <silent> jj <ESC>
    inoremap <C-j> <down>
    inoremap <C-k> <up>
    inoremap <C-h> <left>
    inoremap <C-l> <right>

    if has("autocmd")
      filetype plugin on
      filetype indent on
    endif
