quest reset_status begin
	state start begin
		when 71103.use or 71104.use or 71105.use or 71106.use begin
			local name = { "VIT", "INT", "STR", "DEX" }
			local idx = item.get_vnum() - 71103
			local func = { pc.get_ht, pc.get_iq, pc.get_st, pc.get_dx }
			if func[idx+1]() == 1 then
				syschat("<Scroll> Restauracion de Puntos de Estado.")
				syschat("<Error> "..name[idx+1].." Restarurada")
				return
			end
			say_title("Restablecer Estado:")
			say("El pergamino permite restaurar los puntos de estado")
			say("invertidos en el entrenamiento de los atributos.")
			say("Atributo: "..name[idx+1].." ")
			say_reward("¿Realmente quieres reiniciar el Atributo "..name[idx+1].." ?")
			say("")
			local s = select("Restablecer", "Cancelar")
			if s == 1 then
				if pc.reset_status( idx ) == true then
					say_title("Restablecer Estado:")
					say_reward(""..name[idx+1].." Restablecida!")
					say("")
					pc.remove_item(item.get_vnum())
				else
					say_title("Restablecer Estado:")
					say_reward("El restablecimiento de estado fue cancelado.")
					say("")
				end
			end
		end
	end
end
