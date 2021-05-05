# vim-qfex

vim plugin for quiclfix/loaclist. 

## Features

* preview in popup window(Vim8).
* delete and undo item in qflist.
* Open the selected item in a split/vplit/tab window.
* auto close qflist on select item.

## Usage

### Config

```vim
let g:qfex_autopreview_enabled = 1
let g:qfex_autoclose_enabled = 1
let g:qfex_disable_default_mappings = 1 " if disable default mapping
let g:qfex_preview_opt = { 
\ 'height': 15,
\ 'offset': 7,
\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
\ }
```

### Mappings

```vim
function! s:setup_vimqfex() abort
  nmap <buffer> p     <Plug>(qfex-preview-toggle)
  nmap <buffer> <C-p> <Plug>(qfex-preview-toggle-auto)
  nmap <buffer> <CR>  <Plug>(qfex-opener-edit)
  nmap <buffer> <C-t> <Plug>(qfex-opener-tab)
  nmap <buffer> <C-x> <Plug>(qfex-opener-split)
  nmap <buffer> <C-v> <Plug>(qfex-opener-vsplit)
  nmap <buffer> dd    <Plug>(qfex-item-delete)
  vmap <buffer> d     <Plug>(qfex-item-delete)
  nmap <buffer> u     <Plug>(qfex-item-undo)
endfunction
augroup vimqfex
  au!
  autocmd FileType qf call s:setup_vimqfex()
augroup END
```

## License

[MIT](LICENSE)
