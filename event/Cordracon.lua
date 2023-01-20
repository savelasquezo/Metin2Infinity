quest Cordracon begin
	state start begin
		when 20011.chat."GM: Evento Cordraconis" with pc.is_gm() begin
			say_title("Evento Cordraconis ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventCordracon") == 0 then
				local a = select ( "Activar" , "Cancelar" )
				if a == 1 then
					say_title("Evento Cordraconis ->Panel GM")
					say("Seleccione la Duracion del Evento -Horas-")
					local tiempo=math.floor(tonumber(input()))
					say_title("Evento Cordraconis ->Panel GM")
					say("Activar Evento Cordraconis durante "..tiempo.." Horas")
					local b = select("Confirmar","Cancelar")
					if b == 1 then
						server_timer("TimeEventCordracon1",tiempo*60*60)
						game.set_event_flag("EventCordracon",1)
						game.set_event_flag("EventCordraconProb",10)
						notice_all("<Evento> El Evento Cordraconis Ha Comenzado.")
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
					game.set_event_flag("EventCordracon",0)
					clear_server_timer('TimeEventCordracon1', get_server_timer_arg())
				elseif a == 2 then
					say_title("Evento Cordraconis ->Panel GM")
					say("Introduzca la Probabilidad de Drop")
					say("Estandar 10/1000")
					local prob= math.floor(tonumber(input()))
					if prob >= 50 then
						say_title("Evento Cordraconis ->Panel GM")
						say("¡El valor es demasiado Alto!")
						return
					end
					say_title("Evento Cordraconis ->Panel GM")
					say("Modificar la Probabilidad a "..prob.."/1000")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventCordraconProb",prob)
						syschat("<Evento> La Probabilidad de Drop ha Aumentado!")
					end
				end
			end
		end
		when TimeEventCordracon1.server_timer begin
			server_timer("TimeEventCordracon2",10*60)
			notice_all("<Evento>El Evento Coordraconis Finalizara en 10 Minutos!")
		end
		when TimeEventCordracon2.server_timer begin
			game.set_event_flag("EventCordracon",0)
			notice_all("<Evento> El Evento Cordraconis Ha Finalizado.")
		end
		when login with game.get_event_flag("EventCordracon") == 1 begin
			if pc.get_level ( ) < 15 then
				return 
			end
			syschat("<Evento Cordraconis>")
			syschat("El Evento Cordraconis se encuentra <Activado>")
		end
		when kill with game.get_event_flag("EventCordracon") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,1000) <= game.get_event_flag("EventCordraconProb") then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					local n = math.random(51562,51568)
					game.drop_item_with_ownership(n, 1)
					syschat("<Evento> Has encontrado un "..item_name(n).."")
					if number(1,100) <= game.get_event_flag("EventCordraconProb")*2 then
						game.drop_item_with_ownership(51501, 1)
						syschat("<Evento> Has encontrado un Cordraconis Mitico Adicional!")
					end
				end
			end
		end
		when 51501.use begin
			pc.remove_item("51501", 1)
			local pct = number(1,7)
			if pct == nil then
				return
			elseif pct == 1 then
				local items = {
					111000,
					112000,
					113000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 2 then
				local items = {
					121000,
					122000,
					123000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 3 then
				local items = {
					131000,
					132000,
					133000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 4 then
				local items = {
					141000,
					142000,
					143000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 5 then
				local items = {
					151000,
					152000,
					153000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 6 then
				local items = {
					161000,
					162000,
					163000,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))]+math.random(0,5)*1000, 1)
			elseif pct == 7 then
				local items = {
					114000,
					124000,
					134000,
					144000,
					154000,
					164000,
					100700,
							}
				pc.give_item2_select(items[math.random(1,table.getn(items))], 1)
			end
		end
	end
end
