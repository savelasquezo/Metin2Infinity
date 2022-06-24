quest DawnmistThunderLord begin
	state start begin
		function Setting()
			if DawnmistThunderLord.Settings == nil then
				DawnmistThunderLord.Settings = {
				["DungeonName"] = "Arboreal",
				["DungeonInfoIndex"] = 9,
				["Level"] = 110,
				["TimeLimit"] = 45,
				["TimeToRetry"] = 2,
				["PartyMinCount"] = 2,
				["NPC"] = 20411,
				["KeyItem"] = 50137,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 210,
				["IndexCoord"] = {7680,14080},
				["IndexPoss"] = {152,942},
				["Outdoor"] = 210,
				["OutdoorCoord"] = {7680,14080},
				["OutdoorPoss"] = {610,106},
				---------------------------------------
				---------------------------------------
				["King"] = 6408,
				["KingPoss"] = {69,941,3},
				["Stone"] = 8059,
				["StonePoss"] = {{83,926,1},{83,956,1},{72,953,1},{72,930,1},{64,926,1},{64,956,1},{57,953,1},{57,930,1},{53,941,1}},
				["FinalBoss"] = 6409,
				["FinalBossPoss"] = {69,941,3},
				}
			end
			return DawnmistThunderLord.Settings
		end
		function InDungeon()
			local s = DawnmistThunderLord.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20411.chat.gameforge.npc.dungeon0090 with not DawnmistThunderLord.InDungeon() begin
			local s = DawnmistThunderLord.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DawnmistThunderLord.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DawnmistThunderLord.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("DawnmistThunderLordIndex"))
				else
					game.set_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."",0)
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
					local s = DawnmistThunderLord.Setting()
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
				pc.setqf("DawnmistThunderLord", 1)
				pc.setqf("DawnmistThunderLordRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with DawnmistThunderLord.InDungeon() begin
			local s = DawnmistThunderLord.Setting()
			timer("DawnmistThunderLordRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DawnmistThunderLordFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."",0)
				pc.setqf("DawnmistThunderLordRelogin", 0)
			end
		end
		when login with not DawnmistThunderLord.InDungeon() begin
			local s = DawnmistThunderLord.Setting()
			if pc.get_map_index() == s.Index then
				if pc.get_x() <= s.IndexCoord[1]+200 and pc.get_y() >= s.IndexCoord[2]+850 then
					game.set_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."",0)
					pc.setqf("DawnmistThunderLordRelogin", 0)
					pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
				end
			end
		end
		when DawnmistThunderLordExit.timer begin
			local s = DawnmistThunderLord.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when DawnmistThunderLordRelogin.timer begin
			local s = DawnmistThunderLord.Setting()
			pc.setqf("DawnmistThunderLordRelogin", 0)
			game.set_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."",0)
		end
		when login with DawnmistThunderLord.InDungeon() begin
			local s = DawnmistThunderLord.Setting()
			if pc.getqf("DawnmistThunderLordRelogin") == d.get_map_index() then
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
				timer("DawnmistThunderLordExit", 5)
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
			pc.setqf("DawnmistThunderLordRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("DawnmistThunderLordRelogin", s.TimeLimit*60)
			if pc.getqf("DawnmistThunderLord") == 1 then
				game.set_event_flag("DawnmistThunderLord_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("DawnmistThunderLordIndex", d.get_map_index())
				d.notice(string.format("Elimina al %s!", mob_name(s.King)))
				d.spawn_mob_dir(s.King, s.KingPoss[1], s.KingPoss[2], s.KingPoss[3])
				d.regen_file("data/dungeon/DawnmistThunderLord/regen.txt")
				server_timer("DawnmistThunderLord10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("DawnmistThunderLord", 0)
			end
		end
		when kill with DawnmistThunderLord.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = DawnmistThunderLord.Setting()
			if mobVnum == s.King then
				d.notice(string.format("Has Eliminado al %s!", mob_name(s.King)))
				server_timer("DawnmistThunderLordDelayTime", 5, d.get_map_index())
			elseif mobVnum == s.Stone then
				local CountStone = d.getf("CountStone")
				local FinalBossVid = d.getf("FinalBossVid")
				if CountStone > 0 then
					d.notice(string.format("¡Advertencia! La %s ha desatado su Furia!",  mob_name(s.FinalBoss)))
					d.notice("Aumenta el Ataque & la Resistencia ha Desminuido!")
					d.setf("CountStone", CountStone-1)
					npc.set_vid_attack_mul(FinalBossVid,10/(CountStone + 1))
					npc.set_vid_damage_mul(FinalBossVid,10/(CountStone + 1))
				end
			elseif mobVnum == s.FinalBoss then
				d.notice(string.format("Has Eliminado al %s! El Sello del %s se esta Recuperando! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
				server_timer("DawnmistThunderLordEndTimers", 60*3, d.get_map_index())
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
		when DawnmistThunderLordDelayTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DawnmistThunderLord.Setting()
				d.notice(string.format("El %s ha sido Invocado!", mob_name(s.FinalBoss)))
				d.notice(string.format("Los %s determinan el Ataque & Resistencia de el %s!", mob_name(s.Stone), mob_name(s.FinalBoss)))
				for i = 1, table.getn(s.StonePoss), 1 do
					d.spawn_mob_dir(s.Stone, s.StonePoss[i][1],s.StonePoss[i][2],s.StonePoss[i][3])
				end
				local FinalBossVid = d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss,s.FinalBossPoss[1],s.FinalBossPoss[2],5))
				d.setf("FinalBossVid", FinalBossVid)
				d.setf("CountStone", 9)
			end
		end
		when DawnmistThunderLord10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DawnmistThunderLord.Setting()
				server_timer("DawnmistThunderLord05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DawnmistThunderLord05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DawnmistThunderLord.Setting()
				server_timer("DawnmistThunderLord10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DawnmistThunderLord10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DawnmistThunderLord.Setting()
				server_timer("DawnmistThunderLordEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when DawnmistThunderLordEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DawnmistThunderLord.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("DawnmistThunderLord_"..pc.getqf("DawnmistThunderLordIndex").."",0)
				d.setf("DawnmistThunderLordFail", 1)
				d.exit_all()
			end
		end
	end
end
