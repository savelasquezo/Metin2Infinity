quest GuildSystem4 begin
	state start begin	
		when login begin
			cmdchat("gecmis_q "..q.getcurrentquestindex())
		end
		when button or info begin
			if pc.has_guild() and pc.is_guild_master() then
				cmdchat("gecmistemizle")
				local name = GuildSystem4.get_input("isim_ver")
				local query2=[[SELECT player.lonca_gecmis.guild FROM player.lonca_gecmis WHERE player.lonca_gecmis.name = '"..name.."';]]
				local res11, res22 = mysql_direct_query2(query2)
				if res11 == nil or res11 == 0 then return end
				for num1, str11 in ipairs(res22) do
					cmdchat("lonca_gecmis_ekle "..str11.guild.."")
				end
			end
		end
		function get_input(par)
			cmdchat("getinputbegin")
			local ret = input(cmdchat(par))
			cmdchat("getinputend")
			return ret
		end
	end
end
