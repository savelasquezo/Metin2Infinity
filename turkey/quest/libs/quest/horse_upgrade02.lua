quest horse_upgrade02 begin
	state start begin
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
				setstate(__COMPLETE__)
			else
				set_state(information)
			end
		end
	end
	state information begin
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
				setstate(__COMPLETE__)
			end
		end
		when 20349.chat."Caballo Militar" with pc.level >= 45 begin
			say_title("Chico del Establo:")
			if horse.is_dead() then
				say("El Caballo ha muerto, primero deberas revivirlo")
				say("Usando una Hierva de Monos.")
				say_item("Hierva de Monos normal", 50058, "")
				say("")
				say("Consigue la Hierva de Monos normal")
				say("Encuenntrala en la Mazmorra de Monos normal.")
				say("")
			elseif pc.level < 45 then
				say("Eres demasiado Joven para estar listo para montar")
				say("Un Caballo Militar.")
				say("")
				say("Regresa cuando seas al menos Nivel 45.")
				say("")
			elseif pc . count_item ("50050") < 10 then
				say("Necesitas 10 Medallas de Caballo para poder")
				say("Entrenar un Caballo Militar.")
				say_item("Medalla de Caballo", 50050, "")
				say("")
				say("Consigue las Medallas de Caballo")
				say("Encuenntrala en la Mazmorra de Monos.")
				say("")
			elseif pc . count_item ("50052") < 1 then
				say("Necesitas Libro Caballo Armado para poder")
				say("Entrenar un Caballo Militar.")
				say_item("Libro Caballo Armado", 50052, "")
				say("")
				say("Consigue Un Libro Caballo Armado")
				say("")
			elseif horse.get_level()== 20 and not horse.is_dead() and pc . count_item ("50050") >= 10 and pc.level >= 45 then
				say("El Entrenamiento del Caballo Militar Requiere")
				say("Al menos 10 Medallas de Caballo.")
				say_item("Medallas de Caballo", 50050, "")
				say("")
				say("En Caso de Fallar Perderas Todas las Medallas")
				say("Recomendable hacer la mision en grupo.")
				say("")
				local b= select("Entrenar Caballo Militar", "Cancelar")
				if 1==b then
					if pc . count_item ("50050")>= 10 then
						pc.removeitem("50050", 10)
						send_letter("Entrenamiento Militar")
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
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
				setstate(__COMPLETE__)
			end
		end
		when letter begin
			q.set_counter("Guerrero Llama: ", 300 - pc.getqf("kill_count"))
		end
		when 2205.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Guerrero Llama: ", 300 - pc.getqf("kill_count"))
			if get_time()>=pc.getqf("limit_time") then
				setstate(failure)
			end
		end
		when letter begin
			q.set_clock("Tiempo Restante", pc.getqf("limit_time")-get_time())
		end
		when enter begin
			pc.setqf("limit_time", get_time()+60*60)
			pc.setqf("kill_count", 0)
		end
		when leave begin
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Entrenamiento Militar")
			q.set_title("Entrenamiento Militar")
			q.start()
		end
		when button or info begin
			say_title("Entrenamiento Militar")
			say("Elimina 300 Guerreros Llama Solo tienes")
			say("60 Minutos para Completar el Entrenamiento.")
			say("")
			say("La Mision la Puedes Completar en Grupo")
			say("Aunque tu deberas ser quien Lidere.")
			say("")
		end
		when 2205.party_kill with pc.getqf("kill_count") >= 300 and pc.getqf("limit_time")>=get_time() begin
			setstate(report)
		end
		when 20349.chat."Entrenamiento Militar" begin
			say_title("Chico del Establo:")
			say("Elimina 300 Guerreros Llama. Solo tienes")
			say("60 Minutos para Completar el Entrenamiento.")
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
					say("El Entrenamiento Militar ha sido Cancelado")
					say("Ahora deberas Descansar.")
					say("")
					setstate(information)
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
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
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
			say_title("Entrenamiento Militar")
			say_reward("Lograste Completar el Entrenamiento")
			say_reward("Regresa y Reporta los Resultados")
		end
		when 20349.chat."-Reporte- Entrenamiento Militar" begin
			say_title("Chico del Establo:")
			say("Sorprendente  Has Compeltado la Prueba")
			say("La Elaboracion del Libro Militar")
			say("Costara 1.000.000 Yang")
			say_item("Libro Caballo Militar", 50053, "")
			say("")
			setstate(buy)
		end
	end
	state failure begin
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
				setstate(__COMPLETE__)
			end
		end
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
			setstate(information)
			q.done()
		end
	end
	state __COMPLETE__ begin
	end
	state buy begin
		when login or levelup with pc.level >= 45 begin
			if horse.get_grade() > 2 then
				setstate(__COMPLETE__)
			end
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Caballo Militar Finalizado")
			q.set_title("Caballo Militar Finalizado")
			q.start()
		end
		when button or info begin
			say_title("Caballo Militar")
			say("El Tiempo de espera ha Finalizado")
			say("Ve donde el Chico del Establo.")
			say("")
			say("El Libro tendra un Costo de 1.000.000 Yang")
			say("")
		end
		when 20349.chat."Entrenamiento Caballo Militar" begin
			say_title("Chico del Establo:")
			say("Finalizado  El Libro Militar esta Fializado")
			say("[DELAY value;340].......................[/DELAY]")
			say("Gracias a este Libro podras Invocar")
			say("Directamente desde el Establo al Caballo Militar")
			say_item("Libro Caballo Militar", 50053, "")
			say("")
			say("El Libro Tendra un Costo de 1.000.000 Yang")
			say("")
			local b= select("Comprar Caballo Militar", "Cancelar")
			if 1==b then
				if pc.money >= 1000000 then
					if pc . count_item ("50052") >= 1 then
						say_title("Chico del Establo:")
						say("Felicidades  Ahora Tienes Caballo Militar")
						say("[DELAY value;340].......................[/DELAY]")
						say_item("Ginseng Rojo", 50056, "")
						say("Obsequiare Algunos Alimnetos a Tu Caballo")
						say("Haz Alcanzado el Grado Maximo en Monta")
						say("Nuevas Habilidades Desbloqueadas.")
						say("")
						pc.changemoney(-1000000)
						pc.removeitem("50052", 1)
						pc.give_item2("50056", 30)
						pc.give_item2("50053", 1)
						horse.set_level (30)
						setstate(__COMPLETE__)
						q.done()
					else
						say_title("Chico del Establo:")
						say("Necesitas Libro Caballo Militar para poder")
						say("Entrenar un Caballo Militar.")
						say_item("Libro Caballo Militar", 50052, "")
						say("")
						say("Consigue Un Libro Caballo Militar")
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
