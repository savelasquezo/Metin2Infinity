quest collect_quest_lv90  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 90 begin
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
			say("Quiero saber mas sobre las criaturas que gobiernan")
			say("las facciones que se resisten a la voluntad del")
			say("Dios dragon, e incitan a la violencia y muerte sin")
			say("compacion contra nuestro reino, su comportamiento")
			say("se ha alterado drasticamente desde que los metines")
			say("llegaron, antes eran pacificos y tranquilos")
			say("nunca se vio tan afectada, por favor, ten cuidado")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¿Podrias conseguirme Nota de Lider?")
			say_item_vnum(30168)
			say("Traeme Notas de lider, aunque que las pruebas")
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
			say("necesita 50 Nota de lider en todo el continente")
			say("para sus investigaciones.")
			say_item_vnum(30168)
			say("Puedes conseguir Notas de Lider Eliminando")
			say("Lideres Elites de los Clanes del Imperio.")
			say_reward(string.format("Hasta Ahora has entregado %s[ENTER]Nota de Lider. ", pc.getqf("collect_count")))
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
		when 2093.kill or 2094.kill or 2191.kill or 2192.kill or 2206.kill or 2207.kill or 3903.kill or 3901.kill or 3902.kill or 7021.kill or 2307.kill or 2492.kill or
			 2493.kill or 3090.kill or 3190.kill or 3910.kill or 3390.kill or 3791.kill or 3890.kill or 3591.kill or 3593.kill or 3691.kill or 3191.kill or 3290.kill or
			 3291.kill or 3490.kill or 3491.kill or 3590.kill or 3592.kill or 3690.kill or 3790.kill or 1092.kill or 1093.kill or 1095.kill or 1191.kill or 1192.kill or
			 1901.kill or 1902.kill or 2091.kill or 2092.kill or 691.kill or 692.kill or 791.kill or 792.kill begin
			local s = number(1, 5)
			if s == 1 then
				pc.give_item2(30168, 1)
				syschat("Has Encontrado una Nota de Lider! ")
			end 
		end
		when 20084.take with item.get_vnum() == 30227 begin--DEBUG
			if pc.count_item(30227) == 200 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if select("Restablecer Mision","Cancelar") == 1 then
					affect.add_collect_point(POINT_ATTBONUS_WARRIOR,10,60*60*24*365*60)
					affect.add_collect_point(POINT_ATTBONUS_ASSASSIN,10,60*60*24*365*60)
					affect.add_collect_point(POINT_ATTBONUS_SURA,10,60*60*24*365*60)
					affect.add_collect_point(POINT_ATTBONUS_SHAMAN,10,60*60*24*365*60)
					pc.give_item2(71159)
					clear_letter()
					set_state(__complete)
					return
				end
			end
		end
		when 20084.chat."Nota de Lider" with pc.count_item(30168) >0 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if get_time() > pc.getqf("duration") or pc.getqf("drink_drug")!=0 then
				if pc.count_item(30168) >0 then 
					say("Oh, Has conseguido una Nota de Lider!")
					say("Dame un momento para Analizarlo ... ")
					pc.remove_item("30168", 1)
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
						if pc.getqf("collect_count") < 49 then
							local index =pc.getqf("collect_count")+1
							pc.setqf("collect_count",index)
							say(string.format("Oh! Esta Nota de lider es de buena calidad!.[ENTER]Sin embargo, todavia necesito %s mas. ", 50-pc.getqf("collect_count")))
							say("")
							pc.setqf("drink_drug",0)
							return
						end
						say("Has conseguido los 50 Nota de Lider!")
						say("Gracias. Pero, todavia necesito una piedra especial.")
						say("La llaman Piedra Alma del Lider.")
						say_item_vnum(30227)
						say("Seria fantastico si puedieras conseguirla tambien.")
						say("La conseguiras Eliminando Lideres en todo el continente.")
						say("")
						pc.setqf("collect_count",0)
						pc.setqf("drink_drug",0)
						pc.setqf("duration",0)
						set_state(key_item)
						return
					else
						say("Hm, este Nota de Lider esta manchada.")
						say("No creo que pueda usarlo para mis estudios...")
						say("Por favor, traeme otro!")
						say("")
						pc.setqf("drink_drug",0)
						return
					end
				else
					say("Por favor, vuelve cuando hayas encontrado alguno.")
					say(string.format("Todavia necesito %s Notas de Lider ", 50-pc.getqf("collect_count")))
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
			if pc.count_item(30227) > 0 then
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
			if pc.count_item(30227) >0 then
				say_reward("Has encontrado la Piedra Alma del Lider!")
				say("")
				return
			end
			say("Para la investigacion del Biologo Chaegirab.")
			say("Se han recogido 50 Notas de Lider")
			say("Ahora para completar la investigacion necesitas")
			say("una Piedra Alma del Lider. ")
			say_item_vnum(30227)
			say("Podras conseguirla en los Lideres del Imperio.")
			say("")
		end
		when 691.kill or 692.kill or 791.kill or 792.kill or 1092.kill or 1093.kill or 1095.kill or 1191.kill or 1192.kill or 1901.kill or 1902.kill or 2091.kill or 2092.kill or
			 2093.kill or 2094.kill or 2191.kill or 2192.kill or 2206.kill or 2207.kill or 3903.kill or 3901.kill or 3902.kill or 7021.kill or 2307.kill or 2492.kill or 2493.kill begin
			local s = number(1, 10)
			if s == 1 and pc.count_item(30227)==0 then
				pc.give_item2(30227, 1)
				send_letter("Tienes la Piedra Alma del Lider")
			end
		end
		when __TARGET__.target.click or 20084.chat."Piedra Alma del Jinunggyi" with pc.count_item(30227) > 0 begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.count_item(30227) > 0 then 
				say("Guao! Muchas gracias! Para recompensarte, te dare")
				say("esta receta, su composicion es especial.")
				say("La pocion se puede hacer utilizando la formula")
				say("Ve y busca de Baek-go, el hara la pocion para Ti.")
				say("")
				pc.remove_item(30227,1)
				set_state(__reward)
			else
				say("Por favor, vuelve cuando hayas encontrado")
				say("la Piedra Alma del Lider.")
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
			say("La recompensa por las Notas y la Piedra Alma del Lider")
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
			say("Aumentara tu fuerza contra Razas en 10 Pts.")
			say("Tambien, te doy esta Caja de Lider")
			say("Contiene objetos muy valiosos! No la pierdas!")
			say_reward("Fuerza contra Razas Aumentada 10 Pts")
			say("")
			affect.add_collect_point(POINT_ATTBONUS_WARRIOR,10,60*60*24*365*60)
			affect.add_collect_point(POINT_ATTBONUS_ASSASSIN,10,60*60*24*365*60)
			affect.add_collect_point(POINT_ATTBONUS_SURA,10,60*60*24*365*60)
			affect.add_collect_point(POINT_ATTBONUS_SHAMAN,10,60*60*24*365*60)
			pc.give_item2(71159)
			clear_letter()
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
