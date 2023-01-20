quest quest_boss6 begin
	state start begin
		when login or levelup with pc.level >= 65 begin
			if pc.getf("quest_boss5","quest__complete") == 1 then
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
			send_letter("Fuego Purgador")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Necesito que te presentes Inmediatamente")
			say("¡Tengo una tarea Urgente!")
			say("")
		end
		when __TARGET__.target.click or	20355.chat."Fuego Purgador" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Bienvenido "..pc.get_name()..".")
			say("Doyyumhwan representa una Zona minera muy importante")
			say("para la elaboracion de armas del nuestro reino.")
			say("Ultimamente las criaturas que han poblado desde")
			say("tiempos ancestrales estas tierras han prohibido")
			say("el ingreso de nuestros aldeanos!")
			say("")
			say("Elimina 1750 Criaturas de Fuego de Doyyumhwan")
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
			q.set_counter("Fuego Purgador: ", 1750 - pc.getqf("kill_count"))
		end
		when 2205.party_kill or 2204.party_kill or 2203.party_kill or 2202.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Fuego Purgador: ", 1750 - pc.getqf("kill_count"))
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
			makequestbutton("Elimina Moobs Llama")
			q.set_title("Elimina Moobs Llama")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1750 Criaturas de Fuego")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1750 Criaturas de Fuego")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when 2205.party_kill or 2204.party_kill or 2203.party_kill or 2202.party_kill
			with pc.getqf("kill_count") >= 1750 and pc.getqf("limit_time") > get_time() begin
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
		when 20355.chat."Fuego Purgador"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico ! Has Logrado Derrotarlos a Todos!")
			say("El Rey LLama se revelado en venganza, se ha")
			say("propuesto a eliminar a todos los seres vivios.")
			say("Debesmos detenerla inmediatamente antes de que")
			say("mas vidas se pierdan!")
			say("")
			set_state(__reward)
		end
	end
	state __reward begin
		when letter begin
			q.set_counter("Rey Llama: ", 1 - pc.getqf("kill_count2"))
		end
		when 2206.party_kill begin
			pc.setqf("kill_count2", pc.getqf("kill_count2")+1)
			q.set_counter("Rey Llama: ", 1 - pc.getqf("kill_count2"))
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
			makequestbutton("Elimina Rey Llama")
			q.set_title("Elimina Rey Llama")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Rey Llama")
			say("Deten la Furia del Comandante Llama")
			say("En el Volcan Doyyumhwan.")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Rey Llama")
			say("Deten la Furia del Comandante Llama")
			say("En el Volcan Doyyumhwan.")
			say("")
		end
		when 2206.party_kill
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
		when 20355.chat."Fuego Purgador"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico! Detuviste a las criaturas de Fuego")
			say("Has demostrado tu valor y determinacion.!")
			say("Gracias a tus esfuerzos la aldea estara segura")
			say("Logicamente seras recompenzado por tus Logros")
			say("")
			say_white("~Recompenzas~")
			if pc.job == 0 then
				say_gold("Yang: 300000000")
				pc.give_exp_perc("main", 65, 30)
				pc.changegold(300000000)
			elseif pc.job == 1 then
				say_gold("Yang: 350000000")
				pc.give_exp_perc("main", 65, 70)
				pc.changegold(350000000)
			elseif pc.job == 2 then
				say_gold("Yang: 325000000")
				pc.give_exp_perc("main", 65, 35)
				pc.changegold(325000000)
			elseif pc.job == 3 then
				say_gold("Yang: 315000000")
				pc.give_exp_perc("main", 65, 90)
				pc.changegold(315000000)
			end
			say_gold("MDs: 75")
			say("")
			mysql_direct_query ( "UPDATE account.account SET coins = coins + 75 WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("Obtienes 75 Monedas Dragon." )
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
			if pc.getf("quest_boss6","quest__complete") == 1 then
				return
			end
			pc.setqf("quest__complete", 1)
		end
	end
end
