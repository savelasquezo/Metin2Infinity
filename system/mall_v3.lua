quest mall_v3 begin
	state start begin
		when login begin
			mall_v3.set_quest_id(q.getcurrentquestindex())
		end
		
		when button begin
			local cmd = mall_v3.get_quest_cmd()
			if cmd[1] == 'OPEN_STARTPAGE' then
				local client_last_edit_mall_overview = cmd[2]
				local last_edit_mall_overview = mall_v3.get_last_edit_mall_overview()
				if client_last_edit_mall_overview != last_edit_mall_overview then
					mall_v3.set_client_loadingbar_percent(0)
					mall_v3.set_client_startpage_banners()
					mall_v3.set_client_loadingbar_percent(50)
					mall_v3.set_client_startpage_malls()
					mall_v3.set_client_last_edit_mall_overview(last_edit_mall_overview)
					mall_v3.set_client_loadingbar_percent(100)
					mall_v3.open_client_startpage()
				else
					mall_v3.open_client_startpage()
				end
			elseif cmd[1] == 'OPEN' then
				local mall_id = tonumber(cmd[2])
				if not mall_v3.IsFinite(mall_id) then return end
				if not mall_id then return end
				local client_last_edit_mall = cmd[3]
				local last_edit_mall = mall_v3.get_last_edit_mall(mall_id)
				if client_last_edit_mall != last_edit_mall then
					mall_v3.set_client_loadingbar_percent(0)
					if mall_v3.create_client_mall(mall_id) then
						mall_v3.set_client_loadingbar_percent(35)
						mall_v3.set_client_categories(mall_id)
						mall_v3.set_client_loadingbar_percent(70)
						mall_v3.set_client_items(mall_id)
						mall_v3.set_client_last_edit_mall(mall_id, last_edit_mall)
						mall_v3.set_client_loadingbar_percent(100)
						mall_v3.set_client_currency(mall_id)
						mall_v3.open_client_mall(mall_id)
					end
				else
					mall_v3.set_client_currency(mall_id)
					mall_v3.open_client_mall(mall_id)
				end
			elseif cmd[1] == 'BUY' then
				local item_id = tonumber(cmd[2])
				if not mall_v3.IsFinite(item_id) then return end
				if not item_id then return end
				if item_id < 1 then return end

				local amount = tonumber(cmd[3])
				if not mall_v3.IsFinite(amount) then return end
				if not amount then return end
				if amount > 200 then return end
				if amount < 1 then return end

				mall_v3.buy_item(item_id, amount)
			end
		end
		
		
		function file_exists(name)
			local f=io.open(name,"r")
			if f~=nil then f:close() return true else return false end
		end
		
		function write_log(text)
			local log_file = get_locale_base_path().."/quest/itemshop_log_"..os.date("%d%m%Y")..".txt"
			if not mall_v3.file_exists(log_file) then 
				local log_txt = io.open(log_file, "w+")
				log_txt:close()
			end
			local log_txt = io.open(log_file, "a+")
			local date_ = os.date("%d.%m.%Y %H:%M:%S")
			log_txt:write('accid: '..pc.get_account_id()..' name: '..pc.get_name()..' date: '..date_..' log: '..text..'\\n')
			log_txt:flush()
			log_txt:close()
		end

		function IsFinite(num)
			return not (num ~= num or tostring(num) == "inf" or tostring(num) == "-inf" )
		end
		
		function get_quest_cmd()
			cmdchat('getinputbegin')
			local ret = input(cmdchat('mall_v3 GET_QUEST_CMD()'))
			cmdchat('getinputend')
			-- mall_v3.write_log("cmd:"..ret)
			return mall_v3.split_(ret,'#')
		end

		function set_quest_id(id)
			mall_v3.send_command(string.format("SET_QUEST_ID(%d)", id))
		end

		function get_last_edit_mall_overview()
			return string.gsub(mysql_query("SELECT last_edit FROM mall.last_edit_mall_overview;").last_edit[1],' ','-')
		end
		
		function set_client_last_edit_mall_overview(last_edit)
			mall_v3.send_command('SET_LAST_UPDATE_MALL_OVERVIEW('..last_edit..')')
		end

		function get_last_edit_mall(mall_id)
			return string.gsub(mysql_query("SELECT last_edit FROM mall.last_edit_mall WHERE mall_id = "..mall_id..";").last_edit[1],' ','-')
		end
		
		function set_client_last_edit_mall(mall_id, last_edit)
			mall_v3.send_command('SET_LAST_UPDATE_MALL('..mall_id..','..last_edit..')')
		end
		
		function set_client_startpage_banners()
			mall_v3.clear_client_startpage_banners()
			
			-- max 10 banners!
			local banners = mysql_query("SELECT path FROM mall.mall_banner WHERE active = 1 ORDER BY weighting DESC LIMIT 10;")
			local bannersLen = table.getn(banners)
			
			for i = 1, bannersLen do
				mall_v3.add_client_startpage_banner(banners.path[i])
			end
		end
		
		function set_client_startpage_malls()
			mall_v3.clear_client_startpage_malls()
			
			local malls = mysql_query("SELECT * FROM mall.mall WHERE active = 1 ORDER BY weighting DESC;")
			local mallsLen = table.getn(malls)
			
			for i = 1, mallsLen do
				mall_v3.add_client_startpage_mall(malls.id[i], malls.title[i])
			end
		end
		
		function set_client_categories(mall_id)
			local categories = mysql_query("SELECT * FROM mall.mall_category_connection as mcc LEFT JOIN mall.mall_category as mc ON mc.id = mcc.category_id WHERE mcc.active = 1 AND mc.active = 1 AND mcc.mall_id = "..mall_id..";")
			local categoriesLen = table.getn(categories)
			
			for i = 1, categoriesLen do
				mall_v3.add_client_category(mall_id, categories.category_id[i], categories.title[i], categories.color[i], categories.icon_vnum[i], categories.weighting[i])
			end
		end 
		
		function set_client_items(mall_id)
			local items = mysql_query("SELECT mi.id, mi.vnum, "..
				"mi.socket0, mi.socket1, mi.socket2, mi.socket3, mi.socket4, mi.socket5, "..
				"mi.attrtype0, mi.attrvalue0, mi.attrtype1, mi.attrvalue1, mi.attrtype2, "..
				"mi.attrvalue2, mi.attrtype3, mi.attrvalue3, mi.attrtype4, mi.attrvalue4, "..
				"mi.attrtype5, mi.attrvalue5, mi.attrtype6, mi.attrvalue6, "..
				"mi.price, mi.discount_percent, UNIX_TIMESTAMP(mi.end_date) as end_date, mi.buyable_after_run_out, "..
				"mi.weighting, mi.recommended, mi.new, mcc.mall_id, mcc.category_id "..
			"FROM mall.mall_item as mi "..
				"LEFT JOIN mall.mall_category_connection as mcc ON mcc.id = mi.mall_category_connection_id "..
				"LEFT JOIN mall.mall_category as mc ON mc.id = mcc.category_id "..
				"LEFT JOIN mall.mall as m ON m.id = mcc.mall_id "..
			"WHERE mi.active = 1 AND mcc.active = 1 AND mc.active = 1 AND m.active = 1 "..
				"AND m.id = "..mall_id.." AND ((NOW() < mi.end_date OR mi.end_date = '1970-01-01 08:00:00' OR mi.end_date = '0000-00-00 00:00:00' OR mi.end_date IS NULL) "..
				"AND (NOW() > mi.start_date OR mi.start_date = '1970-01-01 08:00:00' OR mi.start_date = '0000-00-00 00:00:00' OR mi.start_date IS NULL) "..
				"OR (mi.end_date < NOW() and mi.buyable_after_run_out = 1)) "..
			"ORDER BY mi.id ASC;")

			for i = 1, table.getn(items) do
				mall_v3.add_client_item(items.id[i], items.vnum[i], items.socket0[i], items.socket1[i], items.socket2[i], items.socket3[i], items.socket4[i], items.socket5[i], items.attrtype0[i], items.attrvalue0[i], items.attrtype1[i], items.attrvalue1[i], items.attrtype2[i], items.attrvalue2[i], items.attrtype3[i], items.attrvalue3[i], items.attrtype4[i], items.attrvalue4[i], items.attrtype5[i], items.attrvalue5[i], items.attrtype6[i], items.attrvalue6[i], items.mall_id[i], items.category_id[i], items.price[i], items.discount_percent[i], items.end_date[i], items.buyable_after_run_out[i], items.weighting[i], items.recommended[i], items.new[i])
			end
		end
		
		function set_client_currency(mall_id)
			local result = mysql_query("SELECT c.title FROM mall.mall as m LEFT JOIN mall.currency as c ON c.id = m.currency_id WHERE c.active = 1 AND m.active = 1 AND m.id = "..mall_id..";")
			if table.getn(result) == 0 then
				mall_v3.mall_chat('Currency title for mall_id:'..mall_id..' not found!')
				return
			end

			mall_v3.set_client_currency_value(mall_id, mall_v3.get_currency_value(mall_id))
			mall_v3.set_client_currency_name(mall_id, result.title[1])
		end

		function get_currency_fields(mall_id)
			local currency_fields = mysql_query("SELECT c.table_name, c.column_name, c.id_type FROM mall.mall as m LEFT JOIN mall.currency as c ON c.id = m.currency_id WHERE c.active = 1 AND m.active = 1 AND m.id = "..mall_id..";")
			if table.getn(currency_fields) == 0 then
				mall_v3.mall_chat('The table_name and column_name for the currency for mall_id:'..mall_id..' was not found.')
				return
			end
			return {["table_name"]=currency_fields.table_name[1], ["column_name"]=currency_fields.column_name[1], ["id_type"]=currency_fields.id_type[1]}
		end

		function get_currency_value(mall_id)
			local currency_value = 0
			local currency_fields = mall_v3.get_currency_fields(mall_id)
			
			local id_types = {
				["account_id"] = pc.get_account_id(),
				["player_id"] = pc.get_player_id()
			}
			
			local currency_table = mysql_query("SELECT * FROM "..currency_fields["table_name"].." as a WHERE a.id = "..id_types[currency_fields["id_type"]]..";")
			if table.getn(currency_table) == 0 then
				mall_v3.mall_chat('The currency_table was not found.')
				return currency_value
			end

			if not mall_v3.key_in_table(currency_table, currency_fields["column_name"]) then
				mall_v3.mall_chat('The column_name:'..currency_fields["column_name"]..' for the currency for mall_id:'..mall_id..' was not found in account table.')
				return currency_value
			end

			return tonumber(currency_table[currency_fields["column_name"]][1])
		end

		function get_item_by_id(item_id)
			return mysql_query("SELECT mi.id, mi.vnum, "..
			"mi.socket0, mi.socket1, mi.socket2, mi.socket3, mi.socket4, mi.socket5, "..
			"mi.attrtype0, mi.attrvalue0, mi.attrtype1, mi.attrvalue1, mi.attrtype2, "..
			"mi.attrvalue2, mi.attrtype3, mi.attrvalue3, mi.attrtype4, mi.attrvalue4, "..
			"mi.attrtype5, mi.attrvalue5, mi.attrtype6, mi.attrvalue6, "..
			"mi.price, mi.discount_percent, UNIX_TIMESTAMP(mi.end_date) as end_date, UNIX_TIMESTAMP(mi.start_date) as start_date, mi.buyable_after_run_out, "..
			"mi.weighting, mi.recommended, mi.new, mcc.mall_id, mcc.category_id "..
		"FROM mall.mall_item as mi "..
			"LEFT JOIN mall.mall_category_connection as mcc ON mcc.id = mi.mall_category_connection_id "..
			"LEFT JOIN mall.mall_category as mc ON mc.id = mcc.category_id "..
			"LEFT JOIN mall.mall as m ON m.id = mcc.mall_id "..
		"WHERE mi.active = 1 AND mcc.active = 1 AND mc.active = 1 AND m.active = 1 "..
			"AND mi.id = "..item_id.." AND ((NOW() < mi.end_date OR mi.end_date = '1970-01-01 08:00:00' OR mi.end_date = '0000-00-00 00:00:00' OR mi.end_date IS NULL) "..
			"AND (NOW() > mi.start_date OR mi.start_date = '1970-01-01 08:00:00' OR mi.start_date = '0000-00-00 00:00:00' OR mi.start_date IS NULL) "..
			"OR (mi.end_date < NOW() and mi.buyable_after_run_out = 1));")
		end

		function buy_item(item_id, amount)
			mall_item = mall_v3.get_item_by_id(item_id)
			if table.getn(mall_item) == 0 then
				mall_v3.mall_chat("This item does not exist.")
				return
			end

			--local cur_item = mall_v3.get_itemproto_item(mall_item.vnum[1])
			--if table.getn(cur_item) == 0 then
			--	mall_v3.mall_chat("[Error 001]") -- Your player.item_proto table in MySQL is missing!
			--	return
			--end
			
			if tonumber(mall_item.end_date[1]) != 25200 and tonumber(mall_item.end_date[1]) != 0 then -- got an end date (not 1970-01-01 08:00:00 and not 0000-00-00 00:00:00)
				timeLeft = mall_v3.current_time_diff(mall_item.end_date[1])
				if mall_item.discount_percent[1] > 0 and timeLeft <= 0 then -- has percent and if the timeleft is <= 0 then set percent = 0
					mall_item.discount_percent[1] = 0
				end
			end
			
			if not pc.enough_inventory(mall_item.vnum[1]) then mall_v3.mall_chat("<Lamdashop> �Espacio Insuficiente!") return end

			local coins = mall_v3.get_currency_value(mall_item.mall_id[1])
			local real_price = math.floor((mall_item.price[1]*amount) - (((mall_item.price[1]*amount) / 100 ) * mall_item.discount_percent[1]))
			
			if real_price < 0 then 
				mall_v3.mall_chat("[Error 002]") -- the price of the item was negative.
				return 
			end
			
			if coins < real_price then mall_v3.mall_chat("<Lamdashop> �Coins Insuficiente!") return end
			
			local new_coins = coins-real_price
			
			mall_v3.set_currency_value(mall_item.mall_id[1], new_coins, real_price)
			mall_v3.set_client_currency_value(mall_item.mall_id[1], new_coins)

			pc.give_item2_select(mall_item.vnum[1], amount)
			--if cur_item.limittype0[1] == 7 then -- realtime item?
			--	item.set_socket(0,mall_item.socket0[1]+os.time())
			--else
				item.set_socket(0,mall_item.socket0[1])
			--end
			item.set_socket(1,mall_item.socket1[1])
			item.set_socket(2,mall_item.socket2[1])
			--if cur_item.type[1] != 28 and cur_item.magic_pct[1] != 100 then -- costume bonus fix
			if item.get_type(mall_item.vnum[1]) != 28 then -- costume bonus fix
				if mall_item.attrvalue0[1] > 0 then
					item.set_value(0,mall_item.attrtype0[1],mall_item.attrvalue0[1])
				end
				if mall_item.attrvalue1[1] > 0 then
					item.set_value(0,mall_item.attrtype1[1],mall_item.attrvalue1[1])
				end
				if mall_item.attrvalue2[1] > 0 then
					item.set_value(0,mall_item.attrtype2[1],mall_item.attrvalue2[1])
				end
				if mall_item.attrvalue3[1] > 0 then
					item.set_value(0,mall_item.attrtype3[1],mall_item.attrvalue3[1])
				end
				if mall_item.attrvalue4[1] > 0 then
					item.set_value(0,mall_item.attrtype4[1],mall_item.attrvalue4[1])
				end
				if mall_item.attrvalue5[1] > 0 then
					item.set_value(0,mall_item.attrtype5[1],mall_item.attrvalue5[1])
				end
				if mall_item.attrvalue6[1] > 0 then
					item.set_value(0,mall_item.attrtype6[1],mall_item.attrvalue6[1])
				end
			end
			mall_v3.mall_chat("<Lamdashop> �Compra Exitosa!")
			mall_v3.log_mall_item(item_id, mall_item.vnum[1], mall_item.socket0[1],mall_item.socket1[1],mall_item.socket2[1],mall_item.socket3[1],mall_item.socket4[1],mall_item.socket5[1], mall_item.attrtype0[1], mall_item.attrvalue0[1], mall_item.attrtype1[1], mall_item.attrvalue1[1], mall_item.attrtype2[1], mall_item.attrvalue2[1], mall_item.attrtype3[1], mall_item.attrvalue3[1], mall_item.attrtype4[1], mall_item.attrvalue4[1], mall_item.attrtype5[1], mall_item.attrvalue5[1], mall_item.attrtype6[1], mall_item.attrvalue6[1], mall_item.mall_id[1], mall_item.category_id[1], mall_item.price[1], real_price, mall_item.discount_percent[1], mall_item.start_date[1], mall_item.end_date[1], amount, coins, new_coins)
		end
		
		--function get_itemproto_item(vnum)
		--	return mysql_query('SELECT limittype0, type, magic_pct, flag FROM player.item_proto where vnum = '..vnum)
		--end
		
		function log_mall_item(mall_item_id, vnum, socket0,socket1,socket2,socket3,socket4,socket5, attrtype0,attrvalue0, attrtype1,attrvalue1, attrtype2,attrvalue2, attrtype3,attrvalue3, attrtype4,attrvalue4, attrtype5,attrvalue5, attrtype6,attrvalue6, mall_id, category_id, price,real_price, discount_percent, start_date, end_date, count, coins, new_coins)
			mysql_query("INSERT INTO mall.mall_item_purchase_log(mall_item_id, vnum, socket0,socket1,socket2,socket3,socket4,socket5, attrtype0,attrvalue0, attrtype1,attrvalue1, attrtype2,attrvalue2, attrtype3,attrvalue3, attrtype4,attrvalue4, attrtype5,attrvalue5, attrtype6,attrvalue6, mall_id, category_id, price,real_price, discount_percent, start_date, end_date, count, account_currency_old_value, account_currency_new_value, account_id, purchase_date) VALUES("..mall_item_id..","..vnum..","..socket0..","..socket1..","..socket2..","..socket3..","..socket4..","..socket5..","..attrtype0..","..attrvalue0..","..attrtype1..","..attrvalue1..","..attrtype2..","..attrvalue2..","..attrtype3..","..attrvalue3..","..attrtype4..","..attrvalue4..","..attrtype5..","..attrvalue5..","..attrtype6..","..attrvalue6..","..mall_id..","..category_id..","..price..","..real_price..","..discount_percent..","..start_date..","..end_date..","..count..","..coins..","..new_coins..","..pc.get_account_id()..",CURRENT_TIMESTAMP)")
		end

		function set_currency_value(mall_id, value, real)
			local currency_fields = mall_v3.get_currency_fields(mall_id)
			local id_types = {
				["account_id"] = pc.get_account_id(),
				["player_id"] = pc.get_player_id()
			}
			if currency_fields["column_name"] == "cheque" then
				pc.change_cheque(-real)
				mysql_direct_query("UPDATE player.player SET cheque = "..pc.get_cheque().." WHERE id = "..pc.get_player_id()..";")
			else
				mysql_query("UPDATE "..currency_fields["table_name"].." SET "..currency_fields["column_name"].." = "..value.." WHERE id = "..id_types[currency_fields["id_type"]])
			end
		end
		
		function open_client_startpage()
			mall_v3.send_command('OPEN_STARTPAGE()')
		end
		
		function open_client_mall(mall_id)
			mall_v3.send_command('OPEN('..mall_id..')')
		end
		
		function set_client_currency_name(mall_id, name)
			mall_v3.send_command('SET_CURRENCY_NAME('..mall_id..','..string.gsub(name,' ','_')..')')
		end
		
		function set_client_currency_value(mall_id, value)
			mall_v3.send_command('SET_CURRENCY_VALUE('..mall_id..','..value..')')
		end
		
		function set_client_loadingbar_percent(percent)
			mall_v3.send_command('SET_LOADINGBAR_PERCENT('..percent..')')
		end
		
		function add_client_startpage_mall(id, title)
			mall_v3.send_command('ADD_STARTPAGE_MALL('..id..','..string.gsub(title,' ','_')..')')
		end
		
		function add_client_startpage_banner(path)
			mall_v3.send_command('ADD_STARTPAGE_BANNER('..string.gsub(path,' ','_')..')')
		end
		
		function add_client_category(mall_id, id, title, color, icon_vnum, weighting)
			mall_v3.send_command('ADD_CATEGORY('..mall_id..','..id..','..string.gsub(title,' ','_')..','..color..','..icon_vnum..','..weighting..')')
		end
		
		function add_client_item(id, vnum, socket0, socket1, socket2, socket3, socket4, socket5, attrtype0, attrvalue0, attrtype1, attrvalue1, attrtype2, attrvalue2, attrtype3, attrvalue3, attrtype4, attrvalue4, attrtype5, attrvalue5, attrtype6, attrvalue6, mall_id, category_id, price, discount_percent, end_date, buyable_after_run_out, weighting, recommended, new)
			mall_v3.send_command('ADD_ITEM('..id..','..vnum..','..socket0..','..socket1..','..socket2..','..socket3..','..socket4..','..socket5..','..attrtype0..','..attrvalue0..','..attrtype1..','..attrvalue1..','..attrtype2..','..attrvalue2..','..attrtype3..','..attrvalue3..','..attrtype4..','..attrvalue4..','..attrtype5..','..attrvalue5..','..attrtype6..','..attrvalue6..','..mall_id..','..category_id..','..price..','..discount_percent..','..end_date..','..buyable_after_run_out..','..weighting..','..recommended..','..new..')')
		end
		
		function clear_client_startpage_banners()
			mall_v3.send_command('CLEAR_STARTPAGE_BANNERS()')
		end
		
		function clear_client_startpage_malls()
			mall_v3.send_command('CLEAR_STARTPAGE_MALLS()')
		end
		
		function create_client_mall(mall_id)
			mall_v3.remove_client_mall(mall_id)
			local mall = mysql_query("SELECT m.title, m.buy_coins_url FROM mall.mall as m WHERE active = 1 AND m.id = "..mall_id..";")
			if table.getn(mall) == 0 then
				mall_v3.mall_chat('Mall with id:'..mall_id..' not found!')
				return 
			end
			mall_v3.send_command('CREATE_MALL('..mall_id..','..string.gsub(mall.title[1],' ','_')..','..mall.buy_coins_url[1]..')')
			return mall_id
		end

		function remove_client_mall(mall_id)
			mall_v3.send_command('REMOVE_MALL('..mall_id..')')
		end
		
		function send_command(command)
			-- mall_v3.mall_chat('send command: '..command)
			cmdchat('mall_v3 '..command)
		end

		function mall_chat(text)
			syschat(""..text)
		end

		function key_in_table(table, key)
			for k, v in pairs(table) do
				if k == key then return true end
			end
			return false
		end
		
		function current_time_diff(date_)
			return os.difftime(date_, os.time({day=os.date("%d"),month=os.date("%m"),year=os.date("%Y"),hour=os.date("%H"),min=os.date("%M"),sec=os.date("%S")}))
		end
		
		function split_(string_, sep)
			local sep, fields = sep or ":", {}
			local pattern = string.format("([^%s]+)", sep)
			string.gsub(string_,pattern, function(c) fields[table.getn(fields)+1] = c end)
			return fields
		end
	end
end
