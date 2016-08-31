" history 存储容量
set history=5000
" 开启语法高亮，并设置theme
syntax enable
" 去掉边框
set go=
" 显示行号
set number
" 用空格替换制表符
set expandtab
" 制表符占4个空格
set tabstop=4
" 默认缩进为4个空格大小
set shiftwidth=4
" 增量式搜索
set incsearch
" 高量搜索
set hlsearch
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 检测文件类型
filetype on
filetype plugin on
filetype indent on

" 文件修改后自动载入
set autoread
" 启动时不显示乌干达儿童的提示
set shortmess=atI

" 忽略文件
set wildignore=*.swp,*.bak,*.pyc,*.class,*.svn
" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline

" 设置退出vim后，内容显示在终端屏幕
set t_ti= t_te=

" 显示当前的行列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode
" 在上下移动光标时，光标的上方和 下方至少会保留显示的行数
set scrolloff=7

set nocompatible
set hidden


" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
noremap <C-n> :call NumberToggle()<cr>



" ==============================================================================
" 设置插件
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 自动不全单引号，双引号
Plugin 'Raimondi/delimitMate'
" 自动不全htm/xml标签
Plugin 'docunext/closetag.vim'
" 快速注释
Plugin 'scrooloose/nerdcommenter'
" 状态栏增强显示
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" 括号显示增强
Plugin 'kien/rainbow_parentheses.vim'


" nerdtree nerdtreetabs
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" ctrlspace
" Plugin 'vim-ctrlspace/vim-ctrlspace'
" tagbar
Plugin 'majutsushi/tagbar'
" 文件搜索
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'iamcco/markdown-preview.vim'

" Color schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

call vundle#end()            " required
filetype plugin indent on    " required


set background=dark
colorscheme solarized


" nerdtree
autocmd vimenter * NERDTree
map <F2> :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %


" vim preview
let g:mkdp_path_to_chrome = "google-chrome"
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）

let g:mkdp_auto_start = 0
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开
" markdown 文件的时候打开一次

let g:mkdp_auto_open = 0
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预
" 览窗口

let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不
" 自动关闭预览窗口

let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时
" 更新预览

let g:mkdp_command_for_global = 0
" 设置为 1 则所有文件都可以使用 MarkdownPreview 进行预览，默认只有 markdown
" 文件可以使用改命令


 au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
