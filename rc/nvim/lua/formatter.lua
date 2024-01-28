function ISort()
    local pos = vim.fn.getpos(".")
    print(pos)
    local buffer = vim.fn.getline(1, '$')
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system('isort -', buffer)
    vim.fn.execute("%d")
    vim.fn.setline(1, vim.fn.split(buffer, '\n'))
    vim.fn.setpos(".", pos)
end

function Black()
    local pos = vim.fn.getpos(".")
    local buffer = vim.fn.getline(1, '$')
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system('black -', buffer)
    vim.fn.execute("%d")
    local buffer = vim.fn.split(buffer, '\n')
    table.remove(buffer)
    table.remove(buffer)
    table.remove(buffer)
    table.remove(buffer)
    vim.fn.setline(1, buffer)
    vim.fn.setpos(".", pos)
end

function Remark()
    local pos = vim.fn.getpos(".")
    local buffer = vim.fn.getline(1, "$")
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system("remark", buffer)
    vim.fn.execute("%d")
    vim.fn.setline(1, vim.fn.split(buffer, "\n"))
    vim.fn.setpos(".", pos)
end

return {
    ISort = ISort,
    Black = Black,
    Remark = Remark,
}
