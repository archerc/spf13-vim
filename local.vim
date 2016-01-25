" -*- vim:ft=vim:  

set gfn=Consolas:h18
set cursorline

nnoremap       <silent>     <Tab>       @=(foldlevel('.')?'za':"\<Tab>")<CR>
vnoremap                    <Tab>       zf

nnoremap    q      :bd<cr>
" nnoremap jk      <esc>
nnoremap    <leader>w  :w!<cr>

" Vim settings" {
autocmd FileType vim call VimSettings()
function! VimSettings()
    setlocal    fdm=marker
    setlocal    commentstring="\"%s"
    setlocal    foldmarker={,}
    let         &l:commentstring='" %s'
    "let         &l:foldmarker='"{,"}'
endfunction
" }

" Unite " {
"if exists("g:loaded_unite")
au      VimEnter    *   call UniteSettings()
function! UniteSettings()
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
endfunction
" }

" airline tabline for buffer " {
let g:airline_extensions = ['branch', 'tabline']
nnoremap    gb      :bn<cr>
nnoremap    gB      :bp<cr>
" }
