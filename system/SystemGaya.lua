quest SystemGaya begin
	state start begin
		when 20504.chat."Artesanias Gaya" begin
			say_title("Altar Gaya:")
			say("Las Gemas Gayas tienen el poder de absorber poder")
			say("demoniaco de las piedras metin, usando la gemas")
			say("creare unas poderosas joyas.")
			say("Unicamente necesito una piedras espirituales")
			say("cualquier piedra +0 +1 +2 +3")
			say_item(" ", 50926, "")
			say("Usando 10 Gayas podre fabricar las Joyas")
			say("El proceso es complicado y puede fallar.")
			say("")
			local option = select("Intercambiar","Transmutar","Cancelar ")
			if option == 3 then
				return
			elseif option == 1 then
				setskin(NOWINDOW)
				game.open_gaya_market()
			elseif option == 2 then
				setskin(NOWINDOW)
				 game.open_gaya()
			end
		end
	end
end
