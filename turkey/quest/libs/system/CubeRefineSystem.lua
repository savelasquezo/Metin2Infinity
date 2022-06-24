quest CubeRefineSystem begin
	state start begin
		when 20383.chat."Armamento Runico" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Jae-Seon Kim~")
			say("")
			say("Bienvenido Novato! Como puedes ver soy un")
			say("herrero EXPERTO! Nunca fallo a la hora de forjar.")
			say("soy el herrero mas experto en la creacion ")
			say("Si me traes los materiales indicados podre crear")
			say("para ti un impresionante Armamento.")
			say("")
			say("Quieres fabricar algun equipamiento?")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Jae-Seon Kim~")
				say("Entonces, no me hagas perder el tiempo.")
				say("")
				return
			end
		end
		when 20017.chat."Creacion de Cinturones" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Yu-Hwan~")
			say("")
			say("Desde la destruccion metin, las cosas han cambiado")
			say("mucho, tenemos que aumentar nuestra fuerza, para")
			say("hacer frente a esta devastacion.")
			say("he descubierto que con lo materiales adecuados")
			say("se pueden crear poderosos accesorios.")
			say("Trae los materiales indicados.")
			say("Fabricare para ti un poderoso cinturon.")
			say("")
			say("Quieres fabricar algun Cinturon?")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Yu-Hwan~")
				say("MMM entiendo tal vez es mucho para ti.")
				say("")
				return
			end
		end
								when 20018.chat."Haz las Pociones" begin
									raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
									say_yellow("~Baek-Go~")
									say("")
									say("Hola, Soy el doctor Baek-Go. Especialista en la")
									say("creacion de toca clase de rocios y pociones, toda")
									say("hierba tiene un poder oculto y solo yo se como")
									say("extraer todo su potencial.")
									say("Quieres fabricar pociones?")
									say("")
									local a = select ( "Si" , "No" )
									if a == 1 then
										command("cube open")
									elseif a == 2 then
										raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
										say_yellow("~Baek-Go~")
										say("Vuelve, Cuando estes listo.")
										say("")
										return
									end
								end
		when 40005.chat."Crafteo Especial" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Creador Especial~")
			say("")
			say("Bienvenido")
			say("Aqui podras adquirir items especiales ")
			say("Para mejorar tu experician como jugador ")
			say("Recuerda que su valor comercial es bastante elevado ")
			say("Quieres Crear alguno de estos items?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Creador Especial~")
				say("haha!!, igual sabia que no podrias.")
				say("")
				return
			end
		end
		when 20381.chat."Creador de Armaduras" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Confucio~")
			say("")
			say("Bienvenido Joven Viajero")
			say("Yo soy el encargado de crear las armaduras ")
			say("Con las que podras enfrentar a las criaturas ")
			say("Que habitan estas tieras. ")
			say("Te interesa crear alguna?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Confucio~")
				say("Vuelve cuando estes preparado.")
				say("")
				return
			end
		end
		when 20438.chat."Piedras Especiales" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Monje~")
			say("")
			say("Bienvenido, espero estes muy bien!")
			say("Yo soy el encargado de crear las piedras ")
			say("Mas hermosas y poderosas de este mundo ")
			say("Con ellas podras vencer a quien sea. ")
			say("Quieres crear alguna?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Monje~")
				say("Es un proceso muy complicado, todo a su tiempo.")
				say("")
				return
			end
		end
		when 40033.chat."Equipo PvP" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Lilith~")
			say("")
			say("Bienvenido Humano!!")
			say("Yo soy una ex comandante de los demonios ")
			say("Mas poderosos de este mundo y de otros, ")
			say("Tal ves hayas escuchado del mitico Lord Yandrack ")
			say("Pues el era mi rey, y lo traicione por su gran ")
			say("Crueldad y ambicion, asi que te ayudare con la creacion ")
			say("De nuevo equipo para que seas mas fuerte. ")
			say("Deseas Crear Alguno?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Lilith~")
				say("Entiendo, Los materiales no son nada faciles.")
				say("")
				return
			end
		end
		when 40050.chat."Guerra Lamda!" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow("~Ascendido Serpiente~")
			say("")
			say("Bienvenido Humano!!")
			say("Yo soy un guerrero que logro controlar el gran ")
			say("Poder de la diosa de las serpientes, ")
			say("Con este poder pienso darte todo mi conocimiento ")
			say("En creacion de equipos y herramientas que te van ")
			say("A volver un ser increiblemente fuerte, tanto")
			say("Que seras temido en los dos reinos!. ")
			say("Deseas Crear Alguno?.")
			say("")
			local a = select ( "Si" , "No" )
			if a == 1 then
				command("cube open")
			elseif a == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Ascendido Serpiente~")
				say("Entiendo, Los materiales no son nada faciles.")
				say("")
				return
			end
		end
	end
end
