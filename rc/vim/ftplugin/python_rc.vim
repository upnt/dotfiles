" Format
function _py_isort()
    let pos = getpos(".")
    let buffer = getline(1, '$')
    let buffer = join(buffer, "\n")
    let buffer = system('isort -', buffer)
    execute "%d"
    call setline(1, split(buffer, '\n'))
    call setpos(".", pos)
endfunction

function _py_black()
    let pos = getpos(".")
    let buffer = getline(1, '$')
    let buffer = join(buffer, "\n")
    let buffer = system('black -', buffer)
    execute "%d"
    call setline(1, split(buffer, '\n')[:-5])
    call setpos(".", pos)
endfunction

augroup auto_format
    autocmd!
    autocmd! BufWritePre * call _py_isort()
    autocmd! BufWritePre * call _py_black()
augroup END
