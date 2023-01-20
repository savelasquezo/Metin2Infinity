quest dsoul_dayli begin
	state start begin
		when login or levelup with pc.level >= 30 begin
			set_state(information)
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20001)
			if v != 0 then
				target.vid("__TARGET__", v, "Alquimista")
			end
			send_letter("Alquimia")
		end
		when button or info begin
			say_title("Alquimista:")
			say("He Desarrollado una tecnica que permite acumular")
			say("el poder del Dios Dragon en las Piedras Dragon.")
			say("Ven a buscarme lo Antes posible!.")
			say("")
		end
		when __TARGET__.target.click or	20001.chat."Alquimia Piedras Dragon" begin
			target.delete("__TARGET__")
			say_title("Alquimista:")
			say("He Descubierto algo sorprendente, los fragmentos")
			say("de piedras dragon son joyas realmente raras")
			say_item("Fragmento de Piedra Dragon", 30270, "")
			say("Contienen un poder sorprendente, se dice que estas")
			say("contienen el alma de antiguos dragones.")
			say("Recientemente he desarrollado una tecnica que me")
			say("permite regresarle la vida a estas piedras dragon.")
			say("")
			wait()
			say_title("Alquimista:")
			say("Consigueme 10 Fragmentos Dragon y los transmutare")
			say("en una nueva piedra dragon llena de vida.")
			say_item("Cor Draconis ++", 51503, "")
			say("Los Cor Draconis contiene una de las Piedrad Dragon")
			say("aleatoria, aunque en estado simple podras refinar")
			say("estas joyas en unas aun mas poderosas.")
			say("")
			set_state(state_learning)
		end
	end
	state state_learning begin
		when letter begin
			send_letter("Alquimia del Dragon")
		end
		when info or button begin
			say_title("Alquimista:")
			say("Consigueme 10 Fragmentos Dragon y los transmutare")
			say("en una nueva piedra dragon llena de vida.")
			say("")
		end
		when kill begin
			if npc.is_pc() or pc.get_level ( ) < 30 then
				return 
			end
			if number(1,100) == 1 then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(30270, 1)
					syschat("Has encontrado un Fragmento del Dragon.")
				end
			end
		end
		when 20001.chat."Fragmentos del Dragon" begin
			if pc.count_item(30270) >= 10 then
				say_title("Alquimista:")
				say("Fantastico! Lograste conseguir 10 Fragmentos")
				say("ahora empleare mi tecnica para crear Cor Draconis.")
				say_item("Cor Draconis ++", 51503, "")
				say("El poder del Dios Dragon ha entrado en la Draconis")
				say("Esta contiene una Piedra Dragon Aleatoria.")
				say("Haz Recibido el Poder del Ojo del Dragon")
				say("Consigue Fragmentos del Dragon.")
				say("")
				pc.remove_item(30270, 10)
				ds.give_qualification()
				char_log(pc.get_player_id(), 'DS_QUALIFICATION', 'SUCCESS')
				pc.give_item2(51503)
				local today = math.floor(get_global_time() / 86400)
				pc.setf("dsoul_dayli", "eye_timestamp", today)
				pc.setf("dsoul_dayli", "eye_left", 14)
				set_state(state_farming)
			else
				say_title("Alquimista:")
				say("Consigueme 10 Fragmentos Dragon y los transmutare")
				say("en una nueva piedra dragon llena de vida.")
				say_item("Fragmento de Piedra Dragon", 30270, "")
				say("Puedes encuentrar los Fragmentos de Piedras Dragon")
				say("Destruyendo Metines y Monstruos Neutrales.")
				say("")
			end
		end
	end
	state state_farming begin
		when letter begin
			send_letter("Alquimia del Dragon")
		end
		when info or button begin
			say_title("Alquimista:")
			say("Consigueme 10 Fragmentos Dragon y transmutalos")
			say("en una nueva piedra dragon llena de vida.")
			say(string.format("Energia del Dios Dragon", pc.getf("dsoul_dayli", "eye_left")))
			say("")
		end
		when 30270.pick begin
			local eye_left = pc.getf("dsoul_dayli", "eye_left")
			if eye_left <= 0 then
				return
			end
			if pc.count_item(30270) >= 10 then
				pc.setf("dsoul_dayli", "eye_left", eye_left - 1)
				pc.remove_item(30270, 10)
				pc.give_item2(51503, 1)
				if ds.is_qualified() then
					ds.give_qualification()
					char_log(pc.get_player_id(), 'DS_QUALIFICATION', 'SUCCESS')
				end
				if 1 == eye_left then
					syschat("El Poder del Dios Dragon se ha Agotado!")
					set_state(state_closed_season)
				end
			end
		end
		when 20001.chat."Alquimia del Dragon" begin
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dsoul_dayli", "eye_timestamp") then
				say_title("Alquimista:")
				say("La Tecnica del ojo del Dragon es muy desgastante")
				say("Has recibido el poder del Dragon el dia de hoy")
				say("Regresa despues para Activar el poder del Dragon.")
				say("")
			else
				say_title("Alquimista:")
				say("Haz Recibido el Poder del Ojo del Dragon")
				say("Consigue Fragmentos del Dragon.")
				pc.setf("dsoul_dayli", "eye_timestamp", today)
				pc.setf("dsoul_dayli", "eye_left", 15)
				say("")
			end
		end
		when kill with pc.getf("dsoul_dayli", "eye_left") >= 1 begin
			if npc.is_pc() or pc.get_level ( ) < 30 then
				return 
			end
			if number(1,300) == 1 then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(30270, 1)
					syschat("Has encontrado un Fragmento del Dragon.")
				end
			end
		end
	end
	state state_closed_season begin
		when letter begin
			send_letter("El Ojo del Dragon Agotado!")
		end
		when info or button begin
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dsoul_dayli", "eye_timestamp") then
				say_title("Alquimista:")
				say("La Tecnica del ojo del Dragon es muy desgastante")
				say("Has recibido el poder del Dragon el dia de hoy")
				say("Regresa despues para Activar el poder del Dragon.")
				say("")
			else
				say_title("Alquimista:")
				say("La Energia del Dios Dragon se ha recuperado")
				say("Regresa y te entregare el Poder del Ojo del Dragon.")
				say("")
			end
		end
		when 20001.chat."Alquimia del Dragon" begin
			local today = math.floor(get_global_time() / 86400)
			if today == pc.getf("dsoul_dayli", "eye_timestamp") then
				say_title("Alquimista:")
				say("La Tecnica del ojo del Dragon es muy desgastante")
				say("Has recibido el poder del Dragon el dia de hoy")
				say("Regresa despues para Activar el poder del Dragon.")
				say("")
			else
				say_title("Alquimista:")
				say("Haz Recibido el Poder del Ojo del Dragon")
				say("Consigue Fragmentos del Dragon.")
				pc.setf("dsoul_dayli", "eye_timestamp", today)
				pc.setf("dsoul_dayli", "eye_left", 15)
				set_state(state_farming)
			end
		end
	end
end

