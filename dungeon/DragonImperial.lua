quest DragonImperial begin
	state start begin
		function Setting()
			if DragonImperial.Settings == nil then
				DragonImperial.Settings = {
				["DungeonName"] = "Dragon Imperial",
				["DungeonInfoIndex"] = 12,
				["Level"] = 115,
				["TimeLimit"] = 60,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 40004,
				["KeyItem"] = 50151,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 305,
				["IndexCoord"] = {17524,12542},
				["IndexPoss"] = {{240,443},{134,145},{371,140}},
				["Outdoor"] = 304,
				["OutdoorCoord"] = {11264,15104},
				["OutdoorPoss"] = {495,643},
				---------------------------------------
				---------------------------------------
				["KingLv1"] = 4296,
				["KingLv1Poss"] = {240,270,1},
				["XKingLv2"] = 4294,
				["XKingLv2Count"] = 3,
				["YKingLv2"] = 4298,
				["YKingLv2Poss"] =  {134,66,1},
				["KeyLv2"] = 30526,
				["KeyLv2Count"] = 2,
				["aStoneLv2"] = 20466,
				["aStoneLv2Poss"] =  {134,62,1},
				["FinalBoss"] = 6520,
				["FinalBossPoss"] = {371,108},
				}
			end
			return DragonImperial.Settings
		end
		function InDungeon()
			local s = DragonImperial.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 40004.chat.gameforge.npc.dungeon0120 with not DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DragonImperial.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = DragonImperial.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("DragonImperialIndex"))
				else
					game.set_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."",0)
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
					local s = DragonImperial.Setting()
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
				pc.setqf("DragonImperial", 1)
				pc.setqf("DragonImperialRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when logout with DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			timer("DragonImperialRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("DragonImperialFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."",0)
				pc.setqf("DragonImperialRelogin", 0)
			end
		end
		when login with not DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."",0)
				pc.setqf("DragonImperialRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when DragonImperialExit.timer begin
			local s = DragonImperial.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when DragonImperialRelogin.timer begin
			local s = DragonImperial.Setting()
			pc.setqf("DragonImperialRelogin", 0)
			game.set_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."",0)
		end
		when login with DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			if pc.getqf("DragonImperialRelogin") == d.get_map_index() then
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
				timer("DragonImperialExit", 5)
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
			pc.setqf("DragonImperialRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("DragonImperialRelogin", s.TimeLimit*60)
			if pc.getqf("DragonImperial") == 1 then
				game.set_event_flag("DragonImperial_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("DragonImperialIndex", d.get_map_index())
				d.notice(string.format("Elimina las fuerzas del %s!", mob_name(s.KingLv1)))
				d.spawn_mob_dir(s.KingLv1, s.KingLv1Poss[1], s.KingLv1Poss[2], s.KingLv1Poss[3])
				d.regen_file("data/dungeon/DragonImperial/regen1.txt")
				server_timer("DragonImperial10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("DragonImperial", 0)
				d.setf("level", 1)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			end
		end
		when 20466.chat."Ofrenda Sangrienta" with DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say_red("¡Ofrendas de Sangre!")
			say("")
			say_white("Lucha contra la guardia Imperial")
			say_item(""..item_name(s.KeyLv2).."", s.KeyLv2, "")
			say("")
			say_gold("Ofrendas de Sangre")
			say_white(""..s.KeyLv2Count.."")
			say("")
		end
		when 20466.take with DragonImperial.InDungeon() begin
			local s = DragonImperial.Setting()
			if item.get_vnum() == s.KeyLv2 then
				if pc.count_item(s.KeyLv2) < s.KeyLv2Count then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_red("¡Ofrendas de Sangre Infucientes!")
					say("")
					say_white("Ofrendas de Sangre Infucientes")
					say_white("Lucha contra la guardia Imperial")
					say_item(""..item_name(s.KeyLv2).."", s.KeyLv2, "")
					say("")
					say_gold("Ofrendas de Sangre")
					say_white(""..s.KeyLv2Count.."")
					say("")
					return
				end
				pc.remove_item(s.KeyLv2, s.KeyLv2Count)
				d.notice(string.format("El %s ha aceptado la Ofrenda! Seran teletransportados al Nivel 3!", mob_name(s.aStoneLv2)))
				server_timer("DragonImperialJumpTimer", 5, d.get_map_index())
				d.setf("level", 3)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.clear_regen()
				d.purge()
			end
		end
		when kill with DragonImperial.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = DragonImperial.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 1 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv1 then
					d.notice(string.format("Has Eliminado al %s! Seran teletransportados al Nivel 2!", mob_name(s.KingLv1)))
					server_timer("DragonImperialJumpTimer", 10, d.get_map_index())
					d.kill_all()
					d.setf("level", 2)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				end
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.XKingLv2 then
					d.setf("XKingLv2Count", d.getf("XKingLv2Count")+1)
					d.notice(string.format("Has Eliminado al %s!", mob_name(s.YKingLv2)))
					if d.getf("XKingLv2Count") >= s.XKingLv2Count and d.getf("YKingLv2Spawn") == 0 then
						d.notice(string.format("El %s ha sido Invocado!", mob_name(s.YKingLv2)))
						d.spawn_mob_dir(s.YKingLv2, s.YKingLv2Poss[1], s.YKingLv2Poss[2], s.YKingLv2Poss[3])
						d.setf("XKingLv2Count", 0)
						d.setf("YKingLv2Spawn", 1)
					end
				elseif mobVnum == s.YKingLv2 and d.getf("YKingLv2Spawn") != 2 then
					d.setf("KeyLv2Count", d.getf("KeyLv2Count")+1)
					d.notice(string.format("Has Eliminado al %s! Encontraste %s", mob_name(s.YKingLv2), item_name(s.KeyLv2)))
					game.drop_item_with_ownership(s.KeyLv2, 1)
					d.setf("YKingLv2Spawn", 0)
					if d.getf("KeyLv2Count") == s.KeyLv2Count then
						d.notice(string.format("La %s esta Completa!", item_name(s.KeyLv2)))
						d.setf("YKingLv2Spawn", 2)
						d.clear_regen()
					end
				end
			elseif d.getf("level") == 3 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado al %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
					server_timer("DragonImperialEndTimers", 60*3, d.get_map_index())
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
		when DragonImperialJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonImperial.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.notice(string.format("Elimina la Guardia Real! Enfrentate al %s",mob_name(s.YKingLv2)))
					d.spawn_mob_dir(s.aStoneLv2, s.aStoneLv2Poss[1], s.aStoneLv2Poss[2], s.aStoneLv2Poss[3])
					d.set_regen_file("data/dungeon/DragonImperial/regen2.txt")
					d.setf("XKingLv2Count", 0)
					d.setf("YKingLv2Spawn", 0)
					d.setf("KeyLv2Count", 0)
				elseif d.getf("level") == 3 then
					d.notice(string.format("El %s ha sido Invocado!", mob_name(s.FinalBoss)))
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], 1))
					d.regen_file("data/dungeon/DragonImperial/regen3.txt")
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when DragonImperial10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonImperial.Setting()
				server_timer("DragonImperial05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when DragonImperial05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonImperial.Setting()
				server_timer("DragonImperial10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when DragonImperial10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonImperial.Setting()
				server_timer("DragonImperialEndTimers",  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when DragonImperialEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = DragonImperial.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("DragonImperial_"..pc.getqf("DragonImperialIndex").."",0)
				d.setf("DragonImperialFail", 1)
				d.exit_all()
			end
		end
	end
end
