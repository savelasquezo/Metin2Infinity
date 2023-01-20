quest Slim begin
	state start begin
		function Setting()
			if Slim.Settings == nil then
				Slim.Settings = {
				["DungeonName"] = "Caverna Slim",
				["DungeonInfoIndex"] = 0,
				["Level"] = 30,
				["TimeLimit"] = 30,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20626,
				["KeyItem"] = 30415,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 261,
				["IndexCoord"] = {52786,24529},
				["IndexPoss"] = {203,252},
				["Outdoor"] = {1,21,21},
				["OutdoorCoord"] = {{4096,8960},{0,1024},{0,1024}},
				["OutdoorPoss"] = {{405,70},{877,1389},{877,1389}},
				---------------------------------------
				---------------------------------------
				["Slim"] = 20629,
				["KeyItemEmpty"] = 30416,
				["KeyItemFull"] = 30419,
				["Stone"] = 8084,
				["StoneInfo"] = 20627,
				["StoneInfoPoss"] = {289,252},
				["aStone"] = 20628,
				["aStonePoss"] = {289,255},
				["FinalBoss"] = 4167,
				["FinalBossPoss"] = {265,252},
				}
			end
			return Slim.Settings
		end
		function InDungeon()
			local s = Slim.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		function SpawnFakeStone()
			local Poss = {{270,281},{253,278},{228,291},{229,265},{216,245},{251,237},{269,249}}
			for i = 1, table.getn(Poss)-1 do
				local j = number(i, table.getn(Poss))
				if i != j then
					local t = Poss[i];
					Poss[i] = Poss[j];
					Poss[j] = t;
				end
			end
			return Poss
		end
		when 20626.chat.gameforge.npc.dungeon0000 with not Slim.InDungeon() begin
			local s = Slim.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = Slim.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("Slim_"..pc.getqf("SlimIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = Slim.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("SlimIndex"))
				else
					game.set_event_flag("Slim_"..pc.getqf("SlimIndex").."",0)
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
			say(gameforge.npc.dungeon0001)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0002)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = Slim.Setting()
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
				pc.setqf("Slim", 1)
				pc.setqf("SlimRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with Slim.InDungeon() begin
			local s = Slim.Setting()
			timer("SlimRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("SlimFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("Slim_"..pc.getqf("SlimIndex").."",0)
				pc.setqf("SlimRelogin", 0)
			end
		end
		when login with not Slim.InDungeon() begin
			local s = Slim.Setting()
			local e = pc.get_empire()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("Slim_"..pc.getqf("SlimIndex").."",0)
				pc.setqf("SlimRelogin", 0)
				pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
			end
		end
		when SlimExit.timer begin
			local s = Slim.Setting()
			local e = pc.get_empire()
			pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
		end
		when SlimRelogin.timer begin
			local s = Slim.Setting()
			pc.setqf("SlimRelogin", 0)
			game.set_event_flag("Slim_"..pc.getqf("SlimIndex").."",0)
		end
		when login with Slim.InDungeon() begin
			local s = Slim.Setting()
			if pc.getqf("SlimRelogin") == d.get_map_index() then
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
				timer("SlimExit", 5)
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
			pc.setqf("SlimRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("SlimRelogin", s.TimeLimit*60)
			d.setf("e", pc.get_empire())
			if pc.getqf("Slim") == 1 then
				game.set_event_flag("Slim_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("SlimIndex", d.get_map_index())
				d.notice(string.format("~%s~ Encuentra la %s",s.DungeonName, mob_name(s.StoneInfo)))
				d.spawn_mob_dir(s.StoneInfo ,s.StoneInfoPoss[1], s.StoneInfoPoss[2], 7)
				d.spawn_mob_dir(s.aStone ,s.aStonePoss[1], s.aStonePoss[2], 7)
				server_timer("Slim10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.set_regen_file("data/dungeon/Slim/regen.txt")
				pc.setqf("Slim", 2)
			end
		end
		when 20627.chat."Altar de Sombras" with Slim.InDungeon() begin
			local s = Slim.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if pc.getqf("Slim") != 2 then
				say("[ENTER]La Inscripcion esta grabada en Idioma Antiguo[ENTER]Se logra decifrar el Texto[ENTER][ENTER]")
				say_gold(string.format("¡Ofrenda %s en el %s!", mob_name(s.Slim), mob_name(s.aStone)))
				say_gold(string.format("Unicamente el Lider del grupo abrira el %s[ENTER]", mob_name(s.aStone)))
				return
			end
			say("[ENTER]La Inscripcion esta grabada en Idioma Antiguo[ENTER]Se logra decifrar el Texto[ENTER][ENTER]")
			say(string.format("¡Ofrenda %s en el %s!", mob_name(s.Slim), mob_name(s.aStone)))
			say(string.format("Usa el %s recolecta los %s de los %s[ENTER]", item_name(s.KeyItemEmpty),mob_name(s.Slim),mob_name(s.Stone)))
			d.notice(string.format("Encuentra el %s Real! Ofrenda Slims en el %s!",mob_name(s.Stone), mob_name(s.aStone)))
			server_timer("SlimTimeDelay", 1, d.get_map_index())
			pc.give_item2(s.KeyItemEmpty, 1)
			d.setf("CheckDungeon",1)
			pc.setqf("Slim", 0)
		end
		when 20629.take with Slim.InDungeon() begin
			local s = Slim.Setting()
			if item.get_vnum() >= s.KeyItemEmpty and item.get_vnum() < s.KeyItemFull then
				if item.get_vnum() == s.KeyItemFull - 1 then
					d.notice(string.format("La Ofrenda %s ha sido Completada!",mob_name(s.Slim)))
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say(string.format("[ENTER]¡Ofrenda Completa![ENTER]Entrega la ofrenda al %s Invoca al %s",mob_name(s.aStone), mob_name(s.FinalBoss)))
					say_item (""..item_name(s.KeyItemFull).."" , s.KeyItemFull , "")
					d.setf("SlimCount", d.getf("SlimCount")+1)
					item.remove()
					pc.give_item2(s.KeyItemEmpty + d.getf("SlimCount"), 1)
					npc.purge()
				else 
					d.notice(string.format("La Ofrenda %s ha Aumentado!",mob_name(s.Slim)))
					server_timer("SlimTimeDelay", 5, d.get_map_index())
					d.setf("SlimCount", d.getf("SlimCount")+1)
					item.remove()
					pc.give_item2(s.KeyItemEmpty + d.getf("SlimCount"), 1)
					npc.purge()
				end
			end
		end
		when 20628.take with Slim.InDungeon() begin
			local s = Slim.Setting()
			if item.get_vnum() == s.KeyItemFull then
				d.notice(string.format("Ofrenda Aceptada! La %s esta Aproximandose",mob_name(s.FinalBoss)))
				server_timer("SlimTimeDelay", 5, d.get_map_index())
				d.setf("CheckDungeon",2)
				item.remove()
				npc.kill()
			end
		end
		when kill with Slim.InDungeon() begin
			local s = Slim.Setting()
			if npc.get_race() == s.FinalBoss then
				d.notice(string.format("Has Eliminado a la %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
				server_timer("SlimEndTimers", 60*3, d.get_map_index())
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
		when SlimCheckTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				local Poss = Slim.SpawnFakeStone()
				if d.getf("CheckDungeon") == 1 then
					if d.is_unique_dead("SlimeaKt_"..table.getn(Poss).."") then
						d.notice(string.format("Has Eliminado el %s Real! Has Encontrado %s",mob_name(s.Stone),mob_name(s.Slim)))
						d.spawn_mob_dir(s.Slim ,d.getf("xaKt"), d.getf("yaKt"), 0)
						for i = 1, table.getn(Poss), 1  do
							if not d.is_unique_dead("SlimeaKt_"..i.."") then
								d.purge_unique("SlimeaKt_"..i.."")
							end
						end
						clear_server_timer("SlimCheckTime", d.get_map_index())
					end
				end
			else
				clear_server_timer("SlimCheckTime", get_server_timer_arg())
			end
		end
		when SlimTimeDelay.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				if d.getf("CheckDungeon") == 0 then
					return
				elseif d.getf("CheckDungeon") == 1 then
					d.notice(string.format("Destruye el %s Real! Encuentra los %ss",mob_name(s.Stone),mob_name(s.Slim)))
					local Poss = Slim.SpawnFakeStone()
					for i = 1, table.getn(Poss)-1 do
						d.set_unique("SlimeaKt_"..i.."", d.spawn_mob_dir(s.Stone, Poss[i][1], Poss[i][2], 1))
					end
					d.setf("xaKt",Poss[table.getn(Poss)][1])
					d.setf("yaKt",Poss[table.getn(Poss)][2])
					d.set_unique("SlimeaKt_"..table.getn(Poss).."", d.spawn_mob_dir(s.Stone, Poss[table.getn(Poss)][1], Poss[table.getn(Poss)][2], 1))
					server_loop_timer("SlimCheckTime", 3, d.get_map_index())
				elseif d.getf("CheckDungeon") == 2 then
					d.clear_regen()
					d.purge()
					d.notice(string.format("La %s ha Aparecido! Eliminala!",mob_name(s.FinalBoss)))
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], 1))
				end
			end
		end
		when Slim10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				server_timer("Slim05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when Slim05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				server_timer("Slim10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when Slim10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				server_timer("SlimEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when SlimEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = Slim.Setting()
				local e = d.getf("e")
				d.set_warp_location(s.Outdoor[e],s.OutdoorCoord[e][1] + s.OutdoorPoss[e][1], s.OutdoorCoord[e][2] + s.OutdoorPoss[e][2])
				game.set_event_flag("Slim_"..pc.getqf("SlimIndex").."",0)
				d.setf("SlimFail", 1)
				d.exit_all()
			end
		end
	end
end
