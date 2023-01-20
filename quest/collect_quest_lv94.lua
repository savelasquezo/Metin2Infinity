quest collect_quest_lv94 begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 94 begin
			set_state(information)
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20091)
			if v != 0 then
				target.vid("__TARGET__", v, "Seon-Pyeong")
			end
			send_letter("Investigacion de Seon-Pyeong")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20084)))
			say("")
			say("Seon-Pyeong, El Sura de Seungryong , te esta")
			say("buscando ve rapido y preguntale que necestia.")
			say("")
		end
		when __TARGET__.target.click or	20091.chat."Investigacion" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡Necesito Ayuda!")
			say("La investigacion necesita informacion sobre")
			say("las criaturas que habitan la Gruta del Exilio")
			say("Es una tarea que no puedo realizar")
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
			say("¿Podrias conseguirme Joyas del Sabiduria?")
			say_item_vnum(30252)
			say("Traeme Joyas del Sabiduria, necesito estas")
			say("Joyas en buen estado, ten mucho cuidado.")
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
			send_letter("Investigacion de Seon-Pyeong")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20091)))
			say("")
			say("Seon-Pyeong, El Sura de Seungryong")
			say("Necesita 30 Joyas del Sabiduria")
			say("Puedes conseguirlas en Gruta del exilio.")
			say_item_vnum(30252)
			say("Puedes conseguir Joyas del Sabiduria Eliminando")
			say("Integrantes del Clan Setaou en Gruta del Exilio.")
			say_reward(string.format("Hasta Ahora has entregado %s[ENTER]Joyas del Sabiduria. ", pc.getqf("collect_count")))
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
		when 2401.kill or 2402.kill or 2403.kill or 2404.kill begin
			local s = number(1,300)
			if s == 1 then
				pc.give_item2(30252, 1)
				syschat("Has Encontrado una Joya del Sabiduria! ")
			end 
		end
		when 20092.take with item.get_vnum() == 30252 begin--DEBUG
			syschat("Metin2 Lamda Error94")
			if pc.count_item(30252) == 200 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				local s = select("Max HP +2500", "Defensa +150", "Ataque +130")
				if 1 == s then
					affect.add_collect(apply.MAX_HP, 2500, 60*60*24*365*60)
					pc.setqf("reward", 1)
				elseif 2 == s then
					affect.add_collect(apply.DEF_GRADE_BONUS, 150, 60*60*24*365*60)
					pc.setqf("reward", 2)
				elseif 3 == s then 
					affect.add_collect(apply.ATT_GRADE_BONUS, 130, 60*60*24*365*60)
					pc.setqf("reward", 3)
				end
				clear_letter()
				set_quest_state("collect_quest_lv96", "run")
				set_state(__complete)
			end
		end
		when 20091.chat."Joyas del Sabiduria" with pc.count_item(30252) >0 begin
			if get_time() > pc.getqf("duration") or pc.getqf("drink_drug")!=0 then
				if pc.count_item(30252) >0 then 
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("Oh, Has conseguido una Joya del Sabiduria!")
					say("Dame un momento para verficiar su integridad ... ")
					pc.remove_item("30252", 1)
					pc.setqf("duration",get_time()+ 3)
					say("")
					wait()
					local pass_percent
					if pc.getqf("drink_drug")==0 then
						pass_percent=35
					else
						pass_percent=85
					end
					local s= number(1,100)
					if s <= pass_percent  then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say("")
						if pc.getqf("collect_count") < 29 then    
							local index =pc.getqf("collect_count")+1
							pc.setqf("collect_count",index)
							say(string.format("Oh! Esta Joya del Sabiduria es de buena calidad!.[ENTER]Sin embargo, todavia necesito %s mas. ", 30-pc.getqf("collect_count")))
							say("")
							pc.setqf("drink_drug",0)
							return
						end
						say("Has conseguido los 30 Joyas del Sabiduria!")
						say("Guao! Muchas gracias! Para recompensarte.")
						say("Usara la magia antigua de las joyas para elevar")
						say("tu potencial, debes seleccionar que atributos")
						say("deseas maximar, solo puedes elegir uno, tardare")
						say("un tiempo en terminar de extraer la energia")
						say("regresa en 3 horas y potenciare tus atributos.")
						pc.setqf("duration__reward",get_time()+ 60*60*3)
						say("")
						set_state(__reward)
						return
					else
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say("")
						say("Hm, este Joya del Sabiduria esta fracturada.")
						say("No es util para mis planes, necesito una en buen")
						say("Estado, Por favor, traeme otro!")
						say("")
						pc.setqf("drink_drug",0)
						return
					end
				else
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("Por favor, vuelve cuando hayas encontrado alguno.")
					say(string.format("Todavia necesito %s Joyas del Sabiduria ", 30-pc.getqf("collect_count")))
					say("")
					return
				end
			else
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("Lo siento mucho, pero todavia no he terminado") 
				say("El analisis de la ultima muestra.")
				say("")
				return
			end
		end
	end
	state __reward begin
		when letter begin
			send_letter("Recompensa del Seon-Pyeong")
			local v = find_npc_by_vnum(20091)
			if v != 0 then
				target.vid("__TARGET__", v, "Recompensa de Seon-Pyeong")
			end
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(20091)))
			say("")
			say("Como recompensa por las Joyas del Sabiduria")
			say("Seon-Pyeong aumentara tu potencial")
			say("Ve donde Seon-Pyeong para Completar la Mision.")
			say("")
		end
		when __TARGET__.target.click or 20091.chat."Arte Secreto" begin
			if get_time() > pc.getqf("duration__reward") then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("Lo siento mucho, pero todavia no he terminado") 
				say("extraer tal cantidad de energia toma tiempo.")
				say("")
				return
			end
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡He Terminado!")
			say("Logre extraer una gran cantidad de energia")
			say("gracias a esto he aumentado mis poderes.")
			say("usare la energia restante para aumentar")
			say("tu potencial de lucha!")
			say("Que Caracteristica deseas potenciar?")
			say("")
			local s = select("Max HP +2500", "Defensa +150", "Ataque +130")
			if 1 == s then
				affect.add_collect(apply.MAX_HP, 2500, 60*60*24*365*60)
				pc.setqf("reward", 1)
			elseif 2 == s then
				affect.add_collect(apply.DEF_GRADE_BONUS, 150, 60*60*24*365*60)
				pc.setqf("reward", 2)
			elseif 3 == s then 
				affect.add_collect(apply.ATT_GRADE_BONUS, 130, 60*60*24*365*60)
				pc.setqf("reward", 3)
			end
			clear_letter()
			set_quest_state("collect_quest_lv96", "run")
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
