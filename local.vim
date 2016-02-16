" -*- vim:ft=vim:sw=2:ts=2
set cryptmethod=blowfish2
set lines=49
set wrap
set cursorline
set rnu
set noswapfile
if has('gui_running')
  if has('win32') || has('win64')
    set gfn=Lucida_Sans_Typewriter:h13:cANSI
  else
      set gfn=Osaka-Mono:h18 
      " set gfn=Lucida_Sans_Typewriter:h18:cANSI
  endif
  "colorscheme solarized
  colorscheme peaksea
  set lines=50
  set columns=180
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

"* the separator used on the left side >
  let g:airline_left_sep='>'
<
"* the separator used on the right side >
  let g:airline_right_sep='<'
<
"* enable modified detection >
  let g:airline_detect_modified=1

"* enable paste detection >
  let g:airline_detect_paste=1
<
"* enable crypt detection >
  let g:airline_detect_crypt=1
<
"* enable iminsert detection >
  let g:airline_detect_iminsert=1
<
"* determine whether inactive windows should have the left section collapsed to
"  only the filename of that buffer.  >
  let g:airline_inactive_collapse=1
<
"* themes are automatically selected based on the matching colorscheme. this
"  can be overridden by defining a value. >
"  let g:airline_theme=
<
" * if you want to patch the airline theme before it gets applied, you can
"   supply the name of a function where you can modify the palette. >
"  let g:airline_theme_patch_func = 'AirlineThemePatch'
"  function! AirlineThemePatch(palette)
"    if g:airline_theme == 'badwolf'
"      for colors in values(a:palette.inactive)
"        let colors[3] = 245
"      endfor
"    endif
"  endfunction
<
" * enable/disable automatic population of the `g:airline_symbols` dictionary
"   with powerline symbols. >
  let g:airline_powerline_fonts=1
<
"* define the set of text to display for each mode.  >
"  let g:airline_mode_map = {} " see source for the defaults

"  " or copy paste the following into your vimrc for shortform text
"  let g:airline_mode_map = {
"      \ '__' : '-',
"      \ 'n'  : 'N',
"      \ 'i'  : 'I',
"      \ 'R'  : 'R',
"      \ 'c'  : 'C',
"      \ 'v'  : 'V',
"      \ 'V'  : 'V',
"      \ '' : 'V',
"      \ 's'  : 'S',
"      \ 'S'  : 'S',
"      \ '' : 'S',
"      \ }
<
"* define the set of filename match queries which excludes a window from having
"  its statusline modified >
  let g:airline_exclude_filenames = [] " see source for current list
<
"* define the set of filetypes which are excluded from having its window
"  statusline modified >
  let g:airline_exclude_filetypes = [] " see source for current list
<
"* defines whether the preview window should be excluded from have its window
"  statusline modified (may help with plugins which use the preview window
"  heavily) >
  let g:airline_exclude_preview = 0
<
"* disable the Airline customization for selective windows (this is a
"  window-local variable so you can disable it for only some windows) >
"  let w:airline_disabled = 0

  let g:airline_extensions = ['branch', 'tabline']
  let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
  let g:airline#extensions#quickfix#location_text = 'Location'
  let g:airline#extensions#bufferline#enabled = 1
  let g:airline#extensions#bufferline#overwrite_variables = 1
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#branch#empty_message = ''
  let g:airline#extensions#branch#displayed_head_limit = 10
  let g:airline#extensions#branch#format = 0
  let g:airline#extensions#tagbar#enabled = 1
  "let g:airline#extensions#tagbar#flags = ''  (default)
  "let g:airline#extensions#tagbar#flags = 'f'
  "let g:airline#extensions#tagbar#flags = 's'
  let g:airline#extensions#tagbar#flags = 'p'
  let g:airline#extensions#wordcount#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 1
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#show_tab_nr = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
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
if has('python3')
  let g:pymode_python = 'python3'
elseif has('python')
  let g:pymode_python = 'python'
else
  let g:pymode_python = 'disable'
endif
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = ''
let g:pymode_lint_on_fly = 1
let g:pymode_lint_on_write = 0
let g:pymode_rope = 0
autocmd! FileType python call PythonSettings()
function! PythonSettings()
  "setlocal foldmethod=expr
  "setlocal foldexpr=pymode#folding#expr(v:lnum)
  "setlocal foldtext=pymode#folding#text()
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

