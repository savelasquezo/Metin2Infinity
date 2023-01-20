quest GuildSystem3 begin
	state start begin
		when login begin
			cmdchat("lonca_lider_q "..q.getcurrentquestindex())
		end
		when button or info begin
			if pc.has_guild() and pc.is_guild_master() then
				cmdchat("lider_sifirla")
				local query=[[SELECT guild.`id` AS guildid, guild.`name` AS guildname, player.`name` AS playername FROM guild LEFT JOIN player.player ON player.id = guild.master;]]
				local gelen, gelen2 = mysql_direct_query2(query)
				if gelen == nil or gelen == 0 then return end
				for say, sec in ipairs(gelen2) do
					if guild.master_online(""..sec.guildid.."") then
						cmdchat("lider_ekle "..sec.playername.." "..sec.guildname.."")
					end
				end
			end
		end
	end
end
