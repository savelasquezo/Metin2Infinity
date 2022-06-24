quest guild_building begin
	state start begin
		when 20040.click begin
			say_title("Administrador:")
			say("Solo los lideres de gremio tienen permitido")
			say("comprar terrenos para construir sus Edificaciones.")
			say("Quieres comprar estas Tierras?  ")
			say("")
			local s =  select( "Si", "No" )
			if s == 1 then
				if not pc.is_guild_master() then
					say_title("Administrador:")
					say("Solo vendere a los lideres de gremio.")
					say("")
				elseif building.has_land(pc.get_guild()) then
					say_title("Administrador:")
					say("Un gremio que ya posee una tierra")
					say("No puede comprar mas terrenos. ")
					say("")
				else
					local land_id = building.get_land_id(pc.get_map_index(), pc.get_x()*100, pc.get_y()*100)
					if land_id == 0 then
						say_title("Administrador:")
						say("Ha ocurrido un error en la orden.")
						say("")
					else
						local price, owner, guild_level_limit = building.get_land_info(land_id)
						say_title("Administrador:")
						say(string.format("Comprar esta tierra el nivel[ENTER]de tu gremio debe ser %s[ENTER]y cuesta %s Yang.. ", guild_level_limit, price))
						if guild.level(pc.get_guild()) < guild_level_limit then
							say_title("Administrador:")
							say("Tu gremio aun no tiene nivel suficiente.")
							say("")
						else
							say_title("Administrador:")
							say("Quieres comprar estas Tierras? ")
							say("")
							s =  select("Si", "No")
							if s == 1 then
								local price, owner, guild_level_limit = building.get_land_info(land_id)
								if owner!= 0 then
									say_title("Administrador:")
									say("Estas tierras ya tienen propietario. Lo siento.")
									say("")
								elseif pc.gold < price then
									say_title("Administrador:")
									say("No tienes suficiente Yang.")
									say("")
								else
									pc.changegold(-price)
									building.set_land_owner(land_id, pc.get_guild())
									notice_multiline(string.format("El Gremio %s ha comprado un Terreno! ", guild.name(pc.get_guild())),notice)
								end
							else
								say_title("Administrador:")
								say("Ven cuando te hayas decidido.")
								say("")
							end
						end
					end
				end
			else
				say_title("Administrador:")
				say("Ven cuando te hayas decidido.")
				say("")
			end
		end
	end
end
