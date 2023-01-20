quest guild_war_observer begin
	state start begin
		when 11001.chat."Lista de Guerras" or 11003.chat."Lista de Guerras" or 11005.chat."Lista de Guerras" begin
			local g = guild.get_warp_war_list()
			local gname_table = {}
			table.foreachi(g,
				function(n, p) 
					gname_table[n] = guild.get_name(p[1]).." vs "..guild.get_name(p[2])
				end
			)
			if table.getn(g) == 0 then
				say_title("Alguacil de Batalla")
				say("No hay ninguna Guerra de Gremios.")
				say("")
				return
			end
			say_title("Alguacil de Batalla")
			gname_table[table.getn(g)+1] = locale.confirm
			local s = select_table(gname_table)
			say_reward("Desea observar la Guerra?")
			say("")
			if s != table.getn(gname_table) then
				pc.warp_to_guild_war_observer_position(g[s][1], g[s][2])
			end
		end
	end
end
