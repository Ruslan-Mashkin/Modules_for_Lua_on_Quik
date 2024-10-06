-- telegram_module.lua

--[[ Модуль telegram_module предоставляет функционал для отправки сообщений в Telegram.
     Для отправки сообщений используется внешняя программа sender.exe 
]]--

local M = {}  -- Создание таблицы M для экспорта функций модуля

function M.sendTelegramMessage(API_Key, Chat_ID, m_message)
--[[ Функция M.sendTelegramMessage(API_Key, Chat_ID, m_message)
     Описание: Отправляет сообщение в Telegram.
     Аргументы:
         - API_Key: строка, ключ API Telegram.
         - Chat_ID: строка, идентификатор чата Telegram.
         - m_message: строка, текст сообщения.
     Возвращаемое значение: Отсутствует. 
]]

    -- Формирование команды для запуска внешней программы telegram_sender.exe
    local program_file = "sender.exe "
    local mess = "\"" .. m_message .. "\""
    local command = program_file .. API_Key .. " " .. Chat_ID .. " " .. mess
    -- Запуск команды для отправки сообщения
    os.execute(tostring(command))
	-- message("Телеграм модуль дошел до сюдова. ")
	-- message(m_message)
	
end

function M.getPathFromFullPath(fullPath)
--[[ Функция M.getPathFromFullPath(fullPath)
     Описание: Возвращает путь к папке из полного пути к файлу.
     Аргументы:
         - fullPath: строка, полный путь к файлу.
     Возвращаемое значение: Строка с папкой из полного пути к файлу.
]]

    local path = string.match(fullPath, "(.-)([^\\/]-([^%.\\/]*))$")
    return path
end

return M  -- Экспорт таблицы M с функциями модуля
