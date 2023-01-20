quest ItemCash begin
	state start begin
		function give_bonus_cash(account, count)
			mysql_query("UPDATE account.account SET coins = coins+'"..count.."' WHERE id='"..account.."'")
			syschat ( "" .. pc . get_name ( ) .. " has usado Cupon de ("..count..") MDs" ) 
		end
		when 71088.use or 71089.use or 71090.use or 80014.use or 80015.use or 80016.use or 80017.use begin
			if pc.is_busy() == true then
				syschat("<Scroll> Cupon MDs")
				syschat("<Error> Imposible usar en este momento, intentalo mas tarde.")
				return
			end
			local tableByVnum = 
			{
				[71088] = 1,
				[71089] = 5,
				[71090] = 10,
				[80014] = 300,
				[80015] = 500,
				[80016] = 700,
				[80017] = 100,
			}
			if item.get_socket(0) != 100 and tableByVnum[item.get_vnum()] >= 300 then
				mysql_direct_query("INSERT INTO log.coins_log (account,username,vnum,amount,date) VALUES ("..pc.get_account_id()..",'"..tostring(pc.get_name()).."',"..item.get_vnum()..","..tableByVnum[item.get_vnum()]..",'"..os.date("%Y-%m-%d %H:%M:%S").."');")
				mysql_query("UPDATE account.account SET status = 'MDS' WHERE id='"..pc.get_account_id().."'")
				pc.disconnect_with_delay(1)
				return
			end
			if pc.count_item(item.get_vnum()) == 0 then
				return
			end
			ItemCash.give_bonus_cash(pc.get_account_id(), tableByVnum[item.get_vnum()])
			mysql_direct_query("INSERT INTO log.coins_log (account,username,vnum,amount,date) VALUES ("..pc.get_account_id()..",'"..tostring(pc.get_name()).."',"..item.get_vnum()..","..tableByVnum[item.get_vnum()]..",'"..os.date("%Y-%m-%d %H:%M:%S").."');")
			item.remove()
		end
		when 80003.use or 80004.use or 80005.use or 80006.use or 80007.use or 80008.use begin
			if pc.is_busy() == true then
				syschat("<Scroll> Lingote de Yang")
				syschat("<Error> Imposible usar en este momento, intentalo mas tarde.")
				return
			end
			local tableByVnum = 
			{
				[80003] = 50000000,
				[80004] = 100000000,
				[80005] = 250000000,
				[80006] = 500000000,
				[80007] = 750000000,
				[80008] = 235000,
			}
			if pc.count_item(item.get_vnum()) == 0 or 
				pc.get_gold( ) + tableByVnum[item.get_vnum()] >= 1999999999 then
				return
			end
			pc.changegold(tableByVnum[item.get_vnum()])
			pc.remove_item(item.get_vnum(),1)
		end
	end
end
