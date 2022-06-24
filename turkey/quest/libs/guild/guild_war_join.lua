quest guild_war_join begin
	state start begin
		when letter with ( pc.get_map_index() != 71 and pc.get_map_index() != 104 and pc.get_map_index() != 72 and  pc.get_map_index() != 73 and pc.get_map_index() != 208) and pc.get_map_index() <= 200 begin
			local e = guild.get_any_war()
			if e != 0 and pc.get_war_map() == 0 then
				setskin(NOWINDOW)
				makequestbutton("Guerra de Gremios")
			end
		end
		when button begin
			local e = guild.get_any_war()
			if e == 0 then
				say("No hay combates actualmente.")
			else
				say(""..guild.name(e).."Le gustaria participar en una batalla contra un gremio?")
				local s = select("Si", "No")
				if s == 1 then
					guild.war_enter(e)
				else
					setskin(NOWINDOW)
				makequestbutton("Guerra de Gremios")
				end
			end
		end
	end
end
