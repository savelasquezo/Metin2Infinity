quest horse_upgrade01 begin
	state start begin
		when login or levelup with pc.level >= 15 begin
			if horse.get_grade() > 1 then
				set_quest_state("horse_upgrade02", "run")
				setstate(__COMPLETE__)
			else
				set_state(information)
			end
		end
	end
	state information begin
		when login or levelup with pc.level >= 15 begin
			if horse.get_grade() > 1 then
				set_quest_state("horse_upgrade02", "run")
				setstate(__COMPLETE__)
			end
		end
		when 20349.chat."Caballo Armado" with pc.level >= 15 begin
			say_title("Chico del Establo:")
			if horse.is_dead() then
				say("El Caballo ha muerto, primero deberas revivirlo")
				say("Usando una Hierva de Monos.")
				say_item("Hierva de Monos Faciles", 50057, "")
				say("")
				say("Consigue la Hierva de Monos Faciles")
				say("Encuenntrala en la Mazmorra de Monos Faciles.")
				say("")
			elseif pc.level < 15 then
				say("Eres demasiado Joven para estar listo para montar")
				say("Un Caballo Armado.")
				say("")
				say("Regresa cuando seas al menos Nivel 15.")
				say("")
			elseif pc . count_item ("50050") < 10 then
				say("Necesitas 10 Medallas de Caballo para poder")
				say("Entrenar un Caballo Armado.")
				say_item("Medalla de Caballo", 50050, "")
				say("")
				say("Consigue las Medallas de Caballo")
				say("Encuenntrala en la Mazmorra de Monos.")
				say("")
			elseif pc . count_item ("50051") < 1 then
				say("Necesitas Simbolo de Caballo para poder")
				say("Entrenar un Caballo Armado.")
				say_item("Simbolo de Caballo", 50051, "")
				say("")
				say("Consigue Un Simbolo de Caballo")
				say("")
			elseif not horse.is_dead() and pc . count_item ("50050") >= 10 and pc.level >= 15 then
				say("El Entrenamiento del Caballo Armado Requiere")
				say("Al menos 10 Medallas de Caballo.")
				say_item("Medalla de Caballo", 50050, "")
				say("")
				say("En Caso de Fallar Perderas Todas las Medallas de Caballo")
				say("Recomendable hacer la mision en grupo.")
				say("")
				local b= select("Entrenar Caballo Armado", "Cancelar")
				if 1==b then
					if pc . count_item ("50050")>= 10 then
						pc.removeitem("50050", 10)
						send_letter("Entrenamiento Armado")
						q.set_icon("scroll_open_green.tga")
						setstate(test)
					end
				elseif 2==b then
					say("Vuelve, Cuando estes Listo.") 
					say("") 
				else
					say(string.format("Ha Ocurrido un Error", b))
				end
			else
				say(string.format("Ha Ocurrido un Error", b))
			end
		end
	end
	state test begin
		when login or levelup with pc.level >= 15 begin
			if horse.get_grade() > 1 then
				set_quest_state("horse_upgrade02", "run")
				setstate(__COMPLETE__)
			end
		end
		when letter begin
			q.set_counter("General Salvaje: ", 100 - pc.getqf("kill_count"))
		end
		when 504.party_kill or 554.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("General Salvaje: ", 100 - pc.getqf("kill_count"))
			if get_time()>=pc.getqf("limit_time") then
				setstate(failure)
			end
		end
		when letter begin
			q.set_clock("Tiempo Restante Para Completar La Mision", pc.getqf("limit_time")-get_time())
		end
		when enter begin
			pc.setqf("limit_time", get_time()+45*60)
			pc.setqf("kill_count", 0)
		end
		when leave begin
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Entrenamiento Armado")
			q.set_title("Entrenamiento Armado")
			q.start()
		end
		when button or info begin
			say_title("Entrenamiento Armado")
			say("Elimina 100 Generales Salvajes.")
			say("Tienes 45 Min para Completar el Entrenamiento.")
			say("")
			say("La Mision la Puedes Completar en Grupo")
			say("Aunque tu deberas ser quien Lidere.")
			say("")
		end
		when 504.party_kill or 554.party_kill with pc.getqf("kill_count") >= 100 and pc.getqf("limit_time") > get_time() begin
			setstate(report)
		end
		when 20349.chat."Entrenamiento Armado" begin
			say_title("Chico del Establo:")
			say("Elimina 100 Generales Salvajes")
			say("Tienes 45 Min para Completar el Entrenamiento.")
			say("")
			say("La Mision la Puedes Completar en Grupo")
			say("Aunque tu deberas ser quien Lidere.")
			say("")
			local b= select("Cancelar Entrenamiento", "Salir")
			if 2==b then
				return
			end
			if 1==b then
				say_title("Chico del Establo:")
				say("Al Cancelar El Entrenamiento Perderas")
				say("Todas las Medallas de Caballo.")
				say_item("Medalla de Caballo", 50050, "")
				say("")
				local b= select("Cancelar Entrenamiento", "Salir")
				if 1==b then
					say_title("Chico del Establo:")
					say("El Entrenamiento Armado ha sido Cancelado")
					say("Ahora deberas Descansar.")
					say("")
					setstate(start)
					q.done()
				elseif 2==b then
					return
				else
					say(string.format("Ha Ocurrido un Error", b))
				end
			else
				say(string.format("Ha Ocurrido un Error", b))
			end
		end
	end
	state report begin
		when login or levelup with pc.level >= 15 begin
			if horse.get_grade() > 1 then
				set_quest_state("horse_upgrade02", "run")
				setstate(__COMPLETE__)
			end
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Vuelve al Chico del Establo ")
			q.set_title("Vuelve al Chico del Establo ")
			q.start()
		end
		when button or info begin
			say_title("Entrenamiento Armado")
			say_reward("Lograste Completar el Entrenamiento")
			say_reward("Regresa y Reporta los Resultados")
		end
		when 20349.chat."-Reporte- Entrenamiento Armado" begin
			say_title("Chico del Establo:")
			say("Sorprendente  Has Compeltado la Prueba")
			say("La Elaboracion del Libro Armado")
			say("Costara 1.000.000 Yang")
			say_item("Libro Caballo Armado", 50052, "")
			say("")
			setstate(buy)
		end
	end
	state failure begin
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Entrenamiento Fallido")
			q.set_title("Entrenamiento Fallido")
			q.start()
		end
		when button or info begin
			say_title("Entrenamiento Fallido")
			say_reward("Fallaste al Completar el Entrenamiento")
			say_reward("Regresa y Reporta los Resultados")
			setstate(start)
			q.done()
		end
	end
	state __COMPLETE__ begin
	end
	state buy begin
		when login or levelup with pc.level >= 15 begin
			if horse.get_grade() > 1 then
				set_quest_state("horse_upgrade02", "run")
				setstate(__COMPLETE__)
			end
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Caballo Armado Finalizado")
			q.set_title("Caballo Armado Finalizado")
			q.start()
		end
		when button or info begin
			say_title("Caballo Armado")
			say("El Tiempo de espera ha Finalizado")
			say("Ve donde el Chico del Establo.")
			say("")
			say("El Libro tendra un Costo de 1.000.000 Yang")
			say("")
		end
		when 20349.chat."Entrenamiento Caballo Armado" begin
			say_title("Chico del Establo:")
			say("Finalizado  El Libro Armado esta Fializado")
			say("[DELAY value;340].......................[/DELAY]")
			say("Gracias a este Libro podras Invocar")
			say("Directamente desde el Establo al Caballo Armado")
			say_item("Libro Caballo Armado", 50052, "")
			say("")
			say("El Libro Tendra un Costo de 1.000.000 Yang")
			say("")
			local b= select("Comprar Caballo Armado", "Cancelar")
			if 1==b then
				if pc.money >= 1000000 then
					if pc . count_item ("50051") >= 1 then
						say_title("Chico del Establo:")
						say("Felicidades  Ahora Tienes Caballo Armado")
						say("[DELAY value;340].......................[/DELAY]")
						say_item("Zanahoria", 50055, "")
						say("Obsequiare Algunos Alimnetos a Tu Caballo")
						say("Regresa cuando seas Nivel 55")
						say("Entrenare tu Caballo a Grado Militar")
						say("")
						pc.changemoney(-1000000)
						pc.removeitem("50051", 1)
						pc.give_item2("50055", 5)
						pc.give_item2("50052", 1)
						horse.set_level (11)
						set_quest_state("horse_upgrade02", "run")
						setstate(__COMPLETE__)
						q.done()
					else
						say_title("Chico del Establo:")
						say("Necesitas Simbolo de Caballo para poder")
						say("Entrenar un Caballo Armado.")
						say_item("Simbolo de Caballo", 50051, "")
						say("")
						say("Consigue Un Simbolo de Caballo")
						say("")
					end
				else
					say_title("Chico del Establo:")
					say("No tienes sufuciente Yang")
					say("")
				end
			elseif 2==b then
				say_title("Chico del Establo:")
				say("Vuelve, Cuando estes Listo.") 
				say("") 
			else
				say(string.format("Ha Ocurrido un Error", b))
			end
		end
	end
end
