quest TanakasHunter begin
	state start begin
		when 20364.chat."GM: Evento Tanakas" with pc.is_gm() begin
			say_title("Evento de Tanakas ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventTanakasHT") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					say_title("Evento de Tanakas ->Panel GM")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventTanakasHT",1)
						notice_all("<Evento> El Evento de Tanakas ha Comenzado!")
					end
				end
			else
				local n = select("Invocar","Finalizar","Cancelar")
				if n == 3 then
					return
				elseif n == 1 then
					if pc.get_map_index() != 105 then
						say("¡Mapa Incorrecto!")
						return
					end
					regen_in_map(105,"data/event/TanakasHunter/regen.txt")
					big_notice_in_map("Tanakas Invocados! Eliminalos!")
				elseif n == 2 then
					if select("Finalizar","Cancelar") == 1 then
						game.set_event_flag("EventTanakasHT",0)
					end
				end
			end
		end
		when 20364.chat."--Evento Tanakas--" with game.get_event_flag("EventTanakasHT") == 1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Aqui Intercambias tus Orejas Tanakas!")
			say("¿Quieres Intercambiar?")
			say("")
			if select("Intercambiar","Cancelar") == 1 then
				npc.open_shop(39)
			end
		end
		when login with pc.get_map_index() == 105 begin
			if game.get_event_flag("EventTanakasHT") == 0 and not pc.is_gm() then
				warp_to_village()
			end
			loop_timer("TanakasHunterCheck",0.5)
		end
		when TanakasHunterCheck.timer begin
			if pc.get_map_index() == 105 and not pc.is_gm() and game.get_event_flag("EventTanakasHT") == 0 then
				warp_to_village()
			end
		end
		when 20011.chat."Maraton de Tanakas" with game.get_event_flag("EventTanakasHT") == 1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.get_level() < 30 then
				say("Debes ser por los menos nivel 30 para participar")
				say("Si no lo eres por favor vete.")
				say("")
				return
			end
			say("Quieres participar en el evento Tanakas?")
			say("")
			if select("Participar","Cancelar") == 1 then
				if pc.get_empire() == 1 then
					pc.warp(13500,7000)
				end
				if pc.get_empire() == 2 then
					pc.warp(23900,18200)
				end
			end
		end
		when 5251.kill with game.get_event_flag("EventTanakasHT") == 1 begin
			game.drop_item_with_ownership(30202, 1)
			syschat("<Evento> Has encontrado una Oreja Tanaka!")
		end
		when 5252.kill with game.get_event_flag("EventTanakasHT") == 1 begin
			game.drop_item_with_ownership(71089, 1)
			for i = 1, 15, 1  do
				game.drop_item_with_ownership(30202, 1)
				syschat("<Evento> Has Eliminado al Tanaka Dorado!")
			end
		end
	end
end
