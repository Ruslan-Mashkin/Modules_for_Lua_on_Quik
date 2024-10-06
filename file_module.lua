-- ����: file_module.lua
-- require('lfs')
local file_module = {}

--[[
������ ������� ������:
- file_module.fileExists(filename)
- file_module.createFile(filename, content)
- file_module.readFile(filename)
- file_module.writeFile(filename, content)
- file_module.copyFile(source, destination)
- file_module.deleteFile(filename)
- file_module.renameFile(oldName, newName)
- file_module.getFilesInDirectory(directory)
- file_module.appendToFile(filename, content)
- file_module.readLinesFromFile(filename)
- file_module.createTempFile(content)
- file_module.directoryExists(directory)
- file_module.createDirectory(directory)
- file_module.getCurrentDirectory()
]]


local errorLogFile = "error_log.txt"

-- ������� ��� ������ ������ � ����
function logError(errorMessage)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local errorString = timestamp .. " - " .. errorMessage

    local file = io.open(errorLogFile, "a")
    if file then
        file:write(errorString .. "\n")
        file:close()
    else
	
    end
end

function file_module.fileExists(filename)
--[[
��������
    file_module.fileExists - ������� ��� �������� ������������� �����.

��������
    ������ ������� ���������, ���������� �� ���� � ��������� ������.

���������
    filename (string) - ��� �����, ��� �������� ����� ��������� �������������.

������������ ��������
    boolean - ���������� true, ���� ���� ����������, � false � ��������� ������.
]]
    local success, file = pcall(io.open, filename, "r")
    if success then
        if file then
            file:close()
            return true
        else
            return false
        end
    else
        logError("������ ��� �������� ������������� �����: " .. file)
        return false
    end
end

function file_module.createFile(filename, content)
--[[
��������
    file_module.createFile - ������� ��� �������� �����.

��������
    ������ ������� ������� ���� � ��������� ������.

���������
    filename (string) - ��� �����, ������� ����� �������.
    content (string) - ���������� �����.

������������ ��������
    boolean - ���������� true, ���� ���� ������� ������, � false � ��������� ������.
]]
    local success, file = pcall(io.open, filename, "w")
    if success then
        if file then
            file_module.writeFile(filename, content)
            file:close()
            return true
        else
            logError("������ ��� �������� �����: " .. filename)
            return false
        end
    else
        logError("������ ��� �������� �����: " .. file)
        return false
    end
end

function file_module.readFile(filename)
--[[
��������
    file_module.readFile - ������� ��� ������ ����������� �����.

��������
    ������ ������� ��������� ���������� ����� � ��������� ������.

���������
    filename (string) - ��� �����, ���������� �������� ����� �������.

������������ ��������
    string - ���������� ����� � ���� ������. ���� ���� �� ������, ������������ nil.
]]
    local success, file = pcall(io.open, filename, "r")
    if success then
        if file then
            local content = file:read("*a")
            file:close()
            return content
        else
            logError("������ ��� ������ �����: " .. filename)
            return nil
        end
    else
        logError("������ ��� ������ �����: " .. file)
        return nil
    end
end

function file_module.writeFile(filename, content)
--[[
��������
    file_module.writeFile - ������� ��� ������ ����������� � ����.

��������
    ������ ������� ���������� ��������� ���������� � ���� � ��������� ������.
    ���� ���� �� ����������, �� ����� ������.

���������
    filename (string) - ��� �����, � ������� ����� �������� ����������.
    content (string) - ����������, ������� ����� �������� � ����.

������������ ��������
    boolean - true, ���� ������ � ���� ������ �������, false - � ��������� ������.
]]
    local success, file = pcall(io.open, filename, "w")
    if success then
        if file then
            file:write(content)
            file:close()
            return true
        else
            logError("������ ��� ������ � ����: " .. filename)
            return false
        end
    else
        logError("������ ��� ������ � ����: " .. file)
        return false
    end
end

function file_module.copyFile(source, destination)
--[[
��������
    file_module.copyFile - ������� ��� ����������� ����������� �����.

��������
    ������ ������� �������� ���������� ����� �� ������ ����� � ������.

���������
    source (string) - ���� � ��������� �����.
    destination (string) - ���� � �����-����������.

������������ ��������
    boolean - ���������� true, ���� ����������� ������ �������, � false � ��������� ������.
]]
    local success, content = pcall(file_module.readFile, source)
    if success then
        if content then
            return pcall(file_module.writeFile, destination, content)
        else
            return false
        end
    else
        logError("������ ��� ����������� �����: " .. content)
        return false
    end
end

function file_module.deleteFile(filename)
--[[
��������
    file_module.deleteFile - ������� ��� �������� �����.

��������
    ������ ������� ������� ���� � ��������� ������.

���������
    filename (string) - ��� �����, ������� ����� �������.

������������ ��������
    boolean - ���������� true, ���� ���� ������� ������, � false � ��������� ������.
]]
    local success, result = pcall(os.remove, filename)
    if success then
        return result
    else
        logError("������ ��� �������� �����: " .. result)
        return false
    end
end

function file_module.renameFile(oldName, newName)
--[[
��������
    file_module.renameFile - ������� ��� �������������� �����.

��������
    ������ ������� �������� ��� ����� � ��������� oldName �� newName.

���������
    oldName (string) - ������� ��� �����.
    newName (string) - ����� ��� �����.

������������ ��������
    boolean - ���������� true, ���� �������������� ������ �������, � false � ��������� ������.
]]
    local success, result = pcall(os.rename, oldName, newName)
    if success then
        return result
    else
        logError("������ ��� �������������� �����: " .. result)
        return false
    end
end

function file_module.getFilesInDirectory(directory)
--[[
��������
    file_module.getFilesInDirectory - ������� ��� ��������� ������ ������ � ����������.

��������
    ������ ������� ���������� ������ � ������� ������ � ��������� ����������.

���������
    directory (string) - ���� � ����������.

������������ ��������
    table - ������ ����� � ������� ������ � ����������.
]]
    local success, files = pcall(function()
        local files = {}
        for file in io.popen('dir "'..directory..'" /b'):lines() do
            table.insert(files, file)
        end
        return files
    end)

    if success then
        return files
    else
        logError("������ ��� ��������� ������ ������ � ����������: " .. files)
        return nil
    end
end

function file_module.appendToFile(filename, content)
--[[
��������
    file_module.appendToFile - ������� ��� ���������� ������ � ����� �����.

��������
    ������ ������� ��������� ��������� ���������� � ����� ����� � ��������� ������.
    ���� ���� �� ����������, �� ����� ������.

���������
    filename (string) - ��� �����, � ������� ����� �������� ����������.
    content (string) - ����������, ������� ����� �������� � ����.

������������ ��������
    boolean - true, ���� ���������� � ���� ������ �������, false - � ��������� ������.
]]
    local success, result = pcall(function()
        local file = io.open(filename, "a")
        if file then
            file:write(content)
            file:close()
            return true
        else
            return false
        end
    end)

    if success then
        return result
    else
        logError("������ ��� ���������� ������ � ����: " .. result)
        return false
    end
end

function file_module.readLinesFromFile(filename)
--[[
��������
    file_module.readLinesFromFile - ������� ��� ������ ����� ���������.

��������
    ������ ������� ��������� ���������� ����� � ��������� ������ � ���������� ������ �����.

���������
    filename (string) - ��� �����, ���������� �������� ����� �������.

������������ ��������
    table - ������ �����, �������������� ����� ���������� �����. ���� ���� �� ������, ������������ nil.
]]
    local success, lines = pcall(function()
        local file = io.open(filename, "r")
        if file then
            local lines = {}
            for line in file:lines() do
                table.insert(lines, line)
            end
            file:close()
            return lines
        else
            return nil
        end
    end)

    if success then
        return lines
    else
        logError("������ ��� ������ ����� ���������: " .. lines)
        return nil
    end
end

function file_module.createTempFile(content)
--[[
��������
    file_module.createTempFile - ������� ��� �������� ���������� �����.

��������
    ������ ������� ������� ��������� ����, ���������� � ���� ��������� ���������� � ���������� ��� ���.

���������
    content (string) - ���������� ���������� �����.

������������ ��������
    string - ��� ���������� ���������� �����.
]]
    local success, temp_filename = pcall(function()
        local temp_filename = os.tmpname()
        file_module.writeFile(temp_filename, content)
        return temp_filename
    end)

    if success then
        return temp_filename
    else
        logError("������ ��� �������� ���������� �����: " .. temp_filename)
        return nil
    end
end

function file_module.directoryExists(directory)
--[[
��������
    file_module.directoryExists - ������� ��� �������� ������������� ����������.

��������
    ������ ������� ���������, ���������� �� ���������� � ��������� ������.

���������
    directory (string) - ��� ����������, ��� ������� ����� ��������� �������������.

������������ ��������
    boolean - ���������� true, ���� ���������� ����������, � false � ��������� ������.
]]
    local dummy_file = directory .. "/.dummy_file_for_directory_existence_check"
    local file = io.open(dummy_file, "w")

    if file then
        file:close()
        os.remove(dummy_file)
        return true
    else
        return false
    end
end

function file_module.createDirectory(directory)
--[[
��������
    file_module.createDirectory - ������� ��� �������� ����������. 

��������
    ������ ������� ������� ���������� � ��������� ������.

���������
    directory (string) - ��� ����������, ������� ����� �������.

������������ ��������
    boolean - ���������� true, ���� ���������� ������� �������, � false � ��������� ������.
]]
    local success, result = pcall(function()
        return os.execute('mkdir "'..directory..'"') == 0
    end)

    if success then
        return result
    else
        logError("������ ��� �������� ����������: " .. result)
        return false
    end
end

function file_module.getCurrentDirectory()
--[[
��������
    file_module.getCurrentDirectory - ������� ��� ��������� ������� ����������.

��������
    ������ ������� ���������� ���� � ������� ����������.

������������ ��������
    string - ���� � ������� ����������.
]]
    local handle = io.popen('cd')
    local current_directory = handle:read('*a'):gsub('\n', '')
    handle:close()
    return current_directory
	
end



return file_module