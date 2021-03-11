let s:winid = -1

let s:config = { 
\ 'height': 15,
\ 'offset': 7,
\ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
\ }

call extend(s:config, get(g:, 'qfex_preview_opt', {}))

function! s:popup_cb(winid, result) abort
  let s:winid = -1
  call sign_unplace('PopUpQfPreview')
  if !empty(sign_getdefined('QfErrorLine'))
    call sign_undefine('QfErrorLine')
  endif
endfunction

function! qfex#preview#open(idx) abort
  call popup_close(s:winid)

  const l:wininfo = getwininfo(win_getid())[0]
  let l:qflist = l:wininfo.loclist ? getloclist(0) : getqflist()
  if len(l:qflist) == 0 | return | endif

  const l:qfitem = l:qflist[a:idx]

  " lines position of the display area.
  const l:disp_area = l:wininfo.winrow - 1

  " Disable popup if there is no display area.
  if l:disp_area < s:config.height / 2 
    return
  endif
  if s:config.height < l:disp_area
    let l:height = s:config.height
    let l:offset = s:config.offset
  else
    let l:height = s:config.height /2
    let l:offset = s:config.offset /2
  endif

  let l:firstline = l:qfitem.lnum - l:offset < 1 ? 1 : l:qfitem.lnum - l:offset

  let l:title = printf('%s (%d/%d)',
  \ bufname(l:qfitem.bufnr)->fnamemodify(':~:.'),
  \ a:idx + 1,
  \ len(l:qflist)
  \ )

  let opts = {
  \ 'line': l:disp_area,
  \ 'pos': 'botleft',
  \ 'col': l:wininfo.wincol,
  \ 'minheight': l:height,
  \ 'maxheight': l:height,
  \ 'minwidth': l:wininfo.width - 4,
  \ 'maxwidth': l:wininfo.width - 4,
  \ 'firstline': l:firstline,
  \ 'title': l:title,
  \ 'padding': [0,1,0,1],
  \ 'border': [1,1,1,1],
  \ 'borderchars': s:config.borderchars,
  \ 'scrollbar': v:false,
  \ 'moved': 'any',
  \ 'mapping': v:false,
  \ 'callback': funcref('s:popup_cb'),
  \ }
  let s:winid = popup_create(l:qfitem.bufnr, opts)

  call sign_define('QfErrorLine', {'linehl': 'CursorLine'})
  call sign_place(0, 'PopUpQfPreview', 'QfErrorLine', l:qfitem.bufnr, {'lnum': l:qfitem.lnum})
endfunction

function! qfex#preview#close() abort
  call popup_close(s:winid)
endfunction

function! qfex#preview#toggle(idx) abort
  if s:winid == -1
    call qfex#preview#open(a:idx)
  else
    call popup_close(s:winid)
  endif
endfunction
