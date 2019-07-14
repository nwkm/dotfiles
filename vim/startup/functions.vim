function! OpenUnderTab() abort
  let curfile = expand("<cfile>")
  if filereadable(curfile)
    execute(":tabe " . curfile)
  else
    echo "The file \"" . curfile . "\" is not readable."
  endif
endfunction
