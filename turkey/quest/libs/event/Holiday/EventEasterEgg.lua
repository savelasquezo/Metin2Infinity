quest EventEasterEgg begin
	state start begin
		function Setting()
			if EventEasterEgg.Settings == nil then
				EventEasterEgg.Settings = {
				["TimeToRetry"] = 3,
				["Index"] = 406,
				["IndexCoord"] = {5840,22528},
				["IndexPoss"] = {406,713},
				}
			end
			return EventEasterEgg.Settings
		end
		function InEasterMap()
			local s = EventEasterEgg.Setting()
			return pc.get_map_index() == s.Index
		end
		when login with EventEasterEgg.InEasterMap() begin
			if game.get_event_flag("EventEasterEgg") == 0 and not pc.is_gm() then
				warp_to_village()
			end
			loop_timer("EventEasterEggCheck",1)
		end
		when EventEasterEggCheck.timer begin
			if EventEasterEgg.InEasterMap() and not pc.is_gm() and game.get_event_flag("EventEasterEgg") == 0 then
				warp_to_village()
			end
		end
		when 30129.chat."GM: Evento Pascua" with pc.is_gm() begin
			say_title("Evento de Pascua ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventEasterEgg") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					say_title("Evento de Pascua ->Panel GM")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventEasterEgg",1)
						game.set_event_flag("EventEasterEggDrops",10)
						notice_all("<Evento> El Evento Lamdascua ha Comenzado!")
					end
				end
			else
				local a = select ("Finalizar","Modificar","Cancelar")
				if a == 3 then
					return
				elseif a == 1 then
					game.set_event_flag("EventEasterEgg",0)
				elseif a == 2 then
					say_title("Evento de Pascua ->Panel GM")
					say("Introduzca la Probabilidad de Drop")
					say("Estandar 10/1000")
					local prob = math.floor(tonumber(input()))
					if prob >= 300 then
						say_title("Evento de Pascua ->Panel GM")
						say("¡El valor es demasiado Alto!")
						return
					end
					say_title("Evento de Pascua ->Panel GM")
					say("Modificar la Probabilidad a "..prob.."/1000")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventEasterEggDrops",prob)
						syschat("<Evento> La Probabilidad de Drop ha Aumentado!")
					end
				end
			end
		end
		when 30129.chat."!He Encontrado los Huevos de Pascua!" with pc.count_item(50181) == 1 and EventEasterEgg.InEasterMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if game.get_event_flag("EventEasterEgg") == 0 then
				say_gold("¡El Evento de Pascua ha Finalizado!")
				say("")
				return
			end
			say("¡Has logrado llenar la cesta de Huevos de Pascua!")
			say("Intercambiala por fabulosas Recompenzas")
			say_item(item_name(50181), 50181, "")
			say("Increibles recompenzas recibiras en Lamdascua")
			say("¡Aprovecha la ocacion y Disfruta!")
			say("")
			say_gold("¿Quieres cambiar la Cesta de Huevos?")
			say("")
			if select ("Intercambiar","Cancelar") == 1 then
				if pc.count_item(50181) == 0 then
					return
				end
				local value = math.random(10,30)
				local job = pc.get_job()
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("¡Fantastico has Intercambiado la Canasta de Pascua!")
				say("Celebra la Lamdascua con Metin2 Lamda")
				say("")
				syschat("<Lamdascua> La Canasta de Huevos se Intercambio x (" .. value .. ") MDs!" )
				mysql_direct_query ( "UPDATE account.account SET coins=coins+ " .. value .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )  
				pc.changegold(math.random(75,95)*1000000)
				pc.give_item2_select(85106,1)
				pc.give_item2(53642, 1)
				pc.remove_item(50181, 1)
			end
		end
		when 30129.chat."Lamdascua" with not EventEasterEgg.InEasterMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Feliz Pascua les desea Metin2 Lamda!")
			say("Maravillosos obsequios & regalos Obtendras")
			say_gold("¿Quieres Ingresar al Evento?")
			say("")
			if select ("Ingresar","Cancelar") == 1 then
				local s = EventEasterEgg.Setting()
				pc.warp((s.IndexCoord[1]+s.IndexPoss[1])*100,(s.IndexCoord[2]+s.IndexPoss[2])*100)
			end
		end
		when 30129.chat."Huevos de Pascua" with pc.count_item(50180) == 0 and EventEasterEgg.InEasterMap() begin
			local TimeToRetry = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Encuentra todos los Huevos de Pascua!")
			say("Cuando tengas todos los tipos de Huevos")
			say("Traene Todos los huevos que puedas")
			say_item("Cesta con Hue. de Pascua", 50181, "")
			say("Increibles recompenzas recibiras en Lamdascua")
			say("¡Aprovecha la ocacion y Disfruta!")
			say("")
			say_gold("¿Quieres una Cesta de Vacia?")
			say("")
			if select ( "Aceptar" , "Cancelar" ) == 1 then
				local s = EventEasterEgg.Setting()
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if pc.getqf("TimeToRetry") > get_time() then
					say("Imposible Fabricar una Nueva Canasta")
					say("¡Llegas muy pronto todavia no han pasado 3 Horas!")
					say("")
					say_gold("~Tiempo~")
					say_white(""..TimeToRetry.."")
					say("")
					return
				end
				say("Ahora podras guardar los Huevos de Pascua")
				say("Date prisa y llenala lo antes posible.")
				say_item("Cesta de Pascua", 50180, "")
				say("Podras reclamar otra una vez llenes la que la que")
				say("tienes, una cesta a la vez. Mucha Suerte !")
				say("")
				pc.give_item2(50180)
				pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			end
		end
		when 30129.chat."Intercambiar" with EventEasterEgg.InEasterMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Consigue Huevos de Pacua!")
			say("Intercambialos por fabulosos Atuendos")
			say_item("Huevo de Pascua", 50160, "")
			say("Los Huevos de Pascua son muy valiosos")
			say("Si tienes Huevos de Pascua fabricare Increibles")
			say("objetos de exclusivos de gran valor")
			say("")
			say_gold("¿Quieres itercambiar Huevos de Pascua?")
			say("")
			if select ( "Intercambiar" , "Cancelar" ) == 1 then
				npc.open_shop()
				return
			end
		end
		when 30129.chat."Artesanias" with EventEasterEgg.InEasterMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Consigue Huevos Dorados de Pacua!")
			say("Intercambialos por fabulosos Premios")
			say_item("Huevo Dorado", 71150, "")
			say("Este Huevo Dorado es Particularmente Raro")
			say("Si tienes Huevos Dorados fabricare Increibles")
			say("objetos de exclusivos de gran valor")
			say("")
			say_gold("¿Quieres cambiar el Huevo Dorado?")
			say("")
			if select ( "Intercambiar" , "Cancelar" ) == 1 then
				command("cube open")
				return
			end
		end
		when 50180.use begin
			for go = 50160, 50179, 1 do
				if pc.count_item(go) < 10 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Lamdascua~")
					say("")
					say("¡Debes tener 10 huevos de todos los Colores!")
					say("Guardalos en la canasta de Pascua")
					say_item("Huevo de Pascua", go, "")
					say("¡Aun te Faltan Huevos de Pascua!")
					say("")
					return
				end
			end
			for go2 = 50160, 50179, 1 do
				pc.remove_item(go2, 10)
			end
			pc.remove_item(50180, 1)
			pc.give_item2(50181, 1)
			syschat("<Lamdascua> Haz llenado la Cesta de Huevos de Pascua!")
		end
		when 30129.chat."Salir del Evento" with EventEasterEgg.InEasterMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Feliz Pascua les desea Metin2 Lamda!")
			say("Maravillosos obsequios & regalos Obtendras")
			say_gold("¿Quieres Salir del Evento?")
			say("")
			if select ("Salir","Cancelar") == 1 then
				warp_to_village()
			end
		end
		when 71150.use begin --Huevo Dorado
			local value = 10
			mysql_direct_query ( "UPDATE account.account SET coins = coins + " .. value .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("<Lamdascua> El Huevo Dorado contenia (" .. value .. ") MDs" )
			pc.changegold(math.random(35,75)*1000000)
			pc.remove_item("71150", 1)
			local pct = number(1,5)
			if pct == nil then
				return
			elseif pct == 1 then --Estolas
				pc.give_item2_select(85106,1)
			elseif pct == 2 then
				local items = {--Skins
					41505,
					41504,
					41506,
					41507,
					41540,
					41541,
					41542,
					41543,
					41291,
					41292,
					41294,
					41295,
					41296,
					41298,
					45191,
					45190,
					45193,
					45192,
							}
					pc.give_item2_select(items[math.random(1,table.getn(items))], 3)
			elseif pct == 3 then
				local items = {--Alquimia
					51562,
					51563,
					51564,
					51565,
					51566,
					51567,
					51568,
							}
				if number(1,table.getn(items)) == 1 then
					local items = {--Alquimia Utilidad
						100300,
						100400,
						100500,
						100700,
								}
					pc.give_item2_select(items[math.random(1,table.getn(items))], 1)
				else
					pc.give_item2_select(items[math.random(1,table.getn(items))], 3)
				end
			elseif pct == 4 then
				local items = {--Utilidad
					39017,
					39018,
					39019,
					39020,
					39024,
					39025,
					39032,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))], 20)
			elseif pct == 5 then
				local items = {--Biologo
					30139,
					30147,
					31067,
					30146,
					30165,
					30166,
					30167,
					30168,
							}
				if number(1,table.getn(items)) == 1 then
					local items = {--Biologo Avanzado
						30251,
						30252,
						30253,
								}
					pc.give_item2_select(items[math.random(1,table.getn(items))], 2)
				else
					pc.give_item2_select(items[math.random(1,table.getn(items))], 2)
				end
			end
		end
		when kill with game.get_event_flag("EventEasterEgg") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,1000) <= game.get_event_flag("EventEasterEggDrops") then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					if pc.get_job() == nil then
						return
					elseif pc.get_job() == 0 then
						if number(1,3) == 1 then
							game.drop_item_with_ownership(math.random(50160,50164), 1)
						else
							game.drop_item_with_ownership(math.random(50160,50179), 1)
						end
					elseif pc.get_job() == 1 then
						if number(1,3) == 1 then
							game.drop_item_with_ownership(math.random(50165,50169), 1)
						else
							game.drop_item_with_ownership(math.random(50160,50179), 1)
						end
					elseif pc.get_job() == 2 then
						if number(1,3) == 1 then
							game.drop_item_with_ownership(math.random(50170,50174), 1)
						else
							game.drop_item_with_ownership(math.random(50160,50179), 1)
						end
					elseif pc.get_job() == 3 then
						if number(1,3) == 1 then
							game.drop_item_with_ownership(math.random(50175,50179), 1)
						else
							game.drop_item_with_ownership(math.random(50160,50179), 1)
						end
					end
					syschat("<Lamdascua> Has encontrado un Huevo de Pascua!")
				end
			end
		end
	end
end

