quest EventChristmas begin
	state start begin
		when 60478.chat."GM: Evento Navidad" with pc.is_gm() begin
			say_title("Evento de Navidad ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventChristmas") == 0 then
				if select ( "Activar" , "Cancelar" ) == 1 then
					say_title("Evento de Navidad ->Panel GM")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventChristmas",1)
						game.set_event_flag("ChristmasDrops",750)
						notice_all("<Evento> La Lamdavidad ha Comenzado!")
					end
				end
			else
				if select("Finalizar","Cancelar") == 1 then
					game.set_event_flag("EventChristmas",0)
				end
			end
		end
		when 60478.chat."Tienda Navidad Lamda" with pc.get_map_index() == 401 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~SANTA CLAUS~")
			say("")
			say("Jo Jo Jo Aventurero")
			say("Este año tengo muchos objetos para que sientas")
			say("El espiritu de la navidad en Lamda2, Espero te gusten")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(36)
			end
			if r == 2 then
				return
			end
		end
		when 60478.chat."Tienda Navidad Retro" with pc.get_map_index() == 401 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~SANTA CLAUS~")
			say("")
			say("Jo Jo Jo Aventurero")
			say("Tambien te traigo los objetos de navidades pasadas")
			say("Por si te gusta lo clasico, a mi me gusta mucho!!.")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(37)
			end
			if r == 2 then
				return
			end
		end
		when 60478.chat."Navidad Lamda" with pc.get_map_index() != 401 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Feliz Navidad les desea Metin2 Lamda!")
			say("Maravillosos obsequios & regalos Obtendras")
			say_gold("¿Quieres Ingresar al Evento?")
			say("")
			if select ("Ingresar","Cancelar") == 1 then
				pc.warp(2252800+545*100,332800+160*100)
			end
		end
		when 60478.chat."Salir del Evento" with pc.get_map_index() == 401 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Feliz Navidad les desea Metin2 Lamda!")
			say("Maravillosos obsequios & regalos Obtendras")
			say_gold("¿Quieres Salir del Evento?")
			say("")
			if select ("Salir","Cancelar") == 1 then
				warp_to_village()
			end
		end
		when 20384.chat."Calcetines de Regalos" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Treinta Calcetines tu colgaras, asi un gran premio")
			say("Tu recibiras, buscalos como drop general Durante")
			say("Todo el mes de Navidad.")
			say_item("Calcetin", 50010, "")
			say("")
		end
		when 20384.take begin
			if item.get_vnum() == 50010 then
				if pc.count_item("50010") < 30 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("Treinta Calcetines tu colgaras, asi un gran premio")
					say("Tu recibiras, buscalos como drop general Durante")
					say("Todo el mes de Navidad.")
					say("")
					return
				end
				notice_all(string.format("Feliz Lamdavidad!! %s ha reclamado un Obsequio!",pc.get_name()))
				pc.remove_item(50010, 30)
				pc.give_item2(71144, 1)
			end
		end
		when kill with game.get_event_flag("EventChristmas") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,game.get_event_flag("ChristmasDrops")) == 1 then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(50010, 1)
					syschat("Has encontrado un Calcetin!")
				end
			end
		end
	end
end

