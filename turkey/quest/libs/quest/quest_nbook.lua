quest quest_nbook begin
	state start begin
		function get_info(Vnum)
			info_map = {
			 [1] = { 401,"Soldados Viento Negro", 20},
			 [2] = { 402,"Maniaco Viento Negro ", 20},
			 [3] = { 404,"Jak-To Viento Negro ", 25},
			 [4] = { 405,"To-Su Viento Negro ", 35},
			 [5] = { 406,"Gu-Ryung Viento Negro ", 35},
			 [6] = { 454,"Joh-Hwan Tormenta Negra ", 35},
			 [7] = { 502,"Siervos Salvaje ", 35},
			 [8] = { 453,"Arquero Tormenta Negra ", 50},
			 [9] = { 554,"General Slv. Fuerte ", 100},
						}
			Vnum = tonumber(Vnum)
			return info_map[Vnum]
		end
		when 20355.chat."Abandonar Mision Normal" with pc.getf("quest_nbook","quest_book") == 1 begin
			say_title("Capitan:")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("Realmente quiere Abortar la Mision Normal?")
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
		when 50308.use begin
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
			local info = quest_nbook.get_info(math.random(1,9))
			local vnum = info[1]
			local name = tostring(info[2])
			local cont = info[3]
			pc.setqf("collect_target", vnum)
			pc.setqf("collect_count1", cont)
			pc.setqf("collect_count2", 0)
			pc.setqf("quest_book", 1)
			say_title("Mision Grado Normal:")
			say("Completa la mision con exito y recibiras grandes")
			say("recompenzas basadas en tu experiencia.")
			say("Elimina "..cont.." "..name.."")
			say("")
			say("Aceptas la mision de Caza de Nivel Normal?")
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
			say_title("Mision Grado Normal:")
			say("Completa la mision con exito y recibiras grandes")
			say("recompenzas basadas en tu experiencia.")
			say("Elimina "..cont.." "..name.."")
			say_reward(string.format("Has Eliminado %s "..mob_name(pc.getqf("collect_target")).."!", pc.getqf("collect_count")))
			say("")
		end
		when 20355.chat."Abandonar Mision Normal" begin
			say_title("Capitan:")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("Realmente quiere Abortar la Mision Normal?")
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
			makequestbutton("Mision Normal Completada!")
			q.set_title("Mision Normal Completada!")
			q.start()
		end
		when button or info begin
			say_title("Mision Normal Completada:")
			say("Lograste Completar la Mision con Exito!")
			say("Regresa con el Capitan!")
			say("")
		end
		when 20355.chat."Mision Normal Finalizada" begin
			say_title("Capitan:")
			say("Estupendo! Haz Completado otra Mision Normal!")
			say("En tiempos de guerra muchas misiones importantes")
			say("deben ser completadas y pocos tienen la destreza")
			say("para finalizarlas con exito!")
			say("En agradecimiento por tu ayuda en las misiones")
			say("Te entregare grandes recompenzas.")
			say("")
			pc.changegold(math.random(185,225)*10000)
			local k = number(1,8)
			local items = {
				{25041, 3},--Pierda Magica
				{39004, 3},--Bola Bendicion
				{51516, 2},--CorDraconis
				{39008, 4},--Pergamino Exorsismo
				{39030, 4},--Lectura Concentrada
				{70063, 2},--Transfor Disfraz
				{70064, 3},--Hechizar Disfraz
				{71035, 3},--Elixir Investigador
							}
			pc.give_item2(items[k][1],items[k][2])
			pc.give_exp_perc("main", 55, 15)
			pc.setqf("collect_target", 0)
			pc.setqf("collect_count1", 0)
			pc.setqf("collect_count2", 0)
			pc.setqf("quest_book", 0)
			set_state(start)
		end
	end
end