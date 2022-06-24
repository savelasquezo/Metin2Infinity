quest GuildSystem6 begin
	state start begin
		when login begin
			cmdchat("loncasiralama index/"..q.getcurrentquestindex())
		end
		when button begin
			cmdchat("getinputbegin")
			local INPUT = split(input(cmdchat("loncasiralama input/")), "/")
			cmdchat("getinputend")
			loncasiralamasi = game.mysql_query2("SELECT guild.name,guild.lider,guild.level,guild.id,guild.win,guild.draw,guild.loss,guild.bayrak FROM player.guild ORDER BY guild.level DESC, guild.ladder_point DESC;")
			if INPUT[1]=="sayfa" then
				GuildSystem6.liste_olustur(loncasiralamasi,tonumber(INPUT[2]))
			elseif INPUT[1]=="isim" then
				GuildSystem6.oyuncu_ara(loncasiralamasi,INPUT[2])
			end
		end
		function liste_olustur(list,sayfa)
			cmdchat("loncasiralama yeniliste/")
			if list==nil then cmdchat("uyariloncasira bilgiyok") return end
			local toplam = table.getn(list)
			cmdchat("loncasiralama sayfa/"..sayfa)
			GuildSystem6.send_list_to_client(list,sayfa, toplam)
		end
		function oyuncu_ara(list,name)
			cmdchat("loncasiralama yeniliste/")
			if list==nil then cmdchat("uyariloncasira bilgiyok") return end
			local pos, count, sayfa, toplam = 0, 0, 0, table.getn(list)
			for i=1, toplam, 1 do 
				if list[i][1]==name then
					pos = i
					break
				end
			end
			if pos == 0 then cmdchat("uyariloncasira oyuncuyok") return end
			for i=0, toplam, 1 do
				if count>pos then
						sayfa = i
						break
				else
					count = count +10
				end
			end
			cmdchat("loncasiralama sayfa/"..sayfa)
			GuildSystem6.send_list_to_client(list,sayfa, toplam)
		end
		function send_list_to_client(list,sayfa, toplam)
			local ende = 0
			for a = sayfa, toplam, 1 do 
				for b = 1, 10, 1 do
					local c = 10 * ( a - 1 ) + b
					local durum = ""
					local kisi = guild.kac_kisi(list[c][4])
					local win = list[c][5].."-"..list[c][6].."-"..list[c][7]
					if guild.master_online(list[c][4]) then
						durum = "On"
					else
						durum = "Off"
					end
					cmdchat("loncasiralama liste/"..c.."|"..list[c][1].."|"..list[c][3].."|"..kisi.."|"..list[c][8].."|"..list[c][2].."|"..durum)
					if c==toplam then ende=1 break end
				end
				if a==1 and ende==1 then cmdchat("loncasiralama blok/0") break
				elseif a==1 then cmdchat("loncasiralama blok/1") break
				elseif ende==1 then cmdchat("loncasiralama blok/2") break
				else cmdchat("loncasiralama blok/3") break
				end
			end
		end
	end
end