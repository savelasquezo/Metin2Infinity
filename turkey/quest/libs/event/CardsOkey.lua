quest CardsOkey begin
	state start begin
		when 20417.chat."GM: Evento Cartas Okey" with pc.is_gm() begin
			say_title("Evento Cartas Okey ->Panel GM")
			say("Hola "..pc.get_name().." Seleccione la Accion a Realizar.")
			if game.get_event_flag("EventCardsOkey") == 0 then
				local a = select ( "Activar" , "Cancelar" )
				if a == 1 then
					say_title("Evento Cartas Okey ->Panel GM")
					say("Seleccione la Duracion del Evento -Horas-")
					local tiempo = math.floor(tonumber(input()))
					say_title("Evento Cartas Okey ->Panel GM")
					say("Activar Evento Cartas Okey durante "..tiempo.." Horas")
					local b = select("Confirmar","Cancelar")
					if b == 1 then
						server_timer("TimeEventCardsOkey1",tiempo*60*60)
						game.set_event_flag("EventCardsOkey",1)
						game.set_event_flag("EventCardsOkeyProb",10)
						notice_all("<Evento> El Evento Cartas Okey Ha Comenzado.")
						notice_all("<Evento> Duracion: "..tiempo.." Horas")
					else
						return
					end
				end
			else
				local a = select ( "Finalizar" , "Modificar" , "Cancelar")
				if a == 3 then
					return
				elseif a == 1 then
					game.set_event_flag("EventCardsOkey",0)
					clear_server_timer('TimeEventCardsOkey1', get_server_timer_arg())
				elseif a == 2 then
					say_title("Evento Cartas Okey ->Panel GM")
					say("Introduzca la Probabilidad de Drop")
					say("Estandar 10/1000")
					local prob = math.floor(tonumber(input()))
					if prob >= 50 then
						say_title("Evento Cartas Okey ->Panel GM")
						say("¡El valor es demasiado Alto!")
						return
					end
					say_title("Evento Cartas Okey ->Panel GM")
					say("Modificar la Probabilidad a "..prob.."/1000")
					if select("Confirmar","Cancelar") == 1 then
						game.set_event_flag("EventCardsOkeyProb",prob)
						syschat("<Evento> La Probabilidad de Drop ha Aumentado!")
					end
				end
			end
		end
		when 20417.chat."Cartas Okey" with game.get_event_flag("EventCardsOkey") == 1 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡El Evento Cartas Okey esta Activado!")
			say("Elimina monstruos cercanos a tu nivel")
			say("recoleta las cartas okey")
			say("")
			say_item_vnum(79505)
			say("¡Entregame 24 Cartas y te entregare un SetOkey")
			say("Usa los SetOkey para participar en el Minijuego")
			say("")
		end
		when 20417.take with game.get_event_flag("EventCardsOkey") == 1 begin
			if pc.count_item(79505) >= 25 then
				pc.remove_item(79505, 25)
				pc.give_item2(79506)
			end
		end
		when TimeEventCardsOkey1.server_timer begin
			server_timer("TimeEventCardsOkey2",10*60)
			notice_all("<Evento>El Evento Cartas Okey Finalizara en 10 Minutos!")
		end
		when TimeEventCardsOkey2.server_timer begin
			game.set_event_flag("EventCardsOkey",0)
			notice_all("<Evento> El Evento Cartas Okey Ha Finalizado.")
		end
		when login with game.get_event_flag("EventCardsOkey") == 1 begin
			if pc.get_level ( ) < 15 then
				return 
			end
			syschat("<Evento Cajas Cartas Okey>")
			syschat("El Evento Cartas Okey se encuentra <Activado>")
		end
		when kill with game.get_event_flag("EventCardsOkey") == 1 begin
			if npc.is_pc() or npc.get_level() < 15 then
				return 
			end
			if number(1,1000) <= game.get_event_flag("EventCardsOkeyProb") then
				local limit = 30
				local minrang = pc.get_level() - limit
				if npc.get_level() >= minrang then
					game.drop_item_with_ownership(79505, 1)
					syschat("<Evento> Has encontrado una Carta Okey!")
				end
			end
		end
		when 71196.use begin --Bronce
			value = math.random(11,13)
			mysql_direct_query ( "UPDATE account.account SET coins = coins + " .. value .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("El Cofre de Bronce Okey contenia (" .. value .. ") MDs" )
			pc.changegold(math.random(10,25)*1000000)
			pc.give_item2_select(51503,10)
			pc.remove_item("71196", 1)
		end
		when 71195.use begin --Plata
			value = math.random(15,17)
			mysql_direct_query ( "UPDATE account.account SET coins = coins + " .. value .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("El Cofre de Plata Okey contenia (" .. value .. ") MDs" )
			pc.changegold(math.random(35,55)*1000000)
			pc.give_item2_select(51541,10)
			pc.remove_item("71195", 1)
		end
		when 71194.use begin --Dorado
			value = math.random(19,23)
			mysql_direct_query ( "UPDATE account.account SET coins = coins + " .. value .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )
			syschat("El Cofre de Oro Okey contenia (" .. value .. ") MDs" )
			pc.changegold(math.random(75,95)*1000000)
			pc.give_item2_select(51562,10)
			pc.remove_item("71194", 1)
		end
	end
end
