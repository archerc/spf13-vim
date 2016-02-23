" -*- vim:ft=vim:sw=2:ts=2

set wrap
set cursorline
set rnu
if has('gui_running')
  if has('win32') || has('win64')
    set gfn=Lucida_Sans_Typewriter:h13:cANSI
    simalt ~X
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

" { VimEnter 
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
let g:unite_source_history_yank_enable = 1
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.test = {
      \     'description' : 'Test menu',
      \ }
let g:unite_source_menu_menus.test.candidates = {
      \   'ghci'      : 'VimShellInteractive ghci',
      \ }
function g:unite_source_menu_menus.test.map(key, value)
  return {
        \       'word' : a:key, 'kind' : 'command',
        \       'action__command' : a:value,
        \     }
endfunction

let g:unite_source_menu_menus.test2 = {
      \     'description' : 'Test menu2',
      \ }
let g:unite_source_menu_menus.test2.command_candidates = {
      \   'python'    : 'VimShellInteractive python',
      \ }

let g:unite_source_menu_menus.test3 = {
      \     'description' : 'Test menu3',
      \ }
let g:unite_source_menu_menus.test3.command_candidates = [
      \   ['ruby', 'VimShellInteractive ruby'],
      \   ['python', 'VimShellInteractive python'],
      \ ]
let g:unite_source_menu_menus.git = {
      \ 'description' : '            gestionar repositorios git
      \                            ⌘ [espacio]g',
      \}
let g:unite_source_menu_menus.git.command_candidates = [
      \['▷ tig                                                        ⌘ ,gt',
      \'normal ,gt'],
      \['▷ git status       (Fugitive)                                ⌘ ,gs',
      \'Gstatus'],
      \['▷ git diff         (Fugitive)                                ⌘ ,gd',
      \'Gdiff'],
      \['▷ git commit       (Fugitive)                                ⌘ ,gc',
      \'Gcommit'],
      \['▷ git log          (Fugitive)                                ⌘ ,gl',
      \'exe "silent Glog | Unite quickfix"'],
      \['▷ git blame        (Fugitive)                                ⌘ ,gb',
      \'Gblame'],
      \['▷ git stage        (Fugitive)                                ⌘ ,gw',
      \'Gwrite'],
      \['▷ git checkout     (Fugitive)                                ⌘ ,go',
      \'Gread'],
      \['▷ git rm           (Fugitive)                                ⌘ ,gr',
      \'Gremove'],
      \['▷ git mv           (Fugitive)                                ⌘ ,gm',
      \'exe "Gmove " input("destino: ")'],
      \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
      \'Git! push'],
      \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
      \'Git! pull'],
      \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
      \'exe "Git! " input("comando git: ")'],
      \['▷ git cd           (Fugitive)',
      \'Gcd'],
      \]
function! UniteSettings()
  if exists("g:loaded_unite")
    " Unite

    nnoremap <silent> sm  :<C-u>Unite menu:test<CR>
    nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap uu u
    nnoremap ut :<C-u>Unite -no-split -buffer-name=files   file_rec/async:!<cr>
    nnoremap ur :<C-u>Unite -no-split -buffer-name=mru     file_mru<cr>
    nnoremap uo :<C-u>Unite -no-split -buffer-name=outline outline<cr>
    nnoremap uy :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
    nnoremap ub :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
    nnoremap uf :<C-u>Unite -no-split -buffer-name=files   file<cr>
    nnoremap u/ :<C-u>Unite -no-split -buffer-name=grep    grep<cr>
    nnoremap ug :<C-u>Unite -no-split -buffer-name=git     giti<cr>
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

" LaTeX" {
"   You may selectively use conceal mode by setting g:tex_conceal in your
"   <.vimrc>.  By default, g:tex_conceal is set to "admgs" to enable concealment
"   for the following sets of characters: >
"   
"   	a = accents/ligatures
"   	b = bold and italic
"   	d = delimiters
"   	m = math symbols
"   	g = Greek
"   	s = superscripts/subscripts
let g:tex_conceal = "abdmg"
let g:Tex_DefaultTargetFormat = 'pdf'
if has('win32')
  let g:Tex_ViewRule_pdf = 'SumatraPDF'
endif
" disable live preview
let g:loaded_vim_live_preview = 1
"let g:livepreview_previewer = 'SumatraPDF'
autocmd!    FileType tex    call TeXSettings()
function!   TeXSettings()
  set conceallevel=0
endfunction
" }

" { Pandoc
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 1
" }
