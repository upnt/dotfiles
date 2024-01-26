function! ISort() abort
    let pos = getpos(".")
    let buffer = getline(1, '$')
    let buffer = join(buffer, "\n")
    let buffer = system('isort -', buffer)
    execute "%d"
    call setline(1, split(buffer, '\n'))
    call setpos(".", pos)
endfunction

function! Black() abort
    let pos = getpos(".")
    let buffer = getline(1, '$')
    let buffer = join(buffer, "\n")
    let buffer = system('black -', buffer)
    execute "%d"
    call setline(1, split(buffer, '\n')[:-5])
    call setpos(".", pos)
endfunction

function! Remark() abort
    let pos = getpos(".")
    let buffer = getline(1, '$')
    let buffer = join(buffer, "\n")
    let buffer = system('remark', buffer)
    execute "%d"
    call setline(1, split(buffer, '\n'))
    call setpos(".", pos)
endfunction

