quest SerpentQueen begin
	state start begin
		function Setting()
			if SerpentQueen.Settings == nil then
				SerpentQueen.Settings = {
				["DungeonName"] = "Calabozo Nagga",
				["DungeonInfoIndex"] = 15,
				["Level"] = 120,
				["TimeLimit"] = 45,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 40016,
				["KeyItem"] = 53713,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 267,
				["IndexCoord"] = {768,16384},
				["IndexPoss"] = {{128,225},{384,481},{640,481},{640,225}},--RBGY
				["IndexLobbyPoss"] = {128,727},
				["Outdoor"] = 266,
				["OutdoorCoord"] = {0,14080},
				["OutdoorPoss"] = {65,683},
				---------------------------------------
				---------------------------------------
				["aStone"] = 60634,
				["aStonePoss"] = {128,640,1},
				["nStone"] = {60625,60627,60629,60631},
				["nStonePoss"] = {{153,665,6},{103,665,4},{103,615,2},{153,615,8}},
				["nStonePossFake"] = {{128,68,1},{384,325,1},{640,325,1},{640,68,1}},
				["mStone"] = {60588,60589,60590,60591},
				["mStonePoss"] = {{{93,163,2},{93,93,1},{163,93,7},{163,163,5}},
								  {{349,419,2},{349,349,1},{419,349,7},{419,419,5}},
								  {{605,419,2},{605,349,1},{675,349,7},{675,419,5}},
								  {{605,163,2},{605,93,1},{675,93,7},{675,163,5}}},
				["UnlockItem"] = {53708,53709,53710,53711},
				["UnlockItemCount"] = 100,
				["mKing"] = {60635,60636,60637,60638},
				["mKingPoss"] = {{125,90,1},{384,330,1},{640,330,1},{640,90,1}},
				["FinalBoss"] = 60597,
				["FinalBossPoss"] = {128,640,1},
				} 
			end
			return SerpentQueen.Settings
		end
		function InDungeon()
			local s = SerpentQueen.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 40016.chat.gameforge.npc.dungeon0150 with not SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SerpentQueen.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					if party.getf("Info") == 0 then
						pc.warp((s.IndexCoord[1]+ s.IndexLobbyPoss[1])*100, (s.IndexCoord[2]+ s.IndexLobbyPoss[2])*100, party.getf("IndexDungeon"))
					else
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
					end
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SerpentQueen.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					if pc.getqf("Info") == 0 then
						pc.warp((s.IndexCoord[1]+ s.IndexLobbyPoss[1])*100, (s.IndexCoord[2]+ s.IndexLobbyPoss[2])*100, pc.getqf("SerpentQueenIndex"))
					else
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("SerpentQueenIndex"))
					end
				else
					game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
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
			say(gameforge.npc.dungeon0151)--
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0152)--
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = SerpentQueen.Setting()
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
				pc.setqf("SerpentQueen", 1)
				pc.setqf("SerpentQueenRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexLobbyPoss[1])*100, (s.IndexCoord[2] + s.IndexLobbyPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexLobbyPoss[1], s.IndexCoord[2] + s.IndexLobbyPoss[2])
				end
			end
		end
		when logout with SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			timer("SerpentQueenRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("SerpentQueenFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
				pc.setqf("SerpentQueenRelogin", 0)
			end
		end
		when login with not SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
				pc.setqf("SerpentQueenRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when SerpentQueenExit.timer begin
			local s = SerpentQueen.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when SerpentQueenRelogin.timer begin
			local s = SerpentQueen.Setting()
			pc.setqf("SerpentQueenRelogin", 0)
			game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
		end
		when login with SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			if pc.getqf("SerpentQueenRelogin") == d.get_map_index() then
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
				timer("SerpentQueenExit", 5)
				return
			end
			if s.KeyItemType == 1 then
				if pc.count_item (s.KeyItem) < s.KeyCount then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say_red(gameforge.dungeon.msm001)
					say("")
					timer("SerpentQueenExit", 5)
					return
				end
				pc.remove_item(s.KeyItem, s.KeyCount)
			end
			if party.is_party() then
				party.setf("IndexDungeon", d.get_map_index())
			end
			pc.setqf("SerpentQueenRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("SerpentQueenRelogin", s.TimeLimit*60)
			if pc.getqf("SerpentQueen") == 1 then
				game.set_event_flag("SerpentQueen_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("SerpentQueenIndex", d.get_map_index())
				d.spawn_mob_dir(s.aStone, s.aStonePoss[1], s.aStonePoss[2], s.aStonePoss[3])
				server_timer("SerpentQueen10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.setf("level",0)
				d.setf("Info",0)
				d.setf("FinishLevel",0)
				pc.setqf("SerpentQueen", 0)
				if party.is_party() then
					party.setf("Info", 0)
					party.setf("level",d.getf("level"))
				else
					pc.setqf("Info", 0)
					pc.setqf("level", d.getf("level"))
				end
				for i= 1,table.getn(s.nStonePoss) do
					d.set_unique("nStone"..i, d.spawn_mob_dir(s.nStone[i]+1, s.nStonePoss[i][1], s.nStonePoss[i][2], s.nStonePoss[i][3]))
				end
			end
		end
		when 60634.chat."Kaa NiganI" with SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			if party.is_party() and not party.is_leader() then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc003,s.DungeonName))
				return
			end
			if d.getf("Info") == 0 then
				if d.getf("FinishLevel") == table.getn(s.nStonePoss) then
					d.setf("level",table.getn(s.nStonePoss)+1)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				else
					local zSc = number(1,table.getn(s.nStonePoss))
					local SetLevel = 0
					d.setf("level",table.getn(s.nStonePoss)+1)
					for i=1,table.getn(s.nStonePoss)*10 do
						SetLevel = SetLevel + 1
						if SetLevel > table.getn(s.nStonePoss) then
							SetLevel = 1
						end
						if not d.is_unique_dead("nStone"..SetLevel) then
							zSc = zSc - 1
							if zSc == 0 then
								d.setf("level",SetLevel)
								if party.is_party() then
									party.setf("level",d.getf("level"))
								end
								pc.setqf("level", d.getf("level"))
								d.setf("FinishLevel",d.getf("FinishLevel")+1)
								break
							end
						end
					end
				end
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			local j = d.getf("level")
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") != 5 and d.getf("Info") != d.getf("level") then
				d.setf("Info",j)
				pc.setqf("Info", j)
				if party.is_party() then
					party.setf("Info", j)
				end
				say(string.format("[ENTER]Enfrentate a la criaturas del %s[ENTER]¡Elimina todas las %s Malignas![ENTER]" ,s.DungeonName, mob_name(s.mStone[j])))
				d.notice(string.format("Elimina las %s - Invoca al %s" ,mob_name(s.mStone[j]),mob_name(s.mKing[j])))
				server_timer("SerpentQueenJumpTimer", 5, d.get_map_index())
			elseif d.getf("level") == 5 and d.getf("Info") != d.getf("level") then
				say(string.format("[ENTER]Elimina el %s[ENTER]Enfrentate a las Serpientes Nagga![ENTER]" ,mob_name(s.FinalBoss)))
				d.setf("Info",j)
				pc.setqf("Info", j)
				if party.is_party() then
					party.setf("Info", j)
				end
				npc.purge()
				server_timer("SerpentQueenDelayTime", 3, d.get_map_index())
				for i= 1,table.getn(s.nStonePoss) do
					if not d.is_unique_dead("nStoneX"..i) then
						d.kill_unique("nStoneX"..i)
					end
				end
			end
		end
		when 60626.take or 60628.take or 60630.take or 60632.take with SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			local j = d.getf("level")
			if item.get_vnum() == s.UnlockItem[j] then
				d.notice(string.format("Has Activado el %s - El %s ha sido Invocado! Eliminalo",mob_name(s.nStone[j]+1), mob_name(s.mKing[j])))
				d.spawn_mob_dir(s.nStone[j], s.nStonePossFake[j][1], s.nStonePossFake[j][2], s.nStonePossFake[j][3])
				server_timer("SerpentQueenJumpTimer", 5, d.get_map_index())
				d.setf("Info", 0)
				pc.setqf("Info", 0)
				if party.is_party() then
					party.setf("Info", 0)
				end
				d.purge_unique("nStone"..j)
				d.set_unique("nStoneX"..j, d.spawn_mob_dir(s.nStone[j], s.nStonePoss[j][1], s.nStonePoss[j][2], s.nStonePoss[j][3]))
				pc.remove_item(s.UnlockItem[j], 1)
				d.clear_regen()
				npc.purge()
			end
		end
		when kill with SerpentQueen.InDungeon() begin
			local s = SerpentQueen.Setting()
			local mobVnum = npc.get_race()
			local j = d.getf("level")
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") != 5 then
				if d.getf("QuestStep") == 99 then
					return
				elseif d.getf("QuestStep") == 0 then
					if party.is_party() and party.getf("level") != d.getf("level") then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					if mobVnum == s.mStone[j] then
						d.setf("mStoneCount"..j, d.getf("mStoneCount"..j)+1)
						if d.getf("mStoneCount"..j) == table.getn(s.mStonePoss) then
							d.notice(string.format("Has Eliminado los %s - Encuentra el %s!",mob_name(s.mStone[j]), item_name(s.UnlockItem[j])))
							d.set_regen_file("data/dungeon/SerpentQueen/regen"..d.getf("level")..".txt")
							d.setf("KillCount", 0)
							d.setf("QuestStep", 1)
						end
					end
				elseif d.getf("QuestStep") == 1 then
					local n = d.getf("KillCount") + 1
					d.setf("KillCount", n)
					if n >= s.UnlockItemCount and d.getf("UnlockItem") == 0 then
						d.notice(string.format("Encontraste la %s!",item_name(s.UnlockItem[j])))
						game.drop_item_with_ownership(s.UnlockItem[j], 1)
						d.setf("UnlockItem", 1)
						d.setf("KillCount", 0)
						d.clear_regen()
					end
				end
			elseif d.getf("level") == 5 then
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado la %s! El Sello del %s se esta Recuperandoo! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
					game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
					server_timer("SerpentQueenEndTimers", 60*3, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
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
			end
		end
		when SerpentQueenJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				local j = d.getf("level")
				if d.getf("Info") != 0 then
					if d.getf("level") != 99 then
						d.spawn_mob_dir(s.nStone[j]+1, s.nStonePossFake[j][1], s.nStonePossFake[j][2], s.nStonePossFake[j][3])
						d.regen_file("data/dungeon/SerpentQueen/regen"..d.getf("level")..".txt")
						d.setf("mStoneCount"..d.getf("level"), 0)
						d.setf("UnlockItem", 0)
						d.setf("QuestStep", 0)
						for i= 1,table.getn(s.mStonePoss[j]) do
							d.spawn_mob_dir(s.mStone[j], s.mStonePoss[j][i][1], s.mStonePoss[j][i][2], s.mStonePoss[j][i][3])
						end
					end
					d.jump_all((s.IndexCoord[1] + s.IndexPoss[j][1]), (s.IndexCoord[2] + s.IndexPoss[j][2]))
				else
					d.jump_all((s.IndexCoord[1] + s.IndexLobbyPoss[1]), (s.IndexCoord[2] + s.IndexLobbyPoss[2]))
				end
			end
		end
		when SerpentQueenDelayTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				d.notice(string.format("%s ~ Elimina la %s!",mob_name(s.aStone), mob_name(s.FinalBoss)))
				d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], s.FinalBossPoss[3])
			end
		end
		when SerpentQueen10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				server_timer("SerpentQueen05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when SerpentQueen05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				server_timer("SerpentQueen10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when SerpentQueen10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				server_timer("SerpentQueenEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when SerpentQueenEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SerpentQueen.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("SerpentQueen_"..pc.getqf("SerpentQueenIndex").."",0)
				d.setf("SerpentQueenFail", 1)
				d.exit_all()
			end
		end
	end
end

