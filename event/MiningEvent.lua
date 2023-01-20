quest MiningEvent begin
	state start begin
		when 20015.chat."GM: Evento Mineria" with pc.is_gm() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_gold("Evento de Mineria")
			say_white("GM")
			say("")
			say_white("¡Seleccione la accion a Realizar!")
			say("")
			if game.get_event_flag("EventMiningMap") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					game.set_event_flag("EventMiningMap",1)
					notice_all("<Evento> El Evento de Mineria ha Comenzado! Habla con "..mob_name(npc.get_race()).." -> Ingresar al Evento!")
				end
			else
				if select("Finalizar","Cancelar") == 1 then
					game.set_event_flag("EventMiningMap",0)
				end
			end
		end
		when 20015.chat."Tienda de Mienria" with pc.get_map_index() == 403 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Aqui Intercambias minerales de Ambar!")
			say_gold("¿Quieres Intercambiar?")
			say("")
			if select("Intercambiar","Cancelar") == 1 then
				npc.open_shop(40)
			end
		end
		when 20015.chat."Mineralogia" with pc.get_map_index() == 403 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("")
			say("¡Aqui fabricar objetos usando Minerales!")
			say_gold("¿Quieres Craftear?")
			say("")
			if select("Craftear Minerales","Cancelar") == 1 then
				command("cube open")
			end
		end
		when 20015.chat."¡Finalizar Evento!" with pc.get_map_index() == 403 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Evento de Mineria!")
			say_gold("¿Quieres Salir del Evento?")
			say("")
			if select ("Salir","Cancelar") == 1 then
				warp_to_village()
			end
		end
		when login with pc.get_map_index() == 403 begin
			if game.get_event_flag("EventMiningMap") == 0 and not pc.is_gm() then
				warp_to_village()
			end
			for i = 50601, 50619, 1  do
				if pc.count_item(i) > 0 and i != 50602 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Evento de Mineria~")
					say_red(gameforge.dungeon.msm001)
					say("")
					say("¡Imposible Ingresar al Evento si tienes Minerales!")
					say("Guardalos en el Almacen e Intentalo Nuevamente")
					say("")
					say_item (item_name(i) , i , "")
					say("")
					timer("MiningExit", 1)
					return
				end
			end
			loop_timer("MiningCheck",1)
		end
		when MiningExit.timer begin
			if pc.get_map_index() == 403 and not pc.is_gm() and game.get_event_flag("EventMiningMap") == 1 then
				warp_to_village()
			end
		end
		when MiningCheck.timer begin
			if pc.get_map_index() == 403 and not pc.is_gm() and game.get_event_flag("EventMiningMap") == 0 then
				warp_to_village()
			end
		end
		when 20015.chat."Maraton de Mineria" with game.get_event_flag("EventMiningMap") == 1 and pc.get_map_index() != 403 begin
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
			say_gold("¿Quieres participar en el evento Mineria?")
			say("")
			if select("Ingresar","Cancelar") == 1 then
				for i = 50601, 50619, 1  do
					if pc.count_item(i) > 0 and i != 50602 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say("")
						say("¡Imposible Ingresar al Evento si tienes Minerales!")
						say("Guardalos en el almacen e intentalo Nuevamente")
						say("")
						say_item (item_name(i) , i , "")
						say("")
						return
					end
				end
				pc.warp(73180300,73157000)
			end
		end
	end
end
