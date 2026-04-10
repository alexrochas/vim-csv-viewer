" vim-csv-viewer
" Visualize CSV as table-like vertical splits

if exists('g:loaded_csv_viewer')
  finish
endif
let g:loaded_csv_viewer = 1

command! -nargs=? CsvSplit call csv_viewer#SplitColumns(<q-args>)
