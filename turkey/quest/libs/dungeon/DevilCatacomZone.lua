quest DevilCatacomZone begin
	state start begin
		function Setting()
			if DevilCatacomZone.Settings == nil then
				DevilCatacomZone.Settings = {
				["DungeonName"] = "Catacumbas del Diablo",
				["DungeonInfoIndex"] = 4,
				["Level"] = 75,
				["TimeLimit"] = 45,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20367,
				["KeyItem"] = 30320,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 216,
				["IndexCoord"] = {3072,12032},
				["IndexPoss"] = {{73,63},{550,45},{1378,249},{70,592},{846,898},{1362,666},{73,1156}},
				["Outdoor"] = 65,
				["OutdoorCoord"] = {5376,512},
				["OutdoorPoss"] = {541,489},
				---------------------------------------
				---------------------------------------
				["aStoneLv1"] = 30101,
				["aStoneLv1Poss"] = {307,323},
				["KillCountLv1Drop"] = 100,
				["KeyLv1"] = 30311,
				["aStoneLv2"] = 30103,
				["aStoneLv2Poss"] = {742,233},
				["KillCountLv2"] = 5,
				["mStoneLv2"] = 30111,
				["mStoneLv2Poss"] = {{566,119,5},{562,313,5},{665,434,7},{883,434,7},{743,390,3},{612,251,1},{654,213,5},{709,338,7},{777,336,7},{733,294,3},{694,271,1},
									 {942,143,5},{942,247,5},{942,323,5},{765, 64,7},{643,116,3},{900,167,1},{850,295,5},{717,164,7},{819,162,7},{802,277,1},{800,241,1}},
				["StoneLv3"] = 8038,
				["StoneLv3Poss"] = {{1366,150},{1366,351},{1234,365},{1234,140},{1150,135},{1130,365},{1135,253}},
				["aStoneLv4"] = 30104,
				["aStoneLv4Poss"] = {500,717},
				["aStoneLv5"] = 30102,
				["aStoneLv5Poss"] = {848,735},
				["KeyLv5"] = 30312,
				["KingLv5"] = 2591,
				["KingLv5Poss"] = {{683,825},{701,644},{849,581},{999,646},{998,850}},
				["KingLv6"] = 2597,
				["KingLv6Poss"] = {1303,704},
				["FinalBoss"] = 2598,
				["FinalBossPoss"] = {74,1103},
				}
			end
			return DevilCatacomZone.Settings
		end
		function InDungeon()
			local s = DevilCatacomZone.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20367.chat.gameforge.npc.dungeon0040 with not DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DevilCatacomZone.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DevilCatacomZone.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("DevilCatacomZoneIndex"))
				else
					game.set_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."",0)
					return
				end
			elseif pc.get_level() < s.Level then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc001,s.Level, s.DungeonName))
				return
			elseif party.is_party() and party.get_near_count() < s.PartyMinCount then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc002,s.DungeonName, s.PartyMinCount))
				return
			elseif party.is_party() and not party.is_leader() then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc003,s.DungeonName))
				return
			elseif pc.getqf("TimeToRetry") > get_time() then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc015, TimeToWait))
				say("")
				return
			elseif pc.count_item (s.KeyItem) < s.KeyCount then
				say_red(gameforge.dungeon.msm001)
				say_white(string.format(gameforge.dungeon.npc017, item_name(s.KeyItem), s.KeyCount))
				say_item (item_name(s.KeyItem) , s.KeyItem , "")
				say("")
				return
			end
			say(gameforge.npc.dungeon0041)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0042)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = DevilCatacomZone.Setting()
					for i, pid in next, pids, nil do
						q.begin_other_pc_block(pid)
						if s.KeyItemType == 1 then 
							if pc.count_item (s.KeyItem) < s.KeyCount then
								table.insert(cantEnterMembersItem[1], pc.get_name())
							end
						end
						if pc.get_level() < s.Level then
							table.insert(cantEnterMembersLvls[1], pc.get_name())
						end
						q.end_other_pc_block()
					end
					if party.get_member_pids() == nil then
						return
					elseif table.getn(cantEnterMembersItem[1]) > 0 and s.KeyItemType == 1 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say_white(string.format(gameforge.dungeon.npc004, item_name(s.KeyItem), s.KeyCount))
						say_item (item_name(s.KeyItem) , s.KeyItem , "")
						say_white(gameforge.dungeon.msm004)
						for i = 1, table.getn(cantEnterMembersItem[1]) do
							say(color(1,1,0), "  "..cantEnterMembersItem[1][i])
						end
						say("")
						return
					elseif table.getn(cantEnterMembersLvls[1]) > 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say(string.format(gameforge.dungeon.npc005, s.Level))
						say("")
						say_white(gameforge.dungeon.msm004)
						for i = 1, table.getn(cantEnterMembersLvls[1]) do
							say(color(1,1,0), "  "..cantEnterMembersLvls[1][i])
						end
						say("")
						return
					end
				end
				if s.KeyItemType == 0 then
					if pc.count_item (s.KeyItem) < s.KeyCount then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", s.DungeonName))
						say_red(gameforge.dungeon.msm001)
						say("")
						return
					end
					pc.remove_item(s.KeyItem, s.KeyCount)
				end
				pc.setqf("DevilCatacomZone", 1)
				pc.setqf("DevilCatacomZoneRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when logout with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			timer("DevilCatacomZoneRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DevilCatacomZoneFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."",0)
				pc.setqf("DevilCatacomZoneRelogin", 0)
			end
		end
		when login with not DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."",0)
				pc.setqf("DevilCatacomZoneRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when DevilCatacomZoneExit.timer begin
			local s = DevilCatacomZone.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when DevilCatacomZoneRelogin.timer begin
			local s = DevilCatacomZone.Setting()
			pc.setqf("DevilCatacomZoneRelogin", 0)
			game.set_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."",0)
		end
		when login with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if pc.getqf("DevilCatacomZoneRelogin") == d.get_map_index() then
				return
			end
			if pc.getqf("TimeToRetry") > get_time() then
				local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", s.DungeonName))
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc015, TimeToWait))
				say_gold(gameforge.dungeon.npc016)
				say("")
				timer("DevilCatacomZoneExit", 5)
				return
			end
			if s.KeyItemType == 1 then
				if pc.count_item (s.KeyItem) < s.KeyCount then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say_red(gameforge.dungeon.msm001)
					say("")
					timer("AncientPyramidExit", 5)
					return
				end
				pc.remove_item(s.KeyItem, s.KeyCount)
			end
			if party.is_party() then
				party.setf("IndexDungeon", d.get_map_index())
			end
			pc.setqf("DevilCatacomZoneRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("DevilCatacomZoneRelogin", s.TimeLimit*60)
			if pc.getqf("DevilCatacomZone") == 1 then
				game.set_event_flag("DevilCatacomZone_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("DevilCatacomZoneIndex", d.get_map_index())
				d.notice(string.format("~Nivel 1~ Encuentra la llave %s! Desbloquea el %s!", item_name(s.KeyLv1), mob_name(s.aStoneLv1)))
				d.spawn_mob_dir(s.aStoneLv1, s.aStoneLv1Poss[1], s.aStoneLv1Poss[2], 7)
				server_timer("DevilCatacomZone10minLeft", (s.TimeLimit-10)*60, d.get_map_index())
				d.set_regen_file("data/dungeon/DevilCatacomZone/regen1.txt")
				d.setf("DropKeyLv1", 0)
				d.setf("KillCountLv1", 0)
				pc.setqf("DevilCatacomZone", 0)
				d.setf("level", 1)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			end
		end
		when 30101.take with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if d.getf("level") == 1 and item.get_vnum() == s.KeyLv1 then
				d.notice(string.format("%s~ %s Verificada! Seran Teletransportados al Nivel 2!",mob_name(s.aStoneLv1),item_name(s.KeyLv1)))
				server_timer("DevilCatacomZoneJumpTimer", 5, d.get_map_index())
				d.setf("level", 2)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.clear_regen()
				item.remove()
				d.purge()
			end
		end
		when 30102.take with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if d.getf("level") == 5 and item.get_vnum() == s.KeyLv5 then 
				d.notice(string.format("%s~ %s Verificada! Seran Teletransportados al Nivel 6!",mob_name(s.aStoneLv5),item_name(s.KeyLv5)))
				server_timer("DevilCatacomZoneJumpTimer", 5, d.get_map_index())
				d.setf("level", 6)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.clear_regen()
				item.remove()
				d.purge()
			end
		end
		when 30103.click with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if d.getf("level") == 2 and d.getf("KillCountLv2") >= s.KillCountLv2 then
				d.notice(string.format("%s~ Activada! Has Liberado el Sello Maldito! Seran Teletransportados al Nivel 3!",mob_name(s.aStoneLv2)))
				server_timer("DevilCatacomZoneJumpTimer", 5, d.get_map_index())
				d.setf("level", 3)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.clear_regen()
				d.purge()
			else
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say_red(gameforge.dungeon.msm001)
				say_gold(string.format("[ENTER]¡Karma Insuficiente![ENTER]"))
				return
			end
		end
		when 30104.click with DevilCatacomZone.InDungeon() begin
			local s = DevilCatacomZone.Setting()
			if d.getf("level") == 4 then
				d.notice(string.format("%s~ Activado! Has Liberado el Sello Maldito! Seran Teletransportados al Nivel 5!",mob_name(s.aStoneLv4)))
				server_timer("DevilCatacomZoneJumpTimer", 5, d.get_map_index())
				d.setf("level", 5)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.clear_regen()
				d.purge()
			end
		end
		when kill with DevilCatacomZone.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = DevilCatacomZone.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 1 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local n = d.getf("KillCountLv1") + 1
				d.setf("KillCountLv1", n)
				if n == s.KillCountLv1Drop then
					if d.getf("DropKeyLv1") == 0 then
						d.notice(string.format("Encontraste %s! Libera el Sello de la %s", item_name(s.KeyLv1), mob_name(s.aStoneLv1)))
						game.drop_item_with_ownership(s.KeyLv1, 1)
						d.setf("DropKeyLv1", 1)
					end
				end
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.mStoneLv2 then
					d.notice(string.format("Has Destruido una %s! Ha Aumentado el Karma!", mob_name(npc.get_race())))
					d.setf("KillCountLv2", d.getf("KillCountLv2")+1)
				end
			elseif d.getf("level") == 3 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv3 then
					d.setf("probStoneLv3", d.getf("probStoneLv3")+1)
					if number(1,table.getn(s.StoneLv3Poss)) <= d.getf("probStoneLv3") then
						d.notice(string.format("Has Eliminado el %s Real! Seran Teletransportados al Nivel 4",mob_name(npc.get_race())))
						server_timer("DevilCatacomZoneJumpTimer", 5, d.get_map_index())
						d.setf("level", 4)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						pc.setqf("level", d.getf("level"))
						d.clear_regen()
						d.kill_all()
					else
						d.notice(string.format("¡Incorrecto! El %s era Falso!",mob_name(npc.get_race())))
					end
				end
			elseif d.getf("level") == 5 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv5 then
					d.notice(string.format("Encontraste %s! Libera el Sello de la %s", item_name(s.KeyLv5), mob_name(s.aStoneLv5)))
					game.drop_item_with_ownership(s.KeyLv5, 1)
				end
			elseif d.getf("level") == 6 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv6 then
					d.notice(string.format("Has Eliminado al %s! Seran Teletransportados al Nivel 7!", mob_name(npc.get_race())))
					server_timer("DevilCatacomZoneJumpTimer", 10, d.get_map_index())
					d.setf("level", 7)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					d.clear_regen()
				end
			elseif d.getf("level") == 7 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado a %s! El Sello de la %s se esta Recuperando! 3min Restantes!", mob_name(npc.get_race()),s.DungeonName))
					server_timer("DevilCatacomZoneEndTimers", 60*3, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						local pids = {party.get_member_pids()}
						notice_all(string.format("El Grupo de %s ha Derrtotado a %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss)))
						party.setf("level",d.getf("level"))
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						pc.setqf("level", d.getf("level"))
						notice_all(string.format("Increible! %s ha Derrtotado a %s!",pc.get_name(),mob_name(s.FinalBoss)))
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
					end
				end
			end
		end
		when DevilCatacomZoneJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilCatacomZone.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.notice(string.format("~Nivel 2~ Desbloquea la %s! Destruye las %s & Aumenta el Karma!", mob_name(s.aStoneLv2), mob_name(s.mStoneLv2)))
					d.spawn_mob_dir(s.aStoneLv2, s.aStoneLv2Poss[1],s.aStoneLv2Poss[2],3)
					d.set_regen_file("data/dungeon/DevilCatacomZone/regen2.txt")
					d.setf("KillCountLv2", 0)
					for i = 1, table.getn(s.mStoneLv2Poss), 1  do 
						d.spawn_mob_dir(s.mStoneLv2, s.mStoneLv2Poss[i][1],s.mStoneLv2Poss[i][2],s.mStoneLv2Poss[i][3])
					end
				elseif d.getf("level") == 3 then
					d.notice(string.format("~Nivel 3~ Destruye el %s Real!", mob_name(s.StoneLv3)))
					d.set_regen_file("data/dungeon/DevilCatacomZone/regen3.txt")
					d.setf("probStoneLv3", 0)
					for i = 1, table.getn(s.StoneLv3Poss), 1  do 
						d.spawn_mob_dir(s.StoneLv3, s.StoneLv3Poss[i][1],s.StoneLv3Poss[i][2],1)
					end
				elseif d.getf("level") == 4 then
					d.notice(string.format("~Nivel 4~ Encuentra el camino al Final del Laberinto! Encuentra el %s!", mob_name(s.aStoneLv4)))
					d.spawn_mob_dir(s.aStoneLv4, s.aStoneLv4Poss[1], s.aStoneLv4Poss[2], 5)
					d.regen_file("data/dungeon/DevilCatacomZone/regen4_"..number(1,5)..".txt")
					d.set_regen_file("data/dungeon/DevilCatacomZone/regen4.txt")
				elseif d.getf("level") == 5 then
					local n = number(1,table.getn(s.KingLv5Poss))
					d.notice(string.format("~Nivel 5~ Desbloquea el %s! Elimina al %s & Encuentra el %s", mob_name(s.aStoneLv5), mob_name(s.KingLv5), item_name(s.KeyLv5)))
					d.spawn_mob_dir(s.aStoneLv5, s.aStoneLv5Poss[1], s.aStoneLv5Poss[2], 5)
					d.spawn_mob_dir(s.KingLv5, s.KingLv5Poss[n][1], s.KingLv5Poss[n][2], 5)
					d.set_regen_file("data/dungeon/DevilCatacomZone/regen5.txt")
				elseif d.getf("level") == 6 then
					d.notice(string.format("~Nivel 6~ Elimina a %s!", mob_name(s.KingLv6)))
					d.spawn_mob_dir(s.KingLv6, s.KingLv6Poss[1], s.KingLv6Poss[2], 5)
					d.regen_file("data/dungeon/DevilCatacomZone/regen6.txt")
				elseif d.getf("level") == 7 then
					d.notice(string.format("~Nivel 7~ Elimina a %s!", mob_name(s.FinalBoss)))
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], 7))
					d.regen_file("data/dungeon/DevilCatacomZone/regen7.txt")
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when DevilCatacomZone10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilCatacomZone.Setting()
				server_timer("DevilCatacomZone05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DevilCatacomZone05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilCatacomZone.Setting()
				server_timer("DevilCatacomZone10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DevilCatacomZone10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilCatacomZone.Setting()
				server_timer("DevilCatacomZoneEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when DevilCatacomZoneEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DevilCatacomZone.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("DevilCatacomZone_"..pc.getqf("DevilCatacomZoneIndex").."",0)
				d.setf("DevilCatacomZoneFail", 1)
				d.exit_all()
			end
		end
	end
end
