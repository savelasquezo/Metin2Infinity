quest SpiderCavern begin
	state start begin
		function Setting()
			if SpiderCavern.Settings == nil then
				SpiderCavern.Settings = {
				["DungeonName"] = "Cubil de la Baronesa",
				["DungeonInfoIndex"] = 5,
				["Level"] = 65,
				["TimeLimit"] = 45,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 30130,
				["KeyItem"] = 30324,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 217,
				["IndexCoord"] = {512,5632},
				["IndexPoss"] = {368,516},
				["Outdoor"] = 63,
				["OutdoorCoord"] = {2048,4864},
				["OutdoorPoss"] = {1400,1445},
				---------------------------------------
				---------------------------------------
				["SummonItem"] = 30327,
				["King"] = 2094,
				["KingPoss"] = {370,590},
				["Eggs"] = 2095,
				["EggsPoss"] = {{370,600},{350,575},{385,598},{395,590},{345,590},{355,598},{380,580},{390,575},{360,580}},
				["FinalBoss"] = 2092,
				["FinalBossPoss"] = {370,590},
				}
			end
			return SpiderCavern.Settings
		end
		function InDungeon()
			local s = SpiderCavern.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 30130.chat.gameforge.npc.dungeon0050 with not SpiderCavern.InDungeon() begin
			local s = SpiderCavern.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SpiderCavern.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = SpiderCavern.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("SpiderCavernIndex"))
				else
					game.set_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."",0)
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
			say(gameforge.npc.dungeon0051)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0052)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = SpiderCavern.Setting()
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
				pc.setqf("SpiderCavern", 1)
				pc.setqf("SpiderCavernRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with SpiderCavern.InDungeon() begin
			local s = SpiderCavern.Setting()
			timer("SpiderCavernRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("SpiderCavernFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."",0)
				pc.setqf("SpiderCavernRelogin", 0)
			end
		end
		when login with not SpiderCavern.InDungeon() begin
			local s = SpiderCavern.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."",0)
				pc.setqf("SpiderCavernRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when SpiderCavernExit.timer begin
			local s = SpiderCavern.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when SpiderCavernRelogin.timer begin
			local s = SpiderCavern.Setting()
			pc.setqf("SpiderCavernRelogin", 0)
			game.set_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."",0)
		end
		when login with SpiderCavern.InDungeon() begin
			local s = SpiderCavern.Setting()
			if pc.getqf("SpiderCavernRelogin") == d.get_map_index() then
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
				timer("SpiderCavernExit", 5)
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
			pc.setqf("SpiderCavernRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("SpiderCavernRelogin", s.TimeLimit*60)
			if pc.getqf("SpiderCavern") == 1 then
				game.set_event_flag("SpiderCavern_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("SpiderCavernIndex", d.get_map_index())
				d.notice(string.format("Elimina al %s! Encuentra el %s", mob_name(s.King), item_name(s.SummonItem)))
				d.spawn_mob_dir(s.King, s.KingPoss[1], s.KingPoss[2], 5)
				d.set_regen_file("data/dungeon/SpiderCavern/regen.txt")
				server_timer("SpiderCavern10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("SpiderCavern", 0)
			end
		end
		when kill with SpiderCavern.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = SpiderCavern.Setting()
			if mobVnum == s.King then
				d.notice(string.format("Encontraste %s", item_name(s.SummonItem)))
				game.drop_item_with_ownership(s.SummonItem, 1)
			elseif mobVnum == s.Eggs then
				local CountEggs = d.getf("CountEggs")
				local FinalBossVid = d.getf("FinalBossVid")
				if CountEggs > 0 then
					d.notice(string.format("¡Advertencia! La %s ha desatado su Furia!",  mob_name(s.FinalBoss)))
					d.notice("Aumenta el Ataque & la Resistencia ha Desminuido!")
					d.setf("CountEggs", CountEggs-1)
					npc.set_vid_attack_mul(FinalBossVid,10/(CountEggs + 1))
					npc.set_vid_damage_mul(FinalBossVid,10/(CountEggs + 1))
				end
			elseif mobVnum == s.FinalBoss then
				d.notice(string.format("Has Eliminado a la %s! El Sello del %s se esta Recuperando! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
				server_timer("SpiderCavernEndTimers", 60*3, d.get_map_index())
				d.setf("level", 99)
				d.clear_regen()
				d.kill_all()
				if party.is_party() then
					local pids = {party.get_member_pids()}
					notice_all(string.format("El Grupo de %s ha Derrtotado a la %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss)))
					party.setf("level",d.getf("level"))
					for i, pid in next, pids, nil do
						q.begin_other_pc_block(pid)
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
						q.end_other_pc_block()
					end
				else
					pc.setqf("level", d.getf("level"))
					notice_all(string.format("Increible! %s ha Derrtotado a la %s!",pc.get_name(),mob_name(s.FinalBoss)))
					dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
				end
			end
		end
		when 30327.use with SpiderCavern.InDungeon() begin
			local s = SpiderCavern.Setting()
			d.notice(string.format("Has usado el %s! La %s se Aproxima", item_name(s.SummonItem), mob_name(s.FinalBoss)))
			server_timer("SpiderCavernDelay", 5, d.get_map_index())
			item.remove()
		end
		when SpiderCavernDelay.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SpiderCavern.Setting()
				if d.getf("KeyUsed") == 0 then
					d.notice(string.format("La %s ha sido Invocada !", mob_name(s.FinalBoss)))
					d.notice(string.format("Los %s determinan el Ataque & Resistencia de la %s!", mob_name(s.Eggs), mob_name(s.FinalBoss)))
					for i = 1, table.getn(s.EggsPoss), 1 do
						d.spawn_mob_dir(s.Eggs, s.EggsPoss[i][1],s.EggsPoss[i][2], 0)
					end
					local FinalBossVid = d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss,s.FinalBossPoss[1],s.FinalBossPoss[2],5))
					d.setf("FinalBossVid", FinalBossVid)
					d.setf("CountEggs", 9)
					d.setf("KeyUsed", 1)
				end
			end
		end
		when SpiderCavern10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SpiderCavern.Setting()
				server_timer("SpiderCavern05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when SpiderCavern05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SpiderCavern.Setting()
				server_timer("SpiderCavern10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when SpiderCavern10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SpiderCavern.Setting()
				server_timer("SpiderCavernEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when SpiderCavernEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = SpiderCavern.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("SpiderCavern_"..pc.getqf("SpiderCavernIndex").."",0)
				d.setf("SpiderCavernFail", 1)
				d.exit_all()
			end
		end
	end
end
