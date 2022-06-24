quest HorseSummon begin
	state start begin
		function horse_menu()
			if horse.is_mine() then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title( "~MENU~" )
				say("~Administracion del Caballo~")
				say("")
				local s = 6
				if horse.is_dead() then
					return
				end
				s = select("Alimentar", "Montar", "Guardar", "Estado", "Nombrar", "Cerrar")
				if s == 0 then
					horse.revive()
				elseif s == 1 then
					local food = horse.get_grade() + 50054 - 1
					if pc.countitem(food) > 0 then
						pc.removeitem(food, 1)
						horse.feed()
					else
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~ALIMENTAR~")
						say("")
						say("Alimentar tu caballo es una tarea siemple simple")
						say("unicamente necesitas el alimento indicado")
						say("")
						say_item(item_name(food), food, "")
						say("")
						return
					end
				elseif s == 2 then
					if !pc.is_mount() then
						horse.ride()
					end
				elseif s == 3 then
					horse.unsummon()
				elseif s == 4 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~ESTADO~")
					say("")
					say("Descansar es importante para las monturas")
					say("¡La Fuerza del caballo depende de su Estado!")
					say("")
					say_title("~VITALIDAD~")
					if horse.get_health_pct() > 50 then
						say_green(""..horse.get_health_pct().."%")
					else
						say_red(""..horse.get_health_pct().."%")
					end
					say("")
					say_title("~RESISTENCIA~")
					if horse.get_stamina_pct() > 50 then
						say_green(""..horse.get_stamina_pct().."%")
					else
						say_red(""..horse.get_stamina_pct().."%")
					end
					say("")
				elseif s == 5 then
					if pc.countitem("71110") <= 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~RENOMBRAR~")
						say("")
						say("Nombrar tu caballo es una tarea siemple simple")
						say("unicamente necesitas Azucar para Caballos")
						say("")
						say_item(item_name(71110), 71110, "")
						say("")
						return
					end
					local old_horse_name = horse.get_name() ;
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~RENOMBRAR~")
					say("")
					say("Nombrar tu Caballo es importante en su Desarrollo")
					say("Necesita un Nombre para desarrollarse por completo")
					say("")
					say_title("EL Nombre debe contener entre 3 a 12 Letras")
					say_title("La Defensa de la Montura Aumentara 20 Puntos")
					say("")
					if string.len(old_horse_name) == 0 then
						say_title("~Nombre Actual~")
						say_red("-SIN NOMBRE-")
					else
						say_title("~Nombre Actual~")
						say_green(old_horse_name)
					end
					say("")
					say("¿Quieres ponerle nombre a tu Caballo? ")
					say("")
					local sd = select("Nombrar Caballo", "Cancelar")
					if sd == 1 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~RENOMBRAR~")
					say("")
					local horse_name = input()
						if string.len(horse_name) < 2 then
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title("~RENOMBRAR~")
							say_red("~Error~")
							say("El Nombre debe contener Minimo 3 Letras")
							say("")
							return
						elseif string.len(horse_name) > 12 then
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title("~RENOMBRAR~")
							say_red("~Error~")
							say("")
							say("El Nombre debe contener Maximo 12 Letras")
							say("")
							return
						end
						local ret = horse.set_name(horse_name)
						if ret == 0 then
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title("~RENOMBRAR~")
							say_red("~Error~")
							say("")
							say("¡El Caballo esta Muerto!")
							say("")
							say("")
							say_title("Afortunadamente podras Recusitarlo")
							say_title("Usando Hierbas de Monos Legendarios")
							say("")
						elseif ret == 1 then
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title("~RENOMBRAR~")
							say_red("~Error~")
							say("")
							say("¡Nombre Incorrecto!")
							say("")
						elseif ret == 2 then
							pc.remove_item("71110")
							raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
							say_title("~RENOMBRAR~")
							say_green("~Exitoso~")
							say("")
							say("¡El Caballo tiene un Nuevo Nombre!")
							say("")
						end
					elseif sd == 2 then
						return
					end
				end
			end
		end
		function get_horse_summon_prob_pct()
			local prob = {10,15,20,30,40,50,60,70,80,90,100}
			local skill_level = pc.get_skill_level(131) + 1
			return prob[skill_level]
		end
		when 20349.chat."Revivir Caballo" with horse.get_grade()==3 and horse.is_dead() begin
			if pc.countitem("50059")==0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say("")
				say("Necesitas la Hierba de Mono de la Mazmorra")
				say("de los monos Dificiles.")
				say_item("Hierba de Monos Dificiles", 50059, "")
				say("")
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("Recusitar el Caballo requiere usar la Hierba")
			say("¡Monos Dificiles!")
			say_item("Hierba de Monos Dificiles", 50059, "")
			say("")
			local sd = select("Revivir Caballo", "Cancelar")
			say("")
			if sd == 1 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say_green("~Exitoso~")
				say("")
				say("¡El Caballo ha sido Revivido!")
				say("")
				pc.removeitem("50059", 1)
				horse.revive()
			elseif sd == 2 then
				return
			end
		end
		when 20349.chat."Revivir Caballo" with horse.get_grade()==2 and horse.is_dead() begin
			if pc.countitem("50058")==0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say("")
				say("Necesitas la Hierba de Mono de la Mazmorra")
				say("de los monos Normales.")
				say_item("Hierba de Monos Normales", 50058, "")
				say("")
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("Recusitar el Caballo requiere usar la Hierba")
			say("¡Monos Normales!")
			say_item("Hierba de Monos Normales", 50058, "")
			say("")
			local sd = select("Revivir Caballo", "Cancelar")
			say("")
			if sd == 1 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say_green("~Exitoso~")
				say("")
				say("¡El Caballo ha sido Revivido!")
				say("")
				pc.removeitem("50058", 1)
				horse.revive()
			elseif sd == 2 then
				return
			end
		end
		when 20349.chat."Revivir Caballo" with horse.get_grade()==1 and horse.is_dead() begin
			if pc.countitem("50057")==0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say("")
				say("Necesitas la Hierba de Mono de la Mazmorra")
				say("de los monos Faciles.")
				say_item("Hierba de Monos Faciles", 50057, "")
				say("")
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("Recusitar el Caballo requiere usar la Hierba")
			say("¡Monos Faciles!")
			say_item("Hierba de Monos Faciles", 50057, "")
			say("")
			local sd = select("Revivir Caballo", "Cancelar")
			say("")
			if sd == 1 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Chico del Establo~")
				say_green("~Exitoso~")
				say("")
				say("¡El Caballo ha sido Revivido!")
				say("")
				pc.removeitem("50057", 1)
				horse.revive()
			elseif sd == 2 then
				return
			end
		end
		when 20349.chat."Libro de Caballo Normal" with horse.get_grade()==1 and pc.countitem("50051")<1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("¡¿Has perdido el Libro de Invocacion?!")
			say("Fabricar uno Nuevo Requiere Yang")
			say_title("1.000.000 Yang.")
			say("")
			say_title("¿Quieres un nuevo Libro Invocador?")
			say("")
			local b=select("Si", "No")
			if 1==b then
				if pc.money>=1000000 then
					pc.changemoney(-1000000)
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_green("~Exitoso~")
					say("")
					say("¡La Fabricacion del Libro Invocador fue un Exito!")
					say("Intenta no Perderlo")
					say("")
					pc.give_item2("50051", 1)
				else
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_red("~Error~")
					say("")
					say("Lo siento no tienes suficiente Yang")
					say("Vuelve cuendo tengas dinero")
					say("")
				end
			else
				return
			end
		end
		when 20349.chat."Libro de Caballo Armado" with horse.get_grade()==2 and pc.countitem("50052")<1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("¡¿Has perdido el Libro de Invocacion?!")
			say("Fabricar uno Nuevo Requiere Yang")
			say_title("3.000.000 Yang.")
			say("")
			say_title("¿Quieres un nuevo Libro Invocador?")
			say("")
			local b=select("Si", "No")
			if 1==b then
				if pc.money>=3000000 then
					pc.changemoney(-3000000)
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_green("~Exitoso~")
					say("")
					say("¡La Fabricacion del Libro Invocador fue un Exito!")
					say("Intenta no Perderlo")
					say("")
					pc.give_item2("50052", 1)
				else
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_red("~Error~")
					say("")
					say("Lo siento no tienes suficiente Yang")
					say("Vuelve cuendo tengas dinero")
					say("")
				end
			else
				return
			end
		end
		when 20349.chat."Libro de Caballo Militar" with horse.get_grade()==3 and pc.countitem("50053")<1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Chico del Establo~")
			say("")
			say("¡¿Has perdido el Libro de Invocacion?!")
			say("Fabricar uno Nuevo Requiere Yang")
			say_title("5.000.000 Yang.")
			say("")
			say_title("¿Quieres un nuevo Libro Invocador?")
			say("")
			local b=select("Si", "No")
			if 1==b then
				if pc.money>=5000000 then
					pc.changemoney(-5000000)
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_green("~Exitoso~")
					say("")
					say("¡La Fabricacion del Libro Invocador fue un Exito!")
					say("Intenta no Perderlo")
					say("")
					pc.give_item2("50053", 1)
				else
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Chico del Establo~")
					say_red("~Error~")
					say("")
					say("Lo siento no tienes suficiente Yang")
					say("Vuelve cuendo tengas dinero")
					say("")
				end
			else
				return
			end
		end
		when 50051.use with horse.get_grade()==0 begin
			chat("[Equitacion] Actualmente no posees un Caballo!")
		end
		when 50051.use with horse.get_grade()==1 begin
			if pc.is_mount() then
				chat("[Equitacion]: Imposible Invocar debe desender de la Montura!")
				return
			end
			if pc.getsp()>=100 then
				if pc.get_map_index() == 113 or pc.get_map_index() == 111 or pc.get_map_index() == 110 or pc.get_map_index() == 140 or pc.get_map_index() == 12 or pc.get_map_index() == 241 then
					chat("[Equitacion] Imposible Invocar durante un Evento!")
				elseif number(1, 100)<=HorseSummon.get_horse_summon_prob_pct() then
					chat("[Equitacion] Invocacion del Caballo Exitosa!")
					horse.summon()
					pc.change_sp(-100)
				else
					chat("[Equitacion] Invocacion del Caballo Fallida! Intentalo Nuevamente")
					pc.change_sp(-100)
				end
				
			else
				chat("[Equitacion] Mana Insuficiente!")
			end
		end
		when 50051.use with horse.get_grade()==2 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50051.use with horse.get_grade()==3 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50052.use with horse.get_grade()==0 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50052.use with horse.get_grade()==1 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50052.use with horse.get_grade()==2 begin
			if pc.is_mount() then
				chat("[Equitacion]: Imposible Invocar debe desender de la Montura!")
				return
			end
			if pc.getsp()>=200 then
				if pc.get_map_index() == 113 or pc.get_map_index() == 111 or pc.get_map_index() == 110 or pc.get_map_index() == 140 or pc.get_map_index() == 12 then
					chat("[Equitacion] Imposible Invocar durante un Evento!")
				elseif number(1, 100)<=HorseSummon.get_horse_summon_prob_pct() then
					chat("[Equitacion] Invocacion del Caballo Exitosa!")
					horse.summon()
					pc.change_sp(-100)
				else
					chat("[Equitacion] Invocacion del Caballo Fallida! Intentalo Nuevamente")
					pc.change_sp(-100)
				end
			else
				chat("[Equitacion] Mana Insuficiente!")
			end
		end
		when 50052.use with horse.get_grade()==3 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50053.use with horse.get_grade()==0 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50053.use with horse.get_grade()==1 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50053.use with horse.get_grade()==2 begin
			chat("[Equitacion] Libro Invocador Inadecuado!")
		end
		when 50053.use with horse.get_grade()==3 begin
			if pc.is_mount() then
				chat("[Equitacion]: Imposible Invocar debe desender de la Montura!")
				return
			end
			if pc.getsp()>=300 then
				if pc.get_map_index() == 113 or pc.get_map_index() == 111 or pc.get_map_index() == 110 or pc.get_map_index() == 140 or pc.get_map_index() == 12 then
					chat("[Equitacion] Imposible Invocar durante un Evento!")
				elseif number(1, 100)<=HorseSummon.get_horse_summon_prob_pct() then
					chat("[Equitacion] Invocacion del Caballo Exitosa!")
					horse.summon()
					pc.change_sp(-300)
				else
					chat("[Equitacion] Invocacion del Caballo Fallida! Intentalo Nuevamente")
					pc.change_sp(-300)
				end
				
			else
				chat("[Equitacion] Mana Insuficiente!")
			end
		end
		when 20030.click begin HorseSummon.horse_menu() end
		when 20101.click begin HorseSummon.horse_menu() end
		when 20102.click begin HorseSummon.horse_menu() end
		when 20103.click begin HorseSummon.horse_menu() end
		when 20104.click begin HorseSummon.horse_menu() end
		when 20105.click begin HorseSummon.horse_menu() end
		when 20106.click begin HorseSummon.horse_menu() end
		when 20107.click begin HorseSummon.horse_menu() end
		when 20108.click begin HorseSummon.horse_menu() end
		when 20109.click begin HorseSummon.horse_menu() end
	end
end
