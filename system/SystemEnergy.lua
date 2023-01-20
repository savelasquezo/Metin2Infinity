quest SystemEnergy begin
	state start begin
		when 20001.chat."Cristal de Energia" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.get_level ( ) < 35 then
				say("Aun eres muy Joven para este poder.")
				say("Vuelve cuando seas Nivel 35 o Superior.")
				say("")
				return
			end
			if pc.count_item ( 51001 ) < 100 then
				say ("No tienes suficientes Fragmento de Energia.")
				say_item("Fragmento de Energia" , 51001 ,"") 
				say("Consigue 100 de estos Fragmentos, Usare mi tecnica")
				say("para fabricarte un poderoso Articulo.")
				say("")
				return
			end
			say("Quieres Forjar los Fragmentos de Energia?")
			say("Recibiras un Cristal de Energia.")
			say_item ( "Cristal de Energia" , 51002 , "")
			say("Necesitas 100 Fragmentos de Energia & 30000 Yang")
			say_gold("¡El Refinamiento puede Fallar!")
			say("")
			if select ( "Continuar" , "Cancelar" ) == 1 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("¡Ingresa la cantidad de Cristales a Fabricar!")
				say("Necesitas 100 Fragmentos de Energia & 30000 Yang")
				local inp = math.floor(tonumber(input()))
				if inp <= 0 or inp == nil or string.find(inp, "nan") or string.find(inp, "NaN") or string.find(inp, "naN") or string.find(inp, "nAN") or string.find(inp, "NAN") or string.find(inp, "Nan") or string.find(inp, "NAn") or string.find(inp, "nAn") then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("!Ingrese un Valor Correcto!")
					say("")
					return
				end
				if pc.get_gold() < 30000*inp then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("¡Yang Insuficiente!")
					say("")
					return
				end
				if pc.count_item(51001) < 100*inp then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say("")
					say("¡Materiales Insuficientes!")
					say("")
					return
				end
				pc.change_gold (-30000*inp)
				pc.remove_item (51001 , 100*inp)
				for i = 1, inp do
					if number (1,100) > 55 then
						pc.give_item2(51002,1)
						syschat("Fantastico! El Cristal de Energia ha sido Fabricado!")
					end
				end
			end
		end
		when 20001.chat."Fragmentar Energia" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.get_level( ) < 30 then 
				say("Aun eres muy Joven para este poder")
				say("Vuelve cuando seas Nivel 30 o Superior.")
				say("")
				return
			end
			say("Lo he creado! Finalmente,he podido desarrollar")
			say("una tecnica nueva.")
			say("He conseguido transformar objetos y conseguir")
			say("Energia pura de ellos.  Es realmente Asombroso!")
			wait( )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Destruye objetos con la ayuda de mi tecnica") 
			say("Recibiras un Fragmento de Energia.") 
			say_item("Fragmento de Energia" , 51001 ,"") 
			say("Consigue 100 de estos Fragmentos, Usare mi tecnica")
			say("para fabricarte un poderoso Articulo.")
			say("Seras invencible!")
		end
		when 20001.take begin
			local ItemVnum = item.get_vnum()
			local LevelLimit = item.get_level_limit(ItemVnum)
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if LevelLimit == nil or LevelLimit < 55 then
				say("¡Imposible!")
				say("La Fragmentacion de energia requiere objetos")
				say("podersos, estos objetos no tienen potencial")
				say_item(item_name(ItemVnum), ItemVnum ,"") 
				say("¡Nivel de Energia Insuficiente!")
				say("Traeme objetos de Nivel 55 o Superior")
				say("")
				return
			elseif item.get_type() != ITEM_WEAPON and item.get_type() != ITEM_ARMOR then
				say("¡Imposible Extraer Energia!")
				say("La Fragmentacion de energia requiere objetos")
				say("podersos, estos objetos no tienen potencial")
				say_item(item_name(ItemVnum), ItemVnum ,"") 
				say("¡Objeto Invalido!")
				say("Traeme objetos de Nivel 55 o Superior")
				say("")
				return
			else
				local LevelLimitMin = item.get_level_limit(ItemVnum)/2
				local LevelLimitMax = item.get_level_limit(ItemVnum)*1
				say("¡Perfecto!")
				say(""..item_name(ItemVnum).."")
				say("Este objeto es perfecto para Extraer Energia")
				say("Aplicandomi tecnica puedro extraer Energia")
				say_item(item_name(ItemVnum), ItemVnum ,"") 
				say_white("Fragmento de Energia")
				say_white(""..LevelLimitMin .." - "..LevelLimitMax.."")
				say("")
				say_gold("¿Queres Fragmentar "..item_name(ItemVnum).."?")
				say("")
				say("")
				say("")
				if select("Fragmentar","Cancelar") == 1 then
					if pc.count_item(ItemVnum) == 0 then
						return
					end
					item.remove()
					pc.give_item2(51001, number(LevelLimitMin,LevelLimitMax))
				end
			end
		end
	end
end
