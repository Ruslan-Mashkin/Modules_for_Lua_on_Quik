-- Файл: file_module.lua
-- require('lfs')
local file_module = {}

--[[
СПИСОК ФУНКЦИЙ МОДУЛЯ:
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

-- Функция для записи ошибок в файл
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
НАЗВАНИЕ
    file_module.fileExists - функция для проверки существования файла.

ОПИСАНИЕ
    Данная функция проверяет, существует ли файл с указанным именем.

ПАРАМЕТРЫ
    filename (string) - имя файла, для которого нужно проверить существование.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если файл существует, и false в противном случае.
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
        logError("Ошибка при проверке существования файла: " .. file)
        return false
    end
end

function file_module.createFile(filename, content)
--[[
НАЗВАНИЕ
    file_module.createFile - функция для создания файла.

ОПИСАНИЕ
    Данная функция создает файл с указанным именем.

ПАРАМЕТРЫ
    filename (string) - имя файла, который нужно создать.
    content (string) - содержимое файла.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если файл успешно создан, и false в противном случае.
]]
    local success, file = pcall(io.open, filename, "w")
    if success then
        if file then
            file_module.writeFile(filename, content)
            file:close()
            return true
        else
            logError("Ошибка при создании файла: " .. filename)
            return false
        end
    else
        logError("Ошибка при создании файла: " .. file)
        return false
    end
end

function file_module.readFile(filename)
--[[
НАЗВАНИЕ
    file_module.readFile - функция для чтения содержимого файла.

ОПИСАНИЕ
    Данная функция считывает содержимое файла с указанным именем.

ПАРАМЕТРЫ
    filename (string) - имя файла, содержимое которого нужно считать.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    string - Содержимое файла в виде строки. Если файл не найден, возвращается nil.
]]
    local success, file = pcall(io.open, filename, "r")
    if success then
        if file then
            local content = file:read("*a")
            file:close()
            return content
        else
            logError("Ошибка при чтении файла: " .. filename)
            return nil
        end
    else
        logError("Ошибка при чтении файла: " .. file)
        return nil
    end
end

function file_module.writeFile(filename, content)
--[[
НАЗВАНИЕ
    file_module.writeFile - функция для записи содержимого в файл.

ОПИСАНИЕ
    Данная функция записывает указанное содержимое в файл с указанным именем.
    Если файл не существует, он будет создан.

ПАРАМЕТРЫ
    filename (string) - имя файла, в который нужно записать содержимое.
    content (string) - содержимое, которое нужно записать в файл.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - true, если запись в файл прошла успешно, false - в противном случае.
]]
    local success, file = pcall(io.open, filename, "w")
    if success then
        if file then
            file:write(content)
            file:close()
            return true
        else
            logError("Ошибка при записи в файл: " .. filename)
            return false
        end
    else
        logError("Ошибка при записи в файл: " .. file)
        return false
    end
end

function file_module.copyFile(source, destination)
--[[
НАЗВАНИЕ
    file_module.copyFile - функция для копирования содержимого файла.

ОПИСАНИЕ
    Данная функция копирует содержимое файла из одного места в другое.

ПАРАМЕТРЫ
    source (string) - путь к исходному файлу.
    destination (string) - путь к файлу-назначению.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если копирование прошло успешно, и false в противном случае.
]]
    local success, content = pcall(file_module.readFile, source)
    if success then
        if content then
            return pcall(file_module.writeFile, destination, content)
        else
            return false
        end
    else
        logError("Ошибка при копировании файла: " .. content)
        return false
    end
end

function file_module.deleteFile(filename)
--[[
НАЗВАНИЕ
    file_module.deleteFile - функция для удаления файла.

ОПИСАНИЕ
    Данная функция удаляет файл с указанным именем.

ПАРАМЕТРЫ
    filename (string) - имя файла, который нужно удалить.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если файл успешно удален, и false в противном случае.
]]
    local success, result = pcall(os.remove, filename)
    if success then
        return result
    else
        logError("Ошибка при удалении файла: " .. result)
        return false
    end
end

function file_module.renameFile(oldName, newName)
--[[
НАЗВАНИЕ
    file_module.renameFile - функция для переименования файла.

ОПИСАНИЕ
    Данная функция изменяет имя файла с указанным oldName на newName.

ПАРАМЕТРЫ
    oldName (string) - текущее имя файла.
    newName (string) - новое имя файла.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если переименование прошло успешно, и false в противном случае.
]]
    local success, result = pcall(os.rename, oldName, newName)
    if success then
        return result
    else
        logError("Ошибка при переименовании файла: " .. result)
        return false
    end
end

function file_module.getFilesInDirectory(directory)
--[[
НАЗВАНИЕ
    file_module.getFilesInDirectory - функция для получения списка файлов в директории.

ОПИСАНИЕ
    Данная функция возвращает массив с именами файлов в указанной директории.

ПАРАМЕТРЫ
    directory (string) - путь к директории.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    table - Массив строк с именами файлов в директории.
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
        logError("Ошибка при получении списка файлов в директории: " .. files)
        return nil
    end
end

function file_module.appendToFile(filename, content)
--[[
НАЗВАНИЕ
    file_module.appendToFile - функция для добавления данных в конец файла.

ОПИСАНИЕ
    Данная функция добавляет указанное содержимое в конец файла с указанным именем.
    Если файл не существует, он будет создан.

ПАРАМЕТРЫ
    filename (string) - имя файла, в который нужно добавить содержимое.
    content (string) - содержимое, которое нужно добавить в файл.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - true, если добавление в файл прошло успешно, false - в противном случае.
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
        logError("Ошибка при добавлении данных в файл: " .. result)
        return false
    end
end

function file_module.readLinesFromFile(filename)
--[[
НАЗВАНИЕ
    file_module.readLinesFromFile - функция для чтения файла построчно.

ОПИСАНИЕ
    Данная функция считывает содержимое файла с указанным именем и возвращает массив строк.

ПАРАМЕТРЫ
    filename (string) - имя файла, содержимое которого нужно считать.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    table - Массив строк, представляющих собой содержимое файла. Если файл не найден, возвращается nil.
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
        logError("Ошибка при чтении файла построчно: " .. lines)
        return nil
    end
end

function file_module.createTempFile(content)
--[[
НАЗВАНИЕ
    file_module.createTempFile - функция для создания временного файла.

ОПИСАНИЕ
    Данная функция создает временный файл, записывает в него указанное содержимое и возвращает его имя.

ПАРАМЕТРЫ
    content (string) - содержимое временного файла.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    string - Имя созданного временного файла.
]]
    local success, temp_filename = pcall(function()
        local temp_filename = os.tmpname()
        file_module.writeFile(temp_filename, content)
        return temp_filename
    end)

    if success then
        return temp_filename
    else
        logError("Ошибка при создании временного файла: " .. temp_filename)
        return nil
    end
end

function file_module.directoryExists(directory)
--[[
НАЗВАНИЕ
    file_module.directoryExists - функция для проверки существования директории.

ОПИСАНИЕ
    Данная функция проверяет, существует ли директория с указанным именем.

ПАРАМЕТРЫ
    directory (string) - имя директории, для которой нужно проверить существование.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если директория существует, и false в противном случае.
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
НАЗВАНИЕ
    file_module.createDirectory - функция для создания директории. 

ОПИСАНИЕ
    Данная функция создает директорию с указанным именем.

ПАРАМЕТРЫ
    directory (string) - имя директории, которую нужно создать.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если директория успешно создана, и false в противном случае.
]]
    local success, result = pcall(function()
        return os.execute('mkdir "'..directory..'"') == 0
    end)

    if success then
        return result
    else
        logError("Ошибка при создании директории: " .. result)
        return false
    end
end

function file_module.getCurrentDirectory()
--[[
НАЗВАНИЕ
    file_module.getCurrentDirectory - функция для получения текущей директории.

ОПИСАНИЕ
    Данная функция возвращает путь к текущей директории.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    string - Путь к текущей директории.
]]
    local handle = io.popen('cd')
    local current_directory = handle:read('*a'):gsub('\n', '')
    handle:close()
    return current_directory
	
end



return file_module