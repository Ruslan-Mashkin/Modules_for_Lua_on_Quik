-- time_module.lua

-- Модуль для работы с временем и датами

--[[
СПИСОК ФУНКЦИЙ МОДУЛЯ ДЛЯ РАБОТЫ С ВРЕМЕНЕМ И ДАТАМИ:

- DateTimeModule.getCurrentDate() Возвращает текущую дату в формате "ДД-ММ-ГГГГ".

- DateTimeModule.getCurrentTime() Возвращает текущее время в формате "ЧЧ:ММ:СС".

- DateTimeModule.getCurrentMinute() Возвращает текущую минуту в числовом формате.

- DateTimeModule.getCurrentSecond() Возвращает текущую секунду в числовом формате.

- DateTimeModule.getCurrentHour() Возвращает текущий час в числовом формате.

- DateTimeModule.getCurrentDay() Возвращает текущий день месяца в числовом формате.

- DateTimeModule.getCurrentMonth() Возвращает текущий месяц в числовом формате.

- DateTimeModule.getCurrentYear() Возвращает текущий год в числовом формате.

- DateTimeModule.getCurrentTimeCompact() Возвращает текущее время в формате "ЧЧММСС" 
	с ведущими нулями для минут и секунд, если они меньше 10.

- DateTimeModule.TimeConvertToNumber(hh, mm, ss) Преобразует переданные часы (hh), минуты (mm) и секунды (ss) 
	в числовое значение в формате "ЧЧММСС".

- DateTimeModule.getCurrentWeekdayNumber() Возвращает текущий день недели в числовом формате 
	(1 - понедельник, 2 - вторник, и так далее).

- DateTimeModule.getCurrentDateCompact() Возвращает текущую дату в формате "ГГГГММДД" с ведущими 
	нулями для месяца и дня, если они меньше 10.

- DateTimeModule.DateConvertToNumber(year, month, day) Преобразует переданные год, месяц и день в числовое значение в формате "ГГГГММДД".

- DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)  Вычисляет разницу в днях между двумя датами.

- DateTimeModule.isWorkTime(start_time, finish_time) Данная функция проверяет, рабочее ли сейчас время
]]

-- Модуль для работы с временем и датами

-- Создаем таблицу для модуля
local DateTimeModule = {}

function DateTimeModule.getCurrentDate()
    --[[
    НАЗВАНИЕ
        getCurrentDate

    ОПИСАНИЕ
        Возвращает текущую дату в формате "ДД-ММ-ГГГГ".

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        string: Текущая дата в формате "ДД-ММ-ГГГГ".
    ]]
    local currentDate = os.date("%d-%m-%Y")
    return currentDate
end

function DateTimeModule.getCurrentTime()
    --[[
    НАЗВАНИЕ
        getCurrentTime

    ОПИСАНИЕ
        Возвращает текущее время в формате "ЧЧ:ММ:СС".

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        string: Текущее время в формате "ЧЧ:ММ:СС".
    ]]
    local currentTime = os.date("%H:%M:%S")
    return currentTime
end

function DateTimeModule.getCurrentMinute()
    --[[
    НАЗВАНИЕ
        getCurrentMinute

    ОПИСАНИЕ
        Возвращает текущую минуту в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущая минута.
    ]]
    local currentMinute = tonumber(os.date("%M"))
    return currentMinute
end

function DateTimeModule.getCurrentSecond()
    --[[
    НАЗВАНИЕ
        getCurrentSecond

    ОПИСАНИЕ
        Возвращает текущую секунду в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущая секунда.
    ]]
    local currentSecond = tonumber(os.date("%S"))
    return currentSecond
end

function DateTimeModule.getCurrentHour()
    --[[
    НАЗВАНИЕ
        getCurrentHour

    ОПИСАНИЕ
        Возвращает текущий час в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущий час.
    ]]
    local currentHour = tonumber(os.date("%H"))
    return currentHour
end

function DateTimeModule.getCurrentDay()
    --[[
    НАЗВАНИЕ
        getCurrentDay

    ОПИСАНИЕ
        Возвращает текущий день месяца в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущий день месяца.
    ]]
    local currentDay = tonumber(os.date("%d"))
    return currentDay
end

function DateTimeModule.getCurrentMonth()
    --[[
    НАЗВАНИЕ
        getCurrentMonth

    ОПИСАНИЕ
        Возвращает текущий месяц в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущий месяц.
    ]]
    local currentMonth = tonumber(os.date("%m"))
    return currentMonth
end

function DateTimeModule.getCurrentYear()
    --[[
    НАЗВАНИЕ
        getCurrentYear

    ОПИСАНИЕ
        Возвращает текущий год в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущий год.
    ]]
    local currentYear = tonumber(os.date("%Y"))
    return currentYear
end

function DateTimeModule.getCurrentTimeCompact()
    --[[
    НАЗВАНИЕ
        getCurrentTimeCompact

    ОПИСАНИЕ
        Возвращает текущее время в формате "ЧЧММСС" с ведущими нулями для минут и секунд, если они меньше 10.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущее время в формате ЧЧММСС.
    ]]
    local currentHour = string.format("%02d", DateTimeModule.getCurrentHour())
    local currentMinute = string.format("%02d", DateTimeModule.getCurrentMinute())
    local currentSecond = string.format("%02d", DateTimeModule.getCurrentSecond())

    return tonumber(currentHour .. currentMinute .. currentSecond)
end

function DateTimeModule.TimeConvertToNumber(hh, mm, ss)
    --[[
    НАЗВАНИЕ
        TimeConvertToNumber

    ОПИСАНИЕ
        Преобразует переданные часы, минуты и секунды в числовое значение в формате "ЧЧММСС".

    ПАРАМЕТРЫ
        number hh: Часы от 0 до 23.
        number mm: Минуты от 0 до 59.
        number ss: Секунды от 0 до 59.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Числовое значение времени в формате ЧЧММСС.
    ]]
    -- Проверяем диапазоны значений
    if hh < 0 or hh > 23 or mm < 0 or mm > 59 or ss < 0 or ss > 59 then
        error("Некорректные значения часов, минут или секунд.")
    end

    -- Форматируем значения с ведущими нулями
    local formattedHH = string.format("%02d", hh)
    local formattedMM = string.format("%02d", mm)
    local formattedSS = string.format("%02d", ss)

    -- Складываем значения в формате hhmmss
    local timeNumber = tonumber(formattedHH .. formattedMM .. formattedSS)

    return timeNumber
end

function DateTimeModule.getCurrentWeekdayNumber()
    --[[
    НАЗВАНИЕ
        getCurrentWeekdayNumber

    ОПИСАНИЕ
        Возвращает текущий день недели в числовом формате.

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущий день недели в числовом формате (1 - понедельник, 2 - вторник, и так далее).
    ]]
    local currentWeekday = tonumber(os.date("%w"))

    -- В Lua номерация дней недели начинается с воскресенья (0), поэтому добавим 1
    currentWeekday = (currentWeekday + 6) % 7 + 1

    return currentWeekday
end

function DateTimeModule.getCurrentDateCompact()
    --[[
    НАЗВАНИЕ
        getCurrentDateCompact

    ОПИСАНИЕ
        Возвращает текущую дату в числовом формате "ГГГГММДД".

    ПАРАМЕТРЫ
        Нет параметров.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Текущая дата в числовом формате "ГГГГММДД".
    ]]
    local currentYear = DateTimeModule.getCurrentYear()
    local currentMonth = string.format("%02d", DateTimeModule.getCurrentMonth())
    local currentDay = string.format("%02d", DateTimeModule.getCurrentDay())

    return tonumber(currentYear .. currentMonth .. currentDay)
end

function DateTimeModule.DateConvertToNumber(year, month, day)
    --[[
    НАЗВАНИЕ
        DateConvertToNumber

    ОПИСАНИЕ
        Преобразует переданные год, месяц и день в числовое значение в формате "ГГГГММДД".

    ПАРАМЕТРЫ
        number year: Год.
        number month: Месяц от 1 до 12.
        number day: День месяца от 1 до 31.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Числовое значение даты в формате "ГГГГММДД".
    ]]
    -- Проверяем диапазоны значений
    if year < 0 or month < 1 or month > 12 or day < 1 or day > 31 then
        error("Некорректные значения года, месяца или дня.")
    end

    -- Форматируем значения с ведущими нулями
    local formattedYear = string.format("%04d", year)
    local formattedMonth = string.format("%02d", month)
    local formattedDay = string.format("%02d", day)

    -- Складываем значения в формате ГГГГММДД
    local dateNumber = tonumber(formattedYear .. formattedMonth .. formattedDay)

    return dateNumber
end

function DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)
    --[[
    НАЗВАНИЕ
        calculateDateDifference

    ОПИСАНИЕ
        Вычисляет разницу в днях между двумя датами.

    ПАРАМЕТРЫ
        number year1: Год первой даты.
        number month1: Месяц первой даты от 1 до 12.
        number day1: День первой даты от 1 до 31.

        number year2: Год второй даты.
        number month2: Месяц второй даты от 1 до 12.
        number day2: День второй даты от 1 до 31.

    ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
        number: Разница в днях между двумя датами.
    ]]
    -- Проверяем диапазоны значений
    if year1 < 0 or month1 < 1 or month1 > 12 or day1 < 1 or day1 > 31 or
       year2 < 0 or month2 < 1 or month2 > 12 or day2 < 1 or day2 > 31 then
        error("Некорректные значения года, месяца или дня.")
    end

    local date1 = os.time({year = year1, month = month1, day = day1})
    local date2 = os.time({year = year2, month = month2, day = day2})

    local dateDifferenceInSeconds = math.abs(date2 - date1)
    
    -- Дни
    local daysDifference = math.floor(dateDifferenceInSeconds / (60 * 60 * 24))

    return daysDifference
end

function DateTimeModule.isWorkTime(start_time, finish_time)
--[[
НАЗВАНИЕ
    isWorkTime

ОПИСАНИЕ
    Данная функция проверяет, рабочее ли сейчас время

ПАРАМЕТРЫ
    start_time - number. Время начала рабочего дня в формате ЧЧММСС.
    finish_time - number. Время окончания рабочего дня в формате ЧЧММСС.

ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
    boolean - Возвращает true, если время рабочее, и false в противном случае.
]]
    local now_time = DateTimeModule.getCurrentTimeCompact()
    if now_time > start_time and now_time < finish_time then
        return true
    else
        return false
    end
end

-- Возвращаем таблицу модуля
return DateTimeModule

