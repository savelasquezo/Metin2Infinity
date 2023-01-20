quest quest_boss1 begin
	state start begin
		when login or levelup with pc.level >= 30 begin
			set_state(information)
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20355)
			if v != 0 then
				target.vid("__TARGET__", v, "Capitan")
			end
			send_letter("Tormenta Bestial")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Necesito que te presentes Inmediatamente")
			say("¡Tengo una tarea Urgente!")
			say("")
		end
		when __TARGET__.target.click or	20355.chat."Tormenta Bestial" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Bienvenido "..pc.get_name()..".")
			say("El Clan Bestial, fuerzas de los Tormenta Negra")
			say("ha estado asaltando a los viajeros del reino.")
			say("No podemos permitir que sigan haciendo esta")
			say("barbarie debes detenerle ahora mismo.")
			say("")
			say("Elimina 1.000 Integrantes del Clan Tormenta Negra")
			say("los demas subordinados no tendran las agallas")
			say("para revelarse contra nuestro Imperio.")
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
			q.set_counter("Tormenta Negra: ", 1000 - pc.getqf("kill_count"))
		end
		when 401.party_kill or 402.party_kill or 403.party_kill or 404.party_kill or 405.party_kill or 406.party_kill or
			 431.party_kill or 432.party_kill or 433.party_kill or 434.party_kill or 435.party_kill or 436.party_kill or
			 451.party_kill or 452.party_kill or 453.party_kill or 454.party_kill or 455.party_kill or 456.party_kill begin
			pc.setqf("kill_count", pc.getqf("kill_count")+1)
			q.set_counter("Tormenta Negra: ", 1000 - pc.getqf("kill_count"))
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
			makequestbutton("Elimina Tormenta Negra")
			q.set_title("Elimina Tormenta Negra")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1.000 Integrantes del Clan Tormenta Negra")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina 1.000 Integrantes del Clan Tormenta Negra")
			say("Tienes 3 Hora para Completar la Mision")
			say("")
		end
		when 401.party_kill or 402.party_kill or 403.party_kill or 404.party_kill or 405.party_kill or 406.party_kill or
			 431.party_kill or 432.party_kill or 433.party_kill or 434.party_kill or 435.party_kill or 436.party_kill or
			 451.party_kill or 452.party_kill or 453.party_kill or 454.party_kill or 455.party_kill or 456.party_kill
			with pc.getqf("kill_count") >= 1000 and pc.getqf("limit_time") > get_time() begin
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
		when 20355.chat."Tormenta Bestial"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico ! Has Logrado Derrotarlos a Todos!")
			say("El Capitan Bestial del Clan Tormenta Negra")
			say("Ha Jurado Venganza contra nuestro reino.")
			say("Debesmos detenerlo ahora que sus fuerzas estan")
			say("debilitadas, Eliminalo cuanto Antes!")
			say("")
			set_state(__reward)
		end
	end
	state __reward begin
		when letter begin
			q.set_counter("Capitan Bestial: ", 1 - pc.getqf("kill_count2"))
		end
		when 591.party_kill begin
			pc.setqf("kill_count2", pc.getqf("kill_count2")+1)
			q.set_counter("Capitan Bestial: ", 1 - pc.getqf("kill_count2"))
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
			makequestbutton("Elimina Capitan Bestial")
			q.set_title("Elimina Capitan Bestial")
			q.start()
		end
		when button begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Capitan Bestial")
			say("Detiene la Revelion del Clan Tormenta Negra")
			say("Antes de darles la oportunidad de atacar.")
			say("")
		end
		when info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20355)))
			say("")
			say("Elimina al Capitan Bestial")
			say("Detiene la Revelion del Clan Tormenta Negra")
			say("Antes de darles la oportunidad de atacar.")
			say("")
		end
		when 591.party_kill
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
		when 20355.chat."Tormenta Bestial"  begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Fantastico! Detuviste al Clan Tormenta Negra")
			say("Has demostrado tu valor y determinacion.!")
			say("Gracias a tus esfuerzos la aldea estara segura")
			say("Logicamente seras recompenzado por tus Logros")
			say("")
			say_white("~Recompenzas~")
			if pc.job == 0 then
				say_gold("Yang: 3000000")
				pc.give_exp_perc("main", 30, 30)
				pc.changegold(3000000)
			elseif pc.job == 1 then
				say_gold("Yang: 3500000")
				pc.give_exp_perc("main", 30, 70)
				pc.changegold(3500000)
			elseif pc.job == 2 then
				say_gold("Yang: 3250000")
				pc.give_exp_perc("main", 30, 35)
				pc.changegold(3250000)
			elseif pc.job == 3 then
				say_gold("Yang: 3150000")
				pc.give_exp_perc("main", 30, 90)
				pc.changegold(3150000)
			end
			say_gold("MDs: 15")
			say("")
			mysql_direct_query ( "UPDATE account.account SET coins = coins + 15 WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("Obtienes 15 Monedas Dragon." )
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
			if pc.getf("quest_boss1","quest__complete") == 1 then
				return
			end
			pc.setqf("quest__complete", 1)
		end
	end
end
