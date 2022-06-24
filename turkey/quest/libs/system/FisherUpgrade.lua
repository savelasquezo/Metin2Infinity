quest FisherUpgrade begin
	state start begin
		when 9009.chat."Arte del Pescador" begin
			say_title("Pescador:")
			say("El Arte de la pesca no es para cualquier novato")
			say("Debes tener un agudo instinto para encontrar los")
			say("peces y la destreza para capturarlos.")
			say_item("Vara de Pesca", 27480, "")
			say("Los peces tienen un alto costo en las tiendas")
			say("es una excelente forma de ganar yang.")
			say("")
			wait()
			say_title("Pescador:")
			say("Para capturar peces necesitas una Vara de Pesca")
			say("te lo vendere por 3000000 Yang.")
			say("Quieres Comprar un Kit de Pesca?" ) 
			say ( "" ) 
			local a = select ( "Si" , "No" ) 
			if a == 1 then 
				if pc.gold < 3000000 then
					say_title("Pescador:")
					say("No tienes suficiente Yang")
					say("")
					return
				end
				pc.changegold(-3000000)
				pc.give_item2("27460" , 1)
				pc.give_item2("27800" , 200)
				pc.give_item2("27801" , 200)
				return 
			elseif a == 2 then 
				say_title("Pescador:")
				say ( "Vuelve, Cuando estes listo." ) 
				say ( "" ) 
				return 
			end
		end
		when 9009.take with item.vnum == 27480 begin
			say_title("Pescador")
			say("Lo siento. Esta Pescadora no se puede mejorar mas.")
			say("")
		end
		when 9009.take with item.vnum >= 27400 and item.vnum < 27590 and item.get_socket(0)!= item.get_value(2) begin
			say_title("Pescador")
			say("Esta Pescadora no se puede mejorar")
			say("No tiene los puntos suficientes.")
			say("")
		end
		when 9009.take with item.vnum == 27400 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27400, 1)
			 pc.give_item2(27410, 1)
		end
		when 9009.take with item.vnum == 27410 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27410, 1)
			 pc.give_item2(27420, 1)
		end
		when 9009.take with item.vnum == 27420 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27420, 1)
			 pc.give_item2(27430, 1)
		end
		when 9009.take with item.vnum == 27430 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27430, 1)
			 pc.give_item2(27440, 1)
		end
		when 9009.take with item.vnum == 27440 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27440, 1)
			 pc.give_item2(27450, 1)
		end
		when 9009.take with item.vnum == 27450 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27450, 1)
			 pc.give_item2(27460, 1)
		end
		when 9009.take with item.vnum == 27460 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27460, 1)
			 pc.give_item2(27470, 1)
		end
		when 9009.take with item.vnum == 27470 and item.get_socket(0) == item.get_value(2) begin
			say_title("Pescador")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Pesca!!")
			say("")
			say_item("Ha Subido de Nivel", 27400, "")
			say("")
			say_gold("Aqui tienes tu palo de pescar con un nuevo nivel!!")
			pc.remove_item(27470, 1)
			 pc.give_item2(27480, 1)
		end
	end
end
