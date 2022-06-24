quest guild_building_alter_of_power begin
	state start begin
		when 20077.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title("Guardian del Altar:")
			say("Esta construccion hace posible que puedas reclutar")
			say("mas miembros en el gremio.")
			say("")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end
			wait()
			say_title("Guardian del Altar:")
			say("Hmm... tu gremio... ")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say_title("Guardian del Altar:")
				say("Veo que ya tienes un gremio mas fuerte.")
				say("Si sustituir tu altar por uno mas grande")
				say("necesitaras lo siguiente: ")
				say_reward("1 KKK Yang[ENTER]30 Piedras Fundacion[ENTER]30 Chapeados[ENTER]30 Troncos ")
				local s =  select("Reemplazar el Altar ", "Cancelar")
				if s == 1 then
					if pc.count_item(90010) >= 30 and pc.count_item(90012) >= 30 and pc.count_item(90011) >= 30 and pc.get_gold() >= 1000000000 then
						say_title("Guardian del Altar:")
						say("Bien. Te pondre un Altar Nuevo. ")
						building.reconstruct(14062)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						char_log(0, "GUILD_BUILDING", "alter_of_power 14062 constructed")
						pc.change_gold(-1000000000)
						pc.remove_item("90010", 30)
						pc.remove_item("90011", 30)
						pc.remove_item("90012", 30)
					else
						say_title("Guardian del Altar:")
						say("No tienes lo necesario para edificar el Altar.")
						say("")
					end
				elseif s == 2 then
					say_title("Guardian del Altar:")
					say("Como quieras... Vuelve mas tarde.")
					say("")
				end
			else
				say_title("Guardian del Altar:")
				say("Tu gremio aun no es tan fuerte")
				say("Vuelve mas tarde cuando lo sea.")
				say("")
			end
		end
		when 20078.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title("Guardian del Altar:")
			say("Esta construccion hace posible que puedas reclutar")
			say("mas miembros en el gremio.")
			say("")
			if pc.getqf("build_level") == 0 then
				pc.setqf("build_level", guild.level(pc.get_guild()))
			end
			wait()
			say_title("Guardian del Altar:")
			say("Hmm... tu gremio... ")
			if pc.getqf("build_level") < guild.level(pc.get_guild()) or guild.level(pc.get_guild()) >= 20 then
				say_title("Guardian del Altar:")
				say("Veo que ya tienes un gremio mas fuerte.")
				say("Si sustituir tu altar por uno mas grande")
				say("necesitaras lo siguiente: ")
				say_reward("3 KKK Yang[ENTER]50 Piedras Fundacion[ENTER]50 Chapeados[ENTER]50 Troncos ")
				local s =  select("Reemplazar el Altar ", "Cancelar")
				if s == 1 then
					if pc.count_item(90010) >= 50 and pc.count_item(90012) >= 50 and pc.count_item(90011) >= 50 and pc.get_gold() >= 3000000000 then
						say_title("Guardian del Altar:")
						say("Bien. Te pondre un Altar Nuevo. ")
						say("")
						building.reconstruct(14063)
						pc.setqf("build_level", guild.level(pc.get_guild()))
						char_log(0, "GUILD_BUILDING", "alter_of_power 14063 constructed")
						pc.change_gold(-3000000000)
						pc.remove_item("90010", 50)
						pc.remove_item("90011", 50)
						pc.remove_item("90012", 50)
					else
						say_title("Guardian del Altar:")
						say("No tienes lo necesario para edificar el Altar.")
						say("")
					end
				elseif s == 2 then
					say_title("Guardian del Altar:")
					say("Como quieras... Vuelve mas tarde.")
					say("")
				end
			else
				say_title("Guardian del Altar:")
				say("Tu gremio aun no es tan fuerte")
				say("Vuelve mas tarde cuando lo sea.")
				say("")
			end
		end
		when 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master() begin
			say_title("Guardian del Altar:")
			say("No puedo hacer nada mas por ti; Ya tienes el altar")
			say("mas fuerte que se puede construir.")
			say("")
		end
		when 20077.click or 20078.click or 20079.click with npc.get_guild() == pc.get_guild() and pc.is_guild_master()!= true begin
			say_title("Guardian del Altar:")
			say("El altar del poder hace posible que se pueda")
			say("reclutar mas personas en el gremio.")
			say("")
		end
	end
end

