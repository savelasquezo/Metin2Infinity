quest DragonLair begin
	state start begin
		function Setting()
			if DragonLair.Settings == nil then
				DragonLair.Settings = {
				["DungeonName"] = "Sala del Dragon",
				["DungeonInfoIndex"] = 6,
				["Level"] = 85,
				["TimeLimit"] = 30,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20626,
				["KeyItem"] = 30179,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 3,
				["Index"] = 73,
				["IndexCoord"] = {1536,12032},
				["IndexPoss"] = {242,173},
				["Outdoor"] = 73,
				["OutdoorCoord"] = {1536,12032},
				["OutdoorPoss"] = {319,174},
				---------------------------------------
				---------------------------------------
				["King"] = 2492,
				["KingPoss"] = {{170, 187},{194, 187},{172, 158},{194, 158}},
				["aStone"] = 20150,
				["aStonePoss"] = {{170, 187},{194, 187},{172, 158},{194, 158}},
				["UnlockItem"] = 30180,
				["UnlockItemProb"] = 10,
				["nStone"] = 20150,
				["nStonePoss"] = {182, 172},
				["FinalBoss"] = 2495,
				["FinalBossPoss"] = {182, 172},
				}
			end
			return DragonLair.Settings
		end
		function InDungeon()
			local s = DragonLair.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 30121.chat.gameforge.npc.dungeon0060 with not DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DragonLair.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DragonLair.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("DragonLairIndex"))
				else
					game.set_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."",0)
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
			say(gameforge.npc.dungeon0061)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0062)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = DragonLair.Setting()
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
				pc.setqf("DragonLair", 1)
				pc.setqf("DragonLairRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			timer("DragonLairRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DragonLairFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."",0)
				pc.setqf("DragonLairRelogin", 0)
			end
		end
		when login with not DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			if pc.get_map_index() == s.Index then
				if pc.get_x() <= s.IndexCoord[1]+260 and pc.get_y() <= s.IndexCoord[2]+230 then
					game.set_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."",0)
					pc.setqf("DragonLairRelogin", 0)
					pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
				end
			end
		end
		when DragonLairExit.timer begin
			local s = DragonLair.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when DragonLairRelogin.timer begin
			local s = DragonLair.Setting()
			pc.setqf("DragonLairRelogin", 0)
			game.set_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."",0)
		end
		when login with DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			if pc.getqf("DragonLairRelogin") == d.get_map_index() then
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
				timer("DragonLairExit", 5)
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
			pc.setqf("DragonLairRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("DragonLairRelogin", s.TimeLimit*60)
			if pc.getqf("DragonLair") == 1 then
				game.set_event_flag("DragonLair_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("DragonLairIndex", d.get_map_index())
				d.notice(string.format("Encuentra Las %s Libera los Sellos del %s",item_name(s.UnlockItem), mob_name(s.aStonePoss)))
				d.notice(string.format("Enfrentate a los %s!", mob_name(s.King)))
				for i = 1, 4 do
					d.spawn_mob_dir(s.aStone + i, s.aStonePoss[i][1], s.aStonePoss[i][2], 3)
					d.spawn_mob(s.King, s.KingPoss[i][1] + number(-10,10), s.KingPoss[i][2] + number(-10,10))
				end
				d.set_unique("StoneFinalBoss", d.spawn_mob_dir(s.nStone, s.nStonePoss[1], s.nStonePoss[2], 3))
				server_timer("DragonLair10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.set_regen_file("data/dungeon/DragonLair/regen.txt")
				pc.setqf("DragonLair", 0)
				d.setf("SealsCount", 0)
				d.setf("KingCount", 0) 
			end
		end
		when kill with DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			local mobVnum = npc.get_race()
			if mobVnum == s.King then
				local count = d.getf("KingCount") + 1
				game.drop_item_with_ownership(s.UnlockItem)
				d.setf("KingCount", count) 
				if count >= 4 then
					d.notice("Todos los Generales Yonghan han sido Eliminados!")
				end
			elseif mobVnum == s.FinalBoss then
				d.notice(string.format("Has Eliminado a al %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
				server_timer("DragonLairEndTimers", 60*3, d.get_map_index())
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
		when 20151.take or 20152.take or 20153.take or 20154.take with DragonLair.InDungeon() begin
			local s = DragonLair.Setting()
			if item.get_vnum() == s.UnlockItem then
				local s = DragonLair.Setting()
				local count = d.getf("SealsCount") + 1
				d.setf("SealsCount", count)
				npc.purge()
				pc.remove_item(s.UnlockItem, 1)
				d.notice("El Sello de Beran-Setaou se ha Roto!")
				if count >= 4 then
					d.notice("El Dragon Azul Beran Setaou esta Recusitando! La Batalla Comenzara Pronto!!")
					server_timer("DragonLairSpawnBoss", 10, d.get_map_index())
				end
			end
		end
		when DragonLairSpawnBoss.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonLair.Setting()
				d.purge_unique("StoneFinalBoss")
				d.notice("El Dragon Azul Beran Setaou ha sido Despertado!")
				d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], 3)
			end
		end
		when DragonLair10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonLair.Setting()
				server_timer("DragonLair05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DragonLair05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonLair.Setting()
				server_timer("DragonLair10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DragonLair10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonLair.Setting()
				server_timer("DragonLairEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when DragonLairEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonLair.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("DragonLair_"..pc.getqf("DragonLairIndex").."",0)
				d.setf("DragonLairFail", 1)
				d.exit_all()
			end
		end
	end
end
