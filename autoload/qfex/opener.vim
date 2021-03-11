function! qfex#opener#enter(cmd) abort
  let l:lnum = line('.')
  if get(get(getwininfo(win_getid()), 0, {}), 'loclist', 0)
    let l:cmd = 'll'
    let l:ccmd = 'lclose'
  else
    let l:cmd = 'cc'
    let l:ccmd = 'cclose'
  endif
  silent! execute a:cmd
  silent! execute l:cmd l:lnum
  if get(g:, 'qfex_autoclose_enabled', v:false)
    silent! execute l:ccmd
  endif
endfunction
