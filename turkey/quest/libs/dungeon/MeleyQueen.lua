quest MeleyQueen begin
	state start begin
		function Setting()
			if MeleyQueen.Settings == nil then
				MeleyQueen.Settings = {
				["DungeonName"] = "Meley",
				["DungeonInfoIndex"] = 11,
				["Index"] = 212,
				["NPC"] = 20419,
				["Outdoor"] = 62,
				["OutdoorCoord"] = {5888,6144},
				["OutdoorPoss"] = {1434,1421},
				["MeleywReward"] = 20420,
				}
			end
			return MeleyQueen.Settings
		end
		when login with MeleyLair.IsMeleyMap() begin
			MeleyLair.Check()
		end
		when login with not MeleyLair.IsMeleyMap() begin
			local s = MeleyQueen.Setting()
			if pc.get_map_index() == s.Index then
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when 20419.chat."Insertar Gremio" with pc.get_map_index() == MeleyLair.GetSubMapIndex() and pc.is_guild_master() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			local Login, Channel = MeleyLair.IsRegistered()
			if Login then
				say_red(gameforge.dungeon.msm001)
				say("[ENTER]Actualmente tu Gremio combate ferozmenten en la Mazmorra[ENTER]¡Ingresa nuevamente, unete a la batalla junto a tu Gremio!")
				say_white("[ENTER]Ingresar")
				say_gold(string.format("~CH %s~", Channel))
				say("")
				return
			end
			local R1, R2 = MeleyLair.GetRequirments()
			say("...")
			say("")
			say_gold(string.format("Nivel Gremio: %d.", R1))
			say_gold(string.format("Clasificacion: %d", R2))
			say("")
			say_white("¿Quieres Ingresar? ")
			say("")
			if select("Aceptar","Cancelar") == 1 then
				local Q1, Q2 = MeleyLair.Register()
				if Q1 == 0 then
					return
				end
				local resultMsg = {
								[1] = "Actualmente tu Gremio combate ferozmenten en la Mazmorra[ENTER]¡Ingresa nuevamente, unete a la batalla junto a tu Gremio CH %d! [ENTRAR].",
								[2] = "¡Imposible Ingresar![ENTER] No pertecenes al Gremio que Actualmente esta Luchando!",
								[3] = "¡Imposible Ingresar![ENTER] Nivel Gremio Requerido: %d",
								[4] = "¡Imposible Ingresar![ENTER] Clasificacion Gremio Requerida: %d",
								[5] = "¡Imposible Ingresar![ENTER] El Gremio no esta Registrado!",
								[6] = "Aventurate en la Lucha Meley![ENTER]¡Si derrotas al Meley recuperaras %d Clasificacion",
								[7] = "¡Imposible Registrar![ENTER] ¡El sello se esta recuperando debes esperar![ENTER]%s",
				}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				if Q1 != 2 and Q1 != 5 then
					if Q1 == 7 then
						say(string.format(resultMsg[Q1],osTime(Q2)))
						say("")
					else
						say(string.format(resultMsg[Q1],Q2))
						say("")
					end
				else
					say(resultMsg[Q1])
					say("")
				end
			end
		end
		when 20419.chat.gameforge.npc.dungeon0110 with pc.get_map_index() == MeleyLair.GetSubMapIndex() and pc.has_guild() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("")
			say("¿Quieres Ingresar? ")
			say("")
			if select("Ingresar", "Cancelar") == 1 then
				local Login, Limit = MeleyLair.Enter()
				if not Login and Limit == 0 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					if pc.is_guild_master() then
						say("[ENTER]¡Imposible Ingresar![ENTER] El Gremio no esta Registrado![ENTER]")
						say("")
					else
						say("[ENTER]Solo el lider del Gremio puede abrir el Sello[ENTER]la entrada a la mazmorra esta restringida[ENTER]")
						say("")
					end
					return
				elseif not Login and Limit > 0 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say(string.format("¡Ingresa a la batalla junto a tu Gremio desde CH %d!", Limit))
					say("")
					return
				elseif Limit == 1 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say(string.format("¡Imposible Ingresar![ENTER]Actualmente el Gremio ya tiene %d Integrantes!", MeleyLair.GetPartecipantsLimit()))
					say("")
					return
				elseif Limit == 2 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say("¡Imposible Ingresar!")
					say("")
					return
				elseif Limit == 3 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say("¡Imposible Ingresar![ENTER]¡Actualmente la mazmorra ha Finalizado!")
					say("")
					return
				elseif Limit == 4 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red(gameforge.dungeon.msm001)
					say("¡Imposible Ingresar![ENTER]Selecciona Modo de Combate: Gremio[ENTER]¡Intentalo Nuevamente!")
					say("")
					return
				end
				return
			end
		end
		when kill with ZodiacoTemple.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = MeleyQueen.Setting()
			if mobVnum == s.MeleywReward then
				if party.is_party() then
					local pids = {party.get_member_pids()}
					for i, pid in next, pids, nil do
						q.begin_other_pc_block(pid)
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
						q.end_other_pc_block()
					end
				else
					dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
				end
			end
		end
		when 20419.chat."Abandonar" with MeleyLair.IsMeleyMap() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say_white("¿Quieres Abandonar la Lucha? ")
			say("")
			if select("Abandonar","Cancelar") == 1 then
				MeleyLair.Leave()
			end
		end
		when 20388.click."" begin
		end
    end
end
