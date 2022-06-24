quest EventSimpleBoss begin
	state start begin
		when 20011.chat."GM: Evento de Jefes" with pc.is_gm() begin
			say_title("Evento de Jefes ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventSimpleBoss") == 0 then
				local a = select ( "Activar" , "Cancelar" )
				if a == 1 then
					say_title("Evento de Jefes ->Panel GM")
					say("Seleccione la Duracion del Evento -Horas-")
					local tiempo=input()
					say_title("Evento de Jefes ->Panel GM")
					say("Activar de Jefes durante "..tiempo.." Horas")
					local b = select("Confirmar","Cancelar")
					if b == 1 then
						server_timer("TimeEventSimpleBoss",tiempo*60*60)
						game.set_event_flag("EventSimpleBoss",1)
						notice_all("<Evento> El Evento de Jefes Ha Comenzado! Habla con Uriel para Ingresar!!")
						notice_all("<Evento> Duracion: "..tiempo.." Horas")
					else
						return
					end
				end
				if a == 2 then
					return
				end
			else
				local a = select ( "Finalizar" , "Cancelar" )
				if a == 1 then
					game.set_event_flag("EventSimpleBoss",0)
					clear_server_timer('TimeEventSimpleBoss', get_server_timer_arg())
				end
				if a == 2 then
					return
				end
			end
		end
		when 20011.chat."Evento de Jefes" with game.get_event_flag("EventSimpleBoss") == 1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡¡Bienvenido "..pc.get_name().."!!")
			say_gold("¿Quieres ingresar al Evento?")
			local b = select("Confirmar","Cancelar")
			if b == 1 then
				pc.warp(1152000+715*100, 435200+568*100)
			end
		end
		when login with pc.get_map_index() == 356 begin
			if game.get_event_flag("EventSimpleBoss") == 0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_red("~Evento Inactivo~")
				say("")
				say_white("Seras Teletransportado al Exterior")
				say_white("~Evento Inactivo Temporalmente~")
				say("")
				timer("ExitsEventSimple", 1)
			end
		end
		when kill with pc.get_map_index() == 356 begin
			if game.get_event_flag("EventSimpleBoss") == 0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_red("~Evento Inactivo~")
				say("")
				say_white("Seras Teletransportado al Exterior")
				say_white("~Evento Inactivo Temporalmente~")
				say("")
				timer("ExitsEventSimple", 1)
			end
		end
		when ExitsEventSimple.timer begin
			warp_to_village()
		end
	end
end
