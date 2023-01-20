quest TransferSystem begin
	state start begin
		when 60003.chat."Transferir Bonificaciones" begin
			say_title("Theowahdan")
			say("Tranferencia de bonificacion permite intercambiar")
			say("las bonificaciones de los disfrazes, permitiendo")
			say("extender la duracion de las bonificaciones.")
			say_item("Transfigurador", 70065, "")
			say("¿Quieres Transfigurar tu Equipamiento?")
			say("")
			local confirm = select("Transferir", "Cancelar")
			if confirm == 2 then
				return
			end
			setskin(NOWINDOW)
			command("item_comb open_costume")
		end
	end
end
