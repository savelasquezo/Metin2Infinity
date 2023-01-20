quest FortuneTelling begin
	state start begin
		when 9006."Adivina la Fortuna" begin
			if get_time()-pc.getqf("time") < 8*60*60 then
				local passed_time = get_time() - pc.getqf("time")
				say_title("Anciana:")
				say("")
				say("Vive tu vida como un adivino")
				say("¿Quieres? Tomando su dicho muy en serio.")
				say("Lo importante")
				say("pensamientos y expresión facial,")
				say("Si ambos son buenos, no te pasa nada..")
				say("Si todavía quieres que tu fortuna se vea ")
				say("vuelve mañana.")
				say("")
				wait()
				local idx = pc.getqf("idx")
				if idx!=0 then
					say_title("Anciana:")
					say("Como dije, mi profecía sobre hoy es la siguiente::")
					say(locale.fortune_words[idx][1])
					wait()
					if pc.getqf("talisman") == 0 and special.fortune_telling[idx][5] > 0 then
						local talisman_cost = special.fortune_telling[idx][5]
						wait()
						say_title("Anciana:")
						say("")
						say("Vas a ser desenfrenado, y tu")
						say("no compraste el amuleto")
						say("tomar")
						say("Tu quieres")
						local s = select("Aceptar","Cancelar")
						if s == 1 then
							if pc.gold < talisman_cost then
								say_title("Anciana:")
								say("")
								say("Soy un buen tipo, pero no puedo darte el amuleto.")
								say("Si quieres protegerte de la mala suerte.")
								say("Dame dinero")
								say("")
								say("")
								pc.setqf("talisman", 0)
							else
								pc.give_item2(70052,1)
								pc.changegold(-talisman_cost)
								pc.setqf("talisman", 1)
							end
						else
						end
					end
				end
			end
			local gold = 7777
			say_title("Anciana:")
			say("")
			say("Eres demasiado joven para gemir tan profundo!")
			say("¿Te gustaría tener tu fortuna tomada?")
			say("")
			local s = select("Dime mi destino")
			if s == 2 then
			say_title("Anciana:")
			say("")
			say("Derecho. Lo más importante en la vida.")
			say("Ser capaz de hacer y de la manera correcta. discutir ")
			say("en!")
			return
			end
			say_title("Anciana:")
			local n = number(1, 10000)
			local i
			local idx
			for i = 1, table.getn(special.fortune_telling) do
				if n<=special.fortune_telling[i][1] then
					idx = i
					break
				else
					n = n - special.fortune_telling[i][1]
				end
			end
			i = idx
			say(locale.fortune_words[i][2])
			local t = {}
			n = 0
			local j
			for j = 2,4 do
				if special.fortune_telling[i][j] != 0 then
					n=n+1
					t[n] = j
				end
			end
			if n > 0 then
				n = number(1, n)
				__give_char_priv(t[n]-1, special.fortune_telling[i][t[n]])
			end
			pc.setqf("time", get_time())
			pc.setqf("idx", i)
			if special.fortune_telling[i][5]>0 then
				wait()
				say(locale.fortune_words[i][3])
				local talisman_cost = special.fortune_telling[i][5]
				local s = select("Evet,bir tane istiyorum.","Hayýr, saðol.")
				if s == 1 then
					say_title("Yaþlý kadýn:")
					if pc.gold < talisman_cost then
						say("Soy una buena persona, pero no puedo darte el amuleto.")
						say("si quieres estar protegido de la mala suerte")
						say("yo su")
						say(" dar dinero a.")
						say("")
						say("precio "..gold.." Yang.")
						say("")
						pc.setqf("talisman", 0)
					else
						pc.give_item2(70052,1)
						pc.changegold(-talisman_cost)
						pc.setqf("talisman", 1)
					end
				elseif s == 2 then
					say_title("Anciana:")
					say("")
					say("Te estas yendo Tal vez tienes razón.  ")
					say("Es una parte de la vida triste.")
					say("Nos vemos pronto si cambias tu decisión,")
					say("entonces ven otra vez.")
					pc.setqf("talisman", 0)
				end
			end
		end
	end
end

