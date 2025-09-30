" ====================
" Vim 开发环境配置
" ====================

" 基础设置
set nocompatible           " 关闭兼容模式
set number                 " 显示行号
set cursorline             " 高亮当前行
set showcmd                " 显示命令
set showmatch              " 括号匹配
set hlsearch               " 搜索高亮
set incsearch              " 增量搜索
set ignorecase             " 搜索忽略大小写
set nosmartcase            " 智能大小写
set autoindent             " 自动缩进
set smartindent            " 智能缩进
set tabstop=4              " Tab宽度
set shiftwidth=4           " 缩进宽度
set expandtab              " 转换tab
set backspace=2            " 退格键设置
set encoding=utf-8         " 编码设置
set fileencoding=utf-8
set mouse=a                " 启用鼠标
set clipboard=unnamedplus  " 系统剪切板
set splitbelow             " 新窗口在下方打开
set splitright             " 新窗口在右方打开
set formatoptions=c        " 自动换行注释


" 插件管理 (vim-plug)
call plug#begin('~/.vim/plugged')

" 禁用 coc.nvim 启动警告（如果 Vim 版本较旧）
let g:coc_disable_startup_warning = 1

" 1. 代码补全 - coc.nvim (强烈推荐)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 2. 文件浏览器
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" 3. 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 4. 语法高亮
Plug 'sheerun/vim-polyglot'

" 5. Git 集成
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 6. 模糊搜索
Plug 'ctrlpvim/ctrlp.vim'

" 7. 主题
Plug 'NLKNguyen/papercolor-theme'

" 8. 括号补全
Plug 'jiangmiao/auto-pairs'

" 9. 注释插件
Plug 'preservim/nerdcommenter'

" 10. 多光标
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" ====================
" 主题设置
" ====================
syntax enable
set background=light

" ====================
" 插件配置
" ====================

" NERDTree 配置
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 30
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
" 自动打开 NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 当只剩 NERDTree 时自动关闭
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline 配置
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='papercolor'


" CtrlP 配置
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Coc.nvim 配置
" 使用 Tab 和 Shift-Tab 来导航补全选项
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 使用 Enter 确认补全
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo 代码导航
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ctags
nnoremap <C-]> g<C-]>


" ====================
" 自定义快捷键
" ====================
" 设置 Leader 键
let mapleader = ","

" 窗口导航
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" cursor
" 设置光标颜色和形状
let &t_SI = "\e[2 q\e]12;red\x7"     " 插入模式：竖线，红色
let &t_SR = "\e[4 q\e]12;blue\x7"     " 替换模式：下划线，红色  
let &t_EI = "\e[2 q\e]12;green\x7"   " 普通模式：块状，绿色
" 确保vim退出时恢复默认光标
autocmd VimLeave * silent !echo -ne "\e[2 q\e]12;white\x7"


" 终端操作快捷键
" 在底部全宽打开终端（最可靠的方案）
nnoremap <leader>bt :botright terminal ++rows=12<CR>

  " 其他终端选项
nnoremap <leader>rt :botright vertical terminal<CR>
nnoremap <leader>tt :tabnew<CR>:terminal<CR>

" 快速关闭终端
nnoremap <leader>qt :bd!<CR>

" 在终端模式下的快捷键
if has('terminal')
    " 终端模式下 Ctrl+w 进行窗口操作
    tnoremap <C-w>h <C-w>h
    tnoremap <C-w>j <C-w>j
    tnoremap <C-w>k <C-w>k
    tnoremap <C-w>l <C-w>l
    tnoremap <C-w>w <C-w>w
    " Esc 或 Ctrl+\ Ctrl+n 退出终端模式
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-\><C-n> <C-\><C-n>
    " 在终端模式下也能使用窗口命令
    tnoremap <C-w>: <C-w>:
    tnoremap <C-w>q <C-w>q
    " 快速退出终端的快捷键
    tnoremap <leader>q <C-\><C-n>:q!<CR>
endif


" 分割窗口
"nnoremap <leader>v :vsplit<CR>
"nnoremap <leader>s :split<CR>

" 缓冲区切换
nnoremap <C-t> :bnext<CR>
nnoremap <leader>d :bdelete<CR>

" 快速保存退出
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" 清除搜索高亮
nnoremap <leader>h :nohlsearch<CR>

" 快速编辑 vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" 额外的实用快捷键
" 窗口大小调整
nnoremap <leader>= <C-w>=
nnoremap <leader>+ <C-w>+
nnoremap <leader>- <C-w>-

" 标签页操作
"nnoremap <leader>t :tabnew<CR>
"nnoremap <leader>tc :tabclose<CR>
nnoremap gt :tabnext<CR>
nnoremap gT :tabprev<CR>

" 快速在 NERDTree 中定位当前文件
nnoremap <leader>nf :NERDTreeFind<CR>

" 添加文件注释指令
function! AddHeader()
  let comment_char = '#'
  
  if &ft == 'cpp'
    let comment_char = '//'
  elseif &ft == 'vim'
    let comment_char = '"'
  endif

  let header = [
      \ comment_char . " File: " . expand("%.t"),
      \ comment_char . " Author: sefur",
      \ comment_char . " Created: " . strftime("%Y-%m-%d %H:%M"),
      \ comment_char . " Description: ",
      \ ""
      \]
  call append(0, header)
  " move cursor to Description
  call cursor(4, len(comment_char . " Description: ") + 1) 
  startinsert
endfunction

nnoremap <F4> :call AddHeader()<CR>
inoremap <F4> <Esc>:call AddHeader()<CR>


" ====================
" 自动命令
" ====================

autocmd FileType c,cpp setlocal formatprg=clang-format
autocmd FileType c,cpp nnoremap <buffer><leader>f :%!clang-format<CR>
autocmd FileType c,cpp vnoremap <buffer><leader>f :!clang-format<CR>

autocmd BufWritePost *.c,*.h,*.cpp silent! !ctags -R .

augroup vimrc
    autocmd!
    " 保存时自动去除行尾空格
    "autocmd BufWritePre * :%s/\s\+$//e
    " 进入插入模式时启用绝对行号
    autocmd InsertEnter * :set number norelativenumber
    " 退出插入模式时启用相对行号
    autocmd InsertLeave * :set number

    " 快速编译运行
    autocmd FileType c nnoremap <leader>r :w<CR>:below 12split \| terminal gcc % -o %< && ./%<<CR>
    autocmd FileType cpp nnoremap <leader>r :w<CR>:below 12split \| terminal g++ % -o %< && ./%<<CR>
    autocmd FileType python nnoremap <leader>r :w<CR>:below 12split \| terminal python3 %<CR>
augroup END
