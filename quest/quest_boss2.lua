quest quest_boss2 begin
	state start begin
		when login or levelup with pc.level >= 40 begin
			if pc.getf("quest_boss1","quest__complete") == 1 then
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
			send_letter("Furia de Orcos")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Necesito que te presentes Inmediatamente")
			say("¡Tengo una tarea Urgente!")
			say("")
		end
		when __TARGET__.target.click or	20355.chat."Furia de Orcos" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Bienvenido "..pc.get_name()..".")
			say("El Clan Orco, Han estado mas hostiles de los Normal")
			say("Recientemente se han reportado muchos casos.")
			say("de ataques de Orcos a Humanos viajeros que cruzan")
			say("el Valle del Dragon, como comandante de las fuerzas")
			say("Armadas, no permitire este tipo de comportamiento.")
			say("")
			say("Elimina 1150 Integrantes de la Raza de Orcos")
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
			q.set_counter("Furia de Orcos: ", 1150 - pc.getqf("kill_count"))
		end
		when 601.party_kill or 602.party_kill or 603.party_kill or 604.party_kill or 631.party_kill or 632.party_kill or
			 633.party_kill or 634.party_kill or 635.party_kill or 636.party_kill or 637.party_kill or 651.party_kill or
			 652.party_kill or 653.party_kill or 654.party_kill or 655.party_kill or 656.party_kill or 657.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Furia de Orcos: ", 1150 - pc.getqf("kill_count"))
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
			makequestbutton("Elimina Orcos")
			q.set_title("Elimina Orcos")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1150 Integrantes de la Raza de Orcos")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1150 Integrantes de la Raza de Orcos")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when 601.party_kill or 602.party_kill or 603.party_kill or 604.party_kill or 631.party_kill or 632.party_kill or
			 633.party_kill or 634.party_kill or 635.party_kill or 636.party_kill or 637.party_kill or 651.party_kill or
			 652.party_kill or 653.party_kill or 654.party_kill or 655.party_kill or 656.party_kill or 657.party_kill 
			with pc.getqf("kill_count") >= 1150 and pc.getqf("limit_time") > get_time() begin
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
		when 20355.chat."Furia de Orcos"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico ! Has Logrado Derrotarlos a Todos!")
			say("El Jefe Orco Lider de las Fuerzas Orcos")
			say("Ha Jurado Venganza contra nuestro reino.")
			say("Debesmos detenerlo ahora que sus fuerzas estan")
			say("debilitadas, Eliminalo cuanto Antes!")
			say("")
			set_state(__reward)
		end
	end
	state __reward begin
		when letter begin
			q.set_counter("Jefe Orco: ", 1 - pc.getqf("kill_count2"))
		end
		when 691.party_kill begin
			pc.setqf("kill_count2", pc.getqf("kill_count2")+1)
			q.set_counter("Jefe Orco: ", 1 - pc.getqf("kill_count2"))
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
			makequestbutton("Elimina Jefe Orco")
			q.set_title("Elimina Jefe Orco")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Jefe Orco")
			say("Detiene la Revelion de la Raza de Orcos")
			say("Antes de darles la oportunidad de atacar.")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Jefe Orco")
			say("Detiene la Revelion de la Raza de Orcos")
			say("Antes de darles la oportunidad de atacar.")
			say("")
		end
		when 691.party_kill
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
			say_reward("Has Logrado Terminar con la Revelion!")
			say_reward("Regresa Inmediatamente!")
			say("")
		end
		when 20355.chat."Furia de Orcos"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico! Detuviste a la Raza de los Orcos")
			say("Has demostrado tu valor y determinacion.!")
			say("Gracias a tus esfuerzos la aldea estara segura")
			say("Logicamente seras recompenzado por tus Logros")
			say("")
			say_white("~Recompenzas~")
			if pc.job == 0 then
				say_gold("Yang: 50000000")
				pc.give_exp_perc("main", 40, 30)
				pc.changegold(50000000)
			elseif pc.job == 1 then
				say_gold("Yang: 55000000")
				pc.give_exp_perc("main", 40, 70)
				pc.changegold(55000000)
			elseif pc.job == 2 then
				say_gold("Yang: 52500000")
				pc.give_exp_perc("main", 40, 35)
				pc.changegold(52500000)
			elseif pc.job == 3 then
				say_gold("Yang: 51500000")
				pc.give_exp_perc("main", 40, 90)
				pc.changegold(51500000)
			end
			say_gold("MDs: 25")
			say("")
			mysql_direct_query ( "UPDATE account.account SET coins = coins + 25 WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("Obtienes 25 Monedas Dragon." )
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
			if pc.getf("quest_boss2","quest__complete") == 1 then
				return
			end
			pc.setqf("quest__complete", 1)
		end
	end
end
