quest MinotauroLaberint begin
	state start begin
		function Setting()
			if MinotauroLaberint.Settings == nil then
				MinotauroLaberint.Settings = {
				["DungeonName"] = "Laberinto del Minotauro",
				["DungeonInfoIndex"] = 2,
				["Level"] = 50,
				["TimeLimit"] = 45,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20625,
				["KeyItem"] = 30410,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 209,
				["IndexCoord"] = {8448,14080},
				["IndexPoss"] = {90,84},
				["Outdoor"] = 64,
				["OutdoorCoord"] = {25600,66560},
				["OutdoorPoss"] = {284,1408},
				---------------------------------------
				---------------------------------------
				["aStone"] = 20621,
				["aStonePoss"] = {{{383,433,5},{353,403,3},{383,374,1},{412,403,7}},{{383,433,5},{353,403,3},{412,403,7},{383,374,1}},
								 {{383,433,5},{383,374,1},{353,403,3},{412,403,7}},{{383,433,5},{383,374,1},{412,403,7},{353,403,3}},
								 {{383,433,5},{412,403,7},{353,403,3},{383,374,1}},{{383,433,5},{412,403,7},{383,374,1},{353,403,3}},
								 {{353,403,3},{383,433,5},{383,374,1},{412,403,7}},{{353,403,3},{383,433,5},{412,403,7},{383,374,1}},
								 {{353,403,3},{383,374,1},{383,433,5},{412,403,7}},{{353,403,3},{383,374,1},{412,403,7},{383,433,5}},
								 {{353,403,3},{412,403,7},{383,433,5},{383,374,1}},{{353,403,3},{412,403,7},{383,374,1},{383,433,5}},
								 {{383,374,1},{383,433,5},{353,403,3},{412,403,7}},{{383,374,1},{383,433,5},{412,403,7},{353,403,3}},
								 {{383,374,1},{353,403,3},{383,433,5},{412,403,7}},{{383,374,1},{353,403,3},{412,403,7},{383,433,5}},
								 {{383,374,1},{412,403,7},{383,433,5},{353,403,3}},{{383,374,1},{412,403,7},{353,403,3},{383,433,5}},
								 {{412,403,7},{383,433,5},{353,403,3},{383,374,1}},{{412,403,7},{383,433,5},{383,374,1},{353,403,3}},
								 {{412,403,7},{353,403,3},{383,433,5},{383,374,1}},{{412,403,7},{353,403,3},{383,374,1},{383,433,5}},
								 {{412,403,7},{383,374,1},{383,433,5},{353,403,3}},{{412,403,7},{383,374,1},{353,403,3},{383,433,5}}},
				["KeyStone"] = 30411,
				["King"] = 4105,
				["KingPoss"] = {{192,146},{123,217},{591,141},{645,153},{446,250},{388,197},{224,383},{431,517},{373,609},{348,708}},
				["FinalBoss"] = 4110,
				["FinalBossPoss"] = {445,380},
			}
			end
			return MinotauroLaberint.Settings
		end
		function InDungeon()
			local s = MinotauroLaberint.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20625.chat.gameforge.npc.dungeon0020 with not MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = MinotauroLaberint.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = MinotauroLaberint.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("MinotauroLaberintIndex"))
				else
					game.set_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."",0)
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
			say(gameforge.npc.dungeon0021)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0022)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = MinotauroLaberint.Setting()
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
				pc.setqf("MinotauroLaberint", 1)
				pc.setqf("MinotauroLaberintRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			timer("MinotauroLaberintRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("MinotauroLaberintFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."",0)
				pc.setqf("MinotauroLaberintRelogin", 0)
			end
		end
		when login with not MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			if pc.get_map_index() == s.Index then
				if pc.get_x() <= s.IndexCoord[1]+260 and pc.get_y() <= s.IndexCoord[2]+230 then
					game.set_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."",0)
					pc.setqf("MinotauroLaberintRelogin", 0)
					pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
				end
			end
		end
		when MinotauroLaberintExit.timer begin
			local s = MinotauroLaberint.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when MinotauroLaberintRelogin.timer begin
			local s = MinotauroLaberint.Setting()
			pc.setqf("MinotauroLaberintRelogin", 0)
			game.set_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."",0)
		end
		when login with MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			if pc.getqf("MinotauroLaberintRelogin") == d.get_map_index() then
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
				timer("MinotauroLaberintExit", 5)
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
			pc.setqf("MinotauroLaberintRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("MinotauroLaberintRelogin", s.TimeLimit*60)
			if pc.getqf("MinotauroLaberint") == 1 then
				game.set_event_flag("MinotauroLaberint_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("MinotauroLaberintIndex", d.get_map_index())
				d.notice(string.format("Encuentra Las %s Libera los Sellos del %s",item_name(s.KeyStone), s.DungeonName))
				d.notice(string.format("Invoca a la Bestia "..mob_name(s.FinalBoss).."!"))
				server_timer("MinotauroLaberint10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.set_regen_file("data/dungeon/MinotauroLaberint/regen1.txt")
				d.setf("i", number(1,table.getn(s.aStonePoss)))
				pc.setqf("MinotauroLaberint", 0)
				d.setf("StoneStep", 1)
				for j = 1, 4, 1  do
					d.set_unique("aSt"..j.."", d.spawn_mob_dir(s.aStone+j-1, s.aStonePoss[d.getf("i")][j][1], s.aStonePoss[d.getf("i")][j][2], s.aStonePoss[d.getf("i")][j][3]))
				end
				for i = 1, table.getn(s.KingPoss), 1  do
					d.spawn_mob_dir(s.King, s.KingPoss[i][1], s.KingPoss[i][2], 0)
				end
			end
		end
		when 20621.chat."Altar Minos" or 20622.chat."Altar Minos" or 20623.chat."Altar Minos" or 20624.chat."Altar Minos" with MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~"..mob_name(s.aStone).."~")
			say("")
			say_gold("!Necesitas "..item_name(s.KeyStone).."!")
			say_gold("!Elimina los "..mob_name(s.King).."!")
			say_item (""..item_name(s.KeyStone).."" , s.KeyStone , "")
			say("")
			return
		end
		when 20621.take or 20622.take or 20623.take or 20624.take with MinotauroLaberint.InDungeon() begin
			local s = MinotauroLaberint.Setting()
			local itemVnum = item.get_vnum()
			local i = d.getf("i")
			pc.remove_item(s.KeyStone, 1)
			if itemVnum == s.KeyStone then
				if d.getf("StoneStep") == o then
					return
				elseif d.getf("StoneStep") == 1 and npc.get_race() == s.aStone+0 then
					npc.purge()
					d.setf("StoneStep", d.getf("StoneStep")+1)
					d.notice("Correcto! El Primer "..mob_name(s.aStone).." ha sido Destruido!")
				elseif d.getf("StoneStep") == 2 and npc.get_race() == s.aStone+1 then
					npc.purge()
					d.setf("StoneStep", d.getf("StoneStep")+1)
					d.notice("Correcto! El Segundo "..mob_name(s.aStone).." ha sido Destruido!")
				elseif d.getf("StoneStep") == 3 and npc.get_race() == s.aStone+2 then
					npc.purge()
					d.setf("StoneStep", d.getf("StoneStep")+1)
					d.notice("Correcto! El Tercer "..mob_name(s.aStone).." ha sido Destruido!")
				elseif d.getf("StoneStep") == 4 and npc.get_race() == s.aStone+3 then
					d.purge()
					d.setf("StoneStep", d.getf("StoneStep")+1)
					d.notice("Correcto! El Cuarto "..mob_name(s.aStone).." ha sido Destruido!")
					d.notice(""..mob_name(s.FinalBoss).." ha Despertado, Eliminalo!")
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], 5))
				else
					d.notice("Incorrecto! Has Fallado al Destruir El "..mob_name(s.aStone).."!")
				end
			end
		end
		when kill with MinotauroLaberint.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = MinotauroLaberint.Setting()
			if mobVnum == s.King then
				game.drop_item_with_ownership(s.KeyStone, 1)
				d.notice("Has Eliminado un "..mob_name(s.King).."")
				d.notice("Encontraste "..item_name(s.KeyStone).."")
			end
			if mobVnum == s.FinalBoss then
				d.notice(string.format("Has Eliminado a al %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
				server_timer("MinotauroLaberintEndTimers", 60*3, d.get_map_index())
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
		when MinotauroLaberint10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = MinotauroLaberint.Setting()
				server_timer("MinotauroLaberint05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when MinotauroLaberint05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = MinotauroLaberint.Setting()
				server_timer("MinotauroLaberint10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when MinotauroLaberint10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = MinotauroLaberint.Setting()
				server_timer("MinotauroLaberintEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when MinotauroLaberintEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = MinotauroLaberint.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("MinotauroLaberint_"..pc.getqf("MinotauroLaberintIndex").."",0)
				d.setf("MinotauroLaberintFail", 1)
				d.exit_all()
			end
		end
	end
end
