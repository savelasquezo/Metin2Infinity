quest TrainingGranndmasterSkill begin
	state start begin
		when 50513.use begin
			cmdchat ( "ruhtasiekranac " .. q . getcurrentquestindex ( ) ) 
		end
		when 50514.use begin
			if pc.get_skill_group() == 0 then
				say_title("Entrenamiento de Potenciacion:")
				say("aun no has iniciado un aprendizaje.")
				say("")
				return
			end
			local check_learned = 0
			local help_skill_list = {
				{{236}, {240},},
				{{237}, {241},},
				{{238}, {242},},
				{{239}, {243},},
				{{244},},
								}
			local skill_list = help_skill_list[pc.get_job() + 1][pc.get_skill_group()]
			for i = 1, table.getn(skill_list) do
				skill_vnum = skill_list[i]
				if pc.get_skill_level(skill_vnum) > 0 then
					check_learned = 1
				end
			end
			if check_learned == 1 then
				say_title("Entrenamiento de Potenciacion:")
				say("Ya has aprendido una habilidad de potenciacion")
				say("")
				return
			end
			help_skill_list_name = {
				[236] = "Potenciador de Giro de Espada",
				[237] = "Potenciador de Emboscada",
				[238] = "Potenciador de Golpe de Dedo",
				[239] = "Potenciador de Disparo Dragon",
				[240] = "Potenciador de Pulso Espiritual",
				[241] = "Potenciador de Flecha de Fuego",
				[242] = "Potenciador de Golpe Oscuro",
				[243] = "Potenciador de Llamada Relampago",
				[244] = "Potenciador de Aliento de Lobo"
						}
			local skill_vnum_list = {}
			local skill_name_list = {}
			for i = 1, table.getn(skill_list) do
				skill_vnum = skill_list[i]
				if pc.get_skill_level(skill_vnum) < 1 then
					table.insert(skill_vnum_list, skill_vnum)
					table.insert(skill_name_list, help_skill_list_name[skill_vnum])
				end
			end
			if table.getn(skill_vnum_list) == 0 then
				say_title("Entrenamiento de Potenciacion:")
				say("No hay habilidades de Potenciacion Disponibles")
				say("")
				return
			end
			table.insert(skill_name_list, "Cancelar")
			say_title("Entrenamiento de Potenciacion:")
			say("Este libro antiguo parece ser muy poderoso!")
			say("contiene la llave para entrenar potenciaciones.")
			say("Solo puede escojer una habilidad")
			say("Decide Sabiamente")
			say("")
			local i = select_table(skill_name_list)
			if i == table.getn(skill_name_list)then
				return
			end
			local name = skill_name_list[i]
			local vnum = skill_vnum_list[i]
			say_title("Entrenamiento de Potenciacion:")
			say("")
			say(string.format("Elijes Entrenar %s.", name))
			say("Confirmacion de Entrenamiento!")
			local confirm = select("Entrenar", "Cancelar")
			if confirm == 1 then
				pc.remove_item(item.get_vnum(), 1)
				pc.set_skill_level(vnum, 20)
				return
			end
			return
		end
		when 50515.use begin
			if pc.get_skill_group() == 0 then
				say_title("Entrenamiento de Contraataque:")
				say("No has iniciado un Aprendizaje aun")
				say("")
				return
			end
			local check_learned = 0
			local anti_skill_list = {221, 222, 223, 224, 225, 226, 227, 228, 229}
			for i = 1, table.getn(anti_skill_list) do
				skill_vnum = anti_skill_list[i]
				if pc.get_skill_level(skill_vnum) > 0 then
					check_learned = 1
				end
			end
			if check_learned == 1 then
				say_title("Entrenamiento de Contraataque:")
				say("Ya has aprendido una habilidad de Contraataque")
				say("")
				return
			end
			anti_skill_list_name = {
				[221] = "Contra Ataque a Giro de Espada",
				[222] = "Contra Ataque a Emboscada",
				[223] = "Contra Ataque a Golpe de Dedo",
				[224] = "Contraataque a Disparo Dragon",
				[225] = "Contra Ataque a Pulso Espiritual",
				[226] = "Contra Ataque a Flecha de Fuego",
				[227] = "Contra Ataque a Golpe Oscuro",
				[228] = "Contra Ataque a Llamada Relampago",
				[229] = "Contra Ataque a Aliento de Lobo"
							}
			local skill_vnum_list = {}
			local skill_name_list = {}
			for i = 1, table.getn(anti_skill_list) do
				skill_vnum = anti_skill_list[i]
				if pc.get_skill_level(skill_vnum) < 1 then
					table.insert(skill_vnum_list, skill_vnum)
					table.insert(skill_name_list, anti_skill_list_name[skill_vnum])
				end
			end
			if table.getn(skill_vnum_list) == 0 then
				say_title("Entrenamiento de Contraataque:")
				say("No hay habilidades de Contraataque Disponibles")
				say("")
				return
			end
			table.insert(skill_name_list, "Cancelar")
			say_title("Entrenamiento de Contraataque:")
			say("Este libro antiguo parece ser muy poderoso!")
			say("contiene la llave para entrenar contraataques.")
			say("Solo puede escojer una habilidad")
			say("Decide Sabiamente")
			say("")
			local i = select_table(skill_name_list)
			if i == table.getn(skill_name_list)then
				return
			end
			local name = skill_name_list[i]
			local vnum = skill_vnum_list[i]
			say_title("Entrenamiento de Contraataque:")
			say("")
			say(string.format("Eliges Entrenar %s.", name))
			say("Confirmacion de Entrenamiento!")
			local confirm = select("Entrenar", "Cancelar")
			if confirm == 1 then
				pc.remove_item(item.get_vnum(), 1)
				pc.set_skill_level(vnum, 20)
				return
			end
			return
		end
		when 50525.use begin
			if pc.get_skill_group() == 0 then
				say_title("Piedra Maestra:")
				say("No has iniciado un Aprendizaje aun")
				say("")
				return
			end
			
			if get_time() < pc.getqf("next_time") then
				if not pc.is_skill_book_no_delay() then
					say_title("Piedra Maestra:")
					say("El Entrenamiento de las habilidades especiales")
					say("toma tiempo, debes descansar por 3 horas")
					say("")
					return
				end
			end
			GRAND_MASTER_SKILL_LEVEL = 30
			PERFECT_MASTER_SKILL_LEVEL = 40
			local check_learned = 0
			local new_skill_list = {221, 222, 223, 224, 225, 226, 227, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244}
			for i = 1, table.getn(new_skill_list) do
				skill_vnum = new_skill_list[i]
				if pc.get_skill_level(skill_vnum) >= GRAND_MASTER_SKILL_LEVEL and pc.get_skill_level(skill_vnum) < PERFECT_MASTER_SKILL_LEVEL then
					check_learned = 1
				end
			end
			if check_learned == 0 then
				say_title("Piedra Maestra:")
				say("No has aprendido ninguna habilidad Maestras")
				say("entrena una habilidad de maestros de guerra.")
				say("")
				return
			end
			new_skill_list_name = {
				[221] = "Contraataque a Giro de Espada",
				[222] = "Contraataque a Emboscada",
				[223] = "Contraataque a Golpe de Dedo",
				[224] = "Contraataque a Disparo Dragon",
				[225] = "Contraataque a Pulso Espiritual",
				[226] = "Contraataque a Flecha de fuego",
				[227] = "Contraataque a Golpe Oscuro",
				[228] = "Contraataque a Llamada Relampago",
				[229] = "Contraataque a Aliento de Lobo",
				[236] = "Potenciador de Giro de Espada",
				[237] = "Potenciador de Emboscada",
				[238] = "Potenciador de Golpe de Dedo",
				[239] = "Potenciador de Disparo Dragon",
				[240] = "Potenciador de Pulso Espiritual",
				[241] = "Potenciador de Flecha de Fuego",
				[242] = "Potenciador de Golpe Oscuro",
				[243] = "Potenciador de Llamada Relampago",
				[244] = "Potenciador de Aliento de Lobo"
							}
			local skill_vnum_list = {}
			local skill_name_list = {}
			for i = 1, table.getn(new_skill_list) do
				skill_vnum = new_skill_list[i]
				if pc.get_skill_level(skill_vnum) >= GRAND_MASTER_SKILL_LEVEL and pc.get_skill_level(skill_vnum) < PERFECT_MASTER_SKILL_LEVEL then
					table.insert(skill_vnum_list, skill_vnum)
					table.insert(skill_name_list, new_skill_list_name[skill_vnum])
				end
			end
			if table.getn(skill_vnum_list) == 0 then
				say_title("Piedra Maestra:")
				say("No hay Habilidades Maestras Disponibles")
				say("")
				return
			end
			say_title("Piedra Maestra:")
			say("El Entrenamiento de habilidades Maestras")
			say("requiere un gran gasto de karma.")
			say("Es posible llegar a rank negativo")
			say("")
			say("Quieres Entrenar?")
			local s = select("Entrenar", "Cancelar")
			if s == 2 then
				return
			end
			say_title("Piedra Maestra:")
			say("Seleccion la Habilidad a Entrenar")
			table.insert(skill_name_list, "Cancelar")
			local i = select_table(skill_name_list)
			if i == table.getn(skill_name_list)then
				return
			end
			local name = skill_name_list[i]
			local vnum = skill_vnum_list[i]
			local level = pc.get_skill_level(vnum)
			local cur_alignment = pc.get_real_alignment()
			local need_alignment = 1000 + 500 * (level - 30)
			if cur_alignment <- 19000+need_alignment then
				say_title("Piedra Maestra:")
				say("No tienes suficiente karma, necesitas mas rank")
				say("entrena arduamente para aumentar el karma.")
				say("")
				return
			end
			if get_time() < pc.getqf("next_time") then
				if pc.is_skill_book_no_delay() then
					pc.remove_skill_book_no_delay()
				else
					say_title("Piedra Maestra:")
					say("El Entrenamiento de las habilidades especiales")
					say("toma tiempo, debes descansar por 3 horas")
					say("")
				end
			end
			
			say(string.format("Eliges Entrenar %s.", name))
			say("Confirmacion de Entrenamiento!")
			local confirm = select("Entrenar", "Cancelar")
			if confirm == 1 then
				pc.setqf("next_time", get_time() + 60 * 60 * math.random(12, 24))
				say_title("Piedra Maestra:")
				if pc.learn_grand_master_skill(vnum) then
					if pc.get_skill_level(vnum) == 40 then
						say(string.format("%s ah alcanzado el Nivel Perfecto", name))
					else
						say(string.format("Has Aumentado %s a G%d.", name, level-30+1+1))
					end
					say("Mi cuerpo esta lleno de poder! Algo sale de mi!")
					say("Has completado el entrenamiento Existosamente!")
					say("")
				else
					pc.change_alignment(-number(need_alignment / 3, need_alignment / 2))
					say("Eso no funciono, Maldicion!")
					say("")
				end
				pc.remove_item(item.get_vnum(), 1)
			end
			return
		end
		when 71000.use begin
			if pc.get_skill_group() == 0 then
				say_title("Olvido Maestro:")
				say("No has iniciado un Aprendizaje aun")
				say("")
				return
			end
			local check_learned = 0
			local new_skill_list = {221, 222, 223, 224, 225, 226, 227, 228, 229, 236, 237, 238, 239, 240, 241, 242, 243, 244}
			for i = 1, table.getn(new_skill_list) do
				skill_vnum = new_skill_list[i]
				if pc.get_skill_level(skill_vnum) > 0 then
					check_learned = 1
				end
			end
			if check_learned == 0 then
				say_title("Olvido Maestro:")
				say("No has aprendido ninguna habilidad Maestras")
				say("entrena una habilidad de maestros de guerra.")
				say("")
				return
			end
			say_title("Olvido Maestro:")
			say("Olvidaras toddas las habilidades maestras")
			say("estas seguro que quieres hacerlo?")
			local confirm = select("Si", "No")
			if confirm == 1 then
				for i = 1, table.getn(new_skill_list) do
					skill_vnum = new_skill_list[i]
					if pc.get_skill_level(skill_vnum) > 0 then
						pc.set_skill_level(skill_vnum, 0)
					end
				end
				pc.remove_item(item.get_vnum(), 1)
			end
			return
		end
		when 50512.use begin
			table.foreachi(special.active_skill_list[pc.get_job()+1][pc.get_skill_group()],function(r,skill) pc.set_skill_level(skill,59) end) 
			syschat("Habilidades Han alcanzado el Grado Master Perfecto.") 
			item.remove() 
		end
	end
end
