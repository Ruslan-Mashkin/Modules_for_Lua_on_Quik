-- prices_module.lua

--[[
������ ������� ������:
- prices_module.add_prices(price1, price2) - ��������� ����� ���� ���.
- prices_module.subtract_prices(price1, price2) - ��������� ������� ����� ����� ������.
- prices_module.calculate_percentage_change(old_price, new_price) - ��������� ������� ��������� ����� ����� ������.
- prices_module.To_integer(n) - ����������� ����� ����� � ����� �����.
- prices_module.Last_price(class, sec) - ���������� ������� ���� ��������� �����������.
- prices_module.Min_price_step(class, sec) - ���������� ����������� ��� ���� ��� ���������� �����������.
- prices_module.CorrectPrice(class, sec, price) - ������������ ��������� ���� � ����, ������������ ��������.
- prices_module.calculate_total_value(quantity, price) - ��������� ����� ��������� �� ������ ���������� � ����.
- prices_module.calculate_yield(initial_value, final_value) - ��������� ���������� �� ������ ��������� � �������� ���������.
- prices_module.calculate_price_increase(current_price, percent_increase) - ��������� �������� ���� ����� ���������� ������� ���� �� �������� �������.
- prices_module.Min_price_today(class, sec) - ���������� ����������� ���� ��� ������������ ��� ��������� �����������.
- prices_module.Max_price_today(class, sec) - ���������� ������������ ���� ��� ������������ ��� ��������� �����������.
]]


-- ����������� �������, ������� ����� ��������� ������� ������
local prices_module = {}

function prices_module.add_prices(price1, price2)
    --[[
        ��������
            add_prices

        ��������
            ��������� ����� ���� ���.

        ���������
            price1 (number): ������ ����.
            price2 (number): ������ ����.

        ������������ ��������
            number: ����� ���� ���.
    ]]
    if type(price1) ~= "number" or type(price2) ~= "number" then
        error("�������� ���������: ��������� �����.")
    end

    return price1 + price2
end

function prices_module.subtract_prices(price1, price2)
    --[[
        ��������
            subtract_prices

        ��������
            ��������� ������� ����� ����� ������.

        ���������
            price1 (number): ������ ����.
            price2 (number): ������ ����.

        ������������ ��������
            number: ������� ����� ����� ������.
    ]]
    if type(price1) ~= "number" or type(price2) ~= "number" then
        error("�������� ���������: ��������� �����.")
    end

    return math.abs(price1 - price2)
end

function prices_module.calculate_percentage_change(old_price, new_price)
    --[[
        ��������
            calculate_percentage_change

        ��������
            ��������� ������� ��������� ����� ����� ������.

        ���������
            old_price (number): ������ ����.
            new_price (number): ����� ����.

        ������������ ��������
            number: ������� ��������� ����� ����� ������.
    ]]
    if type(old_price) ~= "number" or type(new_price) ~= "number" then
        error("�������� ���������: ��������� �����.")
    end

    local change = new_price - old_price
    local percentage_change = (change / old_price) * 100
    return percentage_change
end

function prices_module.To_integer(n)
    --[[
        ��������
            To_integer

        ��������
            ����������� ����� ����� � ����� �����.

        ���������
            n (number): ����� �����, ������� ����� ������������� � ����� �����.

        ������������ ��������
            number: ����� �����, ���� �������������� �������, ��� nil, ���� �� �������.
    ]]
    return math.tointeger(tonumber(n))
end

function prices_module.Last_price(class, sec)
    --[[
        ��������
            Last_price

        ��������
            ���������� ������� ���� ��������� �����������.

        ���������
            class (string): ��� ������ �����������.
            sec (string): ��� �����������.

        ������������ ��������
            number: ������� ���� ��������� �����������.
    ]]
    return tonumber(getParamEx(class, sec, "LAST").param_value)
end

function prices_module.Max_price_today(class, sec)
    --[[
        ��������
            Max_price_today

        ��������
            ���������� ������������ ���� ��� ������������ ��� ��������� �����������.

        ���������
            class (string): ��� ������ �����������.
            sec (string): ��� �����������.

        ������������ ��������
            number: ������������ ���� ��� ������������ ��� ��������� �����������.
    ]]
    return tonumber(getParamEx(class, sec, "PRICEMAX").param_value)
end

function prices_module.Min_price_today(class, sec)
    --[[
        ��������
            Min_price_today

        ��������
            ���������� ����������� ���� ��� ������������ ��� ��������� �����������.

        ���������
            class (string): ��� ������ �����������.
            sec (string): ��� �����������.

        ������������ ��������
            number: ����������� ���� ��� ������������ ��� ��������� �����������.
    ]]
    return tonumber(getParamEx(class, sec, "PRICEMIN").param_value)
end


function prices_module.Min_price_step(class, sec)
    --[[
        ��������
            Min_price_step

        ��������
            ���������� ����������� ��� ���� ��� ���������� �����������.

        ���������
            class (string): ��� ������ �����������.
            sec (string): ��� �����������.

        ������������ ��������
            number: ����������� ��� ���� ��� ����������� �����������.
    ]]
    return tonumber(getParamEx(class, sec, "SEC_PRICE_STEP").param_value)
end

function prices_module.CorrectPrice(class, sec, price)
    --[[
        ��������
            CorrectPrice

        ��������
            ������������ ��������� ���� (price) � ����, ������������ ��������.

        ���������
            class (string): ��� ������ �����������.
            sec (string): ��� �����������.
            price (number): ��������� ����.

        ������������ ��������
            number: ���������������� ����.
    ]]
    local min_step_price = prices_module.Min_price_step(class, sec)
    local res = math.floor(price / min_step_price) * min_step_price
    return math.abs(tonumber(res))
end

function prices_module.calculate_total_value(quantity, price)
    --[[
        ��������
            calculate_total_value

        ��������
            ��������� ����� ��������� �� ������ ���������� � ����.

        ���������
            quantity (number): ����������.
            price (number): ����.

        ������������ ��������
            number: ����� ���������.
    ]]
    return quantity * price
end

function prices_module.calculate_yield(initial_value, final_value)
    --[[
        ��������
            calculate_yield

        ��������
            ��������� ���������� �� ������ ��������� � �������� ���������.

        ���������
            initial_value (number): ��������� ���������.
            final_value (number): �������� ���������.

        ������������ ��������
            number: ���������� � ���������.
    ]]
    return ((final_value - initial_value) / initial_value) * 100
end

function prices_module.calculate_price_increase(current_price, percent_increase)
    --[[
        ��������
            calculate_price_increase

        ��������
            ��������� �������� ���� ����� ���������� ������� ���� �� �������� �������.

        ���������
            current_price (number): ������� ����.
            percent_increase (number): ������� ����������.

        ������������ ��������
            number: �������� ���� ����� ����������.
    ]]
    if type(current_price) ~= "number" or type(percent_increase) ~= "number" then
        error("�������� ���������: ��������� �����.")
    end

    local increase_amount = current_price * (percent_increase / 100)
    return current_price + increase_amount
end


-- ���������� ������� � ��������� � ����� ������
return prices_module
