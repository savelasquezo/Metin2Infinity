quest GuildSystem7 begin
	state start begin
		when kill with npc.is_pc() begin
			local benimvid = pc.get_vid()
			local karsivid = npc.get_vid()
			local benimlonca = guild.get_name(pc.get_guild())
			pc.select(karsivid)
			local karsilonca = guild.get_name(pc.get_guild())
			pc.select(benimvid)
			if pc.get_map_index() >= 1100000 and pc.get_map_index() <= 1120000 then
				if benimlonca != karsilonca then
				local oldurme = game.get_event_flag(""..benimlonca..""..pc.get_name().."oldurme")
				game.set_event_flag(""..benimlonca..""..pc.get_name().."oldurme",oldurme+1)
				local oldurmeskor = pc.getf("loncaistatistik","oldurme")
				local oldurmeskortoplam = oldurmeskor+1
				pc.setf("loncaistatistik","oldurme",oldurmeskortoplam)
				pc.select(karsivid)
				local olumunkaclen = game.get_event_flag(""..karsilonca..""..pc.get_name().."olum")
				game.set_event_flag(""..karsilonca..""..pc.get_name().."olum",olumunkaclen+1)
				local olumskor = pc.getf("loncaistatistik","olum")
				local olumskortoplam = olumskor+1
					pc.setf("loncaistatistik","olum",olumskortoplam)
				end
			end
		end
		when login begin
			pc.setf("loncaistatistik","olum",0)
			pc.setf("loncaistatistik","oldurme",0)
		end
	end
end
