quest Mining begin
	state start begin
		when 20015.chat."Arte del Minero" begin
			say_title("Deokbae:")
			say("El Arte de la mineria no es para cualquier novato")
			say("Debes tener un agudo instinto para encontrar las")
			say("menas y extraer minerales.")
			say_item("Pico", 29110, "")
			say("Los minerales tienen un alto costo en las tiendas")
			say("es una excelente forma de ganar yang.")
			say("")
			wait()
			say_title("Deokbae:")
			say("Para Extraer minerales necesitaras un Pico")
			say("te lo vendere por 3000000 Yang.")
			say("Quieres Comprar un Pico+3 ?" ) 
			say ( "" ) 
			local a = select ( "Si" , "No" ) 
			if a == 1 then 
				if pc.gold < 3000000 then
					say_title("Deokbae:")
					say("No tienes suficiente Yang")
					say("")
					return
				end
				pc.changegold(-3000000)
				pc.give_item2("29104" , 1)
				return 
			elseif a == 2 then 
				say_title("Deokbae:")
				say ( "Vuelve, Cuando estes listo." ) 
				say ( "" ) 
				return 
			end
		end
		when 20015.take with item.vnum == 29110 begin
			say_title("Deokbae:")
			say("Lo siento. Este pico no se puede mejorar mas.")
			say("")
		end
		when 20015.take with item.vnum >= 29101 and item.vnum < 29109 and item.get_socket(0)!= item.get_value(2) begin
			say_title("Deokbae:")
			say("Esta Pico no se puede mejorar")
			say("No tiene los puntos suficientes.")
			say("")
		end
		when 20015.take with item.vnum == 29101 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29101, 1)
			 pc.give_item2(29102, 1)
		end
		when 20015.take with item.vnum == 29101 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29101, 1)
			 pc.give_item2(29102, 1)
		end
		when 20015.take with item.vnum == 29102 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29102, 1)
			 pc.give_item2(29103, 1)
		end
		when 20015.take with item.vnum == 29103 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29103, 1)
			 pc.give_item2(29104, 1)
		end
		when 20015.take with item.vnum == 29104 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29104, 1)
			 pc.give_item2(29105, 1)
		end
		when 20015.take with item.vnum == 29105 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29105, 1)
			 pc.give_item2(29106, 1)
		end
		when 20015.take with item.vnum == 29106 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29106, 1)
			 pc.give_item2(29107, 1)
		end
		when 20015.take with item.vnum == 29107 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29107, 1)
			 pc.give_item2(29108, 1)
		end
		when 20015.take with item.vnum == 29108 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29108, 1)
			 pc.give_item2(29109, 1)
		end
		when 20015.take with item.vnum == 29109 and item.get_socket(0) == item.get_value(2) begin
			say_title("Deokbae:")
			say("Fantastico!")
			say("Haz Trabajdo mucho en la Mineria!!")
			say("")
			say_item("Pico", 29110, "")
			say("")
			say_gold("Aqui tienes tu Pico con un nuevo nivel!!")
			pc.remove_item(29109, 1)
			 pc.give_item2(29110, 1)
		end
		when 20047.click or 20048.click or 20049.click or 20050.click or 20051.click or 20052.click or 20053.click or 20054.click or 20055.click or 20056.click or 20057.click or
			 20058.click or 20059.click or 30301.click or 30302.click or 30303.click or 30304.click or 30305.click or 30306.click begin
			if pc.is_mount() != true then
				pc.mining()
			end
		end
	end
end
