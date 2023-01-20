quest AncientPyramid begin
	state start begin
		function Setting()
			if AncientPyramid.Settings == nil then
				AncientPyramid.Settings = {
				["DungeonName"] = "Piramide Kefren",
				["DungeonInfoIndex"] = 13,
				["Level"] = 105,
				["TimeLimit"] = 90,
				["TimeToRetry"] = 2,
				["PartyMinCount"] = 2,
				["NPC"] = 20601,
				["KeyItem"] = 30401,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 252,
				["IndexCoord"] = {11728,7168},
				["IndexPoss"] = {{91,89},{306,96},{577,84},{96,427},{177,1030},{810,1128}},
				["Outdoor"] = 251,
				["OutdoorCoord"] = {9728,7168},
				["OutdoorPoss"] = {915,582},
				---------------------------------------
				---------------------------------------
				["StoneLv1"] = 8075,
				["StoneLv1Poss"] = {91,151},
				["KeyLv2"] = 30404,
				["aStoneLv2"] = 20602,
				["aStoneLv2Poss"] = {306,157},
				["KingLv2"] = 4049,
				["KingLv2Poss"] = {306,157},
				["StoneLv3"] = 8076,
				["StoneLv3Poss"] = {{567,111},{567,128},{567,145},{567,162},{567,179},{587,111},{587,128},{587,145},{587,162},{587,179}},
				["KingLv3"] = 4050,
				["KingLv3Poss"] = {577,182},
				["KingLv4"] = 4051,
				["KingLv4Poss"] = {1034,189},
				["KeyLv5"] = 30403,
				["KingLv5"] = 4052,
				["KingLv5Poss"] = {177,1030},
				["StoneLv5"] = 8074,
				["StoneLv5Poss"] = {{186,1022},{169,1022},{186,1039},{169,1039}},
				["aStoneLv5"] = 20603,
				["aStoneLv5Poss"] = {{{191,1043,6},{164,1043,4},{164,1017,2},{191,1017,8}},{{191,1043,6},{164,1043,4},{191,1017,8},{164,1017,2}},
									 {{191,1043,6},{164,1017,2},{164,1043,4},{191,1017,8}},{{191,1043,6},{164,1017,2},{191,1017,8},{164,1043,4}},
									 {{191,1043,6},{191,1017,8},{164,1043,4},{164,1017,2}},{{191,1043,6},{191,1017,8},{164,1017,2},{164,1043,4}},
									 {{164,1043,4},{191,1043,6},{164,1017,2},{191,1017,8}},{{164,1043,4},{191,1043,6},{191,1017,8},{164,1017,2}},
									 {{164,1043,4},{164,1017,2},{191,1043,6},{191,1017,8}},{{164,1043,4},{164,1017,2},{191,1017,8},{191,1043,6}},
									 {{164,1043,4},{191,1017,8},{191,1043,6},{164,1017,2}},{{164,1043,4},{191,1017,8},{164,1017,2},{191,1043,6}},
									 {{164,1017,2},{191,1043,6},{164,1043,4},{191,1017,8}},{{164,1017,2},{191,1043,6},{191,1017,8},{164,1043,4}},
									 {{164,1017,2},{164,1043,4},{191,1043,6},{191,1017,8}},{{164,1017,2},{164,1043,4},{191,1017,8},{191,1043,6}},
									 {{164,1017,2},{191,1017,8},{191,1043,6},{164,1043,4}},{{164,1017,2},{191,1017,8},{164,1043,4},{191,1043,6}},
									 {{191,1017,8},{191,1043,6},{164,1043,4},{164,1017,2}},{{191,1017,8},{191,1043,6},{164,1017,2},{164,1043,4}},
									 {{191,1017,8},{164,1043,4},{191,1043,6},{164,1017,2}},{{191,1017,8},{164,1043,4},{164,1017,2},{191,1043,6}},
									 {{191,1017,8},{164,1017,2},{191,1043,6},{164,1043,4}},{{191,1017,8},{164,1017,2},{164,1043,4},{191,1043,6}}},
				["StoneLv6"] = 8077,
				["StoneLv6Poss"] = {{950,1106},{920,1116},{920,1170},{950,1180},{934,1143},{975,1157},{975,1128}},
				["mStoneLv6"] = 8078,
				["mStoneLv6Poss"] = {976,1143},
				["aStoneLv6"] = 20607,
				["aStoneLv6Poss"] = {{1004,1172},{1004,1113}},
				["KeyLv6"] = 30402,
				["KeyStoneLv6"] = 20608,
				["KeyStoneLv6Poss"] = {{989,1135},{989,1139},{989,1143},{989,1147},{989,1151}},
				["StoneBossLv6"] = 20609,
				["StoneBossLv6Poss"] = {1017,1143},
				["BoxChestrLv6"] = 20610,
				["BoxChestrLv6Poss"] = {989,1143},
				["BoxChestrItem"] = 30408,
				["FinalBoss"] = 4053,
				["FinalBossPoss"] = {1017,1143},
				}
			end
			return AncientPyramid.Settings
		end
		function InDungeon()
			local s = AncientPyramid.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20601.chat.gameforge.npc.dungeon0130 with not AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = AncientPyramid.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = AncientPyramid.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("AncientPyramidIndex"))
				else
					game.set_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."",0)
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
			say(string.format(gameforge.npc.dungeon0131,s.DungeonName, s.DungeonName))
			wait( )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(string.format(gameforge.npc.dungeon0132,s.DungeonName))
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = AncientPyramid.Setting()
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
				pc.setqf("AncientPyramid", 1)
				pc.setqf("AncientPyramidRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when logout with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			timer("AncientPyramidRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("AncientPyramidFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."",0)
				pc.setqf("AncientPyramidRelogin", 0)
			end
		end
		when login with not AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."",0)
				pc.setqf("AncientPyramidRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when AncientPyramidExit.timer begin
			local s = AncientPyramid.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when AncientPyramidRelogin.timer begin
			local s = AncientPyramid.Setting()
			pc.setqf("AncientPyramidRelogin", 0)
			game.set_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."",0)
		end
		when login with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			if pc.getqf("AncientPyramidRelogin") == d.get_map_index() then
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
				timer("AncientPyramidExit", 5)
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
			pc.setqf("AncientPyramidRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("AncientPyramidRelogin", s.TimeLimit*60)
			if pc.getqf("AncientPyramid") == 1 then
				game.set_event_flag("AncientPyramid_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("AncientPyramidIndex", d.get_map_index())
				d.notice(string.format("~Nivel 1~ Destruye el %s! Avanza a lo Profundo de la %s!", mob_name(s.StoneLv1),s.DungeonName))
				d.spawn_mob_dir(s.StoneLv1, s.StoneLv1Poss[1], s.StoneLv1Poss[2], 5)
				server_timer("AncientPyramid10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("AncientPyramid", 0)
				d.setf("level", 1)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			end
		end
		when 20602.take with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			if item.get_vnum() <= s.KeyLv2+3 and item.get_vnum() >= s.KeyLv2 then
				for key = s.KeyLv2, s.KeyLv2+3, 1  do
					if pc.count_item(key) == 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", mob_name(npc.get_race())))
						say_red(gameforge.dungeon.msm001)
						say_gold("[ENTER]!Faltan Inscripciones![ENTER]")
						say_item(""..item_name(key).."", key, "")
						say("")
						return
					end
				end
				for keyDell = s.KeyLv2, s.KeyLv2+3, 1  do
					pc.remove_item(keyDell, 1)
				end
				npc.kill()
				d.notice(string.format("%s~ Inscripciones Antiguas Verificadas! %s ha Despertado, Eliminalo!",mob_name(npc.get_race()),mob_name(s.KingLv2)))
				d.spawn_mob_dir(s.KingLv2, s.KingLv2Poss[1], s.KingLv2Poss[2], 5)
			end
		end
		when 20603.take or 20604.take or 20605.take or 20606.take with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			local itemVnum = item.get_vnum()
			local i = d.getf("lv5C")
			if itemVnum == s.KeyLv5 then
				item.remove()
				if d.getf("lvl5stp") == 0 then
					return
				elseif d.getf("lvl5stp") == 1 and npc.get_race() == s.aStoneLv5+0 then
					npc.kill()
					d.setf("lvl5stp", d.getf("lvl5stp")+1)
					d.notice(string.format("Correcto! La Primera %s ha sido Destruida!",mob_name(s.aStoneLv5)))
					for i = 1, 4, 1  do
						d.spawn_mob_dir(s.StoneLv5, s.StoneLv5Poss[i][1],s.StoneLv5Poss[i][2], 7)
					end
				elseif d.getf("lvl5stp") == 2 and npc.get_race() == s.aStoneLv5+1 then
					npc.kill()
					d.setf("lvl5stp", d.getf("lvl5stp")+1)
					d.notice(string.format("Correcto! La Segunda %s ha sido Destruida!",mob_name(s.aStoneLv5)))
					for i = 1, 4, 1  do
						d.spawn_mob_dir(s.StoneLv5, s.StoneLv5Poss[i][1],s.StoneLv5Poss[i][2], 7)
					end
				elseif d.getf("lvl5stp") == 3 and npc.get_race() == s.aStoneLv5+2 then
					npc.kill()
					d.setf("lvl5stp", d.getf("lvl5stp")+1)
					d.notice(string.format("Correcto! La Tercera %s ha sido Destruida!",mob_name(s.aStoneLv5)))
					for i = 1, 4, 1 do
						d.spawn_mob_dir(s.StoneLv5, s.StoneLv5Poss[i][1],s.StoneLv5Poss[i][2], 7)
					end
				elseif d.getf("lvl5stp") == 4 and npc.get_race() == s.aStoneLv5+3 then
					d.notice(string.format("Correcto! La Cuarta %s ha sido Destruida! El %s Esta Aproximandose!",mob_name(s.aStoneLv5), mob_name(s.KingLv5)))
					server_timer("AncientPyramidDelay", 10, d.get_map_index())
					npc.kill()
					d.purge()
				else
					d.notice(string.format("Incorrecto! Has Fallado al Destruir La %s!",mob_name(s.aStoneLv5)))
					if d.getf("lvl5stp") != 1 then
						d.notice(string.format("Las %s Destruidas se han Regenerado!",mob_name(s.aStoneLv5)))
					end
					d.setf("lvl5stp", 1)
					d.regen_file("data/dungeon/AncientPyramid/regen5.txt")
					for j = 1, 4, 1  do
						d.spawn_mob_dir(s.StoneLv5, s.StoneLv5Poss[j][1],s.StoneLv5Poss[j][2], 7)
						if d.is_unique_dead("aSt"..j.."") then
							d.set_unique("aSt"..j.."", d.spawn_mob_dir(s.aStoneLv5+j-1, s.aStoneLv5Poss[i][j][1], s.aStoneLv5Poss[i][j][2], s.aStoneLv5Poss[i][j][3]))
						end
					end
				end
			end
		end
		when 20607.take with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			local itemVnum = item.get_vnum()
			if itemVnum == s.KeyLv6 then
				npc.kill()
				item.remove()
				d.setf("KeyStatus", 0)
				d.setf("StoneKeyCountLv6", d.getf("StoneKeyCountLv6")+1)
				d.notice(string.format("El %s ha sido Destruido!",mob_name(s.aStoneLv6)))
				if d.getf("StoneKeyCountLv6") == 2 then
					d.notice(string.format("La %s Esta Fracturandose! La %s Esta Recusitando!",mob_name(s.StoneBossLv6), mob_name(s.FinalBoss)))
					server_timer("AncientPyramidDelay", 10, d.get_map_index())
					d.setf("DelayLv6", 2)
					for i = 1, table.getn(s.KeyStoneLv6Poss), 1  do
						if not d.is_unique_dead("aKt"..i.."") then
							d.purge_unique("aKt"..i.."")
						end
					end
				end
			end
		end
		when 20608.click with AncientPyramid.InDungeon() begin
			local s = AncientPyramid.Setting()
			if d.count_monster() == 0 and d.getf("KeyStatus") == 0 then
				npc.purge()
				d.setf("probKeyLv6", d.getf("probKeyLv6")+1)
				if number(1,4) <= d.getf("probKeyLv6") then
					d.setf("KeyStatus", 1)
					pc.give_item2(s.KeyLv6, 1)
					d.notice(string.format("Correcto! Has Conseguido %s! Desbloquea Los %s",item_name(s.KeyLv6),mob_name(s.aStoneLv6)))
				else
					d.setf("KeyStatus", 1)
					d.notice(string.format("Incorrecto! La %s era Falsa! El Ejercito Kefren ha Lanzado un Ataque! Elimina la Orda!", mob_name(s.KeyStoneLv6)))
					d.regen_file("data/dungeon/AncientPyramid/regen6.txt")
					server_timer("AncientPyramidDelay", 10, d.get_map_index())
					d.setf("DelayLv6", 1)
					for i = 1, table.getn(s.StoneLv6Poss), 1  do 
						d.spawn_mob_dir(s.StoneLv6, s.StoneLv6Poss[i][1],s.StoneLv6Poss[i][2], 7)
					end
				end
			else
				if d.getf("KeyStatus") == 0 then
					
					return
				end
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say_red(gameforge.dungeon.msm001)
				say(string.format("[ENTER]!Falta %s Monstruos![ENTER]",d.count_monster()))
				say_gold("!Elimina todos los Monstruos en la Sala![ENTER]")
				return
			end
		end
		when kill with AncientPyramid.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = AncientPyramid.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 1 then
				if mobVnum == s.StoneLv1 then
					d.setf("level", 2)
					if party.is_party() and party.getf("level") != d.getf("level") then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					server_timer("AncientPyramidJump", 10, d.get_map_index())
					d.notice(string.format("Has Destruido el %s! Seran Teletransportados al Nivel 2!",mob_name(mobVnum)))
				end
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if d.getf("waves") != 4 then
					d.setf("mlv3Count", d.getf("mlv3Count")+1)
					if d.getf("mlv3Count") == 70 and mobVnum != s.KingLv2 then
						d.setf("mlv3Count", 0)
						game.drop_item_with_ownership(s.KeyLv2 + d.getf("waves"), 1)
						d.notice(string.format("Encontraste %s", item_name(s.KeyLv2 + d.getf("waves"))))
						d.setf("waves", d.getf("waves")+1)
						server_timer("AncientPyramidDelay", 10, d.get_map_index())
						if d.getf("waves") == 4 then
							d.notice(string.format("Has Sobrevivido al Ataque! Desbloquea %s Libera la Maldicio de Kefren", mob_name(s.aStoneLv2)))
						end
					end
				elseif mobVnum == s.KingLv2 then
					d.setf("level", 3)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					server_timer("AncientPyramidJump", 10, d.get_map_index())
					d.notice(string.format("Has Eliminado la %s! Seran Teletransportados al Nivel 3!",mob_name(mobVnum)))
				end
			elseif d.getf("level") == 3 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv2 then
					d.setf("probStoneLv3", d.getf("probStoneLv3")+1)
					if number(1,table.getn(s.StoneLv3Poss)) <= d.getf("probStoneLv3") then
						server_timer("AncientPyramidDelay", 1, d.get_map_index())
						d.notice(string.format("Has Eliminado La %s Real!", mob_name(mobVnum)))
					else
						d.notice(string.format("El %s Era una Ilusion! Encuentra La %s Real!", mob_name(mobVnum),mob_name(mobVnum)))
					end
				end
				if mobVnum == s.KingLv3 then
					d.setf("level", 4)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					server_timer("AncientPyramidJump", 10, d.get_map_index())
					d.notice(string.format("Has Eliminado La %s! Seran Teletransportados al Nivel 4!",mob_name(mobVnum)))
				end
			elseif d.getf("level") == 4 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv4 then
					d.clear_regen()
					d.setf("level", 5)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					server_timer("AncientPyramidJump", 10, d.get_map_index())
					d.notice(string.format("Has Eliminado al %s! Seran Teletransportados al Nivel 5!",mob_name(mobVnum)))
				end
			elseif d.getf("level") == 5 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv5 then
					d.setf("mlv5Count", d.getf("mlv5Count")+1)
					if d.getf("mlv5Count") == 4 then
						d.setf("mlv5Count", 0)
						d.spawn_mob_dir(s.KingLv3, s.KingLv5Poss[1],s.KingLv5Poss[2], 7)
						d.notice(string.format("Has Destruido los %s! %s ha Despertado, Eliminalo!",mob_name(mobVnum),mob_name(s.KingLv3)))
					end
				end
				if mobVnum == s.KingLv3 then
					game.drop_item_with_ownership(s.KeyLv5, 1)
					d.notice(string.format("Has Eliminado al %s! Encontraste %s",mob_name(mobVnum),item_name(s.KeyLv5)))
				end
				if mobVnum == s.KingLv5 then
					d.kill_all()
					d.setf("level", 6)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					server_timer("AncientPyramidJump", 10, d.get_map_index())
					d.notice(string.format("Has Eliminado al %s! Seran Teletransportados al Nivel 6!",mob_name(mobVnum)))
				end
			elseif d.getf("level") == 6 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.mStoneLv6 then
					d.notice(string.format("Invocaste Las %s! Encuentra 2 %s Reales!",mob_name(s.KeyStoneLv6),mob_name(s.KeyStoneLv6)))
					for i = 1, table.getn(s.KeyStoneLv6Poss), 1  do 
						d.set_unique("aKt"..i.."", d.spawn_mob_dir(s.KeyStoneLv6, s.KeyStoneLv6Poss[i][1],s.KeyStoneLv6Poss[i][2], 7))
					end
				end
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado la %s! El Tesoro Kefren es Revelado!", mob_name(npc.get_race()), s.DungeonName))
					server_timer("AncientPyramidDelay", 10, d.get_map_index())
					d.setf("DelayLv6", 3)
					d.kill_all()
					if party.is_party() then
						local pids = {party.get_member_pids()}
						notice_all(string.format("El Grupo de %s ha Derrtotado la %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss)))
						party.setf("level",d.getf("level"))
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						pc.setqf("level", d.getf("level"))
						notice_all(string.format("Increible! %s ha Derrtotado la %s!",pc.get_name(),mob_name(s.FinalBoss)))
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
					end
				end
				if mobVnum == s.BoxChestrLv6 then
					d.notice(string.format("Has Abierto el %s! El Sello del %s se esta Recuperando! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
					server_timer("AncientPyramidEndTimers", 60*3, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						party.setf("level",d.getf("level"))
					else
						pc.setqf("level", d.getf("level"))
					end
				end
			end
		end
		when AncientPyramidDelay.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					if d.getf("waves") != 4 then
						d.regen_file("data/dungeon/AncientPyramid/regen2.txt")
						d.notice(string.format("El Ejercito Kefren ha Lanzado un Ataque! Encuentra %s! Elimina las Defensas Kefren!",item_name(s.KeyLv2 + d.getf("waves"))))
					end
				elseif d.getf("level") == 3 then
					d.purge()
					d.spawn_mob_dir(s.KingLv3, s.KingLv3Poss[1], s.KingLv3Poss[2], 5)
					d.notice(string.format("%s ha Despertado, Eliminalo!", mob_name(s.KingLv3)))
				elseif d.getf("level") == 5 then
					d.spawn_mob_dir(s.KingLv5, s.KingLv5Poss[1], s.KingLv5Poss[2], 7)
					d.notice(string.format("%s ha Despertado, Eliminalo!",mob_name(s.KingLv5)))
				elseif d.getf("level") == 6 then
					if d.getf("DelayLv6") == 0 then
						return
					elseif d.getf("DelayLv6") == 1 then
						d.setf("KeyStatus", 0)
						d.setf("DelayLv6", 0)
					elseif d.getf("DelayLv6") == 2 then
						local s = AncientPyramid.Setting()
						d.kill_unique("StoneBoss")
						d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], 7))
						d.notice(string.format("%s ha Despertado, Eliminalo!",mob_name(s.FinalBoss)))
						d.setf("DelayLv6", 0)
					elseif d.getf("DelayLv6") == 3 then
						local s = AncientPyramid.Setting()
						d.set_unique("boxchest", d.spawn_mob_dir(s.BoxChestrLv6, s.BoxChestrLv6Poss[1], s.BoxChestrLv6Poss[2], 7))
						d.notice(string.format("Has Eliminado al %s el %s ha Aparecido! El Sello de la %s se esta Recuperando! 3min Restantes!", mob_name(s.FinalBoss), mob_name(s.BoxChestrLv6),s.DungeonName))
						d.setf("DelayLv6", 0)
					end
				end
			end
		end
		when AncientPyramidJump.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.setf("waves", 0)
					d.setf("mlv3Count", 0)
					d.regen_file("data/dungeon/AncientPyramid/regen2.txt")
					d.spawn_mob_dir(s.aStoneLv2, s.aStoneLv2Poss[1], s.aStoneLv2Poss[2], 1)
					d.notice(string.format("~Nivel 2~ Desbloquea %s Elimina los Monstruos Kefren & Encuentra Las %s",mob_name(s.aStoneLv2),item_name(s.KeyLv2)))
				elseif d.getf("level") == 3 then
					d.setf("probStoneLv3", 1)
					d.regen_file("data/dungeon/AncientPyramid/regen3.txt")
					d.notice(string.format("~Nivel 3~ Encuentra el %s Real al Interior de Los %s",mob_name(s.KingLv2), mob_name(s.StoneLv3)))
					for i = 1, table.getn(s.StoneLv3Poss), 1 do
						d.spawn_mob_dir(s.StoneLv3, s.StoneLv3Poss[i][1],s.StoneLv3Poss[i][2], 1)
					end
				elseif d.getf("level") == 4 then
					d.set_regen_file("data/dungeon/AncientPyramid/regen4.txt")
					d.spawn_mob_dir(s.KingLv4, s.KingLv4Poss[1], s.KingLv4Poss[2], 5)
					d.regen_file("data/dungeon/AncientPyramid/regen4_"..number(1,3)..".txt")
					d.notice(string.format("~Nivel 4~ Encuentra el camino al Final del Laberinto! Encuentra & Elimina al %s!",mob_name(s.KingLv4)))
				elseif d.getf("level") == 5 then
					d.setf("lvl5stp", 1)
					d.setf("mlv5Count", 0)
					d.setf("lv5C", number(1,table.getn(s.aStoneLv5Poss)))
					d.regen_file("data/dungeon/AncientPyramid/regen5.txt")
					d.notice(string.format("~Nivel 5~ Desbloquea las 4 %s en el Orden Correcto! Elimina los %s & Libera al %s",mob_name(s.aStoneLv5),mob_name(s.StoneLv5), mob_name(s.KingLv3)))
					for j = 1, 4, 1  do
						d.spawn_mob_dir(s.StoneLv5, s.StoneLv5Poss[j][1],s.StoneLv5Poss[j][2], 7)
						d.set_unique("aSt"..j.."", d.spawn_mob_dir(s.aStoneLv5+j-1, s.aStoneLv5Poss[d.getf("lv5C")][j][1], s.aStoneLv5Poss[d.getf("lv5C")][j][2], s.aStoneLv5Poss[d.getf("lv5C")][j][3]))
					end
				elseif d.getf("level") == 6 then
					d.setf("KeyStatus", 0)
					d.setf("probKeyLv6", 0)
					d.setf("StoneKeyCountLv6", 0)
					d.regen_file("data/dungeon/AncientPyramid/regen6.txt")
					d.set_unique("StoneBoss", d.spawn_mob_dir(s.StoneBossLv6, s.StoneBossLv6Poss[1],s.StoneBossLv6Poss[2], 7))
					d.spawn_mob_dir(s.mStoneLv6, s.mStoneLv6Poss[1],s.mStoneLv6Poss[2], 7)
					d.spawn_mob_dir(s.aStoneLv6, s.aStoneLv6Poss[1][1],s.aStoneLv6Poss[1][2], 7)
					d.spawn_mob_dir(s.aStoneLv6, s.aStoneLv6Poss[2][1],s.aStoneLv6Poss[2][2], 7)
					d.notice(string.format("~Nivel 6~ Despierta al %s! Destruye el %s & Desbloquea las 2 %s!",mob_name(s.FinalBoss),mob_name(s.mStoneLv6),mob_name(s.aStoneLv6)))
					for i = 1, table.getn(s.StoneLv6Poss), 1  do 
						d.spawn_mob_dir(s.StoneLv6, s.StoneLv6Poss[i][1],s.StoneLv6Poss[i][2], 7)
					end
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when AncientPyramid10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				server_timer("AncientPyramid05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when AncientPyramid05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				server_timer("AncientPyramid10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when AncientPyramid10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				server_timer("AncientPyramidEndTimers",  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when AncientPyramidEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = AncientPyramid.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("AncientPyramid_"..pc.getqf("AncientPyramidIndex").."",0)
				d.setf("AncientPyramidFail", 1)
				d.exit_all()
			end
		end
	end
end
