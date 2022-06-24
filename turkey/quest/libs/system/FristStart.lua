quest FristStart begin
	state start begin
		when login with pc.getqf("frist_login") == 0 begin
			set_state(welcome_login)
		end
	end
	state welcome_login begin
		when letter begin
			send_letter("Metin2 Lamda!")
		end
		when button or info begin
			pc.setqf("box",1)
			pc.setqf("frist_login",1)
			addimage(20, 12, "password_inventory.tga")
			say("")
			say("")
			say("")
			say("")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("¡Saludos Metinero!")
			say("")
			say_white("Metin2 Lamda te da la Bienvenida!")
			say_white("No dudes en contactar con algun miembro del Staff") 
			say_white("En caso de necesitar ayuda y/o soporte en el juego")
			say_white("Y Recuerda Seguirnos en Nuestras Redes Sociales")
			say_white("Para estar Informado de Todas las Noticas, Actualizaciones")
			say_white("Y Eventos que Realizaremos a lo Largo De Este Viaje.")
			say_white("Mucha Suerte y Esperamos que Disfrutes al Maximo.")
			say("")
			pc.give_item2(50187,1)
			pc.set_skill_level (131,10)--Doma
			horse.set_level("20")
			pc.setqf("FixHorse",1)
			pc.set_skill_level (126,69)--Lenguaje Shinsoo
			pc.set_skill_level (127,69)--Lenguaje Chunjo
			pc.set_skill_level (128,69)--Lenguaje Jinno
			pc.set_skill_level (122,2)---Combo
			say("")
			if pc.get_empire() == 3 then
				return
			elseif pc.get_empire() == 1 then
				if pc.get_job() == 0 then
					if pc.get_sex() == 0 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas al Nuevo Guerrero " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas a la Nueva Guerrera " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 1 then
					if pc.get_sex() == 0 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas al Nuevo Ninja " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas a la Nueva Ninja " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 2 then
					if pc.get_sex() == 0 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas al Nuevo Sura " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas a la Nueva Sura " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 3 then
					if pc.get_sex() == 0 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas al Nuevo Chaman " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion del Dragón Presenta Entre sus Filas a la Nueva Chaman " ..pc.get_name()..",Bienvenida!!.")
					end
				end
			elseif pc.get_empire() == 2 then
				if pc.get_job() == 0 then
					if pc.get_sex() == 0 then
						notice_all("La Legion Bestial Presenta Entre sus Filas al Nuevo Guerrero " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion Bestial Presenta Entre sus Filas a la Nueva Guerrera " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 1 then
					if pc.get_sex() == 0 then
						notice_all("La Legion Bestial Presenta Entre sus Filas al Nuevo Ninja " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion Bestial Presenta Entre sus Filas a la Nueva Ninja " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 2 then
					if pc.get_sex() == 0 then
						notice_all("La Legion Bestial Presenta Entre sus Filas al Nuevo Sura " ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion Bestial Presenta Entre sus Filas a la Nueva Sura " ..pc.get_name()..",Bienvenida!!.")
					end
				end
				if pc.get_job() == 3 then
					if pc.get_sex() == 0 then
						notice_all("La Legion Bestial Presenta Entre sus Filas al Nuevo Chaman "  ..pc.get_name()..",Bienvenido!!.")
					end
					if pc.get_sex() == 1 then
						notice_all("La Legion Bestial Presenta Entre sus Filas a la Nueva Chamana " ..pc.get_name()..",Bienvenida!!.")
					end
				end
			end
			clear_letter ( )
			set_state(unboxing)
		end
	end
	state unboxing begin
		when login or levelup begin
			if pc.getqf("FixHorse") == 1 then
				return
			else
				pc.setqf("FixHorse",1)
				horse.set_level("20")
			end
			if game.get_event_flag("FixMount") == 1 then
				if pc.getqf("FixMountReward") == 1 then
					return
				elseif pc.getf("FixMountNormal") != 1 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_yellow("¡Recompenza Montura!")
					say("")
					say_white("Aqui tienes una recompenza para motivar") 
					say_white("el avance en el Servidor")
					say_white("")
					say_white("¡Gracias por el Apoyo!")
					say_white("")
					say_item_vnum(52438)
					say_white("")
					say_gold("15% Fuerza Monstruos")
					say_gold("10% Fuerza contra Metines")
					say("")
					pc.setqf("FixMountReward",1)
					pc.give_item2(52438,1)
				else
					return
				end
			end
		end
		when 50187.use begin
			if pc.getqf("box") == 1 then
				pc.setqf("box",2)
				item.set_socket(0, pc.get_player_id())
				pc.give_item2(27001,200)
				pc.give_item2(27004,200)
				pc.give_item2(70057,20)--Capa Valor Infinita
				pc.give_item2(13009,1)
				pc.give_item2(17009,1)
				pc.give_item2(14009,1)
				pc.give_item2(16009,1)
				pc.give_item2(15009,1)
				pc.give_item2(70058,1)--Anillo TP
				pc.give_item2(52438,1)--Nuevo Caballo
				pc.setqf("FixMountNormal",1)
				if pc.get_sex() == 0 then
					pc.give_item2(number(41458,41459),1)
				end
				if pc.get_sex() == 1 then
					pc.give_item2(number(41462,41463),1)
				end
				if pc.get_job() == 0 then
					pc.give_item2(12209,1)
					pc.give_item2(11209,1)
					pc.give_item2(19,1)
					pc.give_item2(3009,1)
					pc.give_item2(53010,1)
				elseif pc.get_job() == 1 then
					pc.give_item2(12349,1)
					pc.give_item2(11409,1)
					pc.give_item2(19,1)
					pc.give_item2(1009,1)
					pc.give_item2(2009,1)
					pc.give_item2(53011,1)
				elseif pc.get_job() == 2 then
					pc.give_item2(12489,1)
					pc.give_item2(11609,1)
					pc.give_item2(19,1)
					pc.give_item2(53013,1)
				elseif pc.get_job() == 3 then
					pc.give_item2(12629,1)
					pc.give_item2(11809,1)
					pc.give_item2(5009,1)
					pc.give_item2(7009,1)
					pc.give_item2(53012,1)
				end
				return
			end
			if item.get_socket(0) != pc.get_player_id() then
				syschat("<Error>")
				return
			end
			if pc.getqf("box") == 2 then
				if pc.get_level ( ) < 15 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 15")
					return
				end
				pc.setqf("box",3)
				pc.give_item2(27002,100)--Poción R (M)
				pc.give_item2(27005,100)--Poción A (M)
				pc.give_item2(25040,10)--Bendicion
				pc.give_item2(39028,10)--Encantado
				pc.give_item2(39029,30)--Coaccions
				if pc.get_job() == 0 then
					pc.give_item2(21900,1)
					pc.give_item2(21903,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21900,1)
					pc.give_item2(21901,1)
					pc.give_item2(21902,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21900,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21904,1)
					pc.give_item2(21905,1)
				end
				return
			end
			if pc.getqf("box") == 3 then
				if pc.get_level ( ) < 30 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 30")
					return
				end
				pc.setqf("box",4)
				pc.give_item2(27003,100)--Poción R (G)
				pc.give_item2(27006,100)--Poción A (G)
				pc.give_item2(56001,3)--Poción Refinada (P)
				pc.give_item2(71035,3)--Elixir Investigador
				pc.give_item2(39004,5)--Bola Bendicion
				if pc.get_job() == 0 then
					pc.give_item2(21910,1)
					pc.give_item2(21913,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21910,1)
					pc.give_item2(21911,1)
					pc.give_item2(21912,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21910,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21914,1)
					pc.give_item2(21915,1)
				end
				return
			end
			if pc.getqf("box") == 4 then
				if pc.get_level ( ) < 45 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 45")
					return
				end
				pc.setqf("box",5)
				pc.give_item2(27007,100)--Poción R (E)
				pc.give_item2(27008,100)--Poción A (E)
				pc.give_item2(56002,3)--Poción Refinada M
				pc.give_item2(71004,5)--Medalla Dragon
				pc.give_item2(71201,3)--Ticket de Entrada
				if pc.get_job() == 0 then
					pc.give_item2(21920,1)
					pc.give_item2(21923,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21920,1)
					pc.give_item2(21921,1)
					pc.give_item2(21922,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21920,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21924,1)
					pc.give_item2(21925,1)
				end
				return
			end
			if pc.getqf("box") == 5 then
				if pc.get_level ( ) < 55 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 55")
					return
				end
				pc.setqf("box",6)
				pc.give_item2(72723,3)--Elixir R (P)
				pc.give_item2(72727,3)--Elixir A (P)
				pc.give_item2(56003,3)--Poción Refinada G
				pc.give_item2(25041,1)--Piedra Magica
				pc.give_item2(71004,5)--Medalla Dragon
				pc.give_item2(50821,10)--Rocio
				pc.give_item2(50822,10)--Rocio
				pc.give_item2(50823,10)--Rocio
				pc.give_item2(50824,10)--Rocio
				pc.give_item2(50825,10)--Rocio
				pc.give_item2(50826,10)--Rocio
				if pc.get_job() == 0 then
					pc.give_item2(21930,1)
					pc.give_item2(21933,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21930,1)
					pc.give_item2(21931,1)
					pc.give_item2(21932,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21930,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21934,1)
					pc.give_item2(21935,1)
				end
				return
			end
			if pc.getqf("box") == 6 then
				if pc.get_level ( ) < 65 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 65")
					return
				end
				pc.setqf("box",7)
				pc.give_item2(72724,3)--Elixir R (M)
				pc.give_item2(72728,3)--Elixir A (M)
				pc.give_item2(25041,3)--Piedra Magica
				pc.give_item2(71004,5)--Medalla Dragon
				pc.give_item2(39024,10)--Lucha Critk
				pc.give_item2(39025,10)--Lucha Perfo
				if pc.get_job() == 0 then
					pc.give_item2(21940,1)
					pc.give_item2(21943,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21940,1)
					pc.give_item2(21941,1)
					pc.give_item2(21942,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21940,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21944,1)
					pc.give_item2(21945,1)
				end
				return
			end
			if pc.getqf("box") == 7 then
				if pc.get_level ( ) < 75 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 75")
					return
				end
				pc.setqf("box",8)
				pc.give_item2(72725,3)--Elixir R (G)
				pc.give_item2(72729,3)--Elixir A (G)
				pc.give_item2(30190,3)--Piedra de Sangre
				pc.give_item2(30319,2)--Piedra de Sangre
				pc.give_item2(71004,5)--Medalla Dragon
				pc.give_item2(39017,10)--Bendicion del Dragon
				pc.give_item2(39018,10)--Bendicion del Dragon
				pc.give_item2(39019,10)--Bendicion del Dragon
				pc.give_item2(39020,10)--Bendicion del Dragon
				if pc.get_job() == 0 then
					pc.give_item2(21950,1)
					pc.give_item2(21953,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21950,1)
					pc.give_item2(21951,1)
					pc.give_item2(21952,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21950,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21954,1)
					pc.give_item2(21955,1)
				end
				return
			end
			if pc.getqf("box") == 8 then
				if pc.get_level ( ) < 90 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 90")
					return
				end
				pc.setqf("box",9)
				pc.give_item2(72726,3)--Elixir R (E)
				pc.give_item2(72730,3)--Elixir A (E)
				pc.give_item2(71004,5)--Medalla Dragon
				pc.give_item2(31088,1)--Ticket Arrador
				pc.give_item2(31089,1)--Ticket Nemeres
				if pc.get_job() == 0 then
					pc.give_item2(21960,1)
					pc.give_item2(21963,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21960,1)
					pc.give_item2(21961,1)
					pc.give_item2(21962,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21960,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21964,1)
					pc.give_item2(21965,1)
				end
				return
			end
			if pc.getqf("box") == 9 then
				if pc.get_level ( ) < 120 then 
					syschat("<Error> Tu Nivel es demasiado bajo para abrir este cofre")
					syschat("Requerido: Nivel 120")
					return
				end
				pc.setqf("box",99)
				pc.give_item2(71018,10)-- Bendicion SP
				pc.give_item2(71019,10)-- Bendicion HP
				if pc.get_job() == 0 then
					pc.give_item2(21970,1)
					pc.give_item2(21973,1)
				end
				if pc.get_job() == 1 then
					pc.give_item2(21970,1)
					pc.give_item2(21971,1)
					pc.give_item2(21972,1)
				end
				if pc.get_job() == 2 then
					pc.give_item2(21970,1)
				end
				if pc.get_job() == 3 then
					pc.give_item2(21974,1)
					pc.give_item2(21975,1)
				end
				pc.remove_item("50187",1)
				set_state(complete)
				return
			end
		end
	end
	state complete begin
	end
end
