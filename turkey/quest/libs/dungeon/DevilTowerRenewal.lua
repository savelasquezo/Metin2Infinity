quest DevilTowerRenewal begin
	state start begin
		function Setting()
			if DevilTowerRenewal.Settings == nil then
				DevilTowerRenewal.Settings = {
				["DungeonName"] = "Torre Demoniaca",
				["DungeonInfoIndex"] = 3,
				["Level"] = 45,
				["LevelFinalsFloor"] = 75,
				["TimeToRetry"] = 1,
				["Index"] = 66,
				["NPC"] = 20348,
				["IndexCoord"] = {2048,6656},
				["IndexPoss"] = {{153,235},{373,236},{614,243},{143,484},{366,487},{615,475},{148,697},{364,676}},
				["OutDoorIndex"] = 65,
				["OutDoorCord"] = {5376,512},
				["OutDoorPoss"] = {763,1155},
				---------------------------------------
				---------------------------------------
				["StoneLv1"] = 8015,
				["KingLv2"] = 1091,
				["KingLv2Poss"] = {373,68},
				["StoneLv3"] = 8016,
				["StoneLv3Poss"] = {614,215},
				["StoneLv3F"] = 8017,
				["StoneLv3FPoss"] = {{564,209},{664,209},{684,160},{543,160},{564,111},{664,111},{614,84}},
				["KeyLv4"] = 50084,
				["KillCountLv4Drop"] = 200,
				["aStoneLv4"] = 20073,
				["aStoneLv4Poss"] = {{91,434,4},{196,434,6},{203,394,7},{84,394,3},{144,343,1}},
				["KingLv5"] = 1092,
				["KingLv5Poss"] = {366,367},
				["aStoneLv5"] = 40044,
				["aStoneLv5Poss"] = {366,345},
				["StoneLv6"] = 8018,
				["StoneLv6Poss"] = {{638,419},{592,419},{592,374},{638,374}},
				["BoxLv6"] = 30300,
				["BoxLv6MaxUse"] = 5,
				["KeyFakeLv6"] = 30301,
				["KeyRealLv6"] = 30302,
				["StoneMLv6"] = 8019,
				["StoneMLv6Poss"] = {615,368},
				["KillCountLv7Drop"] = 200,
				["KeyFakeLv7"] = 30303,
				["KeyRealLv7"] = 30304,
				["aStoneLv7"] = 20366,
				["aStoneLv7Poss"] = {148,598},
				["TaxAlignment"] = 35,
				["BlackSmith"] = {20074, 20075, 20076},
				["BlackSmithPoss"] = {364,603},
				["FinalBoss"] = 1093,
				["FinalBossPoss"] = {364,618},
				}
			end
			return DevilTowerRenewal.Settings
		end
		function InDungeon()
			local s = DevilTowerRenewal.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20348.chat.gameforge.npc.dungeon0030 with not DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			local xCord = s.IndexCoord[1] + s.IndexPoss[1][1]
			local yCord = s.IndexCoord[2] + s.IndexPoss[1][2]
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DevilTowerRenewal.Setting()
					if d.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					if pc.get_alignment( ) < s.TaxAlignment*pc.get_level() then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red("~Karma Insuficiente~")
						say("")
						say_white("~Karma Necesario~")
						say_gold(s.TaxAlignment*pc.get_level())
						say("")
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			else
				say(gameforge.npc.dungeon0031)
				if select("Ingresar","Cancelar") == 1 then
					local s = DevilTowerRenewal.Setting()
					if pc.get_level() < s.Level then
						say_gold(string.format(gameforge.npc.dungeon0032, s.Level, s.DungeonName))
						return
					end
					if pc.get_alignment( ) < s.TaxAlignment*pc.get_level() or pc.get_level() < s.LevelFinalsFloor then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red("~Advertencia~")
						say("")
						say("Actualmente no posees los requisitos para Ingresar")
						say("¡Seras expulsado en los niveles Superiores!")
						say("")
						say_gold("~Niveles Superiores~")
						say_white(s.LevelFinalsFloor)
						say("")
						say_gold("~Karma Necesario~")
						say_white(s.TaxAlignment*pc.get_level())
						say("")
						say_gold("¿Aun Quieres Ingresar?")
						say("")
						if select("¡Entrar!","Cancelar") == 2 then
							return
						end
					end
					--if pc.getqf("TimeToRetry") > get_time() then
					--	say_red(gameforge.dungeon.msm001)
					--	say(string.format(gameforge.dungeon.npc006, TimeToWait))
					--	say("")
					--	return
					--end
					pc.setqf("DevilTowerRenewalRelogin", 0)
					pc.warp(xCord*100,yCord*100)
				end
			end
		end
		when logout with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DevilTowerRenewalFail") == 1 or d.getf("level") == 99 then
				pc.setqf("DevilTowerRenewalRelogin", 0)
			end
		end
		when login with not DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if pc.get_map_index() == s.Index then
				if party.is_party() and d.find(party.getf("IndexDungeon")) then
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				elseif pc.get_x() > s.IndexCoord[1]+260 or pc.get_y() > s.IndexCoord[2]+300 then
					pc.warp((s.OutDoorCord[1]+s.OutDoorPoss[1])*100, (s.OutDoorCord[2]+s.OutDoorPoss[2])*100, s.OutDoorIndex)
				end
			end
		end
		when login with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if party.is_party() then
				party.setf("IndexDungeon", d.get_map_index())
			end
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if pc.getqf("DevilTowerStart") == 1 then
				d.notice(string.format("Nivel 2 ~ Derrota al %s & el ejercito de demonios!", mob_name(s.KingLv2)))
				d.spawn_mob_dir(s.KingLv2, s.KingLv2Poss[1], s.KingLv2Poss[2], 1)
				d.regen_file("data/dungeon/DevilTower/regen2.txt")
				server_timer('DevilTower10minLeft', 50*60, pc.get_map_index())
				server_loop_timer("DevilTowerCheck", 5, d.get_map_index())
				pc.setqf("DevilTowerStart", 0)
				d.setf("level", 2)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
			elseif pc.get_x() > s.IndexCoord[1]+500 or pc.get_y() > s.IndexCoord[2]+300 then
				if pc.getqf("DevilTowerRenewalRelogin") == d.get_map_index() then
					return
				end
				if d.getf("level") == 0 or d.getf("level") >= 6 then
					if pc.get_alignment( ) < s.TaxAlignment*pc.get_level() then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", s.DungeonName))
						say_red("~Karma Insuficiente~")
						say("")
						say_white("Seras Teletransportado al Exterior")
						say_white("~Karma Necesario~")
						say_gold(s.TaxAlignment*pc.get_level())
						say("")
						timer("ExitsFinalFloor", 5)
						return
					end
					if pc.get_level() < s.LevelFinalsFloor then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", s.DungeonName))
						say_red("~Nivel Insuficiente~")
						say("")
						say_white("Seras Teletransportado al Exterior")
						say_white("~Nivel Necesario~")
						say_gold(s.LevelFinalsFloor)
						say("")
						timer("ExitsFinalFloor", 5)
						return
					end
					if pc.getqf("DevilTowerStart") == 2 then
						d.setf("level", 6)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						d.notice(string.format("Nivel 6 ~ Destruye los %s! Encuentra el %s!", mob_name(s.StoneLv6), item_name(s.KeyRealLv6)))
						d.setf("BoxLv6MaxUse", s.BoxLv6MaxUse)
						d.setf("KillCountLv6", 0)
						pc.setqf("DevilTowerStart", 0)
						for i = 1, table.getn(s.StoneLv6Poss) do
							d.spawn_mob_dir(s.StoneLv6, s.StoneLv6Poss[i][1], s.StoneLv6Poss[i][2], 1)
						end
					end
					pc.setqf("DevilTowerRenewalRelogin", d.get_map_index())
					pc.change_alignment(-s.TaxAlignment*pc.get_level())
				else
					return
				end
			end
		end
		when 8015.kill with not DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if pc.get_map_index() == s.Index then
				notice_in_map(string.format("<%s> %s Ha sido destruido, Seran teletransportados al Nivel 2!", s.DungeonName, mob_name(npc.get_race())))
				pc.setqf("DevilTowerStart", 1)
				timer("DevilTowerStart", 5)
			end
		end
		when 40044.chat."Segador de la Oscuridad" with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if d.getf("level") != 5 then
				say_red("[ENTER]¡Error!>")
				return
			end
			say(gameforge.npc.dungeon0033)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0034)
			say_gold(string.format("~Nivel Requerido %s~", s.LevelFinalsFloor))
			if select("Ingresar","Cancelar") == 1 then
				local s = DevilTowerRenewal.Setting()
				if pc.get_level() >= s.LevelFinalsFloor and d.getf("LevelFinalsFloor", 1) == 0 then
					local s = DevilTowerRenewal.Setting()
					d.notice(string.format("<%s> Accediendo a los niveles superiores! Seran teletransportados al Nivel 6!", s.DungeonName))
					timer("LoginFinalFloor", 5)
					d.setf("LevelFinalsFloor", 1)
					pc.setqf("DevilTowerStart", 2)
					d.setf("level", 6)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.purge()
				end
			else
				pc.warp((s.OutDoorCord[1]+s.OutDoorPoss[1])*100, (s.OutDoorCord[2]+s.OutDoorPoss[2])*100, s.OutDoorIndex)
			end
		end
		when 20073.take with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if item.get_vnum() == s.KeyLv4 then
				if d.getf("level") != 4 then
					pc.remove_item(s.KeyLv4, 1)
					return
				end
				npc.purge()
				item.remove()
				d.setf("StoneLv4Count", d.getf("StoneLv4Count") - 1)
				if d.getf("StoneLv4Count") == 0 then
					clear_server_timer("DevilTower10secLeft", d.get_map_index())
					server_timer("DevilTowerJumps", 5, d.get_map_index())
					d.notice(string.format("<%s> Has desbloqueado todos los %ss! Seran teletransportados al Nivel 5!", s.DungeonName, mob_name(s.aStoneLv4)))
					d.setf("level", 5)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.clear_regen()
					d.purge()
				else
					d.notice(string.format("<%s> Has desbloqueado %s! Faltan: %s!", s.DungeonName, mob_name(s.aStoneLv4), d.getf("StoneLv4Count")))
				end
			end
		end
		when 20366.take with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if item.get_vnum() == s.KeyRealLv7 then
				if d.getf("level") != 7 then 
					pc.remove_item(s.KeyRealLv7, 1)
					return
				end
				npc.purge()
				item.remove()
				server_timer("DevilTowerJumps", 5, d.get_map_index())
				d.notice(string.format("<%s> Has desbloqueado el  %s! Seran teletransportados al Nivel 8!", s.DungeonName, mob_name(s.aStoneLv7)))
				d.setf("level", 8)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				d.clear_regen()
				d.purge()
			end
		end
		when 30300.use with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if d.getf("level") != 6 then
				item.remove()
				return
			end
			pc.remove_item(s.BoxLv6, 1)
			d.setf("BoxLv6MaxUse", d.getf("BoxLv6MaxUse")-1)
			if number(0,d.getf("BoxLv6MaxUse")) == 0 then
				clear_server_timer("DevilTowerCheck", d.get_map_index())
				pc.give_item2(s.KeyRealLv6, 1)
				d.clear_regen()
			else
				pc.give_item2(s.KeyFakeLv6, 1)
				d.setf("CheckMap", 1)
			end
		end
		when 30302.use with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			if d.getf("level") != 6 then
				item.remove()
				return
			end
			d.notice(string.format("<%s> Has desifrado el %s! Seran teletransportados al nivel 7!", s.DungeonName, item_name(s.KeyRealLv6)))
			pc.remove_item(s.KeyRealLv6, 1)
			server_timer("DevilTowerJumps", 5, d.get_map_index())
			d.setf("level", 7)
			if party.is_party() then
				party.setf("level",d.getf("level"))
			end
			d.clear_regen()
			d.purge()
		end
		when kill with DevilTowerRenewal.InDungeon() begin
			local s = DevilTowerRenewal.Setting()
			local mobVnum = npc.get_race()
			if mobVnum == s.KingLv2 then
				d.notice(string.format("<%s> %s Eliminado! Elimina las fuerzas demoniacas!", s.DungeonName, mob_name(npc.get_race())))
				d.check_eliminated()
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != 2 then
					party.setf("level",d.getf("level"))
				end
			elseif d.getf("level") == 3 then
				if mobVnum == s.StoneLv3 then
					d.setf("StoneLv3Prob", 0)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.notice(string.format("<%s> El %s ha sido destruido! Encuentra el %s real!", s.DungeonName, mob_name(npc.get_race()), mob_name(s.StoneLv3F)))
					for i = 1, table.getn(s.StoneLv3FPoss), 1 do
						d.spawn_mob_dir(s.StoneLv3F, s.StoneLv3FPoss[i][1],s.StoneLv3FPoss[i][2], 1)
					end
					server_timer('DevilTower10minLeft', 10*60, pc.get_map_index())
				elseif mobVnum == s.StoneLv3F then
					d.setf("StoneLv3Prob", d.getf("StoneLv3Prob")+1)
					if number(1,table.getn(s.StoneLv3FPoss)) <= d.getf("StoneLv3Prob") then
						d.notice(string.format("<%s> Has eliminado el %s real! Seran teletransportados al Nivel 4!", s.DungeonName, mob_name(s.StoneLv3F)))
						server_timer("DevilTowerJumps", 5, d.get_map_index())
						d.setf("level", 4)
						d.kill_all()
					else
						d.notice(string.format("<%s> El %s falso ha desaparecido!", s.DungeonName, mob_name(s.StoneLv3F)))
					end
				end
			elseif d.getf("level") == 4 then
				local n = d.getf("KillCountLv4") + 1
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				d.setf("KillCountLv4", n)
				if n == s.KillCountLv4Drop then
					d.notice(string.format("<%s> Has Encontrado %s!", s.DungeonName, item_name(s.KeyLv4)))
					game.drop_item_with_ownership(s.KeyLv4, 1)
					d.setf("KillCountLv4", 0)
				end
			elseif d.getf("level") == 5 then
				if mobVnum == s.KingLv5 then
					d.notice(string.format("<%s> %s Ha sido Derrotado!", s.DungeonName, mob_name(npc.get_race())))
					server_timer("DevilTowerDelay", 3, d.get_map_index())
					d.setf("LevelFinalsFloor", 0)
					d.clear_regen()
					d.kill_all()
				end
			elseif d.getf("level") == 6 then
				if mobVnum == s.StoneLv6 then
					local cont = d.getf("KillCountLv6") + 1
					d.setf("KillCountLv6", cont)
					if cont >= table.getn(s.StoneLv6Poss) then
						d.setf("CheckMap", 0)
						d.setf("KillCountLv6", 0)
						d.set_regen_file("data/dungeon/DevilTower/regen6.txt")
						server_loop_timer("DevilTowerCheck", 5, d.get_map_index())
						d.spawn_mob_dir(s.StoneMLv6 ,s.StoneMLv6Poss[1], s.StoneMLv6Poss[2], 1)
					end
				end
				if mobVnum == s.StoneMLv6 then
					d.setf("CheckMap", 0)
					game.drop_item_with_ownership(s.BoxLv6, 1)
				end
			elseif d.getf("level") == 7 then
				local n = d.getf("KillCountLv7") + 1
				d.setf("KillCountLv7", n)
				if n == s.KillCountLv7Drop then
					if number(1,3) == 1 and d.getf("DropKeyLv7") == 0 then
						d.notice(string.format("<%s> Has Encontrado %s!", s.DungeonName, item_name(s.KeyLv7)))
						game.drop_item_with_ownership(s.KeyRealLv7, 1)
						d.setf("DropKeyLv7", 1)
					else
						d.notice(string.format("<%s> Has Encontrado %s!", s.DungeonName, item_name(s.KeyLv7)))
						game.drop_item_with_ownership(s.KeyFakeLv7, 1)
					end
					d.setf("KillCountLv7", 0)
				end
			elseif d.getf("level") == 8 then
				if mobVnum == s.FinalBoss then
					d.notice(string.format("<%s> Has eliminado al %s!", s.DungeonName, mob_name(npc.get_race())))
					d.setf("BlackSmith", s.BlackSmith[number(1,table.getn(s.BlackSmith))])
					server_timer("DevilTowerDelay", 3, d.get_map_index())
					d.setqf("CanRefine", 1)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						notice_all(string.format("El Grupo de %s ha Derrtotado al %s!",pc.get_name(),mob_name(s.FinalBoss)))
						local pids = {party.get_member_pids()}
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
						notice_all(string.format("%s ha Derrtotado al %s!",pc.get_name(),mob_name(s.FinalBoss)))
					end
				end
			end
		end
		when DevilTowerCheck.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has eliminado las fuerzas del %s ! Seran teletransportados al Nivel 3!", s.DungeonName, mob_name(s.KingLv2)))
						server_timer("DevilTowerJumps", 5, d.get_map_index())
						d.setf("level", 3)
						d.purge()
						return
					end
				elseif d.getf("level") == 6 then
					if d.getf("CheckMap") == 1 then
						d.spawn_mob_dir(s.StoneMLv6 ,s.StoneMLv6Poss[1], s.StoneMLv6Poss[2], 1)
						d.setf("CheckMap", 0)
					end
				end
			else
				clear_server_timer("DevilTowerCheck", get_server_timer_arg())
			end
		end
		when DevilTowerJumps.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 3 then
					d.notice(string.format("Nivel 3 ~ Destruye %s! Encuentra el %s real!", mob_name(s.StoneLv3), mob_name(s.StoneLv3F)))
					d.spawn_mob_dir(s.StoneLv3, s.StoneLv3Poss[1], s.StoneLv3Poss[2], 1)
				elseif d.getf("level") == 4 then
					d.notice(string.format("Nivel 4 ~ Desbloquea %s! Usando los %s!", mob_name(s.aStoneLv4), item_name(s.KeyLv4)))
					server_timer('DevilTower10secLeft', 20*60, d.get_map_index())
					d.set_regen_file("data/dungeon/DevilTower/regen4.txt")
					d.setf("StoneLv4Count", 5)
					d.setf("KillCountLv4", 0)
					for i = 1, table.getn(s.aStoneLv4Poss) do
						d.spawn_mob_dir(s.aStoneLv4, s.aStoneLv4Poss[i][1],s.aStoneLv4Poss[i][2], s.aStoneLv4Poss[i][3])
					end
				elseif d.getf("level") == 5 then
					d.notice(string.format("Nivel 5 ~ Elimina al %s! Invoca al Herrero Demoniaco!", mob_name(s.KingLv5)))
					d.spawn_mob_dir(s.KingLv5, s.KingLv5Poss[1], s.KingLv5Poss[2], 1)
					d.regen_file("data/dungeon/DevilTower/regen5.txt")
				elseif d.getf("level") == 7 then
					d.notice(string.format("Nivel 7 ~ Encuentra la %s! Desbloquea la %s!", item_name(s.KeyRealLv7), mob_name(s.aStoneLv7)))
					d.spawn_mob_dir(s.aStoneLv7, s.aStoneLv7Poss[1], s.aStoneLv7Poss[2], 6)
					d.set_regen_file("data/dungeon/DevilTower/regen7.txt")
					d.setf("KillCountLv7", 0)
					d.setf("DropKeyLv7", 0)
				elseif d.getf("level") == 8 then
					d.notice(string.format("Nivel 8 ~Elimina al %s!", mob_name(s.FinalBoss)))
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], 1))
					d.regen_file("data/dungeon/DevilTower/regen8.txt")
				end
				d.jump_all(s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1], s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2])
			end
		end
		when DevilTowerStart.timer begin
			local s = DevilTowerRenewal.Setting()
			d.new_jump_all(s.Index, s.IndexCoord[1] + s.IndexPoss[2][1], s.IndexCoord[2] + s.IndexPoss[2][2])
		end
		when LoginFinalFloor.timer begin
			local s = DevilTowerRenewal.Setting()
			d.new_jump_all(s.Index, s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1], s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2])
		end
		when ExitsFinalFloor.timer begin
			local s = DevilTowerRenewal.Setting()
			pc.warp((s.OutDoorCord[1]+s.OutDoorPoss[1])*100, (s.OutDoorCord[2]+s.OutDoorPoss[2])*100)
		end
		when DevilTowerDelay.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				local i = d.getf("BlackSmith")
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 5 then
					d.notice("El Demonio Legendario ha sido Invocado!")
					d.spawn_mob_dir(s.aStoneLv5, s.aStoneLv5Poss[1],s.aStoneLv5Poss[2], 1)
				elseif d.getf("level") == 8 then
					d.notice(string.format("<%s> El %s ha sido Invocado!", d.getf("BlackSmith"), s.DungeonName ))
					d.spawn_mob_dir(i,s.BlackSmithPoss[1], s.BlackSmithPoss[2], 1)
					d.notice(string.format("El sello de la %s se esta recuperando! 1min Restantes!", s.DungeonName))
					server_timer("DevilTowerEndTimerss", 60*1, d.get_map_index())
					d.setf("level", 99)
				end
			end
		end
		when DevilTower10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				server_timer('DevilTower05minLeft', 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DevilTower05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				server_timer('DevilTower10secLeft', 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DevilTower10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				server_timer('DevilTowerEndTimerss',  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when DevilTowerEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilTowerRenewal.Setting()
				d.set_warp_location(s.OutDoorIndex,s.OutDoorCord[1], s.OutDoorCord[2])
				d.setf("DevilTowerRenewalFail", 1)
				d.exit_all()
			end
		end
	end
end
