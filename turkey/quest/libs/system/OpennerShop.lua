quest OpennerShop begin
	state start begin
		when 40005.chat."Tiendas de Mazmorras" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Vendedor de Mazmorras~")
			say("")
			say("Bienvenido")
			say("Soy el encargado de cambiar los tickets de ")
			say("Las mazmorras por valiosas recompesas")
			say("Acontinuacion selecciona la mazmorra a la")
			say("Cual deseas ver sus recompensas.")
			say("")
			local r1 = select("Slime", "Minotauro", "Reaper", "Baronesa" , "Azrael", "Siguiente")
			if r1 == 1 then
				npc.open_shop(12)
			end
			if r1 == 2 then
				npc.open_shop(11)
			end
			if r1 == 3 then
				npc.open_shop(2)
			end
			if r1== 4 then
				npc.open_shop(4)
			end
			if r1 == 5 then
				npc.open_shop(3)
			end
			if r1 == 6 then
				local r2 = select("Beran", "Razador", "Nemere", "Jotun", "Hidra", "Meley", "Dragon Definitivo","Piramide Kefren", "Cueva Serpent", "Cancelar")
				if r2 == 1 then
					npc.open_shop(5)
				end
				if r2 == 2 then
					npc.open_shop(6)
				end
				if r2 == 3 then
					npc.open_shop(7)
				end
				if r2 == 4 then
					npc.open_shop(8)
				end
				if r2 == 5 then
					npc.open_shop(9)
				end
				if r2 == 6 then
					npc.open_shop(10)
				end
				if r2 == 7 then
					npc.open_shop(13)
				end
				if r2 == 8 then
					npc.open_shop(30)
				end
				if r2 == 9 then
					npc.open_shop(43)
				end
			end
			if r1 == 9 then
				return
			end
		end
		when 40005.chat."Tienda de Llaves" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Vendedor de LLaves~")
			say("")
			say("Bienvenido")
			say("Yo tambien soy el encargado de crear")
			say("Los Sellos que te daran paso a las ")
			say("Mazmorras mas peligrosas y desafiantes.")
			say("Deseas crear alguna de estas?")
			say("")
			local r = select("Crear!!", "Cancelar")
			if r == 1 then
				npc.open_shop(14)
			end
			if r == 2 then
				return
			end
		end
		when 40005.chat."Tienda General" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Tienda General~")
			say("")
			say("Bienvenido")
			say("Aqui podras comprar objetos utiles,")
			say("Que te serviran antes de ingresar ")
			say("A las mazmorras o los mapas mas ostiles.")
			say("Quieres Comprar Alguno?")
			say("")
			local r = select("Comprar", "Cancelar")
			if r == 1 then
				npc.open_shop(1)
			end
			if r == 2 then
				return
			end
		end
		when 20015.chat."Tienda de Minerales" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~DeokBae~")
			say("")
			say("Bienvenido")
			say("Yo soy el encargado de vender")
			say("Todos los refinados apartir de minerales ")
			say("Para que tus accesorios sean mas poderosos.")
			say("Deseas crear alguno?")
			say("")
			local r = select("Comprar", "Cancelar")
			if r == 1 then
				npc.open_shop(23)
			end
			if r == 2 then
				return
			end
		end
		when 9009.chat."Tienda del Pescador" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Pescador~")
			say("")
			say("Bienvenido")
			say("Yo soy el encargado de vender")
			say("Todos lo necesario para pescar ")
			say("Con esto conseguiras items especiales.")
			say("Deseas comprar alguno?")
			say("")
			local r = select("Comprar", "Cancelar")
			if r == 1 then
				npc.open_shop(24)
			end
			if r == 2 then
				return
			end
		end
		when 20010.chat."Tienda de Boda" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Peddler~")
			say("")
			say("Bienvenido")
			say("Yo soy el encargado de vender")
			say("Todos los elementos para tu boda ")
			say("Y con esto podras unirte en cuerpo y alma.")
			say("Deseas comprar alguno?")
			say("")
			local r = select("Comprar!", "Cancelar")
			if r == 1 then
				npc.open_shop(25)
			end
			if r == 2 then
				return
			end
		end
		when 20451.chat."Tienda de Sellos" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Tienda Zodiacal~")
			say("")
			say("Bienvenido")
			say("Aqui podras comprar todo lo relacionado")
			say("Con los sellos y insignas de los  ")
			say("Legendarios Zodiacales.")
			say("Deseas comprar alguna de estas?")
			say("")
			local r = select("Crear!!", "Cancelar")
			if r == 1 then
				npc.open_shop(28)
			end
			if r == 2 then
				return
			end
		end
		when 20451.chat."Tienda de Libros" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Tienda Zodiacal~")
			say("")
			say("Bienvenido")
			say("Aqui podras comprar todo lo relacionado")
			say("Con los libros y mejoras  ")
			say("Para tu mascota.")
			say("Deseas comprar alguna de estos?")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(29)
			end
			if r == 2 then
				return
			end
		end
		when 40017.chat."Armaduras PVP" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Armaduras PVP~")
			say("")
			say("Armaduras")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(32)
			end
			if r == 2 then
				return
			end
		end
		when 40017.chat."Armas PVP" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Armas PVP~")
			say("")
			say("Armas")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(33)
			end
			if r == 2 then
				return
			end
		end
		when 40017.chat."Accesorios PVP" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Accesorios PVP~")
			say("")
			say("Accesorios")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(34)
			end
			if r == 2 then
				return
			end
		end
		when 40017.chat."General PVP" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~General PVP~")
			say("")
			say("Tienda General PVP")
			say("")
			local r = select("Comprar!!", "Cancelar")
			if r == 1 then
				npc.open_shop(35)
			end
			if r == 2 then
				return
			end
		end
		when 60003.chat."Tienda Estolas" begin	
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Teovahdan~")
			say("")
			say("Hola Aventurero")
			say("Yo puedo crear estolas ademas de combinarlas ")
			say("y añadirle bonos, con los materiales indicados!.")
			say("Deseas Crear Alguna?")
			say("")
			local r = select("Crear!!", "Cancelar")
			if r == 1 then
				npc.open_shop(31)
			end
			if r == 2 then
				return
			end
		end
	end
end
