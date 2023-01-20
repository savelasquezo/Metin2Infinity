quest WoN begin
	state start begin
		when 9005.chat."WoN" begin
			local wones_en_yang = 100000000
			local max_gold = 1999999999
			local max_won = 200
			say_title("Banco General:")
			say("¡Veo que estas interesado en el cambio de divisas!")
			say("Funciona muy bien porque puedes intercambiar")
			say("Yang & Won")
			say("")
			local menu = select("Comprar", "Vender", "Cancelar")
			local actual = pc.get_cheque()
			if menu == 3 then
				return
			elseif menu == 1 then
				say_title("Banco General:")
				say_title("Ingrese la Cantidad de WoN")
				say_gold("Won = 100.000.000 Yang.")
				local inp = math.floor(tonumber(input()))
				if inp <= 0 or inp == nil or string.find(inp, "nan") or string.find(inp, "NaN") or string.find(inp, "naN") or string.find(inp, "nAN") or string.find(inp, "NAN") or string.find(inp, "Nan") or string.find(inp, "NAn") or string.find(inp, "nAn") then
					say_title("Banco General:")
					say("!Ingrese un Valor Correcto!")
					say("")
					return
				end
				if inp <= 0 then
					return
				else
					if pc.get_cheque() + inp > max_won then
						say_title("Banco General:")
						say("!Actualmente posees una gran cantidad de WoN!")
						say("Lo siento pero tienes demasiados Won")
						say("")
						say_title("~Maximo WoN~")
						say_gold(""..max_won.."")
						say("")
						return
					else
						local res_yang = pc.get_gold() + inp * wones_en_yang
						if pc.get_gold() - inp * wones_en_yang > 0 then
							pc.change_gold(-inp * wones_en_yang)
							pc.change_cheque(inp)
							mysql_direct_query("UPDATE player.player SET cheque = "..pc.get_cheque().." WHERE id = "..pc.get_player_id()..";")
							mysql_direct_query("INSERT INTO account.logs_cheque (pid,amount,type,date) VALUES ("..pc.get_player_id()..","..inp..",'BUY','"..os.date("%Y-%m-%d %H:%M:%S").."');")
						else
							say_title("Banco General:")
							say("!Yang Insuficiente!")
							say("Actualmente no posees suficiente Yang")
							say("")
							return
						end
					end
				end
			elseif menu == 2 then
				say_title("Banco General:")
				say_title("Ingrese la Cantidad de WoN a Vender")
				say_gold("Won = 100.000.000 Yang.")
				local inp = math.floor(tonumber(input()))
				if inp <= 0 or inp == nil or string.find(inp, "nan") or string.find(inp, "NaN") or string.find(inp, "naN") or string.find(inp, "nAN") or string.find(inp, "NAN") or string.find(inp, "Nan") or string.find(inp, "NAn") or string.find(inp, "nAn") then
					say_title("Banco General:")
					say("!Ingrese un Valor Correcto!")
					say("")
					return
				end
				if inp <= 0 then
					return
				else
					if pc.get_cheque() >= inp then
						local new_yang = pc.get_gold() + inp * wones_en_yang
						if new_yang >= max_gold then
						say_title("Banco General:")
						say("!Actualmente posees una gran cantidad de Yang!")
						say("Lo siento pero tienes demasiados Yang")
						say("")
						say_title("~Maximo Yang~")
						say_gold(""..max_gold.."")
						say("")
						return
						else
							pc.change_gold(inp * wones_en_yang)
							pc.change_cheque(-inp)
							mysql_direct_query("UPDATE player.player SET cheque = "..pc.get_cheque().." WHERE id = "..pc.get_player_id()..";")
							mysql_direct_query("INSERT INTO account.logs_cheque (pid,amount,type,date) VALUES ("..pc.get_player_id()..","..inp..",'SELL','"..os.date("%Y-%m-%d %H:%M:%S").."');")
						end
					else
						say_title("Banco General:")
						say("!WoN Insuficiente!")
						say("Actualmente no posees suficiente WoN")
						say("")
						return
					end
				end
			end
		end
	end
end
