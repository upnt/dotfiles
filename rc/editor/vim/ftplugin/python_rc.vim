" Format
augroup auto_format
    autocmd!
    autocmd! BufWritePre * call formatter#ISort()
    autocmd! BufWritePre * call formatter#Black()
augroup END
