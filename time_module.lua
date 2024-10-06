-- time_module.lua

-- ������ ��� ������ � �������� � ������

--[[
������ ������� ������ ��� ������ � �������� � ������:

- DateTimeModule.getCurrentDate() ���������� ������� ���� � ������� "��-��-����".

- DateTimeModule.getCurrentTime() ���������� ������� ����� � ������� "��:��:��".

- DateTimeModule.getCurrentMinute() ���������� ������� ������ � �������� �������.

- DateTimeModule.getCurrentSecond() ���������� ������� ������� � �������� �������.

- DateTimeModule.getCurrentHour() ���������� ������� ��� � �������� �������.

- DateTimeModule.getCurrentDay() ���������� ������� ���� ������ � �������� �������.

- DateTimeModule.getCurrentMonth() ���������� ������� ����� � �������� �������.

- DateTimeModule.getCurrentYear() ���������� ������� ��� � �������� �������.

- DateTimeModule.getCurrentTimeCompact() ���������� ������� ����� � ������� "������" 
	� �������� ������ ��� ����� � ������, ���� ��� ������ 10.

- DateTimeModule.TimeConvertToNumber(hh, mm, ss) ����������� ���������� ���� (hh), ������ (mm) � ������� (ss) 
	� �������� �������� � ������� "������".

- DateTimeModule.getCurrentWeekdayNumber() ���������� ������� ���� ������ � �������� ������� 
	(1 - �����������, 2 - �������, � ��� �����).

- DateTimeModule.getCurrentDateCompact() ���������� ������� ���� � ������� "��������" � �������� 
	������ ��� ������ � ���, ���� ��� ������ 10.

- DateTimeModule.DateConvertToNumber(year, month, day) ����������� ���������� ���, ����� � ���� � �������� �������� � ������� "��������".

- DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)  ��������� ������� � ���� ����� ����� ������.

- DateTimeModule.isWorkTime(start_time, finish_time) ������ ������� ���������, ������� �� ������ �����
]]

-- ������ ��� ������ � �������� � ������

-- ������� ������� ��� ������
local DateTimeModule = {}

function DateTimeModule.getCurrentDate()
    --[[
    ��������
        getCurrentDate

    ��������
        ���������� ������� ���� � ������� "��-��-����".

    ���������
        ��� ����������.

    ������������ ��������
        string: ������� ���� � ������� "��-��-����".
    ]]
    local currentDate = os.date("%d-%m-%Y")
    return currentDate
end

function DateTimeModule.getCurrentTime()
    --[[
    ��������
        getCurrentTime

    ��������
        ���������� ������� ����� � ������� "��:��:��".

    ���������
        ��� ����������.

    ������������ ��������
        string: ������� ����� � ������� "��:��:��".
    ]]
    local currentTime = os.date("%H:%M:%S")
    return currentTime
end

function DateTimeModule.getCurrentMinute()
    --[[
    ��������
        getCurrentMinute

    ��������
        ���������� ������� ������ � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ������.
    ]]
    local currentMinute = tonumber(os.date("%M"))
    return currentMinute
end

function DateTimeModule.getCurrentSecond()
    --[[
    ��������
        getCurrentSecond

    ��������
        ���������� ������� ������� � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� �������.
    ]]
    local currentSecond = tonumber(os.date("%S"))
    return currentSecond
end

function DateTimeModule.getCurrentHour()
    --[[
    ��������
        getCurrentHour

    ��������
        ���������� ������� ��� � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ���.
    ]]
    local currentHour = tonumber(os.date("%H"))
    return currentHour
end

function DateTimeModule.getCurrentDay()
    --[[
    ��������
        getCurrentDay

    ��������
        ���������� ������� ���� ������ � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ���� ������.
    ]]
    local currentDay = tonumber(os.date("%d"))
    return currentDay
end

function DateTimeModule.getCurrentMonth()
    --[[
    ��������
        getCurrentMonth

    ��������
        ���������� ������� ����� � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� �����.
    ]]
    local currentMonth = tonumber(os.date("%m"))
    return currentMonth
end

function DateTimeModule.getCurrentYear()
    --[[
    ��������
        getCurrentYear

    ��������
        ���������� ������� ��� � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ���.
    ]]
    local currentYear = tonumber(os.date("%Y"))
    return currentYear
end

function DateTimeModule.getCurrentTimeCompact()
    --[[
    ��������
        getCurrentTimeCompact

    ��������
        ���������� ������� ����� � ������� "������" � �������� ������ ��� ����� � ������, ���� ��� ������ 10.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ����� � ������� ������.
    ]]
    local currentHour = string.format("%02d", DateTimeModule.getCurrentHour())
    local currentMinute = string.format("%02d", DateTimeModule.getCurrentMinute())
    local currentSecond = string.format("%02d", DateTimeModule.getCurrentSecond())

    return tonumber(currentHour .. currentMinute .. currentSecond)
end

function DateTimeModule.TimeConvertToNumber(hh, mm, ss)
    --[[
    ��������
        TimeConvertToNumber

    ��������
        ����������� ���������� ����, ������ � ������� � �������� �������� � ������� "������".

    ���������
        number hh: ���� �� 0 �� 23.
        number mm: ������ �� 0 �� 59.
        number ss: ������� �� 0 �� 59.

    ������������ ��������
        number: �������� �������� ������� � ������� ������.
    ]]
    -- ��������� ��������� ��������
    if hh < 0 or hh > 23 or mm < 0 or mm > 59 or ss < 0 or ss > 59 then
        error("������������ �������� �����, ����� ��� ������.")
    end

    -- ����������� �������� � �������� ������
    local formattedHH = string.format("%02d", hh)
    local formattedMM = string.format("%02d", mm)
    local formattedSS = string.format("%02d", ss)

    -- ���������� �������� � ������� hhmmss
    local timeNumber = tonumber(formattedHH .. formattedMM .. formattedSS)

    return timeNumber
end

function DateTimeModule.getCurrentWeekdayNumber()
    --[[
    ��������
        getCurrentWeekdayNumber

    ��������
        ���������� ������� ���� ������ � �������� �������.

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ���� ������ � �������� ������� (1 - �����������, 2 - �������, � ��� �����).
    ]]
    local currentWeekday = tonumber(os.date("%w"))

    -- � Lua ��������� ���� ������ ���������� � ����������� (0), ������� ������� 1
    currentWeekday = (currentWeekday + 6) % 7 + 1

    return currentWeekday
end

function DateTimeModule.getCurrentDateCompact()
    --[[
    ��������
        getCurrentDateCompact

    ��������
        ���������� ������� ���� � �������� ������� "��������".

    ���������
        ��� ����������.

    ������������ ��������
        number: ������� ���� � �������� ������� "��������".
    ]]
    local currentYear = DateTimeModule.getCurrentYear()
    local currentMonth = string.format("%02d", DateTimeModule.getCurrentMonth())
    local currentDay = string.format("%02d", DateTimeModule.getCurrentDay())

    return tonumber(currentYear .. currentMonth .. currentDay)
end

function DateTimeModule.DateConvertToNumber(year, month, day)
    --[[
    ��������
        DateConvertToNumber

    ��������
        ����������� ���������� ���, ����� � ���� � �������� �������� � ������� "��������".

    ���������
        number year: ���.
        number month: ����� �� 1 �� 12.
        number day: ���� ������ �� 1 �� 31.

    ������������ ��������
        number: �������� �������� ���� � ������� "��������".
    ]]
    -- ��������� ��������� ��������
    if year < 0 or month < 1 or month > 12 or day < 1 or day > 31 then
        error("������������ �������� ����, ������ ��� ���.")
    end

    -- ����������� �������� � �������� ������
    local formattedYear = string.format("%04d", year)
    local formattedMonth = string.format("%02d", month)
    local formattedDay = string.format("%02d", day)

    -- ���������� �������� � ������� ��������
    local dateNumber = tonumber(formattedYear .. formattedMonth .. formattedDay)

    return dateNumber
end

function DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)
    --[[
    ��������
        calculateDateDifference

    ��������
        ��������� ������� � ���� ����� ����� ������.

    ���������
        number year1: ��� ������ ����.
        number month1: ����� ������ ���� �� 1 �� 12.
        number day1: ���� ������ ���� �� 1 �� 31.

        number year2: ��� ������ ����.
        number month2: ����� ������ ���� �� 1 �� 12.
        number day2: ���� ������ ���� �� 1 �� 31.

    ������������ ��������
        number: ������� � ���� ����� ����� ������.
    ]]
    -- ��������� ��������� ��������
    if year1 < 0 or month1 < 1 or month1 > 12 or day1 < 1 or day1 > 31 or
       year2 < 0 or month2 < 1 or month2 > 12 or day2 < 1 or day2 > 31 then
        error("������������ �������� ����, ������ ��� ���.")
    end

    local date1 = os.time({year = year1, month = month1, day = day1})
    local date2 = os.time({year = year2, month = month2, day = day2})

    local dateDifferenceInSeconds = math.abs(date2 - date1)
    
    -- ���
    local daysDifference = math.floor(dateDifferenceInSeconds / (60 * 60 * 24))

    return daysDifference
end

function DateTimeModule.isWorkTime(start_time, finish_time)
--[[
��������
    isWorkTime

��������
    ������ ������� ���������, ������� �� ������ �����

���������
    start_time - number. ����� ������ �������� ��� � ������� ������.
    finish_time - number. ����� ��������� �������� ��� � ������� ������.

������������ ��������
    boolean - ���������� true, ���� ����� �������, � false � ��������� ������.
]]
    local now_time = DateTimeModule.getCurrentTimeCompact()
    if now_time > start_time and now_time < finish_time then
        return true
    else
        return false
    end
end

-- ���������� ������� ������
return DateTimeModule
