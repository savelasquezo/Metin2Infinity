quest PetSystems begin
	state start begin
		function book_skill(value)
			return value - 55009
		end
		function get_pet_info(itemVnum)
			pet_info_map = {
			----[ITEM VNUM] MOB_VNUM, DEFAULT NAME, spawn_effect_idx
			[55701] = { 34041, "", 0},
			[55702] = { 34045, "", 0},
			[55703] = { 34049, "", 0},
			[55704] = { 34053, "", 0},
			[55705] = { 34036, "", 0},
			[55706] = { 34064, "", 0},
			[55707] = { 34073, "", 0},
			[55708] = { 34075, "", 0},
			[55709] = { 34080, "", 0},
			[55710] = { 34082, "", 0},
			[55711] = { 34051, "", 0},
			[55712] = { 34082, "", 0},--
			[55713] = { 34082, "", 0},--
			[55714] = { 34082, "", 0},--
			[55715] = { 34082, "", 0},--
							}
			itemVnum = tonumber(itemVnum)
			return pet_info_map[itemVnum]
		end
		function get_spawn_effect_file(idx)
			effect_table = {
				[0] = nil,
				[1] = "d:\\\\ymir work\\\\effect\\\\etc\\\\appear_die\\\\monster_die.mse",
			}
			return effect_table [idx]
		end
		when login with pc.getqf("new_pet_vnum") != 0 begin
			item.select(pc.getqf("new_pet_item_id"))
			newpet.summon(pc.getqf("new_pet_vnum"), "'s ", false)
		end
		when 55701.use or 55702.use or 55703.use or 55704.use or 55705.use or 55706.use or 55707.use or 55708.use or 55709.use or 55710.use or
			 55711.use or 55712.use or 55713.use or 55714.use or 55715.use begin
			local pet_info = PetSystems.get_pet_info(item.vnum)
			pc.setqf("new_pet_item_id", item.get_id())
			if null != pet_info then
				local mobVnum = pet_info[1]
				local petName = pet_info[2]
				if true == newpet.is_summon(mobVnum) then
					newpet.unsummon(mobVnum)
					pc.setqf("new_pet_vnum", 0)
				else
					if newpet.count_summoned() < 1 then
						newpet.summon(mobVnum, petName, false)
						pc.setqf("new_pet_vnum", mobVnum)
					else
						return
					end
				end
			end
		end
		when 55401.use or 55402.use or 55403.use or 55404.use or 55405.use or 55406.use or 55407.use or 55408.use or 55409.use or 55410.use or
			 55411.use or 55412.use or 55413.use or 55414.use or 55415.use begin
			newpet.EggRequest(item.get_vnum())
			cmdchat(string.format("OpenPetIncubator %d ", (item.get_vnum()-55401)))
		end
		when 55010.use or 55011.use or 55012.use or 55013.use or 55014.use or 55015.use or 55016.use or 55017.use or 55018.use or 
			 55019.use or 55020.use or 55021.use or 55022.use or 55023.use or 55024.use or 55025.use or 55026.use or 55027.use begin
			if newpet.getlevel() >= 80 and  newpet.getevo() == 3 then
				if newpet.increaseskill(PetSystems.book_skill(item.get_vnum())) then
					pc.remove_item(item.get_vnum(), 1)
				end
			end
		end
		when 55028.use begin
			if newpet.count_summoned() < 1 then
				syschat("<Scroll> Restaurar Habilidad Mascota.")
				syschat("<Error> Debes Invocar una Mascota")
				return
			else
				say_title("Restaurar Habilidad:")
				say("El pergamino permite restaurar una habilidad")
				say("especifica de entrenamiento de mascota")
				say("¿Realmente quieres restablecer una habilidad?")
				say("")
				local s = select("Habilidad Primaria","Habilidad Secundaria","Habilidad Terciaria","Cancelar")
				if s == 4 then
					return
				end
				local ret = newpet.resetskill(input)
				if ret == true then
					say_title("Restablecer Estado:")
					say_reward("La Habilidad ha sido Restablecida!")
					say("")
					pc.remove_item(item.get_vnum())
				else
					say_title("Restaurar Habilidad:")
					say_reward("El restablecimiento de habilidad fue cancelado.")
					say("")
				end
			end
		end
		when 55029.use begin
			if newpet.count_summoned() < 1 then
				syschat("<Scroll> Restaurar Habilidades de  Mascota.")
				syschat("<Error> Debes Invocar una Mascota")
				return
			else
				say_title("Restaurar Entrenamiento:")
				say("El pergamino permite restaurar las habilidad")
				say("entrenadas de las mascota")
				say_reward("¿Realmente quieres restablecer las habilidad?")
				say("")
				local s = select("Restablecer","Cancelar")
				if s == 2 then
					say_title("Restaurar Habilidad:")
					say_reward("El restablecimiento de habilidad fue cancelado.")
					say("")
					return
				end
				say_title("Restablecer Estado:")
				say_reward("La Habilidad ha sido Restablecida!")
				say("")
				newpet.resetskill(0)
				newpet.resetskill(1)
				newpet.resetskill(2)
				pc.remove_item(item.get_vnum())
			end
		end
	end
end
