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
-- time_module.lua

-- ћодуль дл¤ работы с временем и датами

--[[
—ѕ»—ќ  ‘”Ќ ÷»… ћќƒ”Ћя ƒЋя –јЅќ“џ — ¬–≈ћ≈Ќ≈ћ » ƒј“јћ»:

- DateTimeModule.getCurrentDate() ¬озвращает текущую дату в формате "ƒƒ-ћћ-√√√√".

- DateTimeModule.getCurrentTime() ¬озвращает текущее врем¤ в формате "„„:ћћ:——".

- DateTimeModule.getCurrentMinute() ¬озвращает текущую минуту в числовом формате.

- DateTimeModule.getCurrentSecond() ¬озвращает текущую секунду в числовом формате.

- DateTimeModule.getCurrentHour() ¬озвращает текущий час в числовом формате.

- DateTimeModule.getCurrentDay() ¬озвращает текущий день мес¤ца в числовом формате.

- DateTimeModule.getCurrentMonth() ¬озвращает текущий мес¤ц в числовом формате.

- DateTimeModule.getCurrentYear() ¬озвращает текущий год в числовом формате.

- DateTimeModule.getCurrentTimeCompact() ¬озвращает текущее врем¤ в формате "„„ћћ——" 
	с ведущими нул¤ми дл¤ минут и секунд, если они меньше 10.

- DateTimeModule.TimeConvertToNumber(hh, mm, ss) ѕреобразует переданные часы (hh), минуты (mm) и секунды (ss) 
	в числовое значение в формате "„„ћћ——".

- DateTimeModule.getCurrentWeekdayNumber() ¬озвращает текущий день недели в числовом формате 
	(1 - понедельник, 2 - вторник, и так далее).

- DateTimeModule.getCurrentDateCompact() ¬озвращает текущую дату в формате "√√√√ћћƒƒ" с ведущими 
	нул¤ми дл¤ мес¤ца и дн¤, если они меньше 10.

- DateTimeModule.DateConvertToNumber(year, month, day) ѕреобразует переданные год, мес¤ц и день в числовое значение в формате "√√√√ћћƒƒ".

- DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)  ¬ычисл¤ет разницу в дн¤х между двум¤ датами.

- DateTimeModule.isWorkTime(start_time, finish_time) ƒанна¤ функци¤ провер¤ет, рабочее ли сейчас врем¤
]]

-- ћодуль дл¤ работы с временем и датами

-- —оздаем таблицу дл¤ модул¤
local DateTimeModule = {}

function DateTimeModule.getCurrentDate()
    --[[
    Ќј«¬јЌ»≈
        getCurrentDate

    ќѕ»—јЌ»≈
        ¬озвращает текущую дату в формате "ƒƒ-ћћ-√√√√".

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        string: “екуща¤ дата в формате "ƒƒ-ћћ-√√√√".
    ]]
    local currentDate = os.date("%d-%m-%Y")
    return currentDate
end

function DateTimeModule.getCurrentTime()
    --[[
    Ќј«¬јЌ»≈
        getCurrentTime

    ќѕ»—јЌ»≈
        ¬озвращает текущее врем¤ в формате "„„:ћћ:——".

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        string: “екущее врем¤ в формате "„„:ћћ:——".
    ]]
    local currentTime = os.date("%H:%M:%S")
    return currentTime
end

function DateTimeModule.getCurrentMinute()
    --[[
    Ќј«¬јЌ»≈
        getCurrentMinute

    ќѕ»—јЌ»≈
        ¬озвращает текущую минуту в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екуща¤ минута.
    ]]
    local currentMinute = tonumber(os.date("%M"))
    return currentMinute
end

function DateTimeModule.getCurrentSecond()
    --[[
    Ќј«¬јЌ»≈
        getCurrentSecond

    ќѕ»—јЌ»≈
        ¬озвращает текущую секунду в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екуща¤ секунда.
    ]]
    local currentSecond = tonumber(os.date("%S"))
    return currentSecond
end

function DateTimeModule.getCurrentHour()
    --[[
    Ќј«¬јЌ»≈
        getCurrentHour

    ќѕ»—јЌ»≈
        ¬озвращает текущий час в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущий час.
    ]]
    local currentHour = tonumber(os.date("%H"))
    return currentHour
end

function DateTimeModule.getCurrentDay()
    --[[
    Ќј«¬јЌ»≈
        getCurrentDay

    ќѕ»—јЌ»≈
        ¬озвращает текущий день мес¤ца в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущий день мес¤ца.
    ]]
    local currentDay = tonumber(os.date("%d"))
    return currentDay
end

function DateTimeModule.getCurrentMonth()
    --[[
    Ќј«¬јЌ»≈
        getCurrentMonth

    ќѕ»—јЌ»≈
        ¬озвращает текущий мес¤ц в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущий мес¤ц.
    ]]
    local currentMonth = tonumber(os.date("%m"))
    return currentMonth
end

function DateTimeModule.getCurrentYear()
    --[[
    Ќј«¬јЌ»≈
        getCurrentYear

    ќѕ»—јЌ»≈
        ¬озвращает текущий год в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущий год.
    ]]
    local currentYear = tonumber(os.date("%Y"))
    return currentYear
end

function DateTimeModule.getCurrentTimeCompact()
    --[[
    Ќј«¬јЌ»≈
        getCurrentTimeCompact

    ќѕ»—јЌ»≈
        ¬озвращает текущее врем¤ в формате "„„ћћ——" с ведущими нул¤ми дл¤ минут и секунд, если они меньше 10.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущее врем¤ в формате „„ћћ——.
    ]]
    local currentHour = string.format("%02d", DateTimeModule.getCurrentHour())
    local currentMinute = string.format("%02d", DateTimeModule.getCurrentMinute())
    local currentSecond = string.format("%02d", DateTimeModule.getCurrentSecond())

    return tonumber(currentHour .. currentMinute .. currentSecond)
end

function DateTimeModule.TimeConvertToNumber(hh, mm, ss)
    --[[
    Ќј«¬јЌ»≈
        TimeConvertToNumber

    ќѕ»—јЌ»≈
        ѕреобразует переданные часы, минуты и секунды в числовое значение в формате "„„ћћ——".

    ѕј–јћ≈“–џ
        number hh: „асы от 0 до 23.
        number mm: ћинуты от 0 до 59.
        number ss: —екунды от 0 до 59.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: „исловое значение времени в формате „„ћћ——.
    ]]
    -- ѕровер¤ем диапазоны значений
    if hh < 0 or hh > 23 or mm < 0 or mm > 59 or ss < 0 or ss > 59 then
        error("Ќекорректные значени¤ часов, минут или секунд.")
    end

    -- ‘орматируем значени¤ с ведущими нул¤ми
    local formattedHH = string.format("%02d", hh)
    local formattedMM = string.format("%02d", mm)
    local formattedSS = string.format("%02d", ss)

    -- —кладываем значени¤ в формате hhmmss
    local timeNumber = tonumber(formattedHH .. formattedMM .. formattedSS)

    return timeNumber
end

function DateTimeModule.getCurrentWeekdayNumber()
    --[[
    Ќј«¬јЌ»≈
        getCurrentWeekdayNumber

    ќѕ»—јЌ»≈
        ¬озвращает текущий день недели в числовом формате.

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екущий день недели в числовом формате (1 - понедельник, 2 - вторник, и так далее).
    ]]
    local currentWeekday = tonumber(os.date("%w"))

    -- ¬ Lua номераци¤ дней недели начинаетс¤ с воскресень¤ (0), поэтому добавим 1
    currentWeekday = (currentWeekday + 6) % 7 + 1

    return currentWeekday
end

function DateTimeModule.getCurrentDateCompact()
    --[[
    Ќј«¬јЌ»≈
        getCurrentDateCompact

    ќѕ»—јЌ»≈
        ¬озвращает текущую дату в числовом формате "√√√√ћћƒƒ".

    ѕј–јћ≈“–џ
        Ќет параметров.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: “екуща¤ дата в числовом формате "√√√√ћћƒƒ".
    ]]
    local currentYear = DateTimeModule.getCurrentYear()
    local currentMonth = string.format("%02d", DateTimeModule.getCurrentMonth())
    local currentDay = string.format("%02d", DateTimeModule.getCurrentDay())

    return tonumber(currentYear .. currentMonth .. currentDay)
end

function DateTimeModule.DateConvertToNumber(year, month, day)
    --[[
    Ќј«¬јЌ»≈
        DateConvertToNumber

    ќѕ»—јЌ»≈
        ѕреобразует переданные год, мес¤ц и день в числовое значение в формате "√√√√ћћƒƒ".

    ѕј–јћ≈“–џ
        number year: √од.
        number month: ћес¤ц от 1 до 12.
        number day: ƒень мес¤ца от 1 до 31.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: „исловое значение даты в формате "√√√√ћћƒƒ".
    ]]
    -- ѕровер¤ем диапазоны значений
    if year < 0 or month < 1 or month > 12 or day < 1 or day > 31 then
        error("Ќекорректные значени¤ года, мес¤ца или дн¤.")
    end

    -- ‘орматируем значени¤ с ведущими нул¤ми
    local formattedYear = string.format("%04d", year)
    local formattedMonth = string.format("%02d", month)
    local formattedDay = string.format("%02d", day)

    -- —кладываем значени¤ в формате √√√√ћћƒƒ
    local dateNumber = tonumber(formattedYear .. formattedMonth .. formattedDay)

    return dateNumber
end

function DateTimeModule.calculateDateDifference(year1, month1, day1, year2, month2, day2)
    --[[
    Ќј«¬јЌ»≈
        calculateDateDifference

    ќѕ»—јЌ»≈
        ¬ычисл¤ет разницу в дн¤х между двум¤ датами.

    ѕј–јћ≈“–џ
        number year1: √од первой даты.
        number month1: ћес¤ц первой даты от 1 до 12.
        number day1: ƒень первой даты от 1 до 31.

        number year2: √од второй даты.
        number month2: ћес¤ц второй даты от 1 до 12.
        number day2: ƒень второй даты от 1 до 31.

    ¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
        number: –азница в дн¤х между двум¤ датами.
    ]]
    -- ѕровер¤ем диапазоны значений
    if year1 < 0 or month1 < 1 or month1 > 12 or day1 < 1 or day1 > 31 or
       year2 < 0 or month2 < 1 or month2 > 12 or day2 < 1 or day2 > 31 then
        error("Ќекорректные значени¤ года, мес¤ца или дн¤.")
    end

    local date1 = os.time({year = year1, month = month1, day = day1})
    local date2 = os.time({year = year2, month = month2, day = day2})

    local dateDifferenceInSeconds = math.abs(date2 - date1)
    
    -- ƒни
    local daysDifference = math.floor(dateDifferenceInSeconds / (60 * 60 * 24))

    return daysDifference
end

function DateTimeModule.isWorkTime(start_time, finish_time)
--[[
Ќј«¬јЌ»≈
    isWorkTime

ќѕ»—јЌ»≈
    ƒанна¤ функци¤ провер¤ет, рабочее ли сейчас врем¤

ѕј–јћ≈“–џ
    start_time - number. ¬рем¤ начала рабочего дн¤ в формате „„ћћ——.
    finish_time - number. ¬рем¤ окончани¤ рабочего дн¤ в формате „„ћћ——.

¬ќ«¬–јўј≈ћџ≈ «Ќј„≈Ќ»я
    boolean - ¬озвращает true, если врем¤ рабочее, и false в противном случае.
]]
    local now_time = DateTimeModule.getCurrentTimeCompact()
    if now_time > start_time and now_time < finish_time then
        return true
    else
        return false
    end
end

-- ¬озвращаем таблицу модул¤
return DateTimeModule
