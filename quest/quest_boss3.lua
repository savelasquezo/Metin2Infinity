quest quest_boss3 begin
	state start begin
		when login or levelup with pc.level >= 50 begin
			if pc.getf("quest_boss2","quest__complete") == 1 then
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
			send_letter("Arenas Peligrosas")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Necesito que te presentes Inmediatamente")
			say("¡Tengo una tarea Urgente!")
			say("")
		end
		when __TARGET__.target.click or	20355.chat."Arenas Peligrosas" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Bienvenido "..pc.get_name()..".")
			say("El Desierto siempre fue un lugar tranquilo por el")
			say("cual los comerciantes viajaban enbtre los reinos.")
			say("en los ultimos dias las criaturas del Desierto")
			say("han estado muy hostiles y atacan a los viajeros")
			say("Tenemos que ponerles un alto Inmediatamente!")
			say("")
			say("Elimina 1300 Serpientes de las Tierras del Desierto")
			say("las demas criaturas no tendran las agallas")
			say("para volver a agredir a los humanos.")
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
			q.set_counter("Arenas Peligrosas: ", 1300 - pc.getqf("kill_count"))
		end
		when 2106.party_kill or 2107.party_kill or 2133.party_kill or 2134.party_kill or 2156.party_kill or 2157.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Arenas Peligrosas: ", 1300 - pc.getqf("kill_count"))
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
			makequestbutton("Elimina Serpientes")
			q.set_title("Elimina Serpientes")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1300 Serpientes de del Desierto")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1300 Serpientes de del Desierto")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when 2106.party_kill or 2107.party_kill or 2133.party_kill or 2134.party_kill or 2156.party_kill or 2157.party_kill
			with pc.getqf("kill_count") >= 1300 and pc.getqf("limit_time") > get_time() begin
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
		when 20355.chat."Arenas Peligrosas"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico ! Has Logrado Derrotarlos a Todos!")
			say("La Tortuga Gigante una Impoenente Criatura")
			say("Es la Causante de estas Agresiones.")
			say("Debesmos detenerla ahora que sus fuerzas estan")
			say("debilitadas, Eliminala cuanto Antes!")
			say("")
			set_state(__reward)
		end
	end
	state __reward begin
		when letter begin
			q.set_counter("Tortuga Gigante: ", 1 - pc.getqf("kill_count2"))
		end
		when 2191.party_kill begin
			pc.setqf("kill_count2", pc.getqf("kill_count2")+1)
			q.set_counter("Tortuga Gigante: ", 1 - pc.getqf("kill_count2"))
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
			makequestbutton("Elimina Tortuga Gigante")
			q.set_title("Elimina Tortuga Gigante")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina a la Tortuga Gigante")
			say("Esta criatura esta generando la agresividad")
			say("en las criaturas del Desierto.")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina a la Tortuga Gigante")
			say("Esta criatura esta generando la agresividad")
			say("en las criaturas del Desierto.")
			say("")
		end
		when 2191.party_kill
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
		when 20355.chat."Arenas Peligrosas"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico! Detuviste a las criaturas del desierto")
			say("Has demostrado tu valor y determinacion.!")
			say("Gracias a tus esfuerzos la aldea estara segura")
			say("Logicamente seras recompenzado por tus Logros")
			say("")
			say_white("~Recompenzas~")
			if pc.job == 0 then
				say_gold("Yang: 90000000")
				pc.give_exp_perc("main", 50, 30)
				pc.changegold(90000000)
			elseif pc.job == 1 then
				say_gold("Yang: 95000000")
				pc.give_exp_perc("main", 50, 70)
				pc.changegold(95000000)
			elseif pc.job == 2 then
				say_gold("Yang: 92500000")
				pc.give_exp_perc("main", 50, 35)
				pc.changegold(92500000)
			elseif pc.job == 3 then
				say_gold("Yang: 91500000")
				pc.give_exp_perc("main", 50, 90)
				pc.changegold(91500000)
			end
			say_gold("MDs: 35")
			say("")
			mysql_direct_query ( "UPDATE account.account SET coins = coins + 35 WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("Obtienes 35 Monedas Dragon." )
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
			if pc.getf("quest_boss3","quest__complete") == 1 then
				return
			end
			pc.setqf("quest__complete", 1)
		end
	end
end
