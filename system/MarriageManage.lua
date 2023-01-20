quest MarriageManage begin
	state start begin
		when 9006.chat."Quiero Casarme" with not pc.is_engaged_or_married() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if not npc.lock() then
				say("Eneste momento no esta disponible la opcion")
				say("Regresa en unos momentos.")
				say("")
				return
			end
			if pc.level < 30 then
				say("Son demasiado Jovenes para Casarlos.")
				say("El Matrimonio implica muchas responsabilidades")
				say("y no estan preparados todavia.")
				say("La gente joven se divorcia muy rapido.")
				say("No dare mi aprobacion a esto.")
				say("Solo es posible casarse una vez se ha")
				say("Alcanzado el Nivel 30.")
				say("")
				npc.unlock()
				return
			end
			local m_ring_num = pc.countitem(70301)
			local m_has_ring = m_ring_num > 0
			if not m_has_ring then
				say("Quieres casarte sin un anillo de boda?")
				say("El Anillo de bodas lo puedes comprar a Peddler")
				say_item("Anillo de boda" , 70301 , "")
				say("Tienes que conseguir un anillo de boda primero.")
				say("Solo entonces podras casarte")
				say("")
				npc.unlock()
				return
			end
			local m_sex = pc.get_sex()
			if not MarriageManage.is_equip_wedding_dress() then
				say("¿Quieres casarte sin un traje de bodas?")
				say("Un matrimonio es algo serio, my honorable")
				say("la cual debe portarse el traje de bodas")
				say("sin ello no puedo casarte")
				say("El Traje de bodas lo puedes comprar a Peddler")
				say("")
				if m_sex==0 then
				say_item("Smoking de Bodas" , MarriageManage . get_wedding_dress ( pc . get_job ( ) ) , "")
					say_reward("Debes usar un Smoking de bodas")
					say_reward("para casarte.")
				else
					say_item("Vestido de la novia" , MarriageManage . get_wedding_dress ( pc . get_job ( ) ) , "")
					say_reward("Debes usar un vestido de novia")
					say_reward("para casarte.")
				end
				npc.unlock()
				return
			end
			local NEED_MONEY = 1000000
			if pc.get_money() < NEED_MONEY then
				say("Lo siento pero ustedes saben nada es gratis")
				say("Para contraer matrimonio es necesario 1kk")
				say("Tengo que transformar los anillos de los anillos")
				say("")
				say_reward ( string . format("lleva contigo 1kk para efectuuar la Boda" , NEED_MONEY / 10000 ) )
				say("")
				npc.unlock()
				return
			end
			say("Estas seguro de querer Casarte?")
			say("Estas seguro de la decision que has tomado!")
			say("Con quien te vas a casar?")
			say("")
			say_reward("Escribe el Nombre")
			local sname = input ( )
			if sname == "" then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("No estamos aqui para bromas")
				say("")
				npc.unlock()
				return
			end
			local u_vid = find_pc_by_name(sname)
			local m_vid = pc.get_vid()
			if u_vid == 0 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("Lo siento.. usted no puede casarse")
				say("la otra persona no esta en linea, o no existe")
				say("")
				say_reward ( string . format("%s no esta en linea" , sname ) )
				say("")
				npc.unlock()
				return
			end
			if not npc.is_near_vid(u_vid, 10) then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("Lo siento.. usted no puede casarse")
				say("la otra persona no esta aqui")
				say("")
				say_reward ( string . format("%s debe estar cerca de ti" , sname ) )
				say("")
				npc.unlock()
				return
			end
			local old = pc.select(u_vid)
			local u_level = pc.get_level()
			local u_job = pc.get_job()
			local u_sex = pc.get_sex()
			local u_name = pc.name
			local u_gold = pc.get_money()
			local u_married = pc.is_married()
			local u_has_ring = pc.countitem(70301) > 0
			local u_wear = MarriageManage.is_equip_wedding_dress()
			pc.select(old)
			local m_level = pc.get_level()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if u_vid == m_vid then
				say("No se puede hacer la boda!")
				say("")
				say_reward("Matrimonio cancelado.")
				say("")
				npc.unlock()
				return
			end
			if u_sex == m_sex then
				say("No puedo casarte con una persona")
				say("del mismo sexo.")
				say("")
				say_reward("Un matrimonio se realiza unicamente")
				say_reward("entre un hombre y una mujer")
				say("")
				npc . unlock ( )
				return
			end
			if u_married then
				say("En que esta pensando usted?")
				say("Usted ya esta casado")
				say("Usted no puede contraer matrimonio")
				say("")
				say_reward ( string . format("%s No se puede casar" , sname ) )
				say("")
				npc.unlock()
				return
			end
			if u_level < 25 then
				say("Con el dolor de mi alma")
				say("Su conyuge no puede contraer matrimonio")
				say("")
				say_reward("Su conyuge debe ser almenos 25")
				say("")
				npc.unlock()
				return
			end
			if m_level - u_level > 15 or u_level - m_level > 15 then
				say("Lo siento mucho, no puedo casarte")
				say("a causa de tu nivel no puedes casarte")
				say("")
				say_reward("la diferencia entre tu conyuge y tu")
				say_reward("no debe ser mayor a 15 niveles.")
				say("")
				npc.unlock()
				return
			end
			if not u_has_ring then
				if m_ring_num >= 2 then
					say("Tu conyuge debe portar un anillo de boda")
				else
					say("No tendre todo el dia.")
					say("")
				end
				say_item("Anillo de boda" , 70301 , "")
				say("Los dos deben portar anillo de boda")
				say("Solo entonces podres casarlos.")
				say("")
				npc.unlock()
				return
			end
			if not u_wear then
				say("Tu conyuge debe portar el traje adecuado")
				say("la boda, no puede casarse con lo que combate.")
				say("")
				if u_sex == 0 then
					say_item("Smoking de Bodas" , MarriageManage . get_wedding_dress ( u_job ) , "")
					say_reward("Debes usar un Smoking de bodas")
					say_reward("para casarte.")
				else
					say_item("Vestido de la novia" , MarriageManage . get_wedding_dress ( u_job ) , "")
					say_reward("Debes usar un vestido de novia")
					say_reward("para casarte.")
					say("")
				end
				if u_sex==0 then
					say_item("Smoking de Bodas" , MarriageManage . get_wedding_dress ( u_job ) , "")
					say_reward("Debes usar un Smoking de bodas")
					say_reward("para casarte.")
				else
					say_item("Vestido de la novia" , MarriageManage . get_wedding_dress ( u_job ) , "")
					say_reward("Debes usar un vestido de novia")
					say_reward("para casarte.")
				end
				say("")
				npc.unlock()
				return
			end
			local ok_sign = confirm ( u_vid , "Deseas casarte con " .. pc . name .. "?" , 30 )
			if ok_sign == CONFIRM_OK then
			local m_name = pc.name
			if pc.get_gold()>=NEED_MONEY then
				pc.change_gold(-NEED_MONEY)
				pc.removeitem(70301, 1)
				pc.give_item2(70302, 1)
				local old = pc.select(u_vid)
				pc.removeitem(70301, 1)
				pc.give_item2(70302, 1)
				pc.select(old)
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("Que momento tan conmovedor!!")
				say("Tu conyuge a aceptado.")
				say("Ahora te dare los votos")
				say("Estas oficialmente casado.")
				say("")
				say_reward("Ahora te llevare al lugar de tu boda.")
				say("")
				wait ( )
				setskin(NOWINDOW)
				marriage.engage_to(u_vid)
			end
			else
				say("Que triste.")
				say("No te casaras.")
				say("")
				say_reward("La otra persona se ha negado")
			end
			say("")
			npc.unlock()
		end
		when 9006.chat."Mi boda" with pc.is_engaged() begin
			say_title("Anciano:")
			say("Comenzaba a pensar que habiad huido de la boda")
			say("tanto que hablo de pensar mas las cosas antes.")
			say("de hablar.")
			say("")
			wait()
			setskin(NOWINDOW)
			marriage.warp_to_my_marriage_map()
		end
		when 9011.chat."Casarse" with pc.is_engaged() and marriage.in_my_wedding() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if not npc.lock() then
				say("Su objetivo es un dialogo conmigo?, por favor espere.")
				say("")
				return
			end
			say("Ahora por favor")
			say("Ponga aqui el nombre de su conyuge")
			local sname = input ( )
			local u_vid = find_pc_by_name ( sname )
			local m_vid = pc . get_vid ( )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if u_vid == 0 then
				say("El jugador que elige no es correcto")
				say("")
				say_reward ( string . format("Ponga el nombre" , sname ) )
				say("")
				npc . unlock ( )
			return
			end
			if not npc . is_near_vid ( u_vid , 10 ) then
				say("Su conyuge debe estar derca de Usted.")
				say("")
				say("")
				say_reward ( string . format("Su conyuge se encuentra muy lejos" , sname ) )
				say("")
				npc . unlock ( )
				return
			end
			if u_vid == m_vid then
				say("No escriba su propio nombre")
				say("")
				say_reward("Se debe introducir el nombre de su conyuge")
				say("")
				npc . unlock ( )
				return
			end
			if u_vid ~= marriage . find_married_vid ( ) then
				say("El nombre que escribe no es el mismo que el de su conyuge.")
				say("Por favor, espere a que busque")
				say("")
				npc . unlock ( )
				return
			end
			local ok_sign = confirm ( u_vid , "Quiere casarse con " .. pc . name .. "?" , 30 )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if ok_sign ~= CONFIRM_OK then
				say("Perdon.")
				say("Su conyuge no ha aceptado")
				say("")
				npc . unlock ( )
			return
			end
			local male_item = {71072, 71073, 71074}
			local female_item = {71069, 71070, 71071}
			if pc.get_sex() == MALE then
				pc.give_item2(male_item[number(1, 3)], 1)
			else
				pc.give_item2(female_item[number(1, 3)], 1)
			end
			say("Felicidades! ahora que te casaste.Espero que seas feliz.")
			say("")
			marriage . set_to_marriage ( )
			say("")
			say_reward("Ahora estas casado")
			say("")
			say_reward("Has recibido un obsequio.")
			say("")
			npc.unlock()
		end
		when 9011.chat."Agregar Musica" with (pc.is_engaged() or pc.is_married()) and marriage.in_my_wedding() and not marriage.wedding_is_playing_music() begin
			marriage . wedding_music ( true , "wedding.mp3")
			setskin ( NOWINDOW )
		end
		when 9011.chat."Detener Musica" with
			(pc.is_engaged() or pc.is_married()) and
			marriage.in_my_wedding() and
			marriage.wedding_is_playing_music() begin
			marriage.wedding_music(false, "default")
			setskin(NOWINDOW)
		end
		when 9011.chat."Finalizar Boda" with pc.is_married() and marriage.in_my_wedding() begin
			if not npc.lock() then
				say_title("Matrimonio:")
				say("Ahora, voy a objeto de que el dialogo con usted mas tarde seguir persiguiendo a hablar de ti")
				say("")
				return
			end
			say_title("Matrimonio:")
			say("Deseas terminar el Matrimonio?")
			say("")
			local s = select("Si","No")
			if s == 1 then
				local u_vid = marriage.find_married_vid()
				if u_vid == 0 then
					say_title("Matrimonio:")
					say("A fin de completar una boda, usted debe solicitar")
					say("el consentimiento de la otra parte. ")
					say("Ahora que su marido no esta en linea")
					say("No se puede completar la boda.")
					say("")
					npc.unlock()
					return
				end
				say_title("Matrimonio:")
				say("Le preguntare si quiere terminar la boda a")
				say("su marido.")
				say("")
				local ok_sign = confirm(u_vid, "Deseas terminar la boda?", 30)
				if ok_sign == CONFIRM_OK then
					marriage.end_wedding()
				else
					say_title("Matrimonio:")
					say("Su esposa ha decidido seguir")
					say("un poco.")
					say("")
				end
				npc.unlock()
			end
		end
		when 11000.chat."Divorcio Unilateral" or
			 11002.chat."Divorcio Unilateral" or
			 11004.chat."Divorcio Unilateral" with pc.is_married() begin
			if not MarriageManage.check_divorce_time() then
			return
			end
			say_title("Guardian:")
			say("Necesitas 5 millones para un divorcio unilateral.")
			say("Aun quieres divorciarte?")
			say("")
			local s = select( "Si" , "No.Solo queria saber...")
			local NEED_MONEY = 5000000
			if s == 2 then
			return
			end
			if pc.money < NEED_MONEY then
			say_title("Guardian de la aldea:")
			say("No tienes suficiente Yang para el divorcio.")
			say("Necesitas tanto Yang como el que necesitaste")
			say("para tu boda.")
			say("Quizaz quieras reconsiderarlo ...")
			say("")
			return
			end
			say("Waechter des Dorfplatzes:")
			say_title("Guardian de la Aldea:")
			say("Realmente necesitas divorciarte ?")
			local c = select( "Si,Divorciarme." , "Cancelar")
			if c == 2 then
			say_title("Guardian de la aldea:")
			say("Me alegra que vayas a considerarlo,yo se que podras")
			say("llegar a un arreglo, Aveces conocemos tarde a las")
			say("personas pero valdra la pena luchar por el amor.")
			say("")
			say_reward("Divorcio unilateral cancelado")
			say("")
			return
			end
			pc.removeitem(70302, 1)
			pc.change_gold(-NEED_MONEY)
			marriage.remove()
			say_title("Guardian de la aldea:")
			say("Tienes razon cuando uno no se lleva bien con la pareja,")
			say("y se ha buscado soluciones, se considere el divorcio.")
			say("Ahora que no tienes pareja, espero que seas feliz")
			say("")
			say_reward("Te has divorciado con exito.")
			say("")
		end
		when 9006.chat."Lista de Ceremonias" with not pc.is_engaged() begin
			local t = marriage.get_wedding_list()
			if table.getn(t) == 0 then
			say_title("Anciano:")
			say("")
			say("Ahora mismo, no se esta celebrando ninguna boda")
			say("")
			else
			local wedding_names = {}
			table.foreachi(t, function(n, p) wedding_names[n] = p[3].."und "..p[4].." Hochzeit" end)
			wedding_names[table.getn(t)+1] = locale.confirm
			local s = select_table(wedding_names)
			if s != table.getn(wedding_names) then
				marriage.join_wedding(t[s][1], t[s][2])
			end
			end
		end
		when 9011.click with not pc.is_engaged() and not pc.is_married() begin
			say_title("Matrimonio:")
			say("Estamos hoy aqui se reunidos")
			say("para celebrar el sagrado matrimonio")
			say("de esta pareja que se ha beneficiada.")
			say("por el amor.")
			say("")
		end
		function check_divorce_time()
			local DIVORCE_LIMIT_TIME = 21600
			if is_test_server() then
			DIVORCE_LIMIT_TIME = 60
			end
			if marriage.get_married_time() < DIVORCE_LIMIT_TIME then
			say_title("Guardian:")
			say("Acabas de casarte y ya pensando en divorcios!!!")
			say("Piensalo mejor,no te vayas a arrepentir despues")
			say("")
			return false
			end
			return true
		end
		function is_equip_wedding_dress()
			local a = pc.get_armor()
			return a >= 11901 and a <= 11904
		end
		function get_wedding_dress(pc_sex)
			if 0==pc_sex then
				return 11901
			else
				return 11903
			end
		end
		when 11000.chat."Divorcio" or 11002.chat."Divorcio" or 11004.chat."Divorcio" with pc.is_married() begin
			if not MarriageManage.check_divorce_time() then
				return
			end
			local u_vid = marriage.find_married_vid()
			if u_vid == 0 or not npc.is_near_vid(u_vid, 10) then
				say_title("Guardian:")
				say("Sin tu pareja, no puedes divorciarte legalmente.")
				say("Â¡Vuelve con tu pareja! Un divorcio es algo serio")
				say("")
				return
			end
			say_title("Guardian:")
			say("Para un divorcio legal, necesitas 500.000 Yang")
			say("y tu pareja tiene que estar de acuerdo tambien.")
			say("Realmente quieres divorciarte?")
			say("")
			local MONEY_NEED_FOR_ONE = 500000
			local s = select("Aceptar" , "Cancelar")
			if s == 1 then
				local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
				local m_have_ring = pc.countitem(70302) > 0
				local old = pc.select(u_vid)
				local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
				local u_have_ring = pc.countitem(70302) > 0
				pc.select(old)
				if not m_have_ring then
					say_title("Guardian:")
					say("No tienes puesto el anillo de compromiso.")
					return;
				end
				if not u_have_ring then
					say_title("Guardian:")
					say("Tu pareja no lleva puesto el anillo de compromiso.")
					return;
				end
				if not m_enough_money then
					say("Waechter des Dorfplatzes:")
					say("Du hast nicht genug Yang fuer die Scheidung.")
					say("")
					say_title("Guardian:")
					say("No tienes suficiente Yang para un divorcio.")
					say("")
					say_reward ( string . format("Para divorciarte, necesitas %d Yang." , MONEY_NEED_FOR_ONE / 10000 ) )
					say("")
					return;
				end
				if not u_enough_money then
					say_title("Guardian:")
					say("Tu pareja no tiene el Yang necesario.")
					say("")
					say_reward("Para divorciarte, ambos deben tener 500k Yang")
					say("")
					return;
				end
				say_title("Guardian:")
				say("Realmente quieres divorciarte? Puede ser un gran.")
				say("error.")
				say("Realmente quieres?")
				say("")
				local c=select("Si" , "No. He cambiado de opinion.")
				if 2 == c then
					say_pc_name()
					say("Tienes toda la razon pueda ser cuestion de tiempo")
					say("")
					wait()
					say_title("Guardian:")
					say("No tengo tiempo para perderlo")
					say("con jovenes indesisos.")
					say("")
					say_reward("Divorcio es una decision seria.")
					say("")
					return
				end
				local ok_sign = confirm(u_vid, pc.name.." Firma el divorcio", 30)
				if ok_sign == CONFIRM_OK then
					local m_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local m_have_ring = pc.countitem(70302) > 0
					local old = pc.select(u_vid)
					local u_enough_money = pc.gold > MONEY_NEED_FOR_ONE
					local u_have_ring = pc.countitem(70302) > 0
					pc.select(old)
					if m_have_ring and m_enough_money and u_have_ring and u_enough_money then
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)
						local old = pc.select(u_vid)
						pc.removeitem(70302, 1)
						pc.change_money(-MONEY_NEED_FOR_ONE)
						pc.select(old)
						say_title("Guardian:")
						say("Divorcio hecho realidad.")
						say("Ambos han firmado el Acta de separacion")
						say("de cuerpos.")
						say("")
						say_reward("Oficialmente quedan solteros")
						say("")
						marriage.remove()
					else
						say_title("Guardian:")
						say("Error ocurrido durante el divorcio.")
						say("Regresa la proxima vez.")
						say("")
						say_reward("El divorcio no se efectuo.")
						say("")
					end
				else
					say_title("Guardian:")
					say("Tu pareja no quiere divorciarse.")
					say("Aclara esto primero")
					say("")
					say_reward("El divorcio ha sido anulado.")
					say("")
				end
			end
		end
	end
end
