quest reset_status begin
	state start begin
		when 71003.use begin
			say_title("Restablecer Habilidad")
			say("Cuando resetees una Habilidad, se te devolveran")
			say("todos los puntos y podras asignarlos de nuevo.")
			say("")
			wait()
			local result = BuildSkillList(pc.get_job(), pc.get_skill_group())
			local vnum_list = result[1]
			local name_list = result[2]
			if table.getn(vnum_list) < 2 then
				say_title("Restablecer Habilidad")
				say("Aun no has estudiado ninguna habilidad.")
				say("")
				return
			end
			say_title("Restablecer Habilidad")
			say("Elije la habilidad que quieres resetear.")
			say("")
			local i = select_table(name_list)
			if table.getn(name_list) == i then
				return
			end
			local name = name_list[i]
			local vnum = vnum_list[i]
			say_title("Restablecer Habilidad")
			say("La habilidad seleccionada se pondra en 0")
			say("recuperaras los puntos usados en ella.")
			say("")
			say_reward(string.format("Deseas Restablecer la habilidades %s ? ", name))
			say("")
			local s =  select("Restablecer", "Cancelar")
			if 2 == s then
				return
			end
			say_title("Restablecer Habilidad")
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
	end
end

