quest collect_quest_lv85  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 85 begin
			set_state(information)
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20084)
			if v != 0 then
				target.vid("__TARGET__", v, "Biologo Chaegirab")
			end
			send_letter("Investigacion del Biologo")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20084)))
			say("")
			say("El Biologo Chaegirab, el aprendiz de Uriel, te esta")
			say("buscando ve rapido y preguntale que necestia.")
			say("")
		end
		when __TARGET__.target.click or	20084.chat."Investigacion" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Necesito Ayuda!")
			say("La investigacion necesita informacion sobre")
			say("todas las criaturas que viven en el continente")
			say("Es una tarea que no puedo completar solo.")
			say("Con tu ayuda seguro que podre resolverlo...")
			say("Te pagare por ello.")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Acabo de examinar los Arboles del Bosque Rojo.")
			say("Este fue originalmente un bosque tranquilo con")
			say("enormes Arboles, el cual se a contaminado con")
			say("energia maligna por los metines, pues los arboles")
			say("se vuelven entidades crueles e indolientes")
			say("por tal razon quiero investigar sus ramas, tienen")
			say("un color muy distintivo, lo notaras al instante!!")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¿Podrias conseguirme Rama arbol rojo fantasma ?")
			say_item_vnum(30167)
			say("Traeme Ramas Rojas, aunque que las pruebas")
			say("son algo complicadas, y soy un excelente Biologo")
			say("¡Buena Suerte!")
			say("")
			set_state(go_to_disciple)
			pc.setqf("duration",0) 
			pc.setqf("collect_count",0)
			pc.setqf("drink_drug",0)
		end
	end
	state go_to_disciple begin
		when letter begin
			send_letter("La investigacion del Biologo")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Investigacion~")
			say("")
			say("El Biologo Chaegirab, el aprendiz de Uriel")
			say("necesita 40 Rama de arbol rojo fantasma del Bosque rojo")
			say("para sus investigaciones.")
			say_item_vnum(30167)
			say("Puedes conseguir Ramas Rojas Eliminando")
			say("Tocon Fantasma Rojo y Suauce Fantasma Rojo.")
			say_reward(string.format("Hasta Ahora has entregado %s[ENTER]Rama de Arbol Rojo Fantasma. ", pc.getqf("collect_count")))
			say("")
		end
		when 71035.use begin
			if pc.getqf("drink_drug")== 1 then
				syschat("<Investigacion> El Efecto ya esta en Uso!")
				return
			end
			pc.remove_item(71035, 1)
			pc.setqf("drink_drug",1)
		end
		when 2312.kill or 2314.kill begin 
			local s = number(1, 55)
			if s == 1 then
				pc.give_item2(30167, 1)
				syschat("Has Encontrado una Rama de Arbol Rojo Fantasma! ")
			end
		end
		when 20084.take with item.get_vnum() == 30226 begin--DEBUG
			if pc.count_item(30226) == 200 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if select("Restablecer Mision","Cancelar") == 1 then
					affect.add_collect_point(POINT_RESIST_WARRIOR,10,60*60*24*365*60)
					affect.add_collect_point(POINT_RESIST_ASSASSIN,10,60*60*24*365*60)
					affect.add_collect_point(POINT_RESIST_SURA,10,60*60*24*365*60)
					affect.add_collect_point(POINT_RESIST_SHAMAN,10,60*60*24*365*60)
					pc.give_item2(50115)
					clear_letter()
					set_quest_state("collect_quest_lv90", "run")
					set_state(__complete)
					return
				end
			end
		end
		when 20084.chat."Rama de Arbol Rojo" with pc.count_item(30167) >0 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if get_time() > pc.getqf("duration") or pc.getqf("drink_drug")!=0 then
				if pc.count_item(30167) > 0 then 
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("Oh, Has conseguido una Rama de Arbol Rojo!")
					say("Dame un momento para Analizarlo ... ")
					pc.remove_item("30167", 1)
					pc.setqf("duration",get_time()+ 3)
					say("")
					wait()
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					local pass_percent
					if pc.getqf("drink_drug")==0 then
						pass_percent=60
					else
						pass_percent=100
					end
					local s= number(1,100)
					if s <= pass_percent  then
						if pc.getqf("collect_count") < 39 then
							local index =pc.getqf("collect_count")+1
							pc.setqf("collect_count",index)
							say(string.format("Oh! Esta Rama de Arbol Rojo es de buena calidad!.[ENTER]Sin embargo, todavia necesito %s mas. ",40-pc.getqf("collect_count")))
							say("")
							pc.setqf("drink_drug",0)
							return
						end
						say("Has conseguido los 40 Ramas de arbol rojo fantasma!")
						say("Gracias. Pero, todavia necesito una piedra especial.")
						say("La llaman Piedra Espiritu Bosque.")
						say_item_vnum(30226)
						say("Seria fantastico si puedieras conseguirla tambien.")
						say("La conseguiras Eliminando las criaturas del Bosque rojo.")
						say("")
						pc.setqf("collect_count",0)
						pc.setqf("drink_drug",0)
						pc.setqf("duration",0)
						set_state(key_item)
						return
					else
						say("Hm, esta Rama Roja esta raquitica.")
						say("No creo que pueda usarlo para mis estudios...")
						say("Por favor, traeme otro!")
						say("")
						pc.setqf("drink_drug",0)
						return
					end
				else
					say("Por favor, vuelve cuando hayas encontrado alguno.")
					say(string.format("Todavia necesito %s Ramas Rojas", 40-pc.getqf("collect_count")))
					say("")
					return
				end
			else
				say("Lo siento mucho, pero todavia no he terminado") 
				say("El analisis de la ultima muestra.")
				say("")
				return
			end
		end
	end
	state key_item begin
		when letter begin
			send_letter("La invetigacion del Biologo ")
			if pc.count_item(30226) > 0 then
				local v = find_npc_by_vnum(20084)
				if v != 0 then
					target.vid("__TARGET__", v, "Biologo Chaegirab")
				end
			end
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20084)))
			say("")
			if pc.count_item(30226) >0 then
				say_reward("Has encontrado la Piedra Espiritu Bosque!")
				say("")
				return
			end
			say("Para la investigacion del Biologo Chaegirab.")
			say("Se han recogido 40 Ramas Rojas Fantasma")
			say("Ahora para completar la investigacion necesitas")
			say("una Piedra Espiritu Bosque. ")
			say_item_vnum(30226)
			say("Podras conseguirla en el Bosque Rojo.")
			say("")
		end
		when 2312.kill or 2314.kill begin 
			local s = number(1,50)
			if s == 1 and pc.count_item(30226)==0 then
				pc.give_item2(30226, 1)
				send_letter("Tienes la Piedra Espiritu Bosque")
			end
		end
		when __TARGET__.target.click or 20084.chat."Piedra Espiritu Bosque" with pc.count_item(30226) > 0 begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.count_item(30226) > 0 then 
				say("Guao! Muchas gracias! Para recompensarte, te dare")
				say("esta receta, su composicion es especial.")
				say("La pocion se puede hacer utilizando la formula")
				say("Ve y busca de Baek-go, el hara la pocion para Ti.")
				say("")
				pc.remove_item(30226,1)
				set_state(__reward)
			else
				say("Por favor, vuelve cuando hayas encontrado")
				say("la Piedra Espiritu Bosque.")
				say("")
				return
			end
		end
	end
	state __reward begin
		when letter begin
			send_letter("Recompensa del Biologo")
			local v = find_npc_by_vnum(20018)
			if v != 0 then
				target.vid("__TARGET__", v, "Recompensa del Biologo")
			end
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20018)))
			say("")
			say("La recompensa por las Ramas y la Piedra Espiritu Bosque")
			say("el Biologo Chaerigab te ha dejado la formula")
			say("de una receta secreta. Ahora ve a Baek-Go")
			say("el creara la pocion para ti.")
		    say("")
		end
		when __TARGET__.target.click or 20018.chat."Receta Secreta" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Mira eso!")
			say("Es una receta secreta del Biologo Chaegirab?")
			say("Aumentara tu Defensa contra Razas en 10 Pts.")
			say("Tambien, te doy esta Caja del Bosque")
			say("Contiene objetos muy valiosos! No la pierdas!")
			say_reward("Defensa contra Razas Aumentada 10 Puntos")
			say("")
			affect.add_collect_point(POINT_RESIST_WARRIOR,10,60*60*24*365*60)
			affect.add_collect_point(POINT_RESIST_ASSASSIN,10,60*60*24*365*60)
			affect.add_collect_point(POINT_RESIST_SURA,10,60*60*24*365*60)
			affect.add_collect_point(POINT_RESIST_SHAMAN,10,60*60*24*365*60)
			pc.give_item2(50115)
			clear_letter()
			set_quest_state("collect_quest_lv90", "run")
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
