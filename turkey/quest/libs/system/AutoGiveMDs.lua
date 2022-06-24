quest AutoGiveMDs begin
	state start begin
		when login begin
			local tiempo = 10800
			local monede = mysql_query("SELECT coins from account.account WHERE id="..pc.get_account_id().." LIMIT 1;")[1][1]
			if pc.getqf("GiveMDs") == 1 then
				if pc.getqf("MSMGiveMDs") == 1 then
					syschat("|cff56ff00|H|h[ItemShop]|h|r MDs Actuales: |cffffa700|H|h" .. monede .. "|h|r - Obtienes 5MDs / 3 Horas Online!")
					pc.setqf("MSMGiveMDs",0)
				end
				return
			end
			pc.setqf("GiveMDs",1)
			syschat("|cff56ff00|H|h[ItemShop]|h|r MDs Actuales: |cffffa700|H|h" .. monede .. "|h|r - Obtienes 5MDs / 3 Horas Online!")
			loop_timer("LoopTimerAutoMDs", tiempo)
		end
		when LoopTimerAutoMDs.timer begin
			pc.setqf("MSMGiveMDs",1)
			local suma_monede = 5
			local selectare_tabel = mysql_query("SELECT coins from account.account WHERE id="..pc.get_account_id().." LIMIT 1")
			local monede = mysql_query("SELECT coins from account.account WHERE id="..pc.get_account_id().." LIMIT 1;")[1][1]
			mysql_query("UPDATE account.account SET coins ='"..(selectare_tabel.coins[1]+suma_monede).."' WHERE id="..pc.get_account_id().." LIMIT 1")
			syschat("|cff56ff00|H|h[ItemShop]|h|r |cffffa700|H|h".. suma_monede .."|h|r MDs Agregadas!")
			syschat("|cff56ff00|H|h[ItemShop]|h|r MDs Actuales: |cffffa700|H|h" .. monede .. "|h|r - Obtienes 5MDs / 3 Horas Online!")
		end
	end
end
