quest GM begin
	state start begin
		when 71099.use begin
			x = pc.get_x()
			y = pc.get_y()
			mapa = pc.get_map_index()
			syschat("Estas en "..x.." "..y.." con el index "..mapa)
		end
		when 70304.use begin
			if pc.is_gm() then
				say_title("Control de Gm")
				say("Que Quieres hacer?")
				local menu = select("Dia/Noche","Rates","Bloquear Chat","Teleport","Gm-Online","Invisible","Cerrar")
				if menu == 7 then
					return
				end
				if menu == 1 then
					say("Que quieres poner?")
					local menu2 = select("Dia","Noche","Cerrar")
					if menu2 == 1 then
						command ("x 2")
					elseif menu2 == 2 then
						command ("x 1")
					elseif menu2 == 3 then
						return
					end
				end
				if menu == 2 then
					say("Rates:")
					say("Que Rates quieres añadir?")
					local menu2 = select("Experiencia","Yang","Drop","Todos","Cerrar")
					if menu2 == 5 then
						return
					end
					if menu2 == 1 then
						say("Experiencia:")
						say("A que reino le quieres dar experiencia?")
						local menu3 = select("Shinsoo","Chunjo","Jinno","Todos","Cerrar")
						if menu3 == 5 then
							return
						end
						if menu3 == 1 then
							local tipo = 4
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en Minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Experiencia para Shinsoo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 2 then
							local tipo = 4
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Experiencia para Chunjo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 3 then
							local tipo = 4
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Experiencia para Jinno:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 4 then
							local tipo = 4
							local reino = 0
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Experiencia para todos:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
					end
					if menu2 == 2 then
						say("Yang:")
						say("A que reino le quieres dar Yang?")
						local menu3 = select("Shinsoo","Chunjo","Jinno","Todos","Cerrar")
						if menu3 == 5 then
							return
						end
						if menu3 == 1 then
							local tipo = 2
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Yang para Shinsoo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 2 then
							local tipo = 2
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Yang para Chunjo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 3 then
							local tipo = 2
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Yang para Jinno:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 4 then
							local tipo = 2
							local reino = 0
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Yang para todos:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
					end
					if menu2 == 3 then
						say("Drop:")
						say("A que reino le quieres dar Drop?")
						local menu3 = select("Shinsoo","Chunjo","Jinno","Todos","Cerrar")
						if menu3 == 5 then
							return
						end
						if menu3 == 1 then
							local tipo = 1
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Drop para Shinsoo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 2 then
							local tipo = 1
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Drop para Chunjo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 3 then
							local tipo = 1
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Drop para Chunjo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 4 then
							local tipo = 1
							local reino = 0
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Drop para todos:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, tipo, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
					end
					if menu2 == 4 then
						say("Experiencia Yang Drop:")
						say("A que reino le quieres dar rates?")
						local menu3 = select("Shinsoo","Chunjo","Jinno","Todos","Cerrar")
						if menu3 == 5 then
							return
						end
						if menu3 == 1 then
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en Minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Rates para Shinsoo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, 1, rate, tiempo*60)
								__give_empire_priv(reino, 2, rate, tiempo*60)
								__give_empire_priv(reino, 4, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 2 then
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Rates para Chunjo:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, 1, rate, tiempo*60)
								__give_empire_priv(reino, 2, rate, tiempo*60)
								__give_empire_priv(reino, 4, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 3 then
							local reino = menu3
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Rates para Jinno:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, 1, rate, tiempo*60)
								__give_empire_priv(reino, 2, rate, tiempo*60)
								__give_empire_priv(reino, 4, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
						if menu3 == 4 then
							local reino = 0
							say("Que porcentaje quieres darle?")
							say_reward("Introduce solo numeros enteros.")
							local rate = input()
							rate=tonumber(rate)
							say("Introduce el tiempo de duracion en minutos")
							local tiempo=input()
							tiempo=tonumber(tiempo)
							say("Rates para todos:")
							say("Estas seguro que quieres darle "..rate.."%[ENTER]durante "..tiempo.." minutos?")
							local menu4 = select("Si","No")
							if menu4 == 1 then
								__give_empire_priv(reino, 1, rate, tiempo*60)
								__give_empire_priv(reino, 2, rate, tiempo*60)
								__give_empire_priv(reino, 4, rate, tiempo*60)
								game.set_event_flag("EventExpDropYG",1)
								server_timer("TimeEventExpDropYG1", tiempo*60)
							else
								return
							end
						end
					end
				end
				if menu == 3 then
					say("Que quieres hacer")
					local menu2 = select("Bloquear chat","Quitar bloqueo de chat","Lista de bloqueados","Cerrar")
					if menu2 == 1 then
						say("Bloquear chat:")
						say("Introduce el nombre del jugador que quieres mutear")
						local nombre = input()
						say("Introduce el tiempo que quieres silecciarlo en minutos")
						local tiempo = input()
						say("Estas seguro que quieres mutear a "..nombre.."[ENTER]durante "..tiempo.." minutos?")
						local menu3 = select("Si","Cerrar")
						if menu3 == 1 then
							notice_all(""..nombre.." ha sido silenciado del chat durante "..tiempo.." minutos de juego")
							tiempo = (tonumber(tiempo)*60)
							command("block_chat "..nombre.." "..tiempo.."")
						elseif menu3 == 2 then
							return
						end
					end
					if menu2 == 2 then
						say("Desbloquear chat:")
						say("Escribe el nombre del jugador que quieres desmutear.")
						local nombre = input()
						if find_pc_by_name(nombre) == 0 then
							say("Ese nombre no existe")
							return
						end
						say("Estas seguro que quieres quitar el muteo a "..nombre.."")
						local menu3 = select("Si","Cerrar")
						if menu3 == 1 then
							command("block_chat "..nombre.." 0")
						end
						if menu3 == 2 then
							return
						end
					end
					if menu2 == 3 then
						command("block_chat_list")
					end
					if menu2 == 4 then
						return
					end
				end
				if menu == 4 then
					say("Que quieres hacer")
					local menu2 = select("Traer a alguien","Ir hacia alguien","Cerrar")
					if menu2 == 3 then 
						return
					end
					if menu2 == 1 then
						say("Traer a alguien:")
						say("")
						say("Escribe el nombre del jugador")
						local nombre = input()
						if find_pc_by_name(nombre) == 0 then
							say("El jugadore no existe o esta desconectado")
							return
						else
							command("t "..nombre)
							say("El jugador "..nombre.." esta de camino")
						end
					end
					if menu2== 2 then
						say("Ir hacia alguien:")
						say("")
						say("Escribe el nombre del jugador")
						local nombre = input()
						if find_pc_by_name(nombre) == 0 then
							say("El jugadore no existe o esta desconectado")
							return
						else
							command("warp "..nombre)
						end
					end
				end
				if menu == 5 then
					notice_all("Staff-Online")
					notice_all("".. pc.get_name() .." Ya esta en linea.")
					notice_all("Preguntas o Problemas/MP.")
				end
				if menu == 6 then 
					command("in")
				end
			end
		end
		when TimeEventExpDropYG1.server_timer begin
			server_timer("TimeEventExpDropYG2",10*60)
			notice_all("<Evento>El Evento Experiencia-Drop-Yang Finalizara en 10 Minutos!")
		end
		when TimeEventExpDropYG2.server_timer begin
			game.set_event_flag("EventExpDropYG",0)
			notice_all("<Evento> El Evento Experiencia-Drop-Yang Ha Finalizado!")
		end
	end
end

