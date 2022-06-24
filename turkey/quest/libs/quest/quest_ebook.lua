quest quest_ebook begin
	state start begin
		function get_info(Vnum)
			info_map = {
			 [1] = { 3001,"Luchadores Gnoll", 30},
			 [2] = { 3005,"Generales Gnoll ", 35},
			 [3] = { 3302,"Soldados Lemur ", 30},
			 [4] = { 3305,"Generales Lemur ", 35},
			 [5] = { 3102,"Soldados Ciclope ", 30},
			 [6] = { 3105,"Generales Ciclope ", 35},
			 [7] = { 3202,"Soldado Manticora ", 30},
			 [8] = { 3205,"Generales Manticora ", 35},
			 [9] = { 3705,"Capitan Karfio ", 50},
						}
			Vnum = tonumber(Vnum)
			return info_map[Vnum]
		end
		when 20355.chat."Abandonar Mision Experto" with pc.getf("quest_ebook","quest_book") == 1 begin
			say_title("Capitan:")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("Realmente quiere Abortar la Mision Experto?")
			say("")
			local b = select ( "Abandonar" , "Cancelar" ) 
			if b == 1 then
				pc.setqf("collect_target", 0)
				pc.setqf("collect_count1", 0)
				pc.setqf("collect_count2", 0)
				pc.setqf("quest_book", 0)
				set_state(start)
			end
			if b == 2 then
				return
			end
		end
		when 50310.use begin
			if pc.getf("quest_fbook","quest_book") == 1 then
				syschat("Actualmente Tiene una Mision Facil Activa")
				return
			end
			if pc.getf("quest_nbook","quest_book") == 1 then
				syschat("Actualmente Tiene una Mision Normal Activa")
				return
			end
			if pc.getf("quest_dbook","quest_book") == 1 then
				syschat("Actualmente Tiene una Mision Dificl Activa")
				return
			end
			if pc.getf("quest_ebook","quest_book") == 1 then
				syschat("Actualmente Tiene una Mision Experto Activa")
				return
			end
			pc.setqf("quest_book", 1)
			item.remove()
			local info = quest_ebook.get_info(math.random(1,9))
			local vnum = info[1]
			local name = tostring(info[2])
			local cont = info[3]
			pc.setqf("collect_target", vnum)
			pc.setqf("collect_count1", cont)
			pc.setqf("collect_count2", 0)
			pc.setqf("quest_book", 1)
			say_title("Mision Grado Experto:")
			say("Completa la mision con exito y recibiras grandes")
			say("recompenzas basadas en tu experiencia.")
			say("Elimina "..cont.." "..name.."")
			say("")
			say("Aceptas la mision de Caza de Nivel Experto?")
			say("Sin Limite de Tiempo.")
			say("")
			local b = select ( "Aceptar" , "Rechazar" ) 
			if b == 1 then
				set_state("go_to_disciple")
				return
			end
			if b == 2 then
				pc.setqf("quest_book", 0)
				return
			end
		end
	end
	state go_to_disciple begin
		when letter begin
			q.set_counter("Objetivo: ", pc.getqf("collect_count1") - pc.getqf("collect_count2"))
		end
		when kill begin
			local s = pc.getqf("collect_target")
			if npc.get_race() == s then
				if (pc.getqf("collect_count2") + 1) == pc.getqf("collect_count1") then
					setstate(report)
					pc.setqf("collect_count2", pc.getqf("collect_count2")+1)
					q.set_counter("Objetivo: ", pc.getqf("collect_count1") - pc.getqf("collect_count2"))
				end
				pc.setqf("collect_count2", pc.getqf("collect_count2")+1)
				q.set_counter("Objetivo: ", pc.getqf("collect_count1") - pc.getqf("collect_count2"))
			end
		end
		when enter begin
			pc.setqf("collect_count2", 0)
		end
		when leave begin
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Eliminar "..mob_name(pc.getqf("collect_target")).." ")
			q.set_title("Eliminar "..mob_name(pc.getqf("collect_target")).." ")
			q.start()
		end
		when button or info begin
			say_title("Mision Grado Experto:")
			say("Completa la mision con exito y recibiras grandes")
			say("recompenzas basadas en tu experiencia.")
			say("Elimina "..cont.." "..name.."")
			say_reward(string.format("Has Eliminado %s "..mob_name(pc.getqf("collect_target")).."!", pc.getqf("collect_count")))
			say("")
		end
		when 20355.chat."Abandonar Mision Experto" begin
			say_title("Capitan:")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("Realmente quiere Abortar la Mision Experto?")
			say("")
			local b = select ( "Abandonar" , "Cancelar" ) 
			if b == 1 then
				pc.setqf("collect_target", 0)
				pc.setqf("collect_count1", 0)
				pc.setqf("collect_count2", 0)
				pc.setqf("quest_book", 0)
				set_state(start)
			end
			if b == 2 then
				return
			end
		end
	end
	state report begin
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Mision Experto Completada!")
			q.set_title("Mision Experto Completada!")
			q.start()
		end
		when button or info begin
			say_title("Mision Experto Completada:")
			say("Lograste Completar la Mision con Exito!")
			say("Regresa con el Capitan!")
			say("")
		end
		when 20355.chat."Mision Experto Finalizada" begin
			say_title("Capitan:")
			say("Estupendo! Haz Completado otra Mision Experto!")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("En agradecimiento por tu ayuda en las misiones")
			say("Te entregare grandes recompenzas.")
			say("")
			pc.changegold(math.random(700,900)*10000)
			local k = number(1,8)
			local items = {
				{25041, 5},--Piedra Magica
				{39004, 10},--Bola Bendicion
				{51555, 2},--CorDraconis++
				{39008, 6},--Pergamino Exorsismo
				{39030, 6},--Lectura Concentrada
				{70063, 3},--Transfor Disfraz
				{70064, 7},--Hechizar Disfraz
				{71035, 7},--Elixir Investigador
							}
			pc.give_item2(items[k][1],items[k][2])
			pc.give_exp_perc("main", 90, 15)
			pc.setqf("collect_target", 0)
			pc.setqf("collect_count1", 0)
			pc.setqf("collect_count2", 0)
			pc.setqf("quest_book", 0)
			set_state(start)
		end
	end
end