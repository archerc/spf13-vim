" -*- vim:ft=vim:sw=2:ts=2

set wrap
set cursorline
set rnu
if has('gui_running')
  if has('win32') || has('win64')
    set gfn=Lucida_Sans_Typewriter:h13:cANSI
  else
    set gfn=Osaka-Mono:h18
  endif
  "colorscheme solarized
  colorscheme peaksea
else
  set background=dark
  colorscheme peaksea
endif

"nnoremap       <silent>     <Tab>       @=(foldlevel('.')?'za':"\<Tab>")<CR>
nnoremap       <silent>     <Tab>       @=(foldlevel('.')?'za':'zj')<CR>
vnoremap                    <Tab>       zf

nnoremap    q      :bd<cr>
" nnoremap jk      <esc>
nnoremap    <leader>w  :w!<cr>
nnoremap    <leader><cr>    :noh<cr>

" VimEnter " {
autocmd! VimEnter   *   call OnVimEnter()
function! OnVimEnter()
  call UniteSettings()
  call FugitiveSettings()
  call PythonSettings()
  if has('win32')
    simalt ~x
  endif
endfunction
" }

" Unite " {
function! UniteSettings()
  if exists("g:loaded_unite")
    " Unite
    let g:unite_source_history_yank_enable = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap uu u
    nnoremap ut :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
    nnoremap ur :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
    nnoremap uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
    nnoremap uy :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
    nnoremap ub :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
    nnoremap uf :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
    nnoremap u/ :<C-u>Unite -no-split -buffer-name=grep    -start-insert grep<cr>
    nnoremap ug :<C-u>Unite -no-split -buffer-name=git     -start-insert giti<cr>
    " nnoremap <leader>ft :Unite file_rec/async -default-action=tabopen<cr>
    " nnoremap <leader>fs :Unite file_rec/async -default-action=split<cr>
    " nnoremap <leader>fv :Unite file_rec/async -default-action=vsplit<cr>
    " nnoremap <leader>fc :Unite file_rec/async
    " Custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      " Play nice with supertab
      let b:SuperTabDisabled=1
      " Enable navigation with control-j and control-k in insert mode
      imap <buffer> <C-j>   <Plug>(unite_select_next_line)
      imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    endfunction
  endif
endfunction
" }

" airline tabline for buffer " {
let g:airline_extensions = ['branch', 'tabline']
nnoremap    gb      :bn<cr>
nnoremap    gB      :bp<cr>
" }

" Vim settings" {
autocmd! FileType vim call VimSettings()
function! VimSettings()
  setlocal    fdm=marker
  setlocal    commentstring="\"%s"
  setlocal    foldmarker={,}
  let         &l:commentstring='" %s'
  "let         &l:foldmarker='"{,"}'
endfunction
" }

" NerdTree settings" {
augroup nerdtree
autocmd! nerdtree FileType nerdtree call NerdTreeSettings()
augroup END
function! NerdTreeSettings()
  nnoremap      b   :Bookmark<cr>
endfunction
" }

" fugitive" {
let g:fugitive_save_wildignore=&wildignore
function! FugitiveSettings()
  if exists("g:loaded_fugitive")
    set wildignore-=*/.git/*
    amenu   Plugin.Fugitive.Git\ Add<Tab><leader>ga   :Git add %:p<CR><CR>
    amenu   Plugin.Fugitive.Git\ Status<Tab><leader>gs   :Gstatus<CR>
    " Hack until it works, commit. That's all there is to it.
    " I use these bindings for easier access:
    " fugitive git bindings
    nnoremap <leader>ga :Git add %:p<CR><CR>
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gc :Gcommit -v -q<CR>
    nnoremap <leader>gt :Gcommit -v -q %:p<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>ge :Gedit<CR>
    nnoremap <leader>gr :Gread<CR>
    nnoremap <leader>gw :Gwrite<CR><CR>
    nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
    nnoremap <leader>gp :Ggrep<Space>
    nnoremap <leader>gm :Gmove<Space>
    nnoremap <leader>gb :Git branch<Space>
    nnoremap <leader>go :Git checkout<Space>
    nnoremap <leader>gps :Dispatch! git push<CR>
    nnoremap <leader>gpl :Dispatch! git pull<CR>
  endif
endfunction
" }

" Python " {
let g:pymode_python = 'python3'
let g:pymode_lint_on_fly = 1
let g:pymode_lint_on_write = 0
let g:pymode_rope = 1
"autocmd! FileType python call PythonSettings()
function! PythonSettings()
endfunction
" }

" Syntastic " {
"let g:loaded_syntastic_plugin = 1
"let g:loaded_syntastic_checker = 0
let g:syntastic_debug = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers = ['python']
" }

