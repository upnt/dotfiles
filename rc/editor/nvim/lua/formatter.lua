function ISort()
    local pos = vim.fn.getpos(".")
    print(pos)
    local buffer = vim.fn.getline(1, '$')
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system('isort - 2>/dev/null', buffer)
    
    if (buffer ~= "") then
        vim.fn.execute("%d")
        vim.fn.setline(1, vim.fn.split(buffer, '\n'))
        vim.fn.setpos(".", pos)
    end
    -- local pos = vim.fn.getpos(".")
    -- local buffer = vim.fn.getline(1, '$')
    -- local buffer = vim.fn.join(buffer, "\n")
    -- local command = string.format("echo %s| isort - 2>&1", buffer)
    -- local file = io.popen(command, "r")
    -- local buffer = file:read("*a")
    -- local success, _, _ = file:close()
    -- local success = true
    -- if (success) then
    --     vim.fn.execute("%d")
    --     vim.fn.setline(1, vim.fn.split(buffer, '\n'))
    --     vim.fn.setpos(".", pos)
    -- else
    --     vim.cmd('echohl ErrorMsg')
    --     vim.cmd(string.format("echomsg 'isort: %s'", buffer))
    --     vim.cmd('echohl None')
    -- end
end

function Black()
    local pos = vim.fn.getpos(".")
    local buffer = vim.fn.getline(1, '$')
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system('black - 2>/dev/null', buffer)

    if (buffer ~= "") then
        vim.fn.execute("%d")
        local buffer = vim.fn.split(buffer, '\n')
        -- table.remove(buffer)
        -- table.remove(buffer)
        -- table.remove(buffer)
        -- table.remove(buffer)
        vim.fn.setline(1, buffer)
        vim.fn.setpos(".", pos)
    end
end

function Remark()
    local pos = vim.fn.getpos(".")
    local buffer = vim.fn.getline(1, "$")
    local buffer = vim.fn.join(buffer, "\n")
    local buffer = vim.fn.system("remark 2>/dev/null", buffer)

    if (buffer ~= "") then
        vim.fn.execute("%d")
        vim.fn.setline(1, vim.fn.split(buffer, "\n"))
        vim.fn.setpos(".", pos)
    end
end

return {
    ISort = ISort,
    Black = Black,
    Remark = Remark,
}
