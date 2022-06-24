quest SashSystem begin
	state start begin
		when 60003.chat."Sistema de Estolas" begin
			say_title("Theowahdan:")
			say("Las Estolas son una pieza de equipo visible")
			say("pueden absorber bonus de Armas y Armaduras.")
			say("El porcentaje de absorcion depende del grado")
			say("de calidad de la Estola.")
			say_item(" ", 85024, "")
			say("La Estola te ofrece dos posibilidades")
			say("Combinacion & Absorcion.")
			say("")
			wait()
			say_title("Theowahdan:")
			say("La combinacion solo se da entre Estolas del mismo")
			say("grado. Al combinar dos Estolas se obtine una")
			say("Estola de mejor calidad.")
			say("")
			say("La absorcion permite obtener bonificaciones de")
			say("armas y armaduras y traspasarselos a la Estola con")
			say("diferentes valores porcentuales.")
			say("")
			say("El grado de absorcion (%) depende del grado de la")
			say("Estola. Al absorber bonificaciones, el arma o")
			say("armadura seleccionada quedara destruida.")
			say("")
		end
		when 60003.chat."Absorcion de Bonificaciones" begin
			say_title("Theowahdan")
			say("La absorcion permite obtener bonificaciones de")
			say("armas y armaduras y traspasarselos a la Estola con")
			say("diferentes valores porcentuales.")
			say("Quieres Absorber Bonificaciones?")
			say("")
			local confirm = select("Si", "No")
			if confirm == 2 then
				return
			end
			setskin(NOWINDOW)
			pc.open_sash(false)
		end
		when 60003.chat."Combinacion" begin
			say_title("Theowahdan")
			say("La combinacion solo se da entre Estolas del mismo")
			say("grado. Al combinar dos Estolas se obtine una")
			say("Estola de mejor calidad.")
			say("Quieres Combinar dos Estolas?")
			say("")
			local confirm = select("Si", "No")
			if confirm == 2 then
				return
			end
			setskin(NOWINDOW)
			pc.open_sash(true)
		end
	end
end
