-- financial_indicators.lua

-- Создаем таблицу для хранения всех функций и данных модуля
local FinancialIndicators = {}

function FinancialIndicators.calculate_sma(data)
    --[[
        НАЗВАНИЕ
            calculate_sma

        ОПИСАНИЕ
            Вычисляет простое скользящее среднее.

        ПАРАМЕТРЫ
            data (table): Таблица данных для расчета.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Результат расчета скользящего среднего.
    ]]
    local period = #data
    if period == 0 then
        error("Нет данных для расчета скользящего среднего.")
    end

    local sum = 0
    for i = 1, period do
        sum = sum + data[i]
    end
    return sum / period
end

function FinancialIndicators.calculate_rsi(data)
    --[[
        НАЗВАНИЕ
            calculate_rsi

        ОПИСАНИЕ
            Вычисляет относительную силу.

        ПАРАМЕТРЫ
            data (table): Таблица данных для расчета.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Результат расчета относительной силы.
    ]]
    local period = #data
    if period < 2 then
        error("Недостаточно данных для расчета RSI.")
    end

    local gain_sum = 0
    local loss_sum = 0

    for i = 2, period do
        local price_diff = data[i] - data[i - 1]
        if price_diff > 0 then
            gain_sum = gain_sum + price_diff
        else
            loss_sum = loss_sum + math.abs(price_diff)
        end
    end

    local avg_gain = gain_sum / period
    local avg_loss = loss_sum / period

    if avg_loss == 0 then
        return 100
    end

    local rs = avg_gain / avg_loss
    local rsi = 100 - (100 / (1 + rs))

    return rsi
end

function FinancialIndicators.calculate_median(data)
    --[[
        НАЗВАНИЕ
            calculate_median

        ОПИСАНИЕ   
            Вычисляет медиану.

        ПАРАМЕТРЫ
            data (table): Таблица данных для расчета медианы.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Результат расчета медианы.
    ]]
    if #data == 0 then
        error("Нет данных для расчета медианы.")
    end

    -- Создаем копию данных
    local data_copy = {}
    for i, value in ipairs(data) do
        data_copy[i] = value
    end

    -- Сортируем копию данных
    table.sort(data_copy)

    local n = #data_copy

    if n % 2 == 0 then
        local middle1 = data_copy[n // 2]
        local middle2 = data_copy[n // 2 + 1]
        return (middle1 + middle2) / 2
    else
        return data_copy[(n + 1) // 2]
    end
end


function FinancialIndicators.calculate_standard_deviation(data)
    --[[
        НАЗВАНИЕ
            calculate_standard_deviation

        ОПИСАНИЕ
            Вычисляет стандартное отклонение.

        ПАРАМЕТРЫ
            data (table): Таблица данных для расчета стандартного отклонения.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Результат расчета стандартного отклонения.
    ]]
    local n = #data
    if n < 2 then
        error("Недостаточно данных для расчета стандартного отклонения.")
    end

    -- Вычисление среднего значения
    local sum = 0
    for i = 1, n do
        sum = sum + data[i]
    end
    local mean = sum / n

    -- Вычисление суммы квадратов разностей от среднего
    local sum_squares = 0
    for i = 1, n do
        sum_squares = sum_squares + (data[i] - mean)^2
    end

    -- Вычисление стандартного отклонения
    local standard_deviation = math.sqrt(sum_squares / (n - 1))

    return standard_deviation
end

function FinancialIndicators.calculate_average_candle_height(data)
    --[[
        НАЗВАНИЕ
            calculate_average_candle_height

        ОПИСАНИЕ
            Вычисляет среднюю высоту свечи на графике.

        ПАРАМЕТРЫ
            data (table): Таблица данных, где каждый элемент - таблица с описанием свечи.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Средняя высота свечи.
    ]]
    local total_height = 0
    local num_candles = #data

    if num_candles == 0 then
        error("Нет данных для расчета средней высоты свечи.")
    end

    for i = 1, num_candles do
        local candle = data[i]
        if type(candle) == "table" and candle.open and candle.close and candle.high and candle.low then
            local height = math.abs(candle.high - candle.low)
            total_height = total_height + height
        else
            error("Некорректные данные свечи.")
        end
    end

    local average_height = total_height / num_candles
    return average_height
end


function FinancialIndicators.calculate_median_candle_height(data)
    --[[
        НАЗВАНИЕ
            calculate_median_candle_height

        ОПИСАНИЕ
            Вычисляет медианную высоту свечи на графике.

        ПАРАМЕТРЫ
            data (table): Таблица данных, где каждый элемент - таблица с описанием свечи.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Медианная высота свечи.
    ]]
    local heights = {}

    for i, candle in ipairs(data) do
        if type(candle) == "table" and candle.open and candle.close and candle.high and candle.low then
            local height = math.abs(candle.high - candle.low)
            table.insert(heights, height)
        else
            error("Некорректные данные свечи.")
        end
    end

    if #heights == 0 then
        error("Нет данных для расчета медианной высоты свечи.")
    end

    -- Сортировка высот для вычисления медианы
    table.sort(heights)

    local median_height = 0

    if #heights % 2 == 0 then
        -- Для четного количества элементов
        local middle1 = heights[#heights / 2]
        local middle2 = heights[#heights / 2 + 1]
        median_height = (middle1 + middle2) / 2
    else
        -- Для нечетного количества элементов
        median_height = heights[(#heights + 1) / 2]
    end

    return median_height
end

function FinancialIndicators.find_max_price(prices)
    --[[
        НАЗВАНИЕ
            find_max_price

        ОПИСАНИЕ
            Находит максимальную цену в списке.

        ПАРАМЕТРЫ
            prices (table): Список цен.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Максимальная цена.
    ]]
    if #prices == 0 then
        error("Список цен пуст.")
    end

    local max_price = prices[1]

    for i = 2, #prices do
        if prices[i] > max_price then
            max_price = prices[i]
        end
    end

    return max_price
end

function FinancialIndicators.find_min_price(prices)
    --[[
        НАЗВАНИЕ
            find_min_price

        ОПИСАНИЕ
            Находит минимальную цену в списке.

        ПАРАМЕТРЫ
            prices (table): Список цен.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Минимальная цена.
    ]]
    if #prices == 0 then
        error("Список цен пуст.")
    end

    local min_price = prices[1]

    for i = 2, #prices do
        if prices[i] < min_price then
            min_price = prices[i]
        end
    end

    return min_price
end

function FinancialIndicators.calculate_correlation(prices1, prices2)
    --[[
        НАЗВАНИЕ
            calculate_correlation

        ОПИСАНИЕ
            Вычисляет корреляцию между двумя наборами цен.

        ПАРАМЕТРЫ
            prices1 (table): Первый набор цен.
            prices2 (table): Второй набор цен.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            number: Коэффициент корреляции.
    ]]
    if #prices1 ~= #prices2 or #prices1 == 0 then
        error("Некорректные данные для вычисления корреляции.")
    end

    local n = #prices1
    local sum1, sum2, sum1Sq, sum2Sq, pSum = 0, 0, 0, 0, 0

    for i = 1, n do
        sum1 = sum1 + prices1[i]
        sum2 = sum2 + prices2[i]
        sum1Sq = sum1Sq + prices1[i]^2
        sum2Sq = sum2Sq + prices2[i]^2
        pSum = pSum + prices1[i] * prices2[i]
    end

    local num = pSum - (sum1 * sum2 / n)
    local den = math.sqrt((sum1Sq - sum1^2 / n) * (sum2Sq - sum2^2 / n))

    if den == 0 then
        return 0 -- Корреляция не определена, если знаменатель равен нулю
    end

    return num / den
end


function FinancialIndicators.extrapolate_prices(prices, target_length)
    --[[
        НАЗВАНИЕ
            extrapolate_prices

        ОПИСАНИЕ
            Экстраполирует значения цен для указанной длины списка, используя линейную экстраполяцию.

        ПАРАМЕТРЫ
            prices (table): Список цен.
            target_length (number): Желаемая длина списка после экстраполяции.

        ВОЗВРАЩАЕМЫЕ ЗНАЧЕНИЯ
            table: Список цен после экстраполяции.
    ]]
    local length = #prices

    if length == 0 or target_length <= length then
        error("Некорректные данные для экстраполяции.")
    end

    local x_sum, y_sum, xy_sum, x_squared_sum = 0, 0, 0, 0

    for i = 1, length do
        x_sum = x_sum + i
        y_sum = y_sum + prices[i]
        xy_sum = xy_sum + i * prices[i]
        x_squared_sum = x_squared_sum + i^2
    end

    local a = (length * xy_sum - x_sum * y_sum) / (length * x_squared_sum - x_sum^2)
    local b = (y_sum - a * x_sum) / length

    local extrapolated_prices = {table.unpack(prices)}

    for i = length + 1, target_length do
        local extrapolated_value = a * i + b
        table.insert(extrapolated_prices, extrapolated_value)
    end

    return extrapolated_prices
end



-- Возвращаем созданный модуль
return FinancialIndicators
