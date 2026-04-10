# vim-csv-viewer

A fast, lightweight Vim plugin that visualizes CSV files in a clean, table-like format using native Vim vertical splits. 

Instead of drawing lines with pipes or overriding your buffer, `vim-csv-viewer` creates a new tab with vertical splits for each column. By leveraging Vim's built-in `scrollbind` and `cursorbind`, scrolling up and down keeps all columns perfectly synchronized, giving you a smooth, spreadsheet-like experience directly in the terminal.

## Features

- **Native Feel:** Each column is a standard Vim buffer. All your normal Vim movement and search commands work perfectly.
- **Synchronous Scrolling:** Automatically binds scrolling and cursor movements across all columns.
- **Header Highlighting:** The first row is automatically highlighted so your column names stand out.
- **Robust CSV Parsing:** Includes a custom Vimscript parser that correctly handles:
  - Commas inside quoted fields (e.g., `"Doe, John"`).
  - Escaped quotes inside quoted fields (e.g., `"He said ""hello"""`).
  - Empty fields.

## Installation

You can install `vim-csv-viewer` using your favorite Vim plugin manager.

**[vim-plug](https://github.com/junegunn/vim-plug)**
```vim
Plug 'alexrochas/vim-csv-viewer'
```

**[Vundle](https://github.com/VundleVim/Vundle.vim)**
```vim
Plugin 'alexrochas/vim-csv-viewer'
```

**[Packer.nvim](https://github.com/wbthomason/packer.nvim)**
```lua
use 'alexrochas/vim-csv-viewer'
```

## Usage

1. Open any CSV file in Vim.
2. Run the command:

```vim
:CsvSplit
```

This will parse the current buffer and open a new tab containing the vertical splits.

**Custom Delimiter:**
If you're using a file with a different delimiter, such as a semicolon (`;`) or a pipe (`|`), you can pass it to the command:

```vim
:CsvSplit ;
```
```vim
:CsvSplit |
```

## License

MIT
