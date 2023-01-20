quest ScrollsAccount begin
	state start begin
		when 76001.use begin
			if pc.is_married() then
				syschat("<Scroll> Modificacion de Raza")
				syschat("<Error> Imposible usar si estas Casado")
				return
			end
			if pc.get_weapon() != 0 or pc.get_armor() !=0 then
				syschat("<Scroll> Modificacion de Raza")
				syschat("<Error> Imposible usar si estas Equipado!")
				return
			end
			if pc.is_polymorphed() then
				syschat("<Scroll> Modificacion de Raza")
				syschat("<Error> Imposible usar si estas Poliformado")
				return
			end
			if pc.has_guild() then
				syschat("<Scroll> Modificacion de Raza")
				syschat("<Error> Imposible usar si estas Liderando Gremio")
				return
			end
			if party.is_party() then
				syschat("<Scroll> Modificacion de Raza")
				syschat("<Error> Imposible usar si estas en Grupo")
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Modificacion Raza~")
			say("")
			say("El pergamino permite cambiar de raza")
			say("Recuerda que este cambio esta sujeto al reglamento.")
			say("")
			say_gold("~Selecciona~")
			local s= select("Guerrero", "Ninja", "Sura", "Chaman","Cancelar")
			if pc.count_item(76001) == 0 then
				return
			end
			local m_sex = pc.get_sex()
			if s == 5 then
				return
			elseif s == 1 then
				if m_sex == 0 then
					pc.change_race(0)
				else
					pc.change_race(4)
				end
			elseif s == 2 then
				if m_sex == 0 then
					pc.change_race(5)
				else
					pc.change_race(1)
				end
			elseif s == 3 then
				if m_sex == 0 then
					pc.change_race(2)
				else
					pc.change_race(6)
				end
			elseif s == 4 then
				if m_sex == 0 then
					pc.change_race(7)
				else
					pc.change_race(3)
				end
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Modificacion de Raza~")
			say("")
			say_reward("El Cambio de raza fue Exitoso")
			say_reward("Reconecta nuevamente tu cuenta.")
			say("")
			pc.remove_item("76001",1)
		end
		when 71003.use begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Restablecer Habilidad~")
			say("")
			say("Cuando resetees una Habilidad, se te devolveran")
			say("todos los puntos y podras asignarlos de nuevo.")
			say("")
			local result = BuildSkillList(pc.get_job(), pc.get_skill_group())
			local vnum_list = result[1]
			local name_list = result[2]
			if table.getn(vnum_list) < 2 then
				say("Aun no has estudiado ninguna habilidad.")
				say("")
				return
			end
			say("Elije la habilidad que quieres resetear.")
			say("")
			local i = select_table(name_list)
			if table.getn(name_list) == i then
				return
			end
			local name = name_list[i]
			local vnum = vnum_list[i]
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Restablecer Habilidad~")
			say("")
			say("La habilidad seleccionada se pondra en 0")
			say("recuperaras los puntos usados en ella.")
			say("")
			say_reward(string.format("Deseas Restablecer la habilidades %s ? ", name))
			say("")
			local s =  select("Restablecer", "Cancelar")
			if 2 == s then
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Restablecer Habilidad~")
			say("")
			say("El Reseteo no puede desahacer, Quieres Continuar?")
			say("")
			local c =  select("Confirmar", "Salir")
			if 2 == c then
				return
			end
			if 1 == c then
				if pc.count_item(71003) == 0 then
					return
				end
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title("~Restablecer Habilidad~")
				say("")
				char_log(0, "RESET_ONE_SKILL", "USE_ITEM(71003)")
				pc.remove_item(71003)
				char_log(0, "RESET_ONE_SKILL", "RESET_SKILL["..name.."]")
				pc.clear_one_skill(vnum)
				char_log(0, "RESET_ONE_SKILL", "APPLY_17MASTER_BONUS")
				pc.setqf("force_to_master_skill", 1)
				say_title("Resetear Habilidad")
				say_reward(string.format("La Habilidad[ENTER]%s[ENTER]ha sido Restablecida", name))
				say("")
			end
		end
		when 71054.use begin
			if get_time() < pc.getqf("next_use_time") then
				syschat("<Scroll> Restablecer Imperio")
				syschat("<Error> Restriccion de 3 Dias Vigente.")
				return
			end
			if pc.is_married() then
				syschat("<Scroll> Restablecer Imperio")
				syschat("<Error> Imposible usar si estas Casado")
				return
			end
			if pc.is_polymorphed() then
				syschat("<Scroll> Restablecer Imperio")
				syschat("<Error> Imposible usar si estas Poliformado")
				return
			end
			if pc.has_guild() then
				syschat("<Scroll> Restablecer Imperio")
				syschat("<Error> Imposible usar si estas Liderando Gremio")
				return
			end
			if party.is_party() then
				syschat("<Scroll> Restablecer Imperio")
				syschat("<Error> Imposible usar si estas en Grupo")
				return
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~Restablecer Imperio~", mob_name(npc.get_race())))
			say("")
			say("El pergamino permite cambiar de Imperio")
			say("Recuerda que este cambio esta sujeto al reglamento.")
			say_reward("¿Realmente quieres cambiar de Imperio?")
			say("")
			local s = select("Restablecer", "Cancelar")
			if s == 1 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~Restablecer Imperio~", mob_name(npc.get_race())))
				say("")
				say("Selecciona el Reino al cual deseas trasladarte")
				say_gold("¿Cual Imperio Escogeras ?")
				say("")
				local s = select("Orden del Dragon", "Legion Bestial","Cancelar")
				if 3==s then
					return
				end
				local ret = pc.change_empire(s)
				local oldempire = pc.get_empire()
				if ret == 999 then
					if pc.count_item(71054) == 0 then
						return
					end
					pc.remove_item("71054",1)
					char_log(0, "CHANGE_EMPIRE",string.format("%d -> %d", oldempire, s))
					pc.disconnect_with_delay(5)
				else
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~Restablecer Imperio~", mob_name(npc.get_race())))
					say("")
					if ret == 1 then
						say("¡Actualmente ya perteneces a este Imperio!")
						say_white("Selecciona Imperio")
						say("")
					elseif ret == 2 then
						say("¡Imposible cambiar de reino en este Momento!")
						say_white("Haz cambiado de Gremio recientemente")
						say_white("¡Espera 24 Horas!")
						say("")
					elseif ret == 3 then
						say("¡Imposible cambiar de reino en este Momento!")
						say_white("Actualmente estas Casado/Comprometido")
						say("")
					end
				end
			end
		end
		when 71055.use begin
			if get_time() < pc.getqf("next_use_time") then
				syschat("<Scroll> Restablecer Nombre")
				syschat("<Error> Restriccion de 3 Dias Vigente.")
				return
			end
			if pc.is_married() then
				syschat("<Scroll> Restablecer Nombre")
				syschat("<Error> Imposible usar si estas Casado")
				return
			end
			if pc.is_polymorphed() then
				syschat("<Scroll> Restablecer Nombre")
				syschat("<Error> Imposible usar si estas Poliformado")
				return
			end
			if pc.has_guild() then
				syschat("<Scroll> Restablecer Nombre")
				syschat("<Error> Imposible usar si estas Liderando Gremio")
				return
			end
			if party.is_party() then
				syschat("<Scroll> Restablecer Nombre")
				syschat("<Error> Imposible usar si estas en Grupo")
				return
			end
			say_title("Restablecer Nombre:")
			say("El pergamino permite cambiar de Nombre")
			say("Recuerda que este cambio esta sujeto al reglamento.")
			say_reward("¿Realmente quieres cambiar de Nombre?")
			say("")
			local s = select("Restablecer", "Cancelar")
			if s == 1 then
				local eski = pc.name
				local yeni = input()
				if string.len(yeni) > 13 or string.len(yeni) < 3 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error> Debe tener entre 3 a 13 Digitos")
					return
				end
				if string.find(yeni, " ") then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error> Invalido")
					return
				end
				local Select = pc.change_name(yeni)
				if Select == 0 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-1> Nombre Invalido, intentalo mas tarde")
					return
				elseif Select == 1 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-2> Nombre Invalido, intentalo mas tarde")
					return
				elseif Select == 2 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-3> Nombre Invalido, intentalo mas tarde")
					return
				elseif Select == 3 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-4> Nombre Invalido, intentalo mas tarde")
					return
				elseif Select == 4 then
					if pc.count_item(71055) == 0 then
						return
					end
					pc.setqf("next_use_time", get_time() + 86400 * 3)
					pc.remove_item("71055",1)
					say_title("Restablecer Nombre:")
					say_reward("El Cambio de Nombre fue Exitoso")
					say_reward("Reconecta nuevamente tu cuenta.")
					say("")
					pc.disconnect_with_delay(5)
				elseif Select == 5 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-5> Nombre Invalido, intentalo mas tarde")
					return
				elseif Select == 6 then
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error-6> Nombre Invalido, intentalo mas tarde")
					return
				else
					syschat("<Scroll> Cambio de Nombre")
					syschat("<Error> Error Desconocido")
					return
				end
			end
			say_title("Restablecer Nombre:")
			say_reward("El restablecimiento de Nombre fue cancelado.")
			say("")
			return
		end
		when 71048.use begin
			if get_time() < pc.getqf("next_use_time") then
				syschat("<Scroll> Modificacion de Encanto")
				syschat("<Error> Restriccion de 3 Dias Vigente.")
				return
			end
			if pc.is_married() then
				syschat("<Scroll> Modificacion de Encanto")
				syschat("<Error> Imposible usar si estas Casado")
				return
			end
			if pc.is_polymorphed() then
				syschat("<Scroll> Modificacion de Encanto")
				syschat("<Error> Imposible usar si estas Poliformado")
				return
			end
			if pc.has_guild() then
				syschat("<Scroll> Modificacion de Encanto")
				syschat("<Error> Imposible usar si estas Liderando Gremio")
				return
			end
			if party.is_party() then
				syschat("<Scroll> Modificacion de Encanto")
				syschat("<Error> Imposible usar si estas en Grupo")
				return
			end
			say_title("Modificacion de Encanto:")
			say("El pergamino permite cambiar de Sexo")
			say("Recuerda que este cambio esta sujeto al reglamento.")
			say_reward("¿Realmente quieres cambiar de Sexo?")
			say("")
			local s= select("Restablecer", "Cancelar")
			if 1==s then
				if pc.count_item(71048) == 0 then
					return
				end
				say_title("Modificacion de Encanto:")
				say_reward("El Cambio de Sexo fue Exitoso")
				say_reward("Reconecta nuevamente tu cuenta.")
				say("")
				pc.setqf("next_time", get_time() + 86400 * 3)
				pc.remove_item("71048",1)
				pc.change_sex()
				local m_sex = pc.get_sex()
				if m_sex == 0 then
					char_log(0, "CHANGE_SEX", "F -> M")
				else
					char_log(0, "CHANGE_SEX", "M -> F")
				end
				pc.disconnect_with_delay(5)
			elseif 2==s then
				return
			end
		end
	end
end
