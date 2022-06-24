quest Blacksmith begin
	state start begin
		when 20016.chat."Manual de Manufactura" begin
			say_title("Herrero:")
			say("El Pergamino de la Guerra es un poderoso pergamino")
			say("mejora objetos sin riesgo desde +0 a +3")
			say("El Pegamino tiene 100% de Acierto.")
			say_item("Pergamino de la Guerra", 39014, "")
			say("La creacion de este pergamino requiere el material")
			say("Mineral de Cobre Magico")
			say("")
			wait()
			say_title("Herrero:")
			say("Consigue una Mineral de Cobre Magico, creare")
			say("El Pergamino de Guerra por 1.000.000 Yang")
			say_item("Mineral de Cobre Magico", 70035, "")
			say("Quieres fabricar un Pergamino de la Guerra?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				if pc.gold < 1000000 then
					say("No tienes suficiente Yang")
					say("")
					return
				end
				if pc.count_item("25040") == 0 then
					say_title("Herrero:")
					say("Debes tener un Pergamino Bendicion para crear" )
					say("El Pergamino de la Guerra." )
					say_item("Pergamino de Bendicion" , 25040 , "")
					say("Consigue una Pergamino de Bendicion.")
					say("")
					return
				end
				if pc.count_item("70035") == 0 then
					say_title("Herrero:")
					say("Debes tener Mineral de Cobre Magico para crear" )
					say("El Pergamino de la Guerra." )
					say_item("Mineral de Cobre Magico" , 70035 , "")
					say("Consigue un Mineral de Cobre Magico.")
					say("")
					return
				end
				say_title("Herrero:")
				say("El Pergamino de la Guerra ha sido creado con Exito")
				say("Traeme mas Mineral de Cobre Magico.")
				say("")
				pc.remove_item(70035,1)
				pc.remove_item(25040,1)
				pc.give_item2(39014, 1)
				pc.changegold(-1000000)
				return
			elseif a == 2 then
				say_title("Herrero:")
				say("Vuelve, Cuando estes listo.")
				say("")
				return
			end
		end
		when 20074.chat."Herrero de Armas"      with pc.getf("DevilTowerRenewal","CanRefine") == 1 begin
			say_title("Seon-Pyeong:")
			say("Bienvenido al sexto nivel de la Torre Demoniaca")
			say("Graciasa  tu Valentia te recompenzare forjando")
			say("una de tus Armas.")
			say("")
		end
		when 20075.chat."Herrero de Armaduras"  with pc.getf("DevilTowerRenewal","CanRefine") == 1 begin
			say_title("Seon-Pyeong:")
			say("Bienvenido al sexto nivel de la Torre Demoniaca")
			say("Graciasa  tu Valentia te recompenzare forjando")
			say("una de tus Armaduras.")
			say("")
		end
		when 20076.chat."Herrero de Accesorios" with pc.getf("DevilTowerRenewal","CanRefine") == 1 begin
			say_title("Seon-Pyeong:")
			say("Bienvenido al sexto nivel de la Torre Demoniaca")
			say("Graciasa  tu Valentia te recompenzare forjando")
			say("uno de tus Accesorios.")
			say("")
		end
	end
end
