--    Сохранить этот файл в каталоге где установлена программа QUIK


trader={}                              -- передающая таблица
Account = "L01-00000F00"               -- торговый счет
--Class_Code = "TQBR"                    -- класс торгуемого инструмента
--Sec_Code = "NVTK"                      -- код торгуемого инструмента
firm_id="MC0002500000"

function trader.kupit_po_rinku(agent,Class_Code,Sec_Code,g_lots)
	local CC=tostring(agent)
	local trans_params =
		{
			CLIENT_CODE = CC,
			CLASSCODE = Class_Code,              -- Код класса
			SECCODE = Sec_Code,      		     -- Код инструмента	
			ACCOUNT = Account,   			     -- Код счета
			TYPE = "M",        		             -- Тип ('L' - лимитированная, 'M' - рыночная)
			TRANS_ID = tostring(os.time()),      -- Номер транзакции
			OPERATION = "B",         			 -- Операция ('B' - buy, или 'S' - sell)	
			QUANTITY = tostring(g_lots),         -- Количество
			PRICE = "0",                         -- Цена
			ACTION = "NEW_ORDER"                 -- Тип транзакции ('NEW_ORDER' - новая заявка)
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		
		message(Sec_Code.."   Транзакция не прошла  ".. tostring(res))
	else
	end
end
function trader.prodat_po_rinku(agent,Class_Code,Sec_Code,g_lots)
	local CC=tostring(agent)
	local trans_params =
		{
			CLIENT_CODE = CC,
			CLASSCODE = Class_Code,              -- Код класса
			SECCODE = Sec_Code,      		     -- Код инструмента	
			ACCOUNT = Account,   				 -- Код счета
			TYPE = "M",        		             -- Тип ('L' - лимитированная, 'M' - рыночная)
			TRANS_ID = tostring(os.time()),      -- Номер транзакции
			OPERATION = "S",         			 -- Операция ('B' - buy, или 'S' - sell)	
			QUANTITY = tostring(g_lots),         -- Количество
			PRICE = "0",                         -- Цена
			ACTION = "NEW_ORDER"                 -- Тип транзакции ('NEW_ORDER' - новая заявка)
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		
		message(Sec_Code.."   Транзакция не прошла  ".. tostring(res))
	else
	end
end
function trader.prodat_po_cene(agent,Class_Code,Sec_Code,g_lots,price)
	local CC=tostring(agent)
	local trans_params =
		{
			CLIENT_CODE = CC,
			CLASSCODE = Class_Code,              -- Код класса
			SECCODE = Sec_Code,      		     -- Код инструмента	
			ACCOUNT = Account,   				 -- Код счета
			TYPE = "L",        		             -- Тип ('L' - лимитированная, 'M' - рыночная)
			TRANS_ID = tostring(os.time()),      -- Номер транзакции
			OPERATION = "S",                     -- Операция ('B' - buy, или 'S' - sell)
			QUANTITY = tostring(g_lots),         -- Количество
			PRICE = tostring(price),             -- Цена
			ACTION = "NEW_ORDER"                 -- Тип транзакции ('NEW_ORDER' - новая заявка)
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(Sec_Code.."   Транзакция не прошла  ".. tostring(res))
	else
	end
end
function trader.kupit_po_cene(agent,Class_Code,Sec_Code,g_lots,price)
	local CC=tostring(agent)
	local trans_params =
		{
			CLIENT_CODE = CC,
			CLASSCODE = Class_Code,              -- Код класса
			SECCODE = Sec_Code,      		     -- Код инструмента	
			ACCOUNT = Account,   				 -- Код счета
			TYPE = "L",        		             -- Тип ('L' - лимитированная, 'M' - рыночная)
			TRANS_ID = tostring(os.time()),      -- Номер транзакции
			OPERATION = "B",                     -- Операция ('B' - buy, или 'S' - sell)
			QUANTITY = tostring(g_lots),         -- Количество
			PRICE = tostring(price),             -- Цена
			ACTION = "NEW_ORDER"                 -- Тип транзакции ('NEW_ORDER' - новая заявка)
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(Sec_Code.."   Транзакция не прошла  ".. tostring(res))
	else
	end
end

function trader.kupit_po_take_profit(agent,Class_Code,Sec_Code,g_lots,price)
	local CC=tostring(agent)
	local trans_params =
		{
		["ACTION"]              = "NEW_STOP_ORDER", -- Тип заявки
		["TRANS_ID"]            = tostring(os.time()),      -- Номер транзакции
		["CLASSCODE"]           = Class_Code,
		["SECCODE"]             = Sec_Code,
		["ACCOUNT"]             = Account,
		["OPERATION"]           = "B", -- Операция ("B" - покупка(BUY), "S" - продажа(SELL))
		["QUANTITY"]            = tostring(g_lots), -- Количество в лотах
		["PRICE"]               = tostring(0), -- Цена, по которой выставится заявка при срабатывании Стоп-Лосса (для рыночной заявки по акциям должна быть 0)
		["STOPPRICE"]           = tostring(price), -- Цена Тэйк-Профита
		["STOP_ORDER_KIND"]     = "TAKE_PROFIT_STOP_ORDER", -- Тип стоп-заявки
		["EXPIRY_DATE"]         = "TODAY", -- Срок действия стоп-заявки ("GTC" – до отмены,"TODAY" - до окончания текущей торговой сессии, Дата в формате "ГГММДД")
      -- "OFFSET" - (ОТСТУП)Если цена достигла Тэйк-профита и идет дальше в прибыль,
      -- то Тэйк-профит сработает только когда цена вернется минимум на 2 шага цены назад,
      -- это может потенциально увеличить прибыль
		["OFFSET"]              = tostring(0.1),
		["OFFSET_UNITS"]        = "PERCENTS", -- Единицы измерения отступа ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "SPREAD" - Когда сработает Тэйк-профит, выставится заявка по цене хуже текущей на 100 шагов цены,
      -- которая АВТОМАТИЧЕСКИ УДОВЛЕТВОРИТСЯ ПО ТЕКУЩЕЙ ЛУЧШЕЙ ЦЕНЕ,
      -- но то, что цена значительно хуже, спасет от проскальзывания,
      -- иначе, сделка может просто не закрыться (заявка на закрытие будет выставлена, но цена к тому времени ее уже проскочит)
		["SPREAD"]              = tostring(0.1),
		["SPREAD_UNITS"]        = "PERCENTS", -- Единицы измерения защитного спрэда ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Тэйк-Профита.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
	    --["MARKET_TAKE_PROFIT"]  = "YES",
		["STOPPRICE2"]          = tostring(0), -- Цена Стоп-Лосса
		["IS_ACTIVE_IN_TIME"]   = "NO",
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Стоп-Лосса.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
		["CLIENT_CODE"]         = CC
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
	else
	end
end

function trader.prodat_po_take_profit(agent,Class_Code,Sec_Code,g_lots,price)
	local CC=tostring(agent)
	local trans_params =
		{
		["ACTION"]              = "NEW_STOP_ORDER", -- Тип заявки
		["TRANS_ID"]            = tostring(os.time()),      -- Номер транзакции
		["CLASSCODE"]           = Class_Code,
		["SECCODE"]             = Sec_Code,
		["ACCOUNT"]             = Account,
		["OPERATION"]           = "S", -- Операция ("B" - покупка(BUY), "S" - продажа(SELL))
		["QUANTITY"]            = tostring(g_lots), -- Количество в лотах
		["PRICE"]               = tostring(0), -- Цена, по которой выставится заявка при срабатывании Стоп-Лосса (для рыночной заявки по акциям должна быть 0)
		["STOPPRICE"]           = tostring(price), -- Цена Тэйк-Профита
		["STOP_ORDER_KIND"]     = "TAKE_PROFIT_STOP_ORDER", -- Тип стоп-заявки
		["EXPIRY_DATE"]         = "TODAY", -- Срок действия стоп-заявки ("GTC" – до отмены,"TODAY" - до окончания текущей торговой сессии, Дата в формате "ГГММДД")
      -- "OFFSET" - (ОТСТУП)Если цена достигла Тэйк-профита и идет дальше в прибыль,
      -- то Тэйк-профит сработает только когда цена вернется минимум на 2 шага цены назад,
      -- это может потенциально увеличить прибыль
		["OFFSET"]              = tostring(0.1),
		["OFFSET_UNITS"]        = "PERCENTS", -- Единицы измерения отступа ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "SPREAD" - Когда сработает Тэйк-профит, выставится заявка по цене хуже текущей на 100 шагов цены,
      -- которая АВТОМАТИЧЕСКИ УДОВЛЕТВОРИТСЯ ПО ТЕКУЩЕЙ ЛУЧШЕЙ ЦЕНЕ,
      -- но то, что цена значительно хуже, спасет от проскальзывания,
      -- иначе, сделка может просто не закрыться (заявка на закрытие будет выставлена, но цена к тому времени ее уже проскочит)
		["SPREAD"]              = tostring(0.1),
		["SPREAD_UNITS"]        = "PERCENTS", -- Единицы измерения защитного спрэда ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Тэйк-Профита.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
	    --["MARKET_TAKE_PROFIT"]  = "YES",
		["STOPPRICE2"]          = tostring(0), -- Цена Стоп-Лосса
		["IS_ACTIVE_IN_TIME"]   = "NO",
		["CLIENT_CODE"]         = CC
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
	else
	end
end
function trader.prodat_po_take_profit_stop_loss(agent,Class_Code,Sec_Code,g_lots,price,Tprice,Sprice) -- Sprice Цена Стоп-Лосса, Tprice Цена Тэйк-Профита, price Цена, по которой выставится заявка при срабатывании Стоп-Лосса 
	local CC=tostring(agent)
	local trans_params =
		{
		["ACTION"]              = "NEW_STOP_ORDER", -- Тип заявки
		["TRANS_ID"]            = tostring(os.time()),      -- Номер транзакции
		["CLASSCODE"]           = Class_Code,
		["SECCODE"]             = Sec_Code,
		["ACCOUNT"]             = Account,
		["OPERATION"]           = "S", -- Операция ("B" - покупка(BUY), "S" - продажа(SELL))
		["QUANTITY"]            = tostring(g_lots), -- Количество в лотах
		["PRICE"]               = tostring(price), -- Цена, по которой выставится заявка при срабатывании Стоп-Лосса (для рыночной заявки по акциям должна быть 0)
		["STOPPRICE"]           = tostring(Tprice), -- Цена Тэйк-Профита
		["STOP_ORDER_KIND"]     = "TAKE_PROFIT_AND_STOP_LIMIT_ORDER", -- Тип стоп-заявки
		["EXPIRY_DATE"]         = "TODAY", -- Срок действия стоп-заявки ("GTC" – до отмены,"TODAY" - до окончания текущей торговой сессии, Дата в формате "ГГММДД")
      -- "OFFSET" - (ОТСТУП)Если цена достигла Тэйк-профита и идет дальше в прибыль,
      -- то Тэйк-профит сработает только когда цена вернется минимум на 2 шага цены назад,
      -- это может потенциально увеличить прибыль
		["OFFSET"]              = tostring(0.01),
		["OFFSET_UNITS"]        = "PERCENTS", -- Единицы измерения отступа ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "SPREAD" - Когда сработает Тэйк-профит, выставится заявка по цене хуже текущей на 100 шагов цены,
      -- которая АВТОМАТИЧЕСКИ УДОВЛЕТВОРИТСЯ ПО ТЕКУЩЕЙ ЛУЧШЕЙ ЦЕНЕ,
      -- но то, что цена значительно хуже, спасет от проскальзывания,
      -- иначе, сделка может просто не закрыться (заявка на закрытие будет выставлена, но цена к тому времени ее уже проскочит)
		["SPREAD"]              = tostring(1),
		["SPREAD_UNITS"]        = "PERCENTS", -- Единицы измерения защитного спрэда ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Тэйк-Профита.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
	    --["MARKET_TAKE_PROFIT"]  = "YES",
		["STOPPRICE2"]          = tostring(Sprice), -- Цена Стоп-Лосса
		["IS_ACTIVE_IN_TIME"]   = "NO",
		["CLIENT_CODE"]         = CC
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
	else
	end
end
function trader.kupit_po_take_profit_stop_loss(agent,Class_Code,Sec_Code,g_lots,price,Tprice,Sprice) -- Sprice Цена Стоп-Лосса, Tprice Цена Тэйк-Профита, price Цена, по которой выставится заявка при срабатывании Стоп-Лосса 
	local CC=tostring(agent)
	local trans_params =
		{
		["ACTION"]              = "NEW_STOP_ORDER", -- Тип заявки
		["TRANS_ID"]            = tostring(os.time()),      -- Номер транзакции
		["CLASSCODE"]           = Class_Code,
		["SECCODE"]             = Sec_Code,
		["ACCOUNT"]             = Account,
		["OPERATION"]           = "B", -- Операция ("B" - покупка(BUY), "S" - продажа(SELL))
		["QUANTITY"]            = tostring(g_lots), -- Количество в лотах
		["PRICE"]               = tostring(price), -- Цена, по которой выставится заявка при срабатывании Стоп-Лосса (для рыночной заявки по акциям должна быть 0)
		["STOPPRICE"]           = tostring(Tprice), -- Цена Тэйк-Профита
		["STOP_ORDER_KIND"]     = "TAKE_PROFIT_AND_STOP_LIMIT_ORDER", -- Тип стоп-заявки
		["EXPIRY_DATE"]         = "TODAY", -- Срок действия стоп-заявки ("GTC" – до отмены,"TODAY" - до окончания текущей торговой сессии, Дата в формате "ГГММДД")
      -- "OFFSET" - (ОТСТУП)Если цена достигла Тэйк-профита и идет дальше в прибыль,
      -- то Тэйк-профит сработает только когда цена вернется минимум на 2 шага цены назад,
      -- это может потенциально увеличить прибыль
		["OFFSET"]              = tostring(0.01),
		["OFFSET_UNITS"]        = "PERCENTS", -- Единицы измерения отступа ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "SPREAD" - Когда сработает Тэйк-профит, выставится заявка по цене хуже текущей на 100 шагов цены,
      -- которая АВТОМАТИЧЕСКИ УДОВЛЕТВОРИТСЯ ПО ТЕКУЩЕЙ ЛУЧШЕЙ ЦЕНЕ,
      -- но то, что цена значительно хуже, спасет от проскальзывания,
      -- иначе, сделка может просто не закрыться (заявка на закрытие будет выставлена, но цена к тому времени ее уже проскочит)
		["SPREAD"]              = tostring(1),
		["SPREAD_UNITS"]        = "PERCENTS", -- Единицы измерения защитного спрэда ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Тэйк-Профита.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
	    --["MARKET_TAKE_PROFIT"]  = "YES",
		["STOPPRICE2"]          = tostring(Sprice), -- Цена Стоп-Лосса
		["IS_ACTIVE_IN_TIME"]   = "NO",
		["CLIENT_CODE"]         = CC
		}
	local res = sendTransaction(trans_params)
	if string.len(res) ~= 0 then
		message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
	else
	end
end

function trader.DeleteStopOrder(agent,Class_Code,Sec_Code)
	for i = 0,getNumberOf("stop_orders") - 1 do
		-- ЕСЛИ строка по нужному инструменту не равна нулю ТО
		order=getItem("stop_orders",i).flags
		if getItem("stop_orders",i).sec_code == Sec_Code then
			-- 
			if bit.band(order,1)>0 then
				nomer_zaavki = getItem("stop_orders",i).order_num
				local CC=tostring(agent)
				local trans_params =
					{
					["ACTION"]              = "KILL_STOP_ORDER", -- Тип заявки
					["TRANS_ID"]            = tostring(os.time()),      -- Номер транзакции
					["CLASSCODE"]           = Class_Code,
					["SECCODE"]             = Sec_Code,
					["ACCOUNT"]             = Account,
					["STOP_ORDER_KIND"]     = "TAKE_PROFIT_STOP_ORDER", -- Тип стоп-заявки
					["CLIENT_CODE"]         = CC,
					['STOP_ORDER_KEY'] = tostring(nomer_zaavki)
					}
				local res = sendTransaction(trans_params)
				if string.len(res) ~= 0 then
					message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
				else
				end
				
			end;
		end;
	end;	
end

function trader.DeleteOrder(agent,Class_Code,Sec_Code)
	for i = 0,getNumberOf("orders") - 1 do
		-- ЕСЛИ строка по нужному инструменту не равна нулю ТО
		order=getItem("orders",i).flags
		if getItem("orders",i).sec_code == Sec_Code then
			-- 
			if bit.band(order,1)>0 then
				nomer_zaavki = getItem("orders",i).order_num
				local CC=agent
				local trans_params =
					{
						CLASSCODE = Class_Code,           -- Код класса
						SECCODE = Sec_Code,      		    -- Код инструмента	
						TRANS_ID = tostring(os.time()),      -- Номер транзакции
						ACTION = "KILL_ORDER",         -- Тип транзакции 
						ORDER_KEY = tostring(nomer_zaavki)
					}
				local res = sendTransaction(trans_params)
				if string.len(res) ~= 0 then
					
					message(tostring(getSecurityInfo(Class_Code,Sec_Code).short_name).."   Транзакция не прошла  ".. tostring(res))
				else
				end
				
			end;
		end;
	end;	

end

function trader.SMA(agent,Class_Code,Sec_Code, TF, Period)
	--Подключаем график
	ds, Error = CreateDataSource(Class_Code, Sec_Code, tonumber(TF))
	-- Ждет, пока данные будут получены с сервера (на случай, если такой график не открыт)
	while (Error == "" or Error == nil) and ds:Size() == 0 do sleep(1) end
	if Error ~= "" and Error ~= nil then message("Ошибка подключения к графику: "..Error) end

	Size = ds:Size() -- Возвращает текущий размер (количество свечей в источнике данных)
	local C = 0
	for i=0, Period - 1 do
		C = C + ds:C(Size - i)
	end
	ds:Close() -- Удаляет источник данных, отписывается от получения данных

	return C / Period
end

function trader.Yesterdays_closing(agent,Class_Code,Sec_Code, TF)
	--Подключаем график
	ds, Error = CreateDataSource(Class_Code, Sec_Code, tonumber(TF))
	-- Ждет, пока данные будут получены с сервера (на случай, если такой график не открыт)
	while (Error == "" or Error == nil) and ds:Size() == 0 do sleep(1) end
	if Error ~= "" and Error ~= nil then message("Ошибка подключения к графику: "..Error) end
	Size = ds:Size() -- Возвращает текущий размер (количество свечей в источнике данных)

	C = ds:C(Size - 1)

	ds:Close() -- Удаляет источник данных, отписывается от получения данных
	return C
end

function trader.MATR(agent,Class_Code,Sec_Code, TF, Period) --- return open, High, High2, Low2, Low
	--Подключаем график
	ds, Error = CreateDataSource(Class_Code, Sec_Code, tonumber(TF))
	-- Ждет, пока данные будут получены с сервера (на случай, если такой график не открыт)
	while (Error == "" or Error == nil) and ds:Size() == 0 do sleep(1) end
	if Error ~= "" and Error ~= nil then message("Ошибка подключения к графику: "..Error) end

	Size = ds:Size() -- Возвращает текущий размер (количество свечей в источнике данных)
	otklon = 0
	otklon2 = 0
	for i=1, tonumber(Period) do
		C = ds:C(Size - i)
		O = ds:O(Size - i)
		H = ds:H(Size - i)
		L = ds:L(Size - i)
		otklon = otklon + math.max((O-L),(H-O))
		otklon2 = otklon2 + ((O-L) + (H-O) / 2)
		
	end
	open = ds:O(Size)
	otklon = otklon / Period
	--otklon = otklon / 3 * 2
	otklon2 = otklon2 / Period
	otklon2 = otklon2 / 10 * 5
	High = open + otklon
	Low = open - otklon
	High2 = open + otklon2
	Low2 = open - otklon2
	ds:Close() -- Удаляет источник данных, отписывается от получения данных

	return open, High, High2, Low2, Low
end

--[[
	-- Заполняет структуру для отправки транзакции на Стоп-лосс и Тэйк-профит
	local Transaction = {
		["ACTION"]              = "NEW_STOP_ORDER", -- Тип заявки
		["TRANS_ID"]            = tostring(trans_id),
		["CLASSCODE"]           = CLASS_CODE,
		["SECCODE"]             = SEC_CODE,
		["ACCOUNT"]             = ACCOUNT,
		["OPERATION"]           = operation, -- Операция ("B" - покупка(BUY), "S" - продажа(SELL))
		["QUANTITY"]            = "1", -- Количество в лотах
		["PRICE"]               = price, -- Цена, по которой выставится заявка при срабатывании Стоп-Лосса (для рыночной заявки по акциям должна быть 0)
		["STOPPRICE"]           = stopprice, -- Цена Тэйк-Профита
		["STOP_ORDER_KIND"]     = "TAKE_PROFIT_AND_STOP_LIMIT_ORDER", -- Тип стоп-заявки
		["EXPIRY_DATE"]         = "TODAY", -- Срок действия стоп-заявки ("GTC" – до отмены,"TODAY" - до окончания текущей торговой сессии, Дата в формате "ГГММДД")
      -- "OFFSET" - (ОТСТУП)Если цена достигла Тэйк-профита и идет дальше в прибыль,
      -- то Тэйк-профит сработает только когда цена вернется минимум на 2 шага цены назад,
      -- это может потенциально увеличить прибыль
		["OFFSET"]              = tostring(2*SEC_PRICE_STEP),
		["OFFSET_UNITS"]        = "PRICE_UNITS", -- Единицы измерения отступа ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "SPREAD" - Когда сработает Тэйк-профит, выставится заявка по цене хуже текущей на 100 шагов цены,
      -- которая АВТОМАТИЧЕСКИ УДОВЛЕТВОРИТСЯ ПО ТЕКУЩЕЙ ЛУЧШЕЙ ЦЕНЕ,
      -- но то, что цена значительно хуже, спасет от проскальзывания,
      -- иначе, сделка может просто не закрыться (заявка на закрытие будет выставлена, но цена к тому времени ее уже проскочит)
		["SPREAD"]              = tostring(100*SEC_PRICE_STEP),
		["SPREAD_UNITS"]        = "PRICE_UNITS", -- Единицы измерения защитного спрэда ("PRICE_UNITS" - шаг цены, или "PERCENTS" - проценты)
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Тэйк-Профита.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
		["MARKET_TAKE_PROFIT"]  = market,
		["STOPPRICE2"]          = stopprice2, -- Цена Стоп-Лосса
		["IS_ACTIVE_IN_TIME"]   = "NO",
      -- "MARKET_TAKE_PROFIT" = ("YES", или "NO") должна ли выставится заявка по рыночной цене при срабатывании Стоп-Лосса.
      -- Для рынка FORTS рыночные заявки, как правило, запрещены,
      -- для лимитированной заявки на FORTS нужно указывать заведомо худшую цену, чтобы она сработала сразу же, как рыночная
		["MARKET_STOP_LIMIT"]   = market,
		["CLIENT_CODE"]         = "Простой MA-робот ТЭЙК-ПРОФИТ и СТОП-ЛОСС"
	}




Список возможных параметров, используемых в функции CreateDataSource():
для акций
"LOTSIZE"            -- Размер лота
"BID"                -- Лучшая цена спроса
"BIDDEPTH"           -- Спрос по лучшей цене
"BIDDEPTHT"          -- Суммарный спрос
"NUMBIDS"            -- Количество заявок на покупку
"OFFER"              -- Лучшая цена предложения
"OFFERDEPTH"         -- Предложение по лучшей цене
"OFFERDEPTHT"        -- Суммарное предложение
"NUMOFFERS"          -- Количество заявок на продажу
"OPEN"               -- Цена открытия
"HIGH"               -- Максимальная цена сделки
"LOW"                -- Минимальная цена сделки
"LAST"               -- Цена последней сделки
"CHANGE"             -- Разница цены последней к предыдущей сессии
"QTY"                -- Количество бумаг в последней сделке
"VOLTODAY"           -- Количество бумаг в обезличенных сделках
"VALTODAY"           -- Оборот в деньгах
"VALUE"              -- Оборот в деньгах последней сделки
"WAPRICE"            -- Средневзвешенная цена
"HIGHBID"            -- Лучшая цена спроса сегодня
"LOWOFFER"           -- Лучшая цена предложения сегодня
"NUMTRADES"          -- Количество сделок за сегодня
"PREVPRICE"          -- Цена закрытия
"PREVWAPRICE"        -- Предыдущая оценка
"LASTCHANGE"         -- % изменения от закрытия
"LASTTOPREVSTLPRC"   -- Разница цены последней к предыдущей сессии
"MARKETPRICETODAY"   -- Рыночная цена
"SEC_FACE_VALUE"     -- Номинал бумаги
"SEC_SCALE"          -- Точность цены

Параметры tri-файла
Параметр	Тип	Описание
CLASSCODE	-	Код класса, по которому выполняется транзакция, например TQBR. Обязательныи? параметр
SECCODE	-	Код инструмента, по которому выполняется транзакция, например SBER
ACTION	-	Вид транзакции, имеющии? одно из следующих значении?:
	«NEW_ORDER» – новая заявка,

	«NEW_NEG_DEAL» – новая заявка на внебиржевую сделку,

	«NEW_REPO_NEG_DEAL» – новая заявка на сделку РЕПО,

	«NEW_EXT_REPO_NEG_DEAL» – новая заявка на сделку модифицированного РЕПО (РЕПО-М),

	«NEW_STOP_ORDER» – новая стоп-заявка,

	«KILL_ORDER» – снять заявку,

	«KILL_NEG_DEAL» – снять заявку на внебиржевую сделку или заявку на сделку РЕПО,

	«KILL_STOP_ORDER» – снять стоп-заявку,

	«KILL_ALL_ORDERS» – снять все заявки из торговои? системы,

	«KILL_ALL_STOP_ORDERS» – снять все стоп-заявки,

	«KILL_ALL_NEG_DEALS» – снять все заявки на внебиржевые сделки и заявки на сделки РЕПО,

	«KILL_ALL_FUTURES_ORDERS» – снять все заявки на рынке FORTS,

	«MOVE_ORDERS» – переставить заявки на рынке FORTS,

	«NEW_QUOTE» – новая безадресная заявка,

	«KILL_QUOTE» – снять безадресную заявку,

	«NEW_REPORT» – новая заявка-отчет о подтверждении транзакции? в режимах РПС и РЕПО,

	«SET_FUT_LIMIT» – новое ограничение по фьючерсному счету

FIRM_ID	-	Идентификатор участника торгов (код фирмы)
ACCOUNT	-	Номер счета Треи?дера. Параметр обязателен при «ACTION» = «KILL_ALL_FUTURES_ORDERS». Параметр чувствителен к верхнему/нижнему регистру символов
CLIENT_CODE	-	20-ти символьное составное поле, может содержать код клиента и текстовыи? комментарии? (поручение) с тем же разделителем, что и при вводе заявки вручную. Необязательныи? параметр
TYPE	-	Тип заявки, необязательныи? параметр. Значения: «L» – лимитированная (по умолчанию), «M» – рыночная
MARKET_MAKER_ORDER	-	Признак того, является ли заявка заявкои? Маркет-Меи?кера. Возможные значения: «YES» или «NO». Значение по умолчанию (если параметр отсутствует): «NO»
OPERATION	-	Направление заявки, обязательныи? параметр. Значения: «S» – продать, «B» – купить
EXECUTION_CONDITION	-	Условие исполнения заявки, необязательныи? параметр. Возможные значения:
	«PUT_IN_QUEUE» – поставить в очередь (по умолчанию),

	«FILL_OR_KILL» – немедленно или отклонить,

	«KILL_BALANCE» – снять остаток

QUANTITY	-	Количество лотов в заявке, обязательныи? параметр
REPOVALUE	-	Объем сделки РЕПО-М в рублях
START_DISCOUNT	-	Начальное значение дисконта в заявке на сделку РЕПО-М
LOWER_DISCOUNT	-	Нижнее предельное значение дисконта в заявке на сделку РЕПО-М
UPPER_DISCOUNT	-	Верхнее предельное значение дисконта в заявке на сделку РЕПО-М
PRICE	-	Цена заявки, за единицу инструмента. Обязательныи? параметр. При выставлении рыночнои? заявки (TYPE=M) на Срочном рынке FORTS необходимо указывать значение цены – укажите наихудшую (минимально или максимально возможную – в зависимости от направленности), заявка все равно будет исполнена по рыночнои? цене. Для других рынков при выставлении рыночнои? заявки укажите price=0
STOPPRICE	-	Стоп-цена, за единицу инструмента. Используется только при «ACTION» = «NEW_STOP_ORDER»
STOP_ORDER_KIND	-	Тип стоп-заявки. Возможные значения:
	«SIMPLE_STOP_ORDER» – стоп-лимит,

	«CONDITION_PRICE_BY_OTHER_SEC» – с условием по другои? бумаге,

	«WITH_LINKED_LIMIT_ORDER» – со связаннои? заявкои?,

	«TAKE_PROFIT_STOP_ORDER» – тэи?к-профит,

	«TAKE_PROFIT_AND_STOP_LIMIT_ORDER» – тэи?к-профит и стоп-лимит,

	«ACTIVATED_BY_ORDER_SIMPLE_STOP_ORDER» – стоп-лимит по исполнению заявки,

	«ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER» – тэи?к-профит по исполнению заявки,

	«ACTIVATED_BY_ORDER_TAKE_PROFIT_AND_STOP_LIMIT_ORDER» – тэи?к-профит и стоп-лимит по исполнению заявки

Если параметр пропущен, то считается, что заявка имеет тип «стоп-лимит»

STOPPRICE_CLASSCODE	-	Класс инструмента условия. Используется только при «STOP_ORDER_KIND» = «CONDITION_PRICE_BY_OTHER_SEC»
STOPPRICE_SECCODE	-	Код инструмента условия. Используется только при «STOP_ORDER_KIND» = «CONDITION_PRICE_BY_OTHER_SEC»
STOPPRICE_CONDITION	-	Направление предельного изменения стоп-цены. Используется только при «STOP_ORDER_KIND» = «CONDITION_PRICE_BY_OTHER_SEC». Возможные значения: «<=» или «>=»
LINKED_ORDER_PRICE	-	Цена связаннои? лимитированнои? заявки. Используется только при «STOP_ORDER_KIND» = «WITH_LINKED_LIMIT_ORDER»
EXPIRY_DATE	-	Срок деи?ствия стоп-заявки. Возможные значения:
	«GTC» – до отмены;

	«TODAY» – до окончания текущеи? торговои? сессии;

	Дата в формате «ГГГГММДД»

STOPPRICE2	-	Цена условия «стоп-лимит» для заявки типа «Тэи?к-профит и стоп-лимит»
MARKET_STOP_LIMIT	-	Признак исполнения заявки по рыночнои? цене при наступлении условия «стоп- лимит». Значения «YES» или «NO». Параметр заявок типа «Тэи?к-профит и стоп- лимит»
MARKET_TAKE_PROFIT	-	Признак исполнения заявки по рыночнои? цене при наступлении условия «тэи?к- профит». Значения «YES» или «NO». Параметр заявок типа «Тэи?к-профит и стоп-лимит»
IS_ACTIVE_IN_TIME	-	Признак деи?ствия заявки типа «Тэи?к-профит и стоп-лимит» в течение определенного интервала времени. Значения «YES» или «NO»
ACTIVE_FROM_TIME	-	Время начала деи?ствия заявки типа «Тэи?к-профит и стоп-лимит» в формате «ЧЧММСС»
ACTIVE_TO_TIME	-	Время окончания деи?ствия заявки типа «Тэи?к-профит и стоп-лимит» в формате «ЧЧММСС»
PARTNER	-	Код организации – партнера по внебиржевои? сделке Применяется при «ACTION» = «NEW_NEG_DEAL», «ACTION» = «NEW_REPO_NEG_DEAL» или «ACTION» = «NEW_EXT_REPO_NEG_DEAL»
ORDER_KEY	-	Номер заявки, снимаемои? из торговои? системы Применяется при «ACTION» = «KILL_ORDER» или «ACTION» = «KILL_NEG_DEAL» или «ACTION» = «KILL_QUOTE»
STOP_ORDER_KEY	-	Номер стоп-заявки, снимаемои? из торговои? системы. Применяется только при «ACTION» = «KILL_STOP_ORDER»
TRANS_ID	-	Уникальныи? идентификационныи? номер заявки, значение от «1» до «2 147 483 647»
SETTLE_CODE	-	Код расчетов при исполнении внебиржевых заявок
PRICE2	-	Цена второи? части РЕПО
REPOTERM	-	Срок РЕПО. Параметр сделок РЕПО-М
REPORATE	-	Ставка РЕПО, в процентах
BLOCK_SECURITIES	-	Признак блокировки бумаг на время операции РЕПО («YES», «NO»)
REFUNDRATE	-	Ставка фиксированного возмещения, выплачиваемого в случае неисполнения второи? части РЕПО, в процентах
COMMENT	-	Текстовыи? комментарии?, указанныи? в заявке. Используется при снятии группы заявок
LARGE_TRADE	-	Признак крупнои? сделки (YES/NO). Параметр внебиржевои? сделки
CURR_CODE	-	Код валюты расчетов по внебиржевои? сделки, например «SUR» – рубли РФ, «USD» – доллары США. Параметр внебиржевои? сделки
FOR_ACCOUNT	-	Лицо, от имени которого и за чеи? счет регистрируется сделка (параметр внебиржевои? сделки). Возможные значения:
	«OWNOWN» – от своего имени, за свои? счет,

	«OWNCLI» – от своего имени, за счет клиента,

	«OWNDUP» – от своего имени, за счет доверительного управления,

	«CLICLI» – от имени клиента, за счет клиента

SETTLE_DATE	-	Дата исполнения внебиржевои? сделки
KILL_IF_LINKED_ORDER_ PARTLY_FILLED	-	Признак снятия стоп-заявки при частичном исполнении связаннои? лимитированнои? заявки. Используется только при «STOP_ORDER_KIND» = «WITH_LINKED_LIMIT_ORDER». Возможные значения: «YES» или «NO»
OFFSET	-	Величина отступа от максимума (минимума) цены последнеи? сделки. Используется при «STOP_ORDER_KIND» = «TAKE_PROFIT_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»
OFFSET_UNITS	-	Единицы измерения отступа. Возможные значения:
	«PERCENTS» – в процентах (шаг изменения – одна сотая процента),

	«PRICE_UNITS» – в параметрах цены (шаг изменения равен шагу цены по данному инструменту)

Используется при «STOP_ORDER_KIND» = «TAKE_PROFIT_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»

SPREAD	-	Величина защитного спрэда. Используется при «STOP_ORDER_KIND» = «TAKE_PROFIT_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»
SPREAD_UNITS	-	Единицы измерения защитного спрэда. Возможные значения:
	«PERCENTS» – в процентах (шаг изменения – одна сотая процента),

	«PRICE_UNITS» – в параметрах цены (шаг изменения равен шагу цены по данному инструменту)

Используется при «STOP_ORDER_KIND» = «TAKE_PROFIT_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»

BASE_ORDER_KEY	-	Регистрационныи? номер заявки-условия. Используется при «STOP_ORDER_KIND» = «ACTIVATED_BY_ORDER_SIMPLE_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»
USE_BASE_ORDER_ BALANCE	-	Признак использования в качестве объема заявки «по исполнению» исполненного количества бумаг заявки-условия. Возможные значения: «YES» или «NO». Используется при «STOP_ORDER_KIND» = «ACTIVATED_BY_ORDER_SIMPLE_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»
ACTIVATE_IF_BASE_ ORDER_PARTLY_FILLED	-	Признак активации заявки «по исполнению» при частичном исполнении заявки-условия. Возможные значения: «YES» или «NO». Используется при «STOP_ORDER_KIND» = «ACTIVATED_BY_ORDER_SIMPLE_STOP_ORDER» или «ACTIVATED_BY_ORDER_TAKE_PROFIT_STOP_ORDER»
BASE_CONTRACT	-	Идентификатор базового контракта для фьючерсов или опционов. Обязательныи? параметр снятия заявок на рынке FORTS
MODE	-	Режим перестановки заявок на рынке FORTS. Параметр операции «ACTION» = «MOVE_ORDERS» Возможные значения:
	«0» – оставить количество в заявках без изменения,

	«1» – изменить количество в заявках на новые,

	«2» – при несовпадении новых количеств с текущим хотя бы в однои? заявке, обе заявки снимаются

FIRST_ORDER_NUMBER	-	Номер первои? заявки
FIRST_ORDER_NEW_ QUANTITY	-	Количество в первои? заявке
FIRST_ORDER_NEW_ PRICE	-	Цена в первои? заявке
SECOND_ORDER_ NUMBER	-	Номер второи? заявки
SECOND_ORDER_NEW_ QUANTITY	-	Количество во второи? заявке
SECOND_ORDER_NEW_ PRICE	-	Цена во второи? заявке
KILL_ACTIVE_ORDERS	-	Признак снятия активных заявок по данному инструменту. Используется только при «ACTION» = «NEW_QUOTE». Возможные значения: «YES» или «NO»
NEG_TRADE_OPERATION	-	Направление операции в сделке, подтверждаемои? отчетом
NEG_TRADE_NUMBER	-	Номер подтверждаемои? отчетом сделки для исполнения
VOLUMEMN	-	Лимит открытых позиции?, при «Тип лимита» = «Ден.средства» или «Всего»
VOLUMEPL	-	Лимит открытых позиции?, при «Тип лимита» = «Залоговые ден.средства»
KFL	-	Коэффициент ликвидности
KGO	-	Коэффициент клиентского гарантии?ного обеспечения
USE_KGO	-	Параметр, которыи? определяет, будет ли загружаться величина КГО при загрузке лимитов из фаи?ла:
при USE_KGO=Y – величина КГО загружается.

при USE_KGO=N – величина КГО не загружается

При установке лимита на Срочном рынке Московскои? Биржи с принудительным понижением (см. п.7.7.2 Раздела 7 «Операции брокера») требуется указать USE_KGO=Y

CHECK_LIMITS	-	Признак проверки попадания цены заявки в диапазон допустимых цен. Параметр Срочного рынка FORTS. Необязательныи? параметр транзакции? установки новых заявок по классам «Опционы ФОРТС» и «РПС: Опционы ФОРТС». Возможные значения: «YES» – выполнять проверку, «NO» – не выполнять
MATCHREF	-	Ссылка, которая связывает две сделки РЕПО или РПС. Сделка может быть заключена только между контрагентами, указавшими одинаковое значение этого параметра в своих заявках. Параметр представляет собои? произвольныи? набор символов (допускаются цифры и буквы количеством до 10). Необязательныи? параметр
CORRECTION	-	Режим корректировки ограничения по фьючерсным счетам. Возможные значения:
	«Y» – включен, установкои? лимита изменяется деи?ствующее значение,

	«N» – выключен (по умолчанию), установкои? лимита задается новое значение
]]--СЂРё РЅР°СЃС‚СѓРїР»РµРЅРёРё СѓСЃР»РѕРІРёСЏ В«С‚СЌРё?Рє- РїСЂРѕС„РёС‚В». Р—РЅР°С‡РµРЅРёСЏ В«YESВ» РёР»Рё В«NOВ». РџР°СЂР°РјРµС‚СЂ Р·Р°СЏРІРѕРє С‚РёРїР° В«РўСЌРё?Рє-РїСЂРѕС„РёС‚ Рё СЃС‚РѕРї-Р»РёРјРёС‚В»
