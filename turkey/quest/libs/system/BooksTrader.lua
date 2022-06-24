quest BooksTrader begin
	state start begin
		function get_input(func)
			cmdchat("bk_trade_sys block 0")
			local input = input(cmdchat(func))
			cmdchat("bk_trade_sys break 0")
			if input == "" or string.find(string.lower(input), "nan") or string.find(string.lower(input), "nil") then
				return 0
			else
				return tostring(input)
			end
		end
		function checkflagoverflow()
			if pc.getqf("bk_count") > 3 or pc.getqf("bk_count") < 0 then
				pc.setqf("bk_count", 0)
			end
		end
		function split(command_, x)
			return BooksTrader.split_(command_,x)
		end
		function split_(string_,delimiter)
			local result = { }
			local from  = 1
			local delim_from, delim_to = string.find( string_, delimiter, from  )
			while delim_from do
				table.insert( result, string.sub( string_, from , delim_from-1 ) )
				from  = delim_to + 1
				delim_from, delim_to = string.find( string_, delimiter, from  )
			end
			table.insert( result, string.sub( string_, from  ) )
			return result
		end
		function give_new_book(sock)
			local skill_list = special.active_skill_list[pc.get_job()+1][pc.get_skill_group()]
			if pc.get_money() < 100000 then
				syschat("<BooksTrader> Yang Insuficiente. Necesitas Minimo 100000 Yang ")
				return
			end
			pc.change_gold(-100000)
			pc.give_item2_select(50300)
			item.set_socket(0, skill_list[sock])
			pc.setqf("bk_count", 0)
			return
		end
		when login begin
			cmdchat("bk_trade_sys qid "..q.getcurrentquestindex())
		end
		when button or info begin
			data = BooksTrader.get_input("bk_trade_sys get 0")
			local _, count = string.gsub(data, "|", "")
			if count < 2 or count > 3 then
				syschat("<BooksTrader> Contenido Inadecuado")
				return
			end
			if pc.get_money() < 100000 then
				syschat("<BooksTrader> Yang Insuficiente. Necesitas Minimo 100000 Yang ")
				return
			end
			if pc.count_item(50300) < 3 then
				syschat("<BooksTrader> Manuales de Habilidad Insuficientes.")
				return
			end
			if pc.get_skill_group() == 0 then
				syschat("<BooksTrader> Eres Demasiado Joven, Elige una Doctrina de Habilidades.")
				return
			end
			BooksTrader.checkflagoverflow()
			splitData = BooksTrader.split(data, '|')
			for i = 1, 3 do
				if splitData[i] == "" or string.find(string.lower(splitData[i]), "nan") or string.find(string.lower(splitData[i]), "nil") then
					syschat("<BooksTrader-1> Error Desconocido. póngase en contacto con el Administrado del Juego")
					return
				end
				if tonumber(splitData[i]) > 450 or tonumber(splitData[i]) < 0 then
					syschat("<BooksTrader-2> Error Desconocido. póngase en contacto con el Administrado del Juego")
					return
				end
				item.select_cell(splitData[i])
				if not item.get_id() or item.get_id() == 0 then
					syschat("<BooksTrader-2> Articulo no Encontrado!" ..splitData[i])
					return
				end
				if tostring(item.get_vnum()) != tostring(50300) then
					syschat("<BooksTrader-3> Error Desconocido. póngase en contacto con el Administrado del Juego")
					return
				end
				if tostring(item.get_count()) != tostring(1) then
					syschat("<BooksTrader-4> Error Desconocido. póngase en contacto con el Administrado del Juego")
					return
				end
				pc.setqf("bk_count", pc.getqf("bk_count") + 1)
				item.remove()
			end
			if pc.getqf("bk_count") == 3 then
				BooksTrader.give_new_book(number(1,7))
				return
			else
				syschat("<BooksTrader> Manuales de Habilidad Insuficientes!")
				return
			end
		end
		when 20023.chat."Intercambiar Manuales" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Oh, aventurero. El mundo esta lleno de problemas")
			say("y solo a traves de la sabiduria puedes sobrevivir")
			say("He dedicado toda mi vida a los libros, memorizando")
			say("cada una de las palabras que alli se encuentran")
			say("he alcanzado un nivel increible de habilidad.")
			say_item("Manual Habilidad", 50300, "")
			say("")
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Erudito de los manuales y las doctrinas de lucha")
			say("lo se todo en cuanto a manuales de habilidad.")
			say("Traeme manuales de habilidad y te los intercambiare")
			say("Unicamente cobro una comicion de 100.000 Yang")
			say("¿Quieres Intercambiar Manuales de Habilidad?")
			say("")
			local a = select ( "Intercambiar" , "Cancelar" )
			if a == 1 then
				setskin(NOWINDOW)
				cmdchat("bk_trade_sys open 0")
			elseif a == 2 then
				say_title("Soon:")
				say("Vuelve, Cuando estes listo.")
				say("")
				return
			end
		end
	end
end
