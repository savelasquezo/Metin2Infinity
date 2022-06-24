quest guild_manage begin
	state start begin
		when 11000.chat."Abandonar Gremio" or 11002.chat."Abandonar Gremio" or 11004.chat."Abandonar Gremio" 
			with pc.hasguild() and not pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			say_title("Alguacil de Batalla:")
			say("Estas seguro de Abandonar el Gremio?")
			say("")
			local s = select("Si", "No")
			if s==1 then
				say_title("Alguacil de Batalla:")
				say("Ok.")
				say("Usted ha Abandonado el Gremio.")
				say("")
				pc.remove_from_guild()
			end
		end
		when 11000.chat."Cerrar Gremio" or 11002.chat."Cerrar Gremio" or 11004.chat."Cerrar Gremio" 
					with pc.hasguild() and pc.isguildmaster() and (pc.is_gm() or npc.empire == pc.empire) begin
			say_title("Alguacil de Batalla:")
			say("Esta seguro que deseas cerrar el Gremio?")
			say("")
			local s = select("Si", "No")
			if s==1 then
				say_title("Alguacil de Batalla:")
				say_reward ( "Has Disuelto el Gremio." )
				pc.destroy_guild()
			end
		end
		when 11000.chat."Crear Gremio" or 11002.chat."Crear Gremio" or 11004.chat."Crear Gremio" with not pc.hasguild() begin
			if pc.hasguild() or pc.isguildmaster() then
				say_title("Alguacil de Batalla:")
				say("Primero deberias abandonar el gremio actual.")
				say("")
				return
			end
			say_title("Alguacil de Batalla:")
			say("Para crear un Gremio, debe ser Minimo nivel 40")
			say("Tendra un costo de 10000 Yang.")
			say("Quieres crear un Gremio?")
			say("")
			local s = select("Si", "No")
			if s == 2 then
				say_title("Alguacil de Batalla:")
				say("Vuelve cuando estes listo.")
				say("")
				return
			end
			if pc.level >= 40 then
				if pc.gold >= 100000 then
					say_title("Alguacil de Batalla:")
					say("Introduce el Nombre del Gremio")
					say("")
					say("")
					say("")
					local guild_name = string.gsub(input(), "[^A-Za-z0-9]", "")
					local guild_len_name = string.len(guild_name)
					say("Confirmacion de Creacion del Gremio?[ENTER]"..guild_name)
					say("")
					local r = select("Crear", "Cancelar")
					if r == 2 then
						say_title("Alguacil de Batalla:")
						say("Regresa cuando estes Listo ")
						say("")
						return
					end
					if not guild_create_item or pc.countitem(guild_create_item)> 0 then
						game.request_make_guild()
					end
				else
					say_title("Alguacil de Batalla:")
					say("No tienes suficiente Yang")
					say("")
					return
				end
			else
				say_title("Alguacil de Batalla:")
				say("No tienes los requisitos ")
				say("para crear un gremio. ")
				say("")
			end
		end
	end
end
