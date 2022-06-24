quest GuildRonark begin
	state start begin
		function Setting()
			return {
				["Index"] = 500,
				["MaxLevel"] = 130,
				["MinLevel"] = 3,
				["NPC"] = 20011,
				["RewardItem"] = 83018,
				["RewardItemCount"] = 1,
				["IndexCoord"] = {6675,2092},
				["IndexPoss"] = {0,0},
				["Ronark"] = 6438,
			}
		end
		function InEvent()
			local s = GuildRonark.Setting()
			return pc.get_map_index() == s.Index
		end
		when logout with GuildRonark.InEvent() begin
			pc.remove_guild_online_member()
		end
		when login with GuildRonark.InEvent() begin
			pc.guild_online_member()
			if pc.not_guild() then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Ronark~")
				say_red(gameforge.dungeon.msm001)
				say("")
				say("¡Imposible Ingresar si no perteneces a un Gremio!")
				say("Enlistate en un gremio e intenta Nuevamente")
				say("")
				timer("GuildRonarkExit", 5)
				return 
			end
			loop_timer("GuildRonarCheck",0.5)
		end
		when GuildRonarCheck.timer begin
			local s = GuildRonark.Setting()
			if GuildRonark.InEvent() and not pc.is_gm() and game.get_event_flag("EventRonarkGld") == 0 then
				if game.get_event_flag("GuildRonarkReward") == 1 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡RONARK!")
					say("Gracias por participar en el Evento Ronark")
					say_white("Seras Teletansportado a la Ciudad")
					say("")
					say_green("~Recompenzas~")
					say_item (""..item_name(s.RewardItem).."",s.RewardItem,"")
					say("")
					pc.give_item2(s.RewardItem,s.RewardItemCount)
				end
				warp_to_village()
			end
		end
		when GuildRonarkExit.timer begin
			warp_to_village()
		end
		when GuildRonarkFinal.server_timer begin
			game.set_event_flag("GuildRonarkReward",1)
			game.set_event_flag("RonarkSummon",0)
			game.set_event_flag("EventRonarkGld",0)
		end
		when kill with GuildRonark.InEvent() begin
			local s = GuildRonark.Setting()
			if npc.get_race() == s.BossRonark then
				notice_in_map("<Evento Ronark> Seran Teletransportados en 1 Minutos!")
				game.set_event_flag("GuildRonarkReward",1)
				server_timer("GuildRonarkFinal",60)
			end
		end
		when 20011.chat."GM: Evento Ronark" with pc.is_gm() begin
			local s = GuildRonark.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_gold("Evento de Ronark")
			say_white("GM")
			say("")
			say_white("¡Seleccione la accion a Realizar!")
			say("")
			if pc.get_map_index() != s.Index then
				say_white("¡Evento Ronark!")
				say("Gremios PvM-PvP")
				say("")
				say_gold("¿Teletransportar al Evento?")
				say("")
				if select("Aceptar","Cancelar") == 1 then
					pc.warp((s.IndexCoord[1]+s.IndexPoss[1])*100,(s.IndexCoord[2]+s.IndexPoss[1])*100)
				end
			elseif game.get_event_flag("EventRonarkGld") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					game.set_event_flag("GuildRonarkReward",0)
					game.set_event_flag("EventRonarkGld",1)
					game.set_event_flag("RonarkKill",0)
					notice_all("<Evento> El Evento de Ronark ha Comenzado! Habla con "..mob_name(npc.get_race()).." -> Ingresar al Evento!")
				end
			elseif game.get_event_flag("EventRonarkGld") == 1 then
				local r = select("Invocar","Finalizar","Cancelar")
				if r == 3 then
					return
				elseif r == 1 then
					if game.get_event_flag("RonarkSummon") == 0 then
						notice_in_map("<Evento Ronark>El Registro ha Cerrado! El Legendario Ronark ha sido Invocado")
						regen_in_map(s.Index,"data/event/Ronark/regen1.txt")
						game.set_event_flag("RonarkSummon",1)
					else
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_gold("Evento de Ronark")
						say_white("GM")
						say("")
						say_white("¡Ronark ya ha sido Invocado!")
						say("Finaliza el Evento")
						say("")
						return
					end
				elseif r == 2 then
					game.set_event_flag("RonarkSummon",0)
					game.set_event_flag("EventRonarkGld",0)
					game.set_event_flag("RonarkKill",0)
				end
			end
		end
		when 20011.chat."¡Salir!" with GuildRonark.InEvent() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Evento de Ronark!")
			say_gold("¿Quieres Salir del Evento?")
			say("")
			if select ("Salir","Cancelar") == 1 then
				warp_to_village()
			end
		end
		when 20011.chat."Ronark" with game.get_event_flag("EventRonarkGld") == 1 and not GuildRonark.InEvent() begin
			local s = GuildRonark.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if game.get_event_flag("RonarkSummon") == 1 then
				say_red(gameforge.dungeon.msm001)
				say("")
				say_gold("¡Tiempo Expirado!")
				say_white("El Evento ya ha Comenzado")
				say("")
				return
			end
			say("¡Ronark está actualmente Activa!")
			say_gold("¿Quieres entrar al evento Ronark?")
			say("")
			local gir = select("Aceptar","Cancelar")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			pc.setqf("AntiBug",get_time()+10)
			if gir == 1 then
				if pc.getqf("AntiBug") < get_time() then
					say_red(gameforge.dungeon.msm001)
					say("")
					say_gold("¡Tiempo Expirado!")
					say_white("Intentalo Nuevamente")
					say("")
					return
				end
				if pc.not_guild() then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Ronark~")
					say_red(gameforge.dungeon.msm001)
					say("")
					say("¡Imposible Ingresar si no perteneces a un Gremio!")
					say("Enlistate en un gremio e intenta Nuevamente")
					say("")
					timer("GuildRonarkExit", 5)
					return 
				end
				pc.warp((s.IndexCoord[1]+s.IndexPoss[1])*100,(s.IndexCoord[2]+s.IndexPoss[1])*100)
			end
		end
	end
end
