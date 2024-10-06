-- telegram_module.lua

--[[ ������ telegram_module ������������� ���������� ��� �������� ��������� � Telegram.
     ��� �������� ��������� ������������ ������� ��������� sender.exe 
]]--

local M = {}  -- �������� ������� M ��� �������� ������� ������

function M.sendTelegramMessage(API_Key, Chat_ID, m_message)
--[[ ������� M.sendTelegramMessage(API_Key, Chat_ID, m_message)
     ��������: ���������� ��������� � Telegram.
     ���������:
         - API_Key: ������, ���� API Telegram.
         - Chat_ID: ������, ������������� ���� Telegram.
         - m_message: ������, ����� ���������.
     ������������ ��������: �����������. 
]]

    -- ������������ ������� ��� ������� ������� ��������� telegram_sender.exe
    local program_file = "sender.exe "
    local mess = "\"" .. m_message .. "\""
    local command = program_file .. API_Key .. " " .. Chat_ID .. " " .. mess
    -- ������ ������� ��� �������� ���������
    os.execute(tostring(command))
	-- message("�������� ������ ����� �� ������. ")
	-- message(m_message)
	
end

function M.getPathFromFullPath(fullPath)
--[[ ������� M.getPathFromFullPath(fullPath)
     ��������: ���������� ���� � ����� �� ������� ���� � �����.
     ���������:
         - fullPath: ������, ������ ���� � �����.
     ������������ ��������: ������ � ������ �� ������� ���� � �����.
]]

    local path = string.match(fullPath, "(.-)([^\\/]-([^%.\\/]*))$")
    return path
end

return M  -- ������� ������� M � ��������� ������
