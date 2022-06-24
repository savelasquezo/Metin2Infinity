quest collect_quest_lv50 begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 50 begin
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
			say("Acabo de examinar Demonios en Torre del Demonio.")
			say("Con estos podemos descubrir cual es su debilidad.")
			say("Ademas estos recuerdos guardan algo de misterio")
			say("en su interior, me gustaria investigar mas")
			say("sobre esto se que estas criaturas estan vinculados")
			say("con algunos susesos sospechosos y calamidades")
			say("por tal razon ayudame a investigarlos.")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¿Podrias conseguirme Recuerdo Oscuro?")
			say_item_vnum(31067)
			say("Traeme Recuerdos Oscuros, aunque que las pruebas")
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
			say("necesita 15 Recuerdo Oscuro en Torre de Demonios")
			say("para sus investigaciones.")
			say_item_vnum(31067)
			say("Puedes conseguir el Recuerdo Oscuro Eliminando")
			say("Soldado Demonio y Demonio Lancero.")
			say_reward(string.format("Hasta Ahora has entregado %s[ENTER]Recuerdo Oscuro. ", pc.getqf("collect_count")))
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
		when 1001.kill or 1003.kill begin
			local s = number(1, 55)
			if s == 1 then
				pc.give_item2(31067, 1)
				syschat("Has Encontrado un Recuerdo Oscuro! ")
			end
		end
		when 20084.take with item.get_vnum() == 30222 begin--DEBUG
			if pc.count_item(30222) == 200 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if select("Restablecer Mision","Cancelar") == 1 then
					affect.add_collect(apply.DEF_GRADE_BONUS, 60, 60*60*24*365*60)
					pc.give_item2(50111)
					clear_letter()
					set_quest_state("collect_quest_lv60", "run")
					set_state(__complete)
					return
				end
			end
		end
		when 20084.chat."Recuerdos Oscuros" with pc.count_item(31067) > 0 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if get_time() > pc.getqf("duration") or pc.getqf("drink_drug")!=0 then
				if pc.count_item(31067) > 0 then 
					say("Oh, Has conseguido un Recuerdo Oscuro!")
					say("Dame un momento para Analizarlo ... ")
					pc.remove_item("31067", 1)
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
						if pc.getqf("collect_count") < 14 then
							local index =pc.getqf("collect_count")+1
							pc.setqf("collect_count",index)
							say(string.format("Oh! Este Recuerdo Oscuro es de buena calidad!.[ENTER]Sin embargo, todavia necesito %s mas. ", 15-pc.getqf("collect_count")))
							say("")
							pc.setqf("drink_drug",0)
							return
						end
						say("Has conseguido los 15 Recuerdos Oscuros!")
						say("Gracias. Pero, todavia necesito algo especial.")
						say("La llaman Piedra Alma de Sagyi.")
						say_item_vnum(30222)
						say("Seria fantastico si puedieras conseguirla tambien.")
						say("La conseguiras eliminando Demonios en la Torre.")
						say("")
						pc.setqf("collect_count",0)
						pc.setqf("drink_drug",0)
						pc.setqf("duration",0)
						set_state(key_item)
						return
					else
						say("Hm, este Recuerdo Oscuro esta deteriorado?.")
						say("No creo que pueda usarlo para mis estudios...")
						say("Por favor, traeme otro!")
						say("")
						pc.setqf("drink_drug",0)
						return
					end
				else
					say("Por favor, vuelve cuando hayas encontrado alguno")
					say(string.format("Todavia necesito %s Recuerdos Oscuro ", 15-pc.getqf("collect_count")))
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
			if pc.count_item(30222) > 0 then
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
			if pc.count_item(30222) > 0 then
				say_reward("Has encontrado la Piedra Alma de Sagyi!")
				say("")
				return
			end
			say("Para la investigacion del Biologo Chaegirab.")
			say("Se han recogido 15 Recuerdos Oscuros")
			say("Ahora para completar la investigacion necesitas")
			say("una Piedra Alma de Sagyi.")
			say_item_vnum(30222)
			say("Podras conseguirla en la Torre del Demonio.")
			say("")
		end
		when 1001.kill or 1003.kill begin
			local s = number(1,50)
			if s == 1 and pc.count_item(30222) == 0 then
				pc.give_item2(30222, 1)
				send_letter("Tienes la Piedra Alma de Sagyi")
			end
		end
		when __TARGET__.target.click or 20084.chat."Piedra Alma de Sagyi" with pc.count_item(30222) > 0 begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.count_item(30222) > 0 then 
				say("Guao! Muchas gracias! Para recompensarte, te dare")
				say("esta receta, su composicion es especial.")
				say("La pocion se puede hacer utilizando la formula")
				say("Ve y busca de Baek-go, el hara la pocion para Ti.")
				say("")
				pc.remove_item(30222,1)
				set_state(__reward)
			else
				say("Por favor, vuelve cuando hayas encontrado")
				say("la Piedra Alma de Sagyi.")
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
			say("La recompensa por la Piedra Alma de Sagyi")
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
			say("Aumentara tu Defensa en 60 Pts.")
			say("Tambien, te doy esta Caja del Sagyi")
			say("Contiene objetos muy valiosos! No la pierdas!")
			say_reward("Defensa Aumentada 60 Pts")
			say("")
			affect.add_collect(apply.DEF_GRADE_BONUS, 60, 60*60*24*365*60)
			pc.give_item2(50111)
			clear_letter()
			set_quest_state("collect_quest_lv60", "run")
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
