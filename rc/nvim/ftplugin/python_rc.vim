" Format
augroup auto_format
    autocmd!
    autocmd BufWritePre * call execute("lua require('formatter').ISort()")
    autocmd BufWritePre * call execute("lua require('formatter').Black()")
augroup END
