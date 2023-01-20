quest guild_building_npc begin
	state start begin
		when 20044.click begin
			if npc.get_guild() == pc.get_guild() then
				say_title("Herrero de Armas:")
				say("Ah! Tu eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("Ademas, tendras un descuento del 5%")
				say("")
			else
				say_title("Herrero de Armas:")
				say("Ah! Tu NO eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("No tendras descuento.")
				say("")
			end
		end
		when 20045.click begin
			if npc.get_guild() == pc.get_guild() then
				say_title("Herrero de Armaduras:")
				say("Ah! Tu eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("Ademas, tendras un descuento del 5%")
				say("")
			else
				say_title("Herrero de Armaduras:")
				say("Ah! Tu NO eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("No tendras descuento.")
				say("")
			end
		end
		when 20046.click begin
			if npc.get_guild() == pc.get_guild() then
				say_title("Herrero de Accesorios:")
				say("Ah! Tu eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("Ademas, tendras un descuento del 5%")
				say("")
			else
				say_title("Herrero de Accesorios:")
				say("Ah! Tu NO eres un miembro de mi gremio!")
				say("Mi probabilidad de exito es mayor en un 10%")
				say("No tendras descuento.")
				say("")
			end
		end
	end
end
