quest SnowTower begin
	state start begin
		function Setting()
			if SnowTower.Settings == nil then
				SnowTower.Settings = {
				["DungeonName"] = "Torre de Vigilancia",
				["DungeonInfoIndex"] = 8,
				["Level"] = 95,
				["TimeLimit"] = 75,
				["TimeToRetry"] = 1.5,
				["PartyMinCount"] = 2,
				["NPC"] = 20395,
				["KeyItem"] = 50135,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 352,
				["IndexCoord"] = {35120,31536},
				["IndexPoss"] = {{171,275},{762,275},{183,536},{422,265},{419,530},{572,700},{746,520},{303,710},{848,683},{927,391}},
				["Outdoor"] = 61,
				["OutdoorCoord"] = {3584,1536},
				["OutdoorPoss"] = {250,340},
				---------------------------------------
				---------------------------------------
				["aStoneLv1"] = 20397,
				["aStoneLv1Poss"] = {172,253,1},
				["KeyItemLv2"] = 30331,
				["KeyItemLv2Prob"] = 45,
				["KillCountLv2Drop"] = 100,
				["KingLv4"] = 6151,
				["KingLv4Poss"] = {420,130,1},
				["KeyItemLv5"] = 30332,
				["KillCountLv5Drop"] = 100,
				["aStoneLv5"] = 20398,
				["aStoneLv5Poss"] = {{452,493,1},{465,465,1},{440,420,1},{381,431,1},{372,469,1}},
				["StoneLv6"] = 8058,
				["StoneLv6Poss"] = {571,650,1},
				["KingLv7"] = 6151,
				["KingLv7Poss"] = {{720,490,1},{710,452,1},{780,450,1},{775,480,1}},
				["KeyItemLv8"] = 30333,
				["KeyItemLv8Prob"] = 35,
				["KillCountLv8Drop"] = 100,
				["StoneLv9"] = 20399,
				["StoneLv9Poss"] = {849,660,1},
				["FinalBoss"] = 6191,
				["FinalBossPoss"] = {927,333,1},
				}
			end
			return SnowTower.Settings
		end
		function InDungeon()
			local s = SnowTower.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20395.chat.gameforge.npc.dungeon0080 with not SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SnowTower.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SnowTower.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("SnowTowerIndex"))
				else
					game.set_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."",0)
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
			say("...")--
			wait( )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("...")--
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = SnowTower.Setting()
					--local HaveShaman = false
					--local HaveNinjas = false
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
						--if Job == 1 or Job == 5 then
						--	HaveNinjas = true
						--end
						--if Job == 3 or Job == 7 then
						--	HaveShaman = true
						--end
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
				--if HaveShaman == false then
				--	say_red(gameforge.dungeon.msm001)
				--	say(gameforge.dungeon.npc013)
				--	say(gameforge.dungeon.npc014)
				--	say("")
				--	return
				--end
				--if HaveNinja == false then
				--	say_red(gameforge.dungeon.msm001)
				--	say(gameforge.dungeon.npc011)
				--	say(gameforge.dungeon.npc014)
				--	say("")
				--	return
				--end
				pc.setqf("SnowTower", 1)
				pc.setqf("SnowTowerRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when logout with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			timer("SnowTowerRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("SnowTowerFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."",0)
				pc.setqf("SnowTowerRelogin", 0)
			end
		end
		when login with not SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."",0)
				pc.setqf("SnowTowerRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when SnowTowerExit.timer begin
			local s = SnowTower.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when SnowTowerRelogin.timer begin
			local s = SnowTower.Setting()
			pc.setqf("SnowTowerRelogin", 0)
			game.set_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."",0)
		end
		when login with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			if pc.getqf("SnowTowerRelogin") == d.get_map_index() then
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
				timer("SnowTowerExit", 5)
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
			pc.setqf("SnowTowerRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("SnowTowerRelogin", s.TimeLimit*60)
			if pc.getqf("SnowTower") == 1 then
				game.set_event_flag("SnowTower_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("SnowTowerIndex", d.get_map_index())
				d.notice(string.format("~Nivel 1~ Activa el %s! Elimina los Mounstruos de Hielo!", mob_name(s.aStoneLv1),s.DungeonName))
				d.spawn_mob_dir(s.aStoneLv1, s.aStoneLv1Poss[1], s.aStoneLv1Poss[2], s.aStoneLv1Poss[3])
				server_timer("SnowTower10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("SnowTower", 0)
				d.setf("level",1)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				else
					pc.setqf("level", d.getf("level"))
				end
			end
		end
		when 20397.chat."Liberar Sello" with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say("")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if d.getf("level") == 1 then
				if party.is_party() and not party.is_leader() then
					say_red(gameforge.dungeon.msm001)
					say(string.format(gameforge.dungeon.npc003,s.DungeonName))
					return
				end
				say("...")
				say("")
				d.notice(string.format("Elimina las Criaturas de Hielo! Aciende en la %s",s.DungeonName))
				d.regen_file("data/dungeon/SnowTower/regen1.txt")
				server_loop_timer("SnowTowerCheckTime", 5, d.get_map_index())
				npc.purge()
			end
		end
		when 30331.use with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			if d.getf("level") == 2 then
				d.setf("KeyItemLv2Use", 0)
				item.remove()
				if number(1,100) <= s.KeyItemLv2Prob + d.getf("KeyItemLv2Plus") then
					d.notice(string.format("La %s Correcta fue encontrada, Seran Teletransportados al Nivel 3", item_name(s.KeyItemLv2)))
					server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
					d.setf("level",3)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					d.clear_regen()
					d.purge()
				else
					d.notice(string.format("La %s era Incorrecta! Encuentra la Correcta!", item_name(s.KeyItemLv2)))
					d.setf("KeyItemLv2Plus", d.getf("KeyItemLv2Plus") + (s.KeyItemLv2Prob/5))
				end
			end
		end
		when 30333.use with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			if d.getf("level") == 8 then
				d.setf("KeyItemLv8Use", 0)
				item.remove()
				if number(1,100) <= s.KeyItemLv8Prob + d.getf("KeyItemLv8Plus") then
					d.notice(string.format("La %s Correcta fue encontrada, Seran Teletransportados al Nivel 9", item_name(s.KeyItemLv8)))
					server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
					d.setf("level",9)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					d.clear_regen()
					d.purge()
				else
					d.notice(string.format("La %s era Incorrecta! Encuentra la Correcta!", item_name(s.KeyItemLv8)))
					d.setf("KeyItemLv8Plus", d.getf("KeyItemLv8Plus") + (s.KeyItemLv8Prob/5))
				end
			end
		end
		when 20398.take with SnowTower.InDungeon() begin
			local s = SnowTower.Setting()
			local NpcVid = npc.get_vid()
			local StoneT = d.getf("aStoneLv5Count")
			if item.get_vnum() == s.KeyItemLv5 then
				if NpcVid == nil then
					return
				elseif NpcVid == d.get_unique_vid("aStoneLv5_1") then
					if StoneT != 0 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv5)))
					else
						d.notice(string.format("Correcto! EL Primer %s ha sido Destruida!", mob_name(s.aStoneLv5)))
						d.setf("aStoneLv5Count",1)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv5_2") then
					if StoneT != 1 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv5)))
					else
						d.notice(string.format("Correcto! EL Segundo %s ha sido Destruido!", mob_name(s.aStoneLv5)))
						d.setf("aStoneLv5Count",2)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv5_3") then
					if StoneT != 2 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv5)))
					else
						d.notice(string.format("Correcto! EL Tercer %s ha sido Destruido!", mob_name(s.aStoneLv5)))
						d.setf("aStoneLv5Count",3)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv5_4") then
					if StoneT != 3 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv5)))
					else
						d.notice(string.format("Correcto! EL Cuarto %s ha sido Destruido!", mob_name(s.aStoneLv5)))
						d.setf("aStoneLv5Count",4)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv5_5") then
					if StoneT != 4 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv5)))
					else
						d.notice(string.format("Correcto! EL Quinto %s ha sido Destruido!", mob_name(s.aStoneLv5)))
						d.notice(string.format("Seran teletransportados al Nivel 6!", mob_name(s.aStoneLv5)))
						server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
						d.setf("level", 6)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						pc.setqf("level", d.getf("level"))
						d.setf("aStoneLv5Count",5)
						d.clear_regen()
						d.purge()
					end
				else
					return
				end
				d.setf("KeyItemLv5Use", 0)
				item.remove()
			end
		end
		when kill with SnowTower.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = SnowTower.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local n = d.getf("KillCountLv2") + 1
				d.setf("KillCountLv2", n)
				if n >= s.KillCountLv2Drop and d.getf("KeyItemLv2Use") == 0 then
					d.setf("KeyItemLv2Use", 1)
					d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv2)))
					game.drop_item_with_ownership(s.KeyItemLv2, 1)
					d.setf("KillCountLv2", 0)
				end
			elseif d.getf("level") == 3 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			elseif d.getf("level") == 4 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv4 then
					d.notice(string.format("Has Eliminado al %s! Elimina las Criaturas de Hielo", mob_name(s.KingLv4)))
					d.regen_file("data/dungeon/SnowTower/regen4.txt")
				end
			elseif d.getf("level") == 5 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local n = d.getf("KillCountLv5") + 1
				d.setf("KillCountLv5", n)
				if n >= s.KillCountLv5Drop and d.getf("KeyItemLv5Use") == 0 then
					d.setf("KeyItemLv5Use", 1)
					d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv5)))
					game.drop_item_with_ownership(s.KeyItemLv5, 1)
					d.setf("KillCountLv5", 0)
				end
			elseif d.getf("level") == 6 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv6 then
					d.notice(string.format("El %s ha sido Destruido! Seran teletransportados al Nivel 7", mob_name(s.StoneLv6)))
					server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
					d.clear_regen()
					d.kill_all()
					d.setf("level", 7)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				end
			elseif d.getf("level") == 7 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv7 then
					d.setf("KingLv7Count", d.getf("KingLv7Count")+1)
					if number(1,table.getn(s.KingLv7Poss)) <= d.getf("KingLv7Count") then
						d.notice(string.format("El %s Real ha sido Eliminado! Seran teletransportados al Nivel 8", mob_name(s.KingLv7)))
						server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
						d.clear_regen()
						d.kill_all()
						d.setf("level", 8)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						pc.setqf("level", d.getf("level"))
					else
						d.notice(string.format("El %s Rael era una Ilucion! Encuentra el Real", mob_name(s.KingLv7)))
						d.regen_file("data/dungeon/SnowTower/regen7.txt")
					end
				end
			elseif d.getf("level") == 8 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local n = d.getf("KillCountLv8") + 1
				d.setf("KillCountLv8", n)
				if n >= s.KillCountLv8Drop and d.getf("KeyItemLv8Use") == 0 then
					d.setf("KeyItemLv8Use", 1)
					d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv8)))
					game.drop_item_with_ownership(s.KeyItemLv8, 1)
					d.setf("KillCountLv8", 0)
				end
			elseif d.getf("level") == 9 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv9 then
					d.notice(string.format("El %s ha sido Destruido! Seran teletransportados al Nivel 10", mob_name(s.StoneLv9)))
					server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
					d.clear_regen()
					d.kill_all()
					d.setf("level", 10)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				end
			elseif d.getf("level") == 10 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level")) 
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado al %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
					server_timer("SnowTowerEndTimers", 60*3, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						local pids = {party.get_member_pids()}
						notice_all(string.format("El Grupo de %s ha Derrtotado al %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss)))
						party.setf("level",d.getf("level"))
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						pc.setqf("level", d.getf("level"))
						notice_all(string.format("Increible! %s ha Derrtotado al %s!",pc.get_name(),mob_name(s.FinalBoss)))
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
					end
				end
			end
		end
		when SnowTowerCheckTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 1 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has debilitado las fuerzas de %s ! Seran teletransportados al Nivel 2!", s.DungeonName, mob_name(s.KingLv4)))
						server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
						d.setf("level",2)
					end
				elseif d.getf("level") == 3 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has debilitado las fuerzas de %s ! Seran teletransportados al Nivel 4!", s.DungeonName, mob_name(s.KingLv4)))
						server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
						d.setf("level",4)
					end
				elseif d.getf("level") == 4 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has debilitado las fuerzas de %s ! Seran teletransportados al Nivel 5!", s.DungeonName, mob_name(s.KingLv4)))
						server_timer("SnowTowerJumpTimer", 5, d.get_map_index())
						d.setf("level",5)
					end
				end
			else
				clear_server_timer("SnowTowerCheckTime", get_server_timer_arg())
			end
		end
		when SnowTowerJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.notice(string.format("~Nivel 2~ Encuentra la %s! Elimina las Fuerzas de %s!", item_name(s.KeyItemLv2), mob_name(s.KingLv4)))
					clear_server_timer("SnowTowerCheckTime", d.get_map_index())
					d.set_regen_file("data/dungeon/SnowTower/regen2.txt")
					d.setf("KeyItemLv2Plus", 0)
					d.setf("KillCountLv2", 0)
				elseif d.getf("level") == 3 then
					d.notice(string.format("~Nivel 3~ Elimina las Criaturas de Hielo de la %s! ",s.DungeonName))
					d.regen_file("data/dungeon/SnowTower/regen3.txt")
					server_loop_timer("SnowTowerCheckTime", 5, d.get_map_index())
				elseif d.getf("level") == 4 then
					d.notice(string.format("~Nivel 4~ Elimina las Fuerzas del %s!", mob_name(s.KingLv4)))
					d.spawn_mob_dir(s.KingLv4, s.KingLv4Poss[1], s.KingLv4Poss[2], s.KingLv4Poss[3])
					d.regen_file("data/dungeon/SnowTower/regen4.txt")
					d.setf("StoneSummonLv5", 0)
				elseif d.getf("level") == 5 then
					d.notice(string.format("~Nivel 5~ Desbloquea los %s! Encuentra la %s!", mob_name(s.aStoneLv5), item_name(s.KeyItemLv5)))
					local x = s.aStoneLv5Poss
					local c = {{x[1][1],x[1][2],x[1][3]},{x[2][1],x[2][2],x[2][3]},{x[3][1],x[3][2],x[3][3]},{x[4][1],x[4][2],x[4][3]},{x[5][1],x[5][2],x[5][3]}}
					for i = 1, table.getn(c), 1 do
						local n = number(1,table.getn(c))
						d.set_unique("aStoneLv5_"..i.."", d.spawn_mob_dir(s.aStoneLv5, c[n][1], c[n][2], c[n][3]))
						table.remove(c,n)
					end
					clear_server_timer("SnowTowerCheckTime", d.get_map_index())
					d.set_regen_file("data/dungeon/SnowTower/regen5.txt")
					d.setf("aStoneLv5Count",0)
					d.setf("KeyItemLv5Use", 0)
					d.setf("KillCountLv5", 0)
				elseif d.getf("level") == 6 then
					d.notice(string.format("~Nivel 6~ Destruye el %s!", mob_name(s.StoneLv6)))
					d.spawn_mob_dir(s.StoneLv6, s.StoneLv6Poss[1], s.StoneLv6Poss[2], s.StoneLv6Poss[3])
					d.set_regen_file("data/dungeon/SnowTower/regen6.txt")
				elseif d.getf("level") == 7 then
					d.notice(string.format("~Nivel 7~ Elimina el %s Real!", mob_name(s.KingLv7)))
					d.set_regen_file("data/dungeon/SnowTower/regen7.txt")
					d.setf("KingLv7Count", 0)
					for i = 1, table.getn(s.KingLv7Poss), 1  do 
						d.spawn_mob_dir(s.KingLv7, s.KingLv7Poss[i][1],s.KingLv7Poss[i][2],s.KingLv7Poss[i][3])
					end
				elseif d.getf("level") == 8 then
					d.notice(string.format("~Nivel 8~ Encuentra la %s! Elimina las Fuerzas de %s!", item_name(s.KeyItemLv8), mob_name(s.KingLv4)))
					d.set_regen_file("data/dungeon/SnowTower/regen8.txt")
					d.setf("KeyItemLv8Plus", 0)
					d.setf("KillCountLv8", 0)
				elseif d.getf("level") == 9 then
					d.notice(string.format("~Nivel 9~ Destruye el %s!", mob_name(s.aStoneLv9)))
					d.spawn_mob_dir(s.StoneLv9, s.StoneLv9Poss[1], s.StoneLv9Poss[2], s.StoneLv9Poss[3])
					d.set_regen_file("data/dungeon/SnowTower/regen9.txt")
				elseif d.getf("level") == 10 then
					d.notice(string.format("~Nivel 10~ Elimina al %s!", mob_name(s.FinalBoss)))
					d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], s.FinalBossPoss[3])
					d.regen_file("data/dungeon/SnowTower/regen10.txt")
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when SnowTower10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				server_timer("SnowTower05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when SnowTower05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				server_timer("SnowTower10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when SnowTower10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				server_timer("SnowTowerEndTimers",  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when SnowTowerEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SnowTower.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("SnowTower_"..pc.getqf("SnowTowerIndex").."",0)
				d.setf("SnowTowerFail", 1)
				d.exit_all()
			end
		end
	end
end
