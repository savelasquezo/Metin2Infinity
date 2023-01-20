quest SystemRank begin
	state start begin
		when login begin
			cmdchat("recordquest index/"..q.getcurrentquestindex())
		end
		when button begin
			cmdchat("getinputbegin")
			local INPUT = split(input(cmdchat("recordquest input/")), "/")
			cmdchat("getinputend")
			local rank = tonumber(INPUT[3])
			if rank == nil then 
				return 
			end
			if game.get_event_flag("recordsorgu_"..pc.get_channel_id().."_"..rank) < get_time() then
				if rank == nil then return 
				elseif rank == 1 then
					rkn1 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn1,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn1 DESC LIMIT 10')
				elseif rank == 2 then
					rkn2 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn2,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn2 DESC LIMIT 10')
				elseif rank == 3 then
					rkn3 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn3,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn3 DESC LIMIT 10')
				elseif rank == 4 then
					rkn4 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn4,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn4 DESC LIMIT 10')
				elseif rank == 5 then
					rkn5 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn5,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn5 DESC LIMIT 10')
				--elseif rank == 6 then
				--	rkn6 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn6,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn6 DESC LIMIT 10')
				--elseif rank == 7 then
				--	rkn7 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn7,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn7 DESC LIMIT 10')
				--elseif rank == 8 then
				--	rkn8 = game.mysql_query2('SELECT player.name,player.level,player.rcrd_rkn8,player_index.empire AS empire FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id ORDER BY player.rcrd_rkn8 DESC LIMIT 10')
				end
				game.set_event_flag("recordsorgu_"..pc.get_channel_id().."_"..rank,get_time()+60)
			end
			if INPUT[1]=="sayfa" then
				if rank == nil then return 
				elseif rank == 1 then
					SystemRank.recordquest_list(rkn1,tonumber(INPUT[2]))
				elseif rank == 2 then
					SystemRank.recordquest_list(rkn2,tonumber(INPUT[2]))
				elseif rank == 3 then
					SystemRank.recordquest_list(rkn3,tonumber(INPUT[2]))
				elseif rank == 4 then
					SystemRank.recordquest_list(rkn4,tonumber(INPUT[2]))
				elseif rank == 5 then
					SystemRank.recordquest_list(rkn5,tonumber(INPUT[2]))
				--elseif rank == 6 then
				--	SystemRank.recordquest_list(rkn6,tonumber(INPUT[2]))
				--elseif rank == 7 then
				--	SystemRank.recordquest_list(rkn7,tonumber(INPUT[2]))
				--elseif rank == 8 then
				--	SystemRank.recordquest_list(rkn8,tonumber(INPUT[2]))
				end
			elseif INPUT[1]=="isim" then
				if rank == nil then return 
				elseif rank == 1 then
					SystemRank.recordquest_send(rkn1,tonumber(INPUT[2]))
				elseif rank == 2 then
					SystemRank.recordquest_send(rkn2,tonumber(INPUT[2]))
				elseif rank == 3 then
					SystemRank.recordquest_send(rkn3,tonumber(INPUT[2]))
				elseif rank == 4 then
					SystemRank.recordquest_send(rkn4,tonumber(INPUT[2]))
				elseif rank == 5 then
					SystemRank.recordquest_send(rkn5,tonumber(INPUT[2]))
				--elseif rank == 6 then
				--	SystemRank.recordquest_send(rkn6,tonumber(INPUT[2]))
				--elseif rank == 7 then
				--	SystemRank.recordquest_send(rkn7,tonumber(INPUT[2]))
				--elseif rank == 8 then
				--	SystemRank.recordquest_send(rkn8,tonumber(INPUT[2]))
				end
			end
		end
		function recordquest_list(list,sayfa)
			cmdchat("recordquest yeniliste/")
			if list==nil or table.getn(list)==0 then 
				cmdchat("recordwarning bilgiyok") 
				return 
			end
			local toplam = table.getn(list)
			cmdchat("recordquest sayfa/"..sayfa)
			SystemRank.send_list_to_client(list,sayfa,toplam)
		end
		function recordquest_send(list,name)
			cmdchat("recordquest yeniliste/")
			if list==nil or table.getn(list)==0 then 
				cmdchat("recordwarning bilgiyok") 
				return 
			end
			local pos, count, sayfa, toplam = 0, 0, 0, table.getn(list)
			for i=1, toplam, 1 do 
				if list[i][1]==name then
					pos = i
					break
				end
			end
			if pos == 0 then cmdchat("recordwarning oyuncuyok") return end
			for i=0, toplam, 1 do
				if count>pos then
					sayfa = i
					break
				else
					count = count +10
				end
			end
			cmdchat("recordquest sayfa/"..sayfa)
			SystemRank.send_list_to_client(list,sayfa,toplam)
		end
		function send_list_to_client(list,sayfa,toplam)
			local ende = 0
			for a = tonumber(sayfa), tonumber(toplam), 1 do 
				for b = 1, 10, 1 do
					local c = 10 * ( a - 1 ) + b
					cmdchat("recordquest liste/"..c.."|"..list[c][1].."|"..list[c][2].."|"..list[c][3].."|"..list[c][4])
					if c==toplam then ende=1 break end
				end
				if a==1 and ende==1 then cmdchat("recordquest blok/0") break
				elseif a==1 then cmdchat("recordquest blok/1") break
				elseif ende==1 then cmdchat("recordquest blok/2") break
				else cmdchat("recordquest blok/3") break
				end
			end
		end
	end
end
