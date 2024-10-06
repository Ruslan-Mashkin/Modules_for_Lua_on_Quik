-- financial_indicators.lua

-- ������� ������� ��� �������� ���� ������� � ������ ������
local FinancialIndicators = {}

function FinancialIndicators.calculate_sma(data)
    --[[
        ��������
            calculate_sma

        ��������
            ��������� ������� ���������� �������.

        ���������
            data (table): ������� ������ ��� �������.

        ������������ ��������
            number: ��������� ������� ����������� ��������.
    ]]
    local period = #data
    if period == 0 then
        error("��� ������ ��� ������� ����������� ��������.")
    end

    local sum = 0
    for i = 1, period do
        sum = sum + data[i]
    end
    return sum / period
end

function FinancialIndicators.calculate_rsi(data)
    --[[
        ��������
            calculate_rsi

        ��������
            ��������� ������������� ����.

        ���������
            data (table): ������� ������ ��� �������.

        ������������ ��������
            number: ��������� ������� ������������� ����.
    ]]
    local period = #data
    if period < 2 then
        error("������������ ������ ��� ������� RSI.")
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
        ��������
            calculate_median

        ��������   
            ��������� �������.

        ���������
            data (table): ������� ������ ��� ������� �������.

        ������������ ��������
            number: ��������� ������� �������.
    ]]
    if #data == 0 then
        error("��� ������ ��� ������� �������.")
    end

    -- ������� ����� ������
    local data_copy = {}
    for i, value in ipairs(data) do
        data_copy[i] = value
    end

    -- ��������� ����� ������
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
        ��������
            calculate_standard_deviation

        ��������
            ��������� ����������� ����������.

        ���������
            data (table): ������� ������ ��� ������� ������������ ����������.

        ������������ ��������
            number: ��������� ������� ������������ ����������.
    ]]
    local n = #data
    if n < 2 then
        error("������������ ������ ��� ������� ������������ ����������.")
    end

    -- ���������� �������� ��������
    local sum = 0
    for i = 1, n do
        sum = sum + data[i]
    end
    local mean = sum / n

    -- ���������� ����� ��������� ��������� �� ��������
    local sum_squares = 0
    for i = 1, n do
        sum_squares = sum_squares + (data[i] - mean)^2
    end

    -- ���������� ������������ ����������
    local standard_deviation = math.sqrt(sum_squares / (n - 1))

    return standard_deviation
end

function FinancialIndicators.calculate_average_candle_height(data)
    --[[
        ��������
            calculate_average_candle_height

        ��������
            ��������� ������� ������ ����� �� �������.

        ���������
            data (table): ������� ������, ��� ������ ������� - ������� � ��������� �����.

        ������������ ��������
            number: ������� ������ �����.
    ]]
    local total_height = 0
    local num_candles = #data

    if num_candles == 0 then
        error("��� ������ ��� ������� ������� ������ �����.")
    end

    for i = 1, num_candles do
        local candle = data[i]
        if type(candle) == "table" and candle.open and candle.close and candle.high and candle.low then
            local height = math.abs(candle.high - candle.low)
            total_height = total_height + height
        else
            error("������������ ������ �����.")
        end
    end

    local average_height = total_height / num_candles
    return average_height
end


function FinancialIndicators.calculate_median_candle_height(data)
    --[[
        ��������
            calculate_median_candle_height

        ��������
            ��������� ��������� ������ ����� �� �������.

        ���������
            data (table): ������� ������, ��� ������ ������� - ������� � ��������� �����.

        ������������ ��������
            number: ��������� ������ �����.
    ]]
    local heights = {}

    for i, candle in ipairs(data) do
        if type(candle) == "table" and candle.open and candle.close and candle.high and candle.low then
            local height = math.abs(candle.high - candle.low)
            table.insert(heights, height)
        else
            error("������������ ������ �����.")
        end
    end

    if #heights == 0 then
        error("��� ������ ��� ������� ��������� ������ �����.")
    end

    -- ���������� ����� ��� ���������� �������
    table.sort(heights)

    local median_height = 0

    if #heights % 2 == 0 then
        -- ��� ������� ���������� ���������
        local middle1 = heights[#heights / 2]
        local middle2 = heights[#heights / 2 + 1]
        median_height = (middle1 + middle2) / 2
    else
        -- ��� ��������� ���������� ���������
        median_height = heights[(#heights + 1) / 2]
    end

    return median_height
end

function FinancialIndicators.find_max_price(prices)
    --[[
        ��������
            find_max_price

        ��������
            ������� ������������ ���� � ������.

        ���������
            prices (table): ������ ���.

        ������������ ��������
            number: ������������ ����.
    ]]
    if #prices == 0 then
        error("������ ��� ����.")
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
        ��������
            find_min_price

        ��������
            ������� ����������� ���� � ������.

        ���������
            prices (table): ������ ���.

        ������������ ��������
            number: ����������� ����.
    ]]
    if #prices == 0 then
        error("������ ��� ����.")
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
        ��������
            calculate_correlation

        ��������
            ��������� ���������� ����� ����� �������� ���.

        ���������
            prices1 (table): ������ ����� ���.
            prices2 (table): ������ ����� ���.

        ������������ ��������
            number: ����������� ����������.
    ]]
    if #prices1 ~= #prices2 or #prices1 == 0 then
        error("������������ ������ ��� ���������� ����������.")
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
        return 0 -- ���������� �� ����������, ���� ����������� ����� ����
    end

    return num / den
end


function FinancialIndicators.extrapolate_prices(prices, target_length)
    --[[
        ��������
            extrapolate_prices

        ��������
            �������������� �������� ��� ��� ��������� ����� ������, ��������� �������� �������������.

        ���������
            prices (table): ������ ���.
            target_length (number): �������� ����� ������ ����� �������������.

        ������������ ��������
            table: ������ ��� ����� �������������.
    ]]
    local length = #prices

    if length == 0 or target_length <= length then
        error("������������ ������ ��� �������������.")
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



-- ���������� ��������� ������
return FinancialIndicators
