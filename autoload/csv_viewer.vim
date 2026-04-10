" autoload/csv_viewer.vim

" Helper function to parse a single CSV line properly
" Handles commas inside quotes and escaped quotes ("")
function! s:ParseCSVLine(line, delimiter) abort
  let l:fields = []
  let l:current_field = ''
  let l:in_quotes = 0
  let l:i = 0
  let l:len = strlen(a:line)
  
  while l:i < l:len
    let l:char = a:line[l:i]
    if l:char ==# '"'
      " Handle escaped quotes ("") inside quoted fields
      if l:in_quotes && l:i + 1 < l:len && a:line[l:i+1] ==# '"'
        let l:current_field .= '"'
        let l:i += 1 " Skip the second quote
      else
        " Toggle quote state
        let l:in_quotes = !l:in_quotes
      endif
    elseif l:char ==# a:delimiter && !l:in_quotes
      " End of field
      call add(l:fields, l:current_field)
      let l:current_field = ''
    else
      " Normal character
      let l:current_field .= l:char
    endif
    let l:i += 1
  endwhile
  
  " Add the last field
  call add(l:fields, l:current_field)
  return l:fields
endfunction

function! csv_viewer#SplitColumns(args)
  " Determine delimiter (default to comma)
  let l:delim = ','
  if !empty(a:args)
    let l:delim = a:args[0] " Take the first character as delimiter
  endif

  " Get all lines from the current buffer
  let l:lines = getline(1, '$')
  if empty(l:lines)
    echoerr "Buffer is empty"
    return
  endif

  " Parse lines properly using the state machine
  let l:parsed_lines = []
  for l:line in l:lines
    call add(l:parsed_lines, s:ParseCSVLine(l:line, l:delim))
  endfor
  
  " Determine the max number of columns
  let l:max_cols = 0
  for l:row in l:parsed_lines
    if len(l:row) > l:max_cols
      let l:max_cols = len(l:row)
    endif
  endfor

  if l:max_cols == 0
    echoerr "No columns found"
    return
  endif

  " Open a new tabpage to keep things clean
  tabnew

  " Loop through columns and create vertical splits
  for l:col_idx in range(l:max_cols)
    if l:col_idx > 0
      rightbelow vnew
    endif
    
    " Extract the column data
    let l:col_data = []
    for l:row in l:parsed_lines
      if l:col_idx < len(l:row)
        call add(l:col_data, l:row[l:col_idx])
      else
        call add(l:col_data, "") " Empty if missing
      endif
    endfor

    " Populate the buffer
    call setline(1, l:col_data)
    
    " Setup buffer settings for spreadsheet-like behavior
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nowrap
    setlocal cursorbind
    setlocal scrollbind
    
    " Highlight the first row (headers)
    call matchadd('Title', '\%1l.*')
  endfor
  
  " Balance windows
  wincmd =
  
  " Jump back to first column
  1wincmd w

endfunction
