quest GuildSystem1 begin
	state start begin
		when login begin
			cmdchat("loncatanitim index/"..q.getcurrentquestindex())
		end
		function split(str, delim, maxNb)
			if str == nil then return str end
			if string.find(str, delim) == nil then return { str } end
			if maxNb == nil or maxNb < 1 then maxNb = 0 end
			local result = {}
			local pat = "(.-)" .. delim .. "()"
			local nb = 0
			local lastPos
			for part, pos in string.gfind(str, pat) do
				nb = nb + 1
				result[nb] = part
				lastPos = pos
				if nb == maxNb then break end
			end
			if nb ~= maxNb then result[nb + 1] = string.sub(str, lastPos) end
			return result
		end
		when button begin
			cmdchat("getinputbegin")
			local INPUT = GuildSystem1.split(input(cmdchat("loncatanitim input/")), "/")
			cmdchat("getinputend")
			if INPUT[1]=="sayfa" then
				GuildSystem1.liste_olustur(lonca_tanitim_tablosu,tonumber(INPUT[2]))
			elseif INPUT[1]=="isim" then
				GuildSystem1.lonca_ara(lonca_tanitim_tablosu,INPUT[2])
			end
		end
		function liste_olustur(list,sayfa)
			cmdchat("loncatanitim yeniliste/")
			if list==nil then cmdchat("uyari bilgiyok") return end
			local toplam = table.getn(list)
			cmdchat("loncatanitim sayfa/"..sayfa)
			GuildSystem1.send_list_to_client(list,sayfa, toplam)
		end
		function lonca_ara(list,name)
			cmdchat("loncatanitim yeniliste/")
			if list==nil then cmdchat("uyari bilgiyok") return end
			local pos, count, sayfa, toplam = 0, 0, 0, table.getn(list)
			for i=1, toplam, 1 do 
				if list[i][1]==name then
					pos = i
					break
				end
			end
			if pos == 0 then cmdchat("uyari loncayok") return end
			for i=0, toplam, 1 do
				if count>pos then
						sayfa = i
						break
				else
					count = count +10
				end
			end
			cmdchat("loncatanitim sayfa/"..sayfa)
			GuildSystem1.send_list_to_client(list,sayfa, toplam)
		end
		function send_list_to_client(list,sayfa, toplam)
			local ende = 0
			for a = sayfa, toplam, 1 do 
				for b = 1, 10, 1 do
					local c = 10 * ( a - 1 ) + b
					local rc = list[c][9]
					local online = 0
					local kisi = guild.kac_kisi(list[c][4])
					local win = list[c][5].."-"..list[c][6].."-"..list[c][7]
					if guild.master_online(list[c][4]) then
						online = 1
					end
					cmdchat("loncatanitim liste/"..list[c][1].."|"..list[c][2].."|"..rc.."|"..kisi.."|"..list[c][3].."|"..win.."|"..list[c][8].."|"..online)
					if c==toplam then ende=1 break end
				end
				if a==1 and ende==1 then cmdchat("loncatanitim blok/0") break
				elseif a==1 then cmdchat("loncatanitim blok/1") break
				elseif ende==1 then cmdchat("loncatanitim blok/2") break
				else cmdchat("loncatanitim blok/3") break
				end
			end
		end
	end
end
