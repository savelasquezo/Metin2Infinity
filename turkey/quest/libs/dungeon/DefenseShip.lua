quest DefenseShip begin
	state start begin
		function Setting()
			if DefenseShip.Settings == nil then
				DefenseShip.Settings = {
				["DungeonName"] = "Royal Yacht",
				["DungeonInfoIndex"] = 10,
				["Level"] = 110,
				["TimeLimit"] = 30,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 40046,
				["KeyItem"] = 50150,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 353,
				["IndexCoord"] = {1280,4864},
				["IndexPoss"] = {385,357},
				["Outdoor"] = 354,
				["OutdoorCoord"] = {1280,5632},
				["OutdoorPoss"] = {423,483},
				---------------------------------------
				---------------------------------------
				["Stone"] = 8105,
				["StonePoss"] = {{377,385},{367,393},{392,385},{403,393},{401,409},{369,409},{377,423},{392,423}},
				["aStone"] = 20434,
				["aStonePoss"] = {385,400,2},
				["nStone"] = 20436,
				["nStonePoss"] = {385,367,1},
				["RewardBox"] = 3965,
				["RewardBoxPoss"] = {385,450,5},
				["King"] = 3956,
				["KingPoss"] = {{385,427,5},{367,416,4},{403,416,6}},
				["FinalBoss"] = 3960,
				["FinalBossPoss"] = {{385,374},{385,440},{392,440},{378,440}},
				}
			end
			return DefenseShip.Settings
		end
		function InDungeon()
			local s = DefenseShip.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 40046.chat.gameforge.npc.dungeon0100 with not DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DefenseShip.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DefenseShip.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("DefenseShipIndex"))
				else
					game.set_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."",0)
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
			wait()
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
					local s = DefenseShip.Setting()
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
				pc.setqf("DefenseShip", 1)
				pc.setqf("DefenseShipRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			timer("DefenseShipRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DefenseShipFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."",0)
				pc.setqf("DefenseShipRelogin", 0)
			end
		end
		when login with not DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			cmdchat("BINARY_Update_Mast_Window 0")
			if pc.get_map_index() == s.Index then
				game.set_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."",0)
				pc.setqf("DefenseShipRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when DefenseShipExit.timer begin
			local s = DefenseShip.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when DefenseShipRelogin.timer begin
			local s = DefenseShip.Setting()
			pc.setqf("DefenseShipRelogin", 0)
			game.set_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."",0)
		end
		when login with DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			cmdchat("BINARY_Update_Mast_Window 1")
			if pc.getqf("DefenseShipRelogin") == d.get_map_index() then
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
				timer("DefenseShipExit", 5)
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
			pc.setqf("DefenseShipRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("DefenseShipRelogin", s.TimeLimit*60)
			if pc.getqf("DefenseShip") == 1 then
				game.set_event_flag("DefenseShip_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("DefenseShipIndex", d.get_map_index())
				d.notice(string.format("Inicia la Navegacion %s! Defiende el %s hasta llegar al Puerto!", mob_name(s.nStone), mob_name(s.aStone)))
				server_timer("DefenseShip10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.set_unique("aStone", d.spawn_mob_dir(s.aStone, s.aStonePoss[1], s.aStonePoss[2], s.aStonePoss[3]))
				d.spawn_mob_dir(s.nStone, s.nStonePoss[1], s.nStonePoss[2], s.nStonePoss[3])
				d.setf("KillCount", table.getn(s.FinalBossPoss))
				pc.setqf("DefenseShip", 2)
				d.setf("Spawn", 0)
			end
		end
		when 20436.chat."Iniciar" with DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if pc.getqf("DefenseShip") != 2 then
				say("")
				say("TEXTO")
				say("")
				return
			end
			say("¿Quieres comenzar a defender el Mastil?")
			if select("Si", "No") == 1 then
				local s = DefenseShip.Setting()
				d.notice(string.format("El %s esta siendo atacando, Protegelo!", s.DungeonName))
				server_loop_timer('DefenseShipSurvivors', 1, pc.get_map_index())
				pc.setqf("DefenseShip", 0)
				for i = 1, (table.getn(s.FinalBossPoss)-1), 1  do
					d.set_unique("HeadBoss"..i.."", d.spawn_mob_dir(s.FinalBoss+i, s.FinalBossPoss[i+1][1],s.FinalBossPoss[i+1][2], 5))
				end
			end
		end
		when DefenseShipSurvivors.server_timer begin
			local s = DefenseShip.Setting()
			if d.select(get_server_timer_arg()) then
				if not d.is_unique_dead("aStone") then
					if d.getf("Spawn") == 0 and d.getf("KillCount") != 0 then
						server_timer("DefenseShipSpawnTime", 15, d.get_map_index())
						d.setf("Spawn", 1)
						return
					end
				else
					clear_server_timer("DefenseShipSurvivors", d.get_map_index())
					server_timer("DefenseShipEndTimers", 10, d.get_map_index())
					d.notice(string.format("Has Fallado al proteger al %s del Ataque!", s.DungeonName))
					d.notice("Debemos Regresar pronto a Tierra Firme!")
				end
			else
				clear_server_timer("DefenseShipSurvivors", d.get_map_index())
			end
		end
		when DefenseShipSpawnTime.server_timer begin
			local s = DefenseShip.Setting()
			if d.select(get_server_timer_arg()) then
				if d.getf("KillCount") != 0 then
					local s = DefenseShip.Setting()
					d.purge_unique("HeadBoss"..d.getf("KillCount").."")
					local KingVid = d.set_victim_mast(d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1][1], s.FinalBossPoss[1][2],1),1)
					d.set_regen_file("data/dungeon/DefenseShip/regen1.txt")
					d.setf("KingVid", KingVid)
					d.setf("KillStoneCount", table.getn(s.StonePoss))
					for i = 1, table.getn(s.KingPoss) do
						d.set_victim_mast(d.spawn_mob_dir(s.King, s.KingPoss[i][1], s.KingPoss[i][2], s.KingPoss[i][3]), 1)
					end
					for i = 1, table.getn(s.StonePoss) do
						if d.is_unique_dead("Stone"..i.."") then
							d.set_unique("Stone"..i.."", d.spawn_mob(s.Stone, s.StonePoss[i][1], s.StonePoss[i][2], 0))
						end
					end
					d.notice(string.format("La %s esta Atacando la Embarcacion!",mob_name(s.FinalBoss)))
					d.notice("La Embarcacion no resistira mucho! Eliminala ")
				end
			end
		end
		when kill with DefenseShip.InDungeon() begin
			local s = DefenseShip.Setting()
			local mobVnum = npc.get_race()
			if d.getf("level") == 99 then
				return
			elseif mobVnum == s.Stone then
				local KingVid = d.getf("KingVid")
				d.notice(string.format("Has Destruido un %s!",mob_name(s.Stone)))
				d.notice("La Resistencia Aumenta & El Daño Disminuye!")
				d.setf("KillStoneCount", d.getf("KillStoneCount")-1)
				npc.set_vid_attack_mul(KingVid, 2*(d.getf("KillStoneCount")+1))
				npc.set_vid_damage_mul(KingVid, 2*(d.getf("KillStoneCount")+1))
			elseif mobVnum == s.FinalBoss then
				d.setf("Spawn", 0)
				d.setf("KillCount", d.getf("KillCount")-1)
				if d.getf("KillCount") == 0 then
					d.notice(string.format("Has Eliminado la %s! El Tesoro Murenida es Revelado!", mob_name(npc.get_race()), s.DungeonName))
					d.spawn_mob_dir(s.RewardBox, s.RewardBoxPoss[1], s.RewardBoxPoss[2], s.RewardBoxPoss[3])
					clear_server_timer("DefenseShipSurvivors", d.get_map_index())
					d.clear_regen()
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
					for i = 1, table.getn(s.StonePoss) do
						if not d.is_unique_dead("Stone"..i.."") then
							d.purge_unique("Stone"..i.."")
						end
					end
				else
					d.notice(string.format("Has Eliminado una %s! El %s esta bajo Ataque!", mob_name(npc.get_race()), s.DungeonName))
					d.regen_file("data/dungeon/DefenseShip/regen2.txt")
				end
			elseif mobVnum == s.RewardBox then
				d.notice(string.format("El Sello del %s se esta Recuperando! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
				server_timer("DefenseShipEndTimers", 60*3, d.get_map_index())
				d.setf("level", 99)
				d.clear_regen()
				if party.is_party() then
					party.setf("level",d.getf("level"))
				else
					pc.setqf("level", d.getf("level"))
				end
			end
		end
		when DefenseShip10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DefenseShip.Setting()
				server_timer("DefenseShip05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DefenseShip05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DefenseShip.Setting()
				server_timer("DefenseShip10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DefenseShip10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DefenseShip.Setting()
				server_timer("DefenseShipEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when DefenseShipEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DefenseShip.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("DefenseShip_"..pc.getqf("DefenseShipIndex").."",0)
				d.setf("DefenseShipFail", 1)
				d.exit_all()
			end
		end
	end
end

