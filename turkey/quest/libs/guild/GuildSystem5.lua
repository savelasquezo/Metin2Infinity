quest GuildSystem5 begin
	state start begin
		when login begin
			cmdchat("oyunicisiralama index/"..q.getcurrentquestindex())
		end
		when button begin
			cmdchat("getinputbegin")
			local INPUT = split(input(cmdchat("oyunicisiralama input/")), "/")
			cmdchat("getinputend")
			local blokk = "BLOCK"
			local gmmi = "[%]%"
			siralama = game.mysql_query2('SELECT player.id,player.name,player.job,player.level,player.exp,player_index.empire,guild.name AS guild_name FROM player.player LEFT JOIN player.player_index ON player_index.id=player.account_id LEFT JOIN player.guild_member ON guild_member.pid=player.id LEFT JOIN player.guild ON guild.id=guild_member.guild_id INNER JOIN account.account ON account.id=player.account_id WHERE player.name NOT LIKE \\"'..gmmi..'\\" AND account.status != \\"'..blokk..'\\" ORDER BY player.level DESC;')
			if INPUT[1]=="sayfa" then
				GuildSystem5.liste_olustur(siralama,tonumber(INPUT[2]))
			elseif INPUT[1]=="isim" then
				GuildSystem5.oyuncu_ara(siralama,INPUT[2])
			end
		end
		function liste_olustur(list,sayfa)
			cmdchat("oyunicisiralama yeniliste/")
			if list==nil then cmdchat("uyarisiralama bilgiyok") return end
			local toplam = table.getn(list)
			cmdchat("oyunicisiralama sayfa/"..sayfa)
			GuildSystem5.send_list_to_client(list,sayfa, toplam)
		end
		function oyuncu_ara(list,name)
			cmdchat("oyunicisiralama yeniliste/")
			if list==nil then cmdchat("uyarisiralama bilgiyok") return end
			local pos, count, sayfa, toplam = 0, 0, 0, table.getn(list)
			for i=1, toplam, 1 do 
				if list[i][2]==name then
					pos = i
					break
				end
			end
			if pos == 0 then cmdchat("uyarisiralama oyuncuyok") return end
			for i=0, toplam, 1 do
				if count>pos then
						sayfa = i
						break
				else
					count = count +10
				end
			end
			cmdchat("oyunicisiralama sayfa/"..sayfa)
			GuildSystem5.send_list_to_client(list,sayfa, toplam)
		end
		function send_list_to_client(list,sayfa, toplam)
			local ende = 0
			for a = sayfa, toplam, 1 do 
				for b = 1, 10, 1 do
					local c = 10 * ( a - 1 ) + b
					local durum = ""
					local lonca = ""
					if pc.online(list[c][2]) then
						durum = "On"
					else
						durum = "Off"
					end
					if list[c][7] == nil or list[c][7] == "" or list[c][7] == "NULL" then
						lonca = "Yok"
					else
						lonca = list[c][7]
					end
					cmdchat("oyunicisiralama liste/"..c.."|"..list[c][2].."|"..list[c][4].."|"..list[c][3].."|"..list[c][6].."|"..lonca.."|"..durum)
					if c==toplam then ende=1 break end
				end
				if a==1 and ende==1 then cmdchat("oyunicisiralama blok/0") break
				elseif a==1 then cmdchat("oyunicisiralama blok/1") break
				elseif ende==1 then cmdchat("oyunicisiralama blok/2") break
				else cmdchat("oyunicisiralama blok/3") break
				end
			end
		end
	end
end
