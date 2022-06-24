quest Moonlight begin
	state start begin
		when 20011.chat."GM: Evento Caja Luna" with pc.is_gm() begin
			say_title("Evento Caja Luz de Luna ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventMoonlight") == 0 then
				local a = select ( "Activar" , "Cancelar" )
				if a == 1 then
					say_title("Evento Caja Luz de Luna ->Panel GM")
					say("Seleccione la Duracion del Evento -Horas-")
					local tiempo= math.floor(tonumber(input()))
					say_title("Evento Caja Luz de Luna ->Panel GM")
					say("Activar Evento Luz de Luna durante "..tiempo.." Horas")
					local b = select("Confirmar","Cancelar")
					if b == 1 then
						server_timer("TimeEventMoonlight1",tiempo*60*60)
						game.set_event_flag("EventMoonlight",1)
						game.set_event_flag("EventMoonlightProb",10)
						notice_all("<Evento> El Evento Caja Luz de Luna Ha Comenzado.")
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
					game.set_event_flag("EventMoonlight",0)
					clear_server_timer('TimeEventMoonlight1', get_server_timer_arg())
				elseif a == 2 then
					say_title("Evento Cajas Luz Luna ->Panel GM")
					say("Introduzca la Probabilidad de Drop")
					say("Estandar 10/1000")
					local prob= math.floor(tonumber(input()))
					if prob >= 50 then
						say_title("Evento Cajas Luz Luna ->Panel GM")
						say("¡El valor es demasiado Alto!")
						return
					end
					say_title("Evento Cajas Luz Luna ->Panel GM")
					say("Modificar la Probabilidad a "..prob.."/1000")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventMoonlightProb",prob)
						syschat("<Evento> La Probabilidad de Drop ha Aumentado!")
					end
				end
			end
		end
		when TimeEventMoonlight1.server_timer begin
			server_timer("TimeEventMoonlight2",10*60)
			notice_all("<Evento>El Evento Luz de Luna Finalizara en 10 Minutos!")
		end
		when TimeEventMoonlight2.server_timer begin
			game.set_event_flag("EventMoonlight",0)
			notice_all("<Evento> El Evento Caja Luz de Luna Ha Finalizado.")
		end
		when login with game.get_event_flag("EventMoonlight") == 1 begin
			if pc.get_level ( ) < 15 then
				return 
			end
			syschat("<Evento Cajas Luz de Luna>")
			syschat("El Evento Caja Luz de Luna se encuentra <Activado>")
		end
		when kill with game.get_event_flag("EventMoonlight") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,1000) <= game.get_event_flag("EventMoonlightProb") then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(50011, 1)
					syschat("<Evento> Has encontrado una Caja Tesoro Luz Luna!")
				end
			end
		end
		when 50011.use begin
			pc.remove_item("50011", 1)
			local pct = number(1,5)
			if pct == nil then
				return
			elseif pct == 1 then
				pc.give_item2_select(51001,math.random(3,7)*5)
			elseif pct == 2 then
				local items = {--Utilidad
					25040,
					25041,
					71035,
					70102,
					70008,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))], 1)
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
				pc.give_item2_select(71084,math.random(10,20)*5)
			elseif pct == 5 then
				pc.changegold(math.random(70,90)*275000)
			end
		end
	end
end
