function qfex#item#delete() range
  let l:qf = getqflist()
  let l:history = get(w:, 'qf_history', [])
  call add(history, copy(l:qf))
  let w:qf_history = l:history
  unlet! qf[a:firstline - 1 : a:lastline - 1]
  call setqflist(qf, 'r')
  execute a:firstline
endfunction

function! qfex#item#undo()
  let l:history = get(w:, 'qf_history', [])
  if !empty(l:history)
    call setqflist(remove(l:history, -1), 'r')
  endif
endfunction
