quest FishingEvent begin
	state start begin
		function Setting()
			return {
				["Index"] = 405,
				["NPC"] = 9009,
				["IndexCoord"] = {2221,4021},
				["IndexPoss"] = {357,474},
				["COIN"] = 27991, 
			}
		end
		function InEvent()
			local s = FishingEvent.Setting()
			return pc.get_map_index() == s.Index
		end
		function GetPointsFishing()
			local res1,acc = mysql_direct_query("SELECT points from player.pescaevent where id ="..pc.get_player_id()..";")
			return tonumber(acc[1].points)
		end
		when FishingExit.timer begin
			if pc.get_map_index() == 405 and not pc.is_gm() and game.get_event_flag("EventFishRankg") == 1 then
				warp_to_village()
			end
		end
		when FishingCheck.timer begin
			if pc.get_map_index() == 405 and not pc.is_gm() and game.get_event_flag("EventFishRankg") == 0 then
				warp_to_village()
			end
		end
		when login with FishingEvent.InEvent() begin
			if game.get_event_flag("EventFishRankg") == 0 and not pc.is_gm() then
				warp_to_village()
			end
			for i = 27803, 27883, 1  do
				if pc.count_item(i) > 0 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say("")
					say("¡Imposible Ingresar al Evento si tienes Pescados!")
					say("Guardalos en el almacen e intentalo Nuevamente")
					say("")
					say_item (item_name(i) , i , "")
					say("")
					timer("FishingExit", 1)
					return
				end
			end
			loop_timer("FishingCheck",1)
		end
		when 9009.chat."Intercambiar" with pc.get_map_index() == 405 and game.get_event_flag("EventFishRankg") == 1 begin
			local s = FishingEvent.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Inigualables riquezas desde el fondo del Oceano!")
			say("Utiliza los "..item_name(s.COIN).." en mi Tienda")
			say("")
			say_item (item_name(s.COIN) , s.COIN , "")
			say("¡Aqui Intercambias los "..item_name(s.COIN).."!")
			say_gold("¿Quieres Intercambiar?")
			say("")
			if select("Intercambiar","Cancelar") == 1 then
				npc.open_shop(41)
			end
		end
		when 9009.chat."GM: Evento Pesca" with pc.is_gm() begin
			local s = FishingEvent.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say_gold("Evento de Pesca")
			say_white("GM")
			say("")
			say_white("¡Seleccione la accion a Realizar!")
			say("")
			if game.get_event_flag("EventFishRankg") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					if pc.get_map_index() != s.Index then
						say_white("¡Evento de Pesca!")
						say("Evento Maraton de Pesca")
						say("")
						say_gold("¿Teletransportar al Evento?")
						say("")
						if select("Aceptar","Cancelar") == 1 then
							pc.warp((s.IndexCoord[1]+s.IndexPoss[1])*100,(s.IndexCoord[2]+s.IndexPoss[2])*100)
						end
					else
						game.set_event_flag("EventFishRankg",1)
						game.set_event_flag("FishingMaxLength",0)
						notice_all("<Evento> El Evento de Pesca ha Comenzado! Habla con "..mob_name(npc.get_race()).." -> Ingresar al Evento!")
					end
				end
			else
				local r = select("Habilitar","Finalizar","Cancelar")
				if r == 3 then
					return
				elseif r == 1 then
					game.set_event_flag("FishingReward",1)
					notice_all("<Evento de Pesca> "..global_getvarchar("FishingLengthLider").." ha Ganado el Evento de Pesca! Longitud: "..game.get_event_flag("FishingMaxLength").."mm")
					notice_in_map("<Evento de Pesca> La Maraton de Pesca ha Terminado! Canjea tus Puntos en el Pescador!")
				elseif r == 2 then
					game.set_event_flag("EventFishRankg",0)
					game.set_event_flag("FishingReward",0)
					notice_all("<Anuncio> El Evento de Pesca ha Finalizado.")
				end
			end
		end
		when 9009.chat."Maraton de Pesca" with game.get_event_flag("EventFishRankg") == 1 and not FishingEvent.InEvent() begin
			local s = FishingEvent.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if pc.get_level() < 30 then
				say_red(gameforge.dungeon.msm001)
				say("")
				say("¡Nivel Insuficiente!")
				say("Imposible ingresar al evento necesitas Nivel 30")
				say("")
				return
			end
			say("")
			say_gold("¿Quieres participar en el evento Pesca?")
			say("")
			if select("Ingresar","Cancelar") == 1 then
				for i = 27803, 27883, 1  do
					if pc.count_item(i) > 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say("")
						say("¡Imposible Ingresar al Evento si tienes Pescados!")
						say("Guardalos en el almacen e intentalo Nuevamente")
						say("")
						say_item (item_name(i) , i , "")
						say("")
						return
					end
				end
				pc.setqf("FishingReward", 0)
				pc.warp((s.IndexCoord[1]+s.IndexPoss[1])*100,(s.IndexCoord[2]+s.IndexPoss[2])*100)
			end
		end
		when 9009.chat."Informacion" with game.get_event_flag("EventFishRankg") == 1 and FishingEvent.InEvent() begin
			local s = FishingEvent.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Ha Iniciado el Evento de Pesca, Consiste en sumar")
			say("puntos pescando, cuando consigas un pez traemelo.")
			say("Todos los peces vivos suman puntos.")
			say_green("¡Consigue Peces Asados y Entregamelos!")
			say_item ("Asados", 27863 , "")
			say("")
			say_gold("¡IMPORTANTE!")
			say_white("Si encuentras un pez grande traemelo")
			say_white("Lograras hacerte con una gran Recompenza")
			say_white("¡Entregamelo VIVO!")
			say("")
			say_gold("~Puntos Actuales~")
			if pc.getqf("FishingRegister") == 1 then
				say_white(""..FishingEvent.GetPointsFishing().."")
			else
				say_white("0")
			end
			say("")
			if game.get_event_flag("FishingReward") == 1 then
				if select ( "Validar","¡Regresar!" ) == 1 then
					if pc.getqf("FishingReward") == 0 and FishingEvent.GetPointsFishing() > 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say("")
						say("¡Unicamente puedes validar la puntuacion una Vez!")
						say_gold("Despues de Validar no podras hacerlo Nuevamente")
						say_gold("¿Quieres validar ls Puntuacion?")
						say("")
						if select ( "Aceptar","¡Regresar!" ) == 1 then
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title(string.format("~%s~", mob_name(npc.get_race())))
							say("")
							say("¡Intercambio Exitoso!")
							notice_in_map("<Evento de Pesca> El Jugador "..pc.get_name().." Ha Logrado "..FishingEvent.GetPointsFishing().." Puntos!")
							say_gold(""..FishingEvent.GetPointsFishing().." Pts")
							while FishingEvent.GetPointsFishing() > 200 do
								mysql_direct_query("UPDATE player.pescaevent SET points = points - 200 WHERE id = "..pc.get_player_id().." ;" )
								pc.give_item2(s.COIN,200)
							end
							pc.give_item2(s.COIN,FishingEvent.GetPointsFishing())
							mysql_direct_query("UPDATE player.pescaevent SET points = 0 WHERE id = "..pc.get_player_id().." ;" )
							pc.setqf("FishingReward", 1)
							say("")
						end
					else
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say("")
						if FishingEvent.GetPointsFishing() == 0 or FishingEvent.GetPointsFishing() == nil then
							say("¡Necesitas Puntos!")
							say("Entregame Peces Asados & Redimelos")
							say("")
							return
						elseif pc.getqf("FishingReward") == 1 then
							say("Ya has redimido la Puntuacion!")
							say("")
							return
						end
					end
				end
			end
		end
		when 9009.take with game.get_event_flag("EventFishRankg") == 1 and FishingEvent.InEvent() begin
			local vnum = item.get_vnum()
			if vnum >= 27803 and vnum <= 27823 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if item.get_socket(0) > game.get_event_flag("FishingMaxLength") then
					game.set_event_flag("FishingMaxLength",item.get_socket(0))
					global_setvarchar("FishingLengthLider",pc.get_name())
					notice_all("<Evento de Pesca> "..pc.get_name().." ha Logrado Capturar una "..item_name(vnum).." de "..item.get_socket(0).."mm")
					say_green("¡Increible!")
					say_white("¡Haz capturado el pez mas grande hasta Ahora!")
					say_white("Actualmente eres el lider de la Competencia")
					say("")
					say_gold("~Longitud~")
					say(""..item.get_socket(0).."mm")
					pc.remove_item(item.get_vnum(),pc.count_item(vnum))
					say("")
				else
					say_red("¡Insuficiente!")
					say_white("¡Lamentablemente este no es el pez mas Grande!")
					say_white("Actualmente otro participante tiene el record")
					say("")
					say_gold("~Lider~")
					say_white(""..global_getvarchar("FishingLengthLider").."")
					say("")
					say_gold("~Longitud~")
					say_white(""..game.get_event_flag("FishingMaxLength").."mm")
					say("")
				end
			elseif vnum >= 27863 and vnum <= 27883 then
				local Pts = (vnum - 27862)*pc.count_item(vnum)
				if pc.getqf("FishingRegister") != 1 then
					mysql_direct_query("INSERT into player.pescaevent(id,nombre,points) VALUES("..pc.get_player_id()..",'"..pc.get_name().."',"..Pts..");")
					pc.setqf("FishingRegister", 1)
				else
					mysql_direct_query("UPDATE player.pescaevent SET points = points + "..Pts.." WHERE id = "..pc.get_player_id().." ;" )
				end
				pc.remove_item(item.get_vnum(),pc.count_item(vnum))
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("¡Fantastico !")
				say("Obtedras "..Pts.." Puntos")
				say_item(""..item_name(vnum).."", vnum, "")
				say_gold("[DELAY value;340]..........................[/DELAY]")
				say_gold("~Actuales~")
				say_white(""..FishingEvent.GetPointsFishing().." Pts")
				say("")
			end
		end
	end
end
