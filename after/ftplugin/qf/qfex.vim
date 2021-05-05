if exists('b:vim_qfex_loaded')
  finish
endif
let b:vim_qfex_loaded = 1

nnoremap <buffer> <Plug>(qfex-opener-edit)         <cmd>call qfex#opener#enter('wincmd p')<CR>
nnoremap <buffer> <Plug>(qfex-opener-tab)          <cmd>call qfex#opener#enter('tabnew')<CR>
nnoremap <buffer> <Plug>(qfex-opener-split)        <cmd>call qfex#opner#enter('wincmd p <bar> split')<CR>
nnoremap <buffer> <Plug>(qfex-opener-vsplit)       <cmd>call qfex#opener#enter('wincmd p <bar> vsplit')<CR>
nnoremap <buffer> <Plug>(qfex-preview-open)        <cmd>call qfex#preview#open(line('.')-1)<CR>
nnoremap <buffer> <Plug>(qfex-preview-close)       <cmd>call qfex#preview#close()<CR>
nnoremap <buffer> <Plug>(qfex-preview-toggle)      <cmd>call qfex#preview#toggle(line('.')-1)<CR>
nnoremap <buffer> <Plug>(qfex-preview-toggle-auto) <cmd>call qfex#preview#toggle_autopreview()<CR>
nnoremap <buffer> <Plug>(qfex-item-delete)         <cmd>call qfex#item#delete()<CR>
vnoremap <buffer> <Plug>(qfex-item-delete)         :call qfex#item#delete()<CR>
nnoremap <buffer> <Plug>(qfex-item-undo)           <cmd>call qfex#item#undo()<CR>

augroup vim-qfex
  autocmd! * <buffer>
  autocmd BufLeave <buffer> silent call qfex#preview#close()
augroup END

if get(g:, 'qfex_autopreview_enabled', 0)
  call qfex#preview#toggle_autopreview()
endif

if !get(g:, 'qfex_disable_default_mappings')
  nmap <buffer> p     <Plug>(qfex-preview-toggle)
  nmap <buffer> <C-p> <Plug>(qfex-preview-toggle-auto)
  nmap <buffer> <CR>  <Plug>(qfex-opener-edit)
  nmap <buffer> <C-t> <Plug>(qfex-opener-tab)
  nmap <buffer> <C-x> <Plug>(qfex-opener-split)
  nmap <buffer> <C-v> <Plug>(qfex-opener-vsplit)
  nmap <buffer> dd    <Plug>(qfex-item-delete)
  vmap <buffer> d     <Plug>(qfex-item-delete)
  nmap <buffer> u     <Plug>(qfex-item-undo)
endif
