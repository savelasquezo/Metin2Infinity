quest collect_quest_lv60  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 60 begin
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
			say("Acabo de examinar los Golems de hielo de Sohan.")
			say("Son seres misticos muy interezantes para mi.")
			say("desde hace mucho tiempo estoy investigandolos")
			say("pero son muy fuertes y con sus cuerpos helados")
			say("son totalmente inmunes al dolor, quiero que me")
			say("traigas una parte de ellos para investigar de")
			say("donde viene su increible resistencia.")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¿Podrias conseguirme Fragmento Glaciar?")
			say_item_vnum(30146)
			say("Traeme Fragmentos Glaciar, aunque que las pruebas")
			say("son algo complicadas yo soy un Excelente Biologo")
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
			say("necesita 20 Fragmento Glaciar en Sohan")
			say("para sus investigaciones.")
			say_item_vnum(30146)
			say("Puedes conseguir Fragmentos Glaciar Eliminando")
			say("Golem de Hielo y Yeti.")
			say_reward(string.format("Hasta Ahora has entregado %s[ENTER]Fragmentos Glaciar. ", pc.getqf("collect_count")))
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
		when 1107.kill or 1106.kill begin
			local s = number(1, 55)
			if s == 1 then
				pc.give_item2(30146, 1)
				syschat("Has Encontrado una Fragmento Glaciar!")
			end
		end
		when 20084.take with item.get_vnum() == 30223 begin--DEBUG
			if pc.count_item(30223) == 200 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if select("Restablecer Mision","Cancelar") == 1 then
					affect.add_collect(apply.ATT_GRADE_BONUS,70,60*60*24*365*60)
					pc.give_item2(50112)
					clear_letter()
					set_quest_state("collect_quest_lv70", "run")
					set_state(__complete)
					return
				end
			end
		end
		when 20084.chat."Fragmento Glaciar" with pc.count_item(30146) > 0 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if get_time() > pc.getqf("duration") or pc.getqf("drink_drug")!=0 then
				if pc.count_item(30146) > 0 then 
					say("Oh, Has conseguido un Fragmento Glaciar!")
					say("Dame un momento para Analizarlo ... ")
					pc.remove_item("30146", 1)
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
						if pc.getqf("collect_count") < 19 then
							local index =pc.getqf("collect_count")+1
							pc.setqf("collect_count",index)
							say(string.format("Oh! Esta Fragmento Glaciar es de buena calidad!.[ENTER]Sin embargo, todavia necesito %s mas. ", 20-pc.getqf("collect_count")))
							say("")
							pc.setqf("drink_drug",0)
							return
						end
						say("Has conseguido los 20 Fragmentos Glaciar!")
						say("Gracias. Pero, todavia necesito algo especial.")
						say("La llaman Piedra Alma del Aurtumryu.")
						say_item_vnum(30223)
						say("Seria fantastico si puedieras conseguirla tambien.")
						say("La conseguiras eliminando Golems en Sohan.")
						say("")
						pc.setqf("collect_count",0)
						pc.setqf("drink_drug",0)
						pc.setqf("duration",0)
						set_state(key_item)
						return
					else
						say("Hm, esta Fragmento Glaciar esta derretido")
						say("No creo que pueda usarlo para mis estudios...")
						say("Por favor, traeme otro!")
						say("")
						pc.setqf("drink_drug",0)
						return
					end
				else
					say("Por favor, vuelve cuando hayas encontrado alguno")
					say(string.format("Todavia necesito %s Fragmentos Glaciar ", 20-pc.getqf("collect_count")))
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
			if pc.count_item(30223) > 0 then
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
			if pc.count_item(30223) > 0 then
				say_reward("Has encontrado la Piedra Alma del Aurumryu!")
				say("")
				return
			end
			say("Para la investigacion del Biologo Chaegirab.")
			say("Se han recogido 20 Fragmentos Glaciar")
			say("Ahora para completar la investigacion necesitas")
			say("una Piedra Alma del Aurtumryu. ")
			say_item_vnum(30223)
			say("Podras conseguirla en la Montana Sohan.")
			say("")
		end
		when 1107.kill or 1106.kill begin
			local s = number(1,50)
			if s == 1 and pc.count_item(30223)==0 then
				pc.give_item2(30223, 1)
				send_letter("Tienes la Piedra Alma del Aurumryu")
			end
		end
		when __TARGET__.target.click or 20084.chat."Piedra Alma del Aurumryu" with pc.count_item(30223) > 0 begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.count_item(30223) > 0 then 
				say("Guao! Muchas gracias! Para recompensarte, te dare")
				say("esta receta, su composicion es especial.")
				say("La pocion se puede hacer utilizando la formula")
				say("Ve y busca de Baek-go, el hara la pocion para Ti.")
				say("")
				pc.remove_item(30223,1)
				set_state(__reward)
			else
				say("Por favor, vuelve cuando hayas encontrado")
				say("la Piedra Alma del Aurumryu.")
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
			say("La recompensa por la Piedra Alma Aurumryu")
			say("El Biologo Chaerigab te ha dejado la formula")
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
			say("Aumentara tu Valor de Ataque 70 Pts.")
			say("Tambien, te doy esta Caja del Aurumryu")
			say("Contiene objetos muy valiosos! No la pierdas!")
			say_reward("Valor de Ataque Aumentado 70 Pts")
			say("")
			affect.add_collect(apply.ATT_GRADE_BONUS,70,60*60*24*365*60)
			pc.give_item2(50112)
			clear_letter()
			set_quest_state("collect_quest_lv70", "run")
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
