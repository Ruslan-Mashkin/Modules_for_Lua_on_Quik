-- prices_module.lua

--[[
СПИСОК ФУНКЦИЙ МОДУЛЯ:
- prices_module.add_prices(price1, price2) - Вычисляет сумму двух цен.
- prices_module.subtract_prices(price1, price2) - Вычисляет разницу между двумя ценами.
- prices_module.calculate_percentage_change(old_price, new_price) - Вычисляет процент изменения между двумя ценами.
- prices_module.To_integer(n) - Преобразует любое число в целое число.
- prices_module.Last_price(class, sec) - Возвращает текущую цену заданного инструмента.
- prices_module.Min_price_step(class, sec) - Возвращает минимальный шаг цены для выбранного инструмента.
- prices_module.CorrectPrice(class, sec, price) - Корректирует расчетную цену к виду, принимаемому системой.
- prices_module.calculate_total_value(quantity, price) - Вычисляет общую стоимость на основе количества и цены.
- prices_module.calculate_yield(initial_value, final_value) - Вычисляет доходность на основе начальной и конечной стоимости.
- prices_module.calculate_price_increase(current_price, percent_increase) - Вычисляет итоговую цену после увеличения текущей цены на заданный процент.
- prices_module.Min_price_today(class, sec) - Возвращает минимальную цену для сегодняшнего дня заданного инструмента.
- prices_module.Max_price_today(class, sec) - Возвращает максимальную цену для сегодняшнего дня заданного инструмента.
]]


-- Определение таблицы, которая будет содержать функции модуля
local prices_module = {}

function prices_module.add_prices(price1, price2)
    --[[
        НАЗВАНИЕ
            add_prices

        ОПИСАНИЕ
            Вычисляет сумму двух цен.

        ПАРАМЕТРЫ
            price1 (number): Первая цена.
            price2 (number): Вторая цена.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Сумма двух цен.
    ]]
    if type(price1) ~= "number" or type(price2) ~= "number" then
        error("Неверные параметры: ожидаются числа.")
    end

    return price1 + price2
end

function prices_module.subtract_prices(price1, price2)
    --[[
        НАЗВАНИЕ
            subtract_prices

        ОПИСАНИЕ
            Вычисляет разницу между двумя ценами.

        ПАРАМЕТРЫ
            price1 (number): Первая цена.
            price2 (number): Вторая цена.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Разница между двумя ценами.
    ]]
    if type(price1) ~= "number" or type(price2) ~= "number" then
        error("Неверные параметры: ожидаются числа.")
    end

    return math.abs(price1 - price2)
end

function prices_module.calculate_percentage_change(old_price, new_price)
    --[[
        НАЗВАНИЕ
            calculate_percentage_change

        ОПИСАНИЕ
            Вычисляет процент изменения между двумя ценами.

        ПАРАМЕТРЫ
            old_price (number): Старая цена.
            new_price (number): Новая цена.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Процент изменения между двумя ценами.
    ]]
    if type(old_price) ~= "number" or type(new_price) ~= "number" then
        error("Неверные параметры: ожидаются числа.")
    end

    local change = new_price - old_price
    local percentage_change = (change / old_price) * 100
    return percentage_change
end

function prices_module.To_integer(n)
    --[[
        НАЗВАНИЕ
            To_integer

        ОПИСАНИЕ
            Преобразует любое число в целое число.

        ПАРАМЕТРЫ
            n (number): Любое число, которое нужно преобразовать в целое число.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Целое число, если преобразование удалось, или nil, если не удалось.
    ]]
    return math.tointeger(tonumber(n))
end

function prices_module.Last_price(class, sec)
    --[[
        НАЗВАНИЕ
            Last_price

        ОПИСАНИЕ
            Возвращает текущую цену заданного инструмента.

        ПАРАМЕТРЫ
            class (string): Код класса инструмента.
            sec (string): Код инструмента.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Текущая цена заданного инструмента.
    ]]
    return tonumber(getParamEx(class, sec, "LAST").param_value)
end

function prices_module.Max_price_today(class, sec)
    --[[
        НАЗВАНИЕ
            Max_price_today

        ОПИСАНИЕ
            Возвращает максимальную цену для сегодняшнего дня заданного инструмента.

        ПАРАМЕТРЫ
            class (string): Код класса инструмента.
            sec (string): Код инструмента.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Максимальная цена для сегодняшнего дня заданного инструмента.
    ]]
    return tonumber(getParamEx(class, sec, "PRICEMAX").param_value)
end

function prices_module.Min_price_today(class, sec)
    --[[
        НАЗВАНИЕ
            Min_price_today

        ОПИСАНИЕ
            Возвращает минимальную цену для сегодняшнего дня заданного инструмента.

        ПАРАМЕТРЫ
            class (string): Код класса инструмента.
            sec (string): Код инструмента.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Минимальная цена для сегодняшнего дня заданного инструмента.
    ]]
    return tonumber(getParamEx(class, sec, "PRICEMIN").param_value)
end


function prices_module.Min_price_step(class, sec)
    --[[
        НАЗВАНИЕ
            Min_price_step

        ОПИСАНИЕ
            Возвращает минимальный шаг цены для выбранного инструмента.

        ПАРАМЕТРЫ
            class (string): Код класса инструмента.
            sec (string): Код инструмента.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Минимальный шаг цены для переданного инструмента.
    ]]
    return tonumber(getParamEx(class, sec, "SEC_PRICE_STEP").param_value)
end

function prices_module.CorrectPrice(class, sec, price)
    --[[
        НАЗВАНИЕ
            CorrectPrice

        ОПИСАНИЕ
            Корректирует расчетную цену (price) к виду, принимаемому системой.

        ПАРАМЕТРЫ
            class (string): Код класса инструмента.
            sec (string): Код инструмента.
            price (number): Расчетная цена.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Корректированная цена.
    ]]
    local min_step_price = prices_module.Min_price_step(class, sec)
    local res = math.floor(price / min_step_price) * min_step_price
    return math.abs(tonumber(res))
end

function prices_module.calculate_total_value(quantity, price)
    --[[
        НАЗВАНИЕ
            calculate_total_value

        ОПИСАНИЕ
            Вычисляет общую стоимость на основе количества и цены.

        ПАРАМЕТРЫ
            quantity (number): Количество.
            price (number): Цена.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Общая стоимость.
    ]]
    return quantity * price
end

function prices_module.calculate_yield(initial_value, final_value)
    --[[
        НАЗВАНИЕ
            calculate_yield

        ОПИСАНИЕ
            Вычисляет доходность на основе начальной и конечной стоимости.

        ПАРАМЕТРЫ
            initial_value (number): Начальная стоимость.
            final_value (number): Конечная стоимость.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Доходность в процентах.
    ]]
    return ((final_value - initial_value) / initial_value) * 100
end

function prices_module.calculate_price_increase(current_price, percent_increase)
    --[[
        НАЗВАНИЕ
            calculate_price_increase

        ОПИСАНИЕ
            Вычисляет итоговую цену после увеличения текущей цены на заданный процент.

        ПАРАМЕТРЫ
            current_price (number): Текущая цена.
            percent_increase (number): Процент увеличения.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Итоговая цена после увеличения.
    ]]
    if type(current_price) ~= "number" or type(percent_increase) ~= "number" then
        error("Неверные параметры: ожидаются числа.")
    end

    local increase_amount = current_price * (percent_increase / 100)
    return current_price + increase_amount
end


-- Возвращаем таблицу с функциями в конце модуля
return prices_module
