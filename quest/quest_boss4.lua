quest quest_boss4 begin
	state start begin
		when login or levelup with pc.level >= 65 begin
			if pc.getf("quest_boss3","quest__complete") == 1 then
				set_state(information)
				return
			end
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20355)
			if v != 0 then
				target.vid("__TARGET__", v, "Capitan")
			end
			send_letter("Invierno Eterno")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Necesito que te presentes Inmediatamente")
			say("¡Tengo una tarea Urgente!")
			say("")
		end
		when __TARGET__.target.click or	20355.chat."Invierno Eterno" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Bienvenido "..pc.get_name()..".")
			say("Tierras Sohan es de vital importancia para el reino")
			say("es una ruta de suministros vital.")
			say("Ultimamente han aparecido unas criaturas demoniacas")
			say("es como si el mismo invierno les diera vida.")
			say("tenemos que controlar esta Nueva Raza!")
			say("")
			say("Elimina 1450 Criaturas del Frio de Tierras Sohan")
			say("es imperativo que estas criaturas no dominen")
			say("estas tierras, espero puedes realizarlo!")
			say("")
			say_white("~Consejo~")
			say_gold("Recuerda que puedes reclutar un Equipo")
			say_gold("Objetivos Eliminados en grupo tambien Cuentan")
			say_green("¡Unicamente al Lider del Grupo!")
			say("")
			set_state(go_to_disciple)
			pc.setqf("kill_count",0)
		end
	end
	state go_to_disciple begin
		when letter begin
			q.set_counter("Invierno Eterno: ", 1450 - pc.getqf("kill_count"))
		end
		when 1101.party_kill or 1104.party_kill or 1107.party_kill or 1133.party_kill or 1136.party_kill or 1155.party_kill or 1171.party_kill or 1174.party_kill or
			 1152.party_kill or 1102.party_kill or 1105.party_kill or 1131.party_kill or 1134.party_kill or 1137.party_kill or 1156.party_kill or 1172.party_kill or
			 1175.party_kill or 1153.party_kill or 1103.party_kill or 1106.party_kill or 1132.party_kill or 1135.party_kill or 1151.party_kill or 1157.party_kill or
			 1173.party_kill or 1176.party_kill or 1177.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Invierno Eterno: ", 1450 - pc.getqf("kill_count"))
			if get_time()>=pc.getqf("limit_time") then
				setstate(failure)
			end
		end
		when letter begin
			q.set_clock("Tiempo Limite:", pc.getqf("limit_time")-get_time())
		end
		when enter begin
			pc.setqf("limit_time", get_time()+60*60*3)
			pc.setqf("kill_count", 0)
		end
		when leave begin
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Elimina Moobs Helados")
			q.set_title("Elimina Moobs Helados")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1450 Criaturas del Frio")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1450 Criaturas del Frio")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when 1101.party_kill or 1104.party_kill or 1107.party_kill or 1133.party_kill or 1136.party_kill or 1155.party_kill or 1171.party_kill or 1174.party_kill or
			 1152.party_kill or 1102.party_kill or 1105.party_kill or 1131.party_kill or 1134.party_kill or 1137.party_kill or 1156.party_kill or 1172.party_kill or
			 1175.party_kill or 1153.party_kill or 1103.party_kill or 1106.party_kill or 1132.party_kill or 1135.party_kill or 1151.party_kill or 1157.party_kill or
			 1173.party_kill or 1176.party_kill or 1177.party_kill with pc.getqf("kill_count") >= 1450 and pc.getqf("limit_time") > get_time() begin
			setstate(report1)
		end
	end
	state report1 begin
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Vuelve con el Capitan!")
			q.set_title("Vuelve con el Capitan!")
			q.start()
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say_reward("Has Logrado Derrotarlos a Todos!")
			say_reward("Regresa Inmediatamente!")
			say("")
		end
		when 20355.chat."Invierno Eterno"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico ! Has Logrado Derrotarlos a Todos!")
			say("El Zorro de Nueve Colas es la criatura mas")
			say("poderosa en todo Sohan.")
			say("Debesmos eliminarlo cuanto antres, sin un lider")
			say("las otras criaturas se calmaran!")
			say("")
			set_state(__reward)
		end
	end
	state __reward begin
		when letter begin
			q.set_counter("Nueve Colas: ", 1 - pc.getqf("kill_count2"))
		end
		when 1901.party_kill begin
			pc.setqf("kill_count2", pc.getqf("kill_count2")+1)
			q.set_counter("Nueve Colas: ", 1 - pc.getqf("kill_count2"))
			if get_time()>=pc.getqf("limit_time2") then
				setstate(failure)
			end
		end
		when letter begin
			q.set_clock("Tiempo Limite:", pc.getqf("limit_time2")-get_time())
		end
		when enter begin
			pc.setqf("limit_time2", get_time()+60*60*1)
			pc.setqf("kill_count2", 0)
		end
		when leave begin
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Elimina Nueve Colas")
			q.set_title("Elimina Nueve Colas")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Nueve Colas")
			say("El lider de las criaturas del Frio")
			say("sin su lider todo se calmara.")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Nueve Colas")
			say("El lider de las criaturas del Frio")
			say("sin su lider todo se calmara.")
			say("")
		end
		when 1901.party_kill
			with pc.getqf("kill_count2") >= 1 and pc.getqf("limit_time2") > get_time() begin
			setstate(report2)
		end
	end
	state report2 begin
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Vuelve con el Capitan!")
			q.set_title("Vuelve con el Capitan!")
			q.start()
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say_reward("Has Logrado Terminar con el Problema!")
			say_reward("Regresa Inmediatamente!")
			say("")
		end
		when 20355.chat."Invierno Eterno"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico! Detuviste a las criaturas del Frio")
			say("Has demostrado tu valor y determinacion.!")
			say("Gracias a tus esfuerzos la aldea estara segura")
			say("Logicamente seras recompenzado por tus Logros")
			say("")
			say_white("~Recompenzas~")
			if pc.job == 0 then
				say_gold("Yang: 120000000")
				pc.give_exp_perc("main", 65, 30)
				pc.changegold(120000000)
			elseif pc.job == 1 then
				say_gold("Yang: 150000000")
				pc.give_exp_perc("main", 65, 70)
				pc.changegold(150000000)
			elseif pc.job == 2 then
				say_gold("Yang: 145000000")
				pc.give_exp_perc("main", 65, 35)
				pc.changegold(145000000)
			elseif pc.job == 3 then
				say_gold("Yang: 135000000")
				pc.give_exp_perc("main", 65, 90)
				pc.changegold(135000000)
			end
			say_gold("MDs: 45")
			say("")
			mysql_direct_query ( "UPDATE account.account SET coins = coins + 45 WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("Obtienes 45 Monedas Dragon." )
			set_state(__complete)
		end
	end
	state failure begin
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("!Mision Fallida!")
			q.set_title("!Mision Fallida!")
			q.start()
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("!Mision Fallida!")
			say("")
			say_reward("Fallaste al Completar la Mision")
			say_reward("Regresa y Habla con el Capitan!")
			setstate(information)
			q.done()
		end
	end
	state __complete begin
		when login begin
			if pc.getf("quest_boss4","quest__complete") == 1 then
				return
			end
			pc.setqf("quest__complete", 1)
		end
	end
end
