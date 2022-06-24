quest Hexagonal begin
	state start begin
		when 20011.chat."GM: Evento Hexagonal" with pc.is_gm() begin
			say_title("Evento Hexagonal ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventHexagonal") == 0 then
				local a = select ( "Activar" , "Cancelar" )
				if a == 1 then
					say_title("Evento Hexagonal ->Panel GM")
					say("Seleccione la Duracion del Evento -Horas-")
					local tiempo=math.floor(tonumber(input()))
					say_title("Evento Hexagonal ->Panel GM")
					say("Activar Evento Hexagonal durante "..tiempo.." Horas")
					local b = select("Confirmar","Cancelar")
					if b == 1 then
						server_timer("TimeEventHexagonal1",tiempo*60*60)
						game.set_event_flag("EventHexagonal",1)
						game.set_event_flag("EventHexagonalProb",10)
						notice_all("<Evento> El Evento Hexagonal Ha Comenzado.")
						notice_all("<Evento> Duracion: "..tiempo.." Horas")
					else
						return
					end
				end
				if a == 2 then
					return
				end
			else
				local a = select ( "Finalizar" , "Modificar" , "Cancelar")
				if a == 3 then
					return
				elseif a == 1 then
					game.set_event_flag("EventHexagonal",0)
					clear_server_timer('TimeEventHexagonal1', get_server_timer_arg())
				elseif a == 2 then
					say_title("Evento Hexagonal ->Panel GM")
					say("Introduzca la Probabilidad de Drop")
					say("Estandar 10/1000")
					local prob= math.floor(tonumber(input()))
					if prob >= 50 then
						say_title("Evento Hexagonal ->Panel GM")
						say("¡El valor es demasiado Alto!")
						return
					end
					say_title("Evento Hexagonal ->Panel GM")
					say("Modificar la Probabilidad a "..prob.."/1000")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventHexagonalProb",prob)
						syschat("<Evento> La Probabilidad de Drop ha Aumentado!")
					end
				end
			end
		end
		when TimeEventHexagonal1.server_timer begin
			server_timer("TimeEventHexagonal2",10*60)
			notice_all("<Evento>El Evento Hexagonales Finalizara en 10 Minutos!")
		end
		when TimeEventHexagonal2.server_timer begin
			game.set_event_flag("EventHexagonal",0)
			notice_all("<Evento> El Evento Hexagonal Ha Finalizado.")
		end
		when login with game.get_event_flag("EventHexagonal") == 1 begin
			if pc.get_level ( ) < 15 then
				return 
			end
			syschat("<Evento Hexagonal>")
			syschat("El Evento Hexagonal se encuentra <Activado>")
		end
		when kill with game.get_event_flag("EventHexagonal") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,1000) <= game.get_event_flag("EventHexagonalProb") then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(39045, 1)
					syschat("<Evento> Has encontrado una Hexagonal!")
				end
			end
		end
		when 39045.use begin
			pc.remove_item("39045", 1)
			local pct = number(1,90)
			if pct == nil then
				return
			elseif pct <= 55 then
				if number(1,1000) <= game.get_event_flag("EventHexagonalProb")*2 then
					pc.give_item2_select(71084,200)
					syschat("<Evento> Fantastico! Hexagonal Dorada!")
				else
					pc.give_item2_select(71084,math.random(25,45))
				end
			elseif pct <= 75 then
				local items = {
					70024,
					70063,
					70064,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))], 2)
			elseif pct <= 85 then
				local items = {
					71301,
					71302,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))], 2)
			elseif pct <= 90 then
				pc.give_item2_select(100700, 1)
			end
		end
	end
end
