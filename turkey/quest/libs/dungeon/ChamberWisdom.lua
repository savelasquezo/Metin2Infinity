quest ChamberWisdom begin
	state start begin
		function Setting()
			if ChamberWisdom.Settings == nil then
				ChamberWisdom.Settings = {
				["DungeonName"] = "Camara del Juicio",
				["DungeonInfoIndex"] = 1,
				["Level"] = 45,
				["TimeLimit"] = 30,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20638,
				["KeyItem"] = 30811,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 265,
				["IndexCoord"] = {11264,22528},
				["IndexPoss"] = {271,304},
				["Outdoor"] = {3,23,0},
				["OutdoorCoord"] = {{3072,8192},{1024,2048},{0,0}},
				["OutdoorPoss"] = {{407,48},{896,466},{0,0}},
				---------------------------------------
				---------------------------------------
				["UnlockItem"] = 30812,
				["nStone"] = 20647,
				["nStonePoss"] = {271,222},
				["StoneX"] = 8085,
				["StoneXPoss"] = {271,298},
				["StoneY"] = 8086,
				["StoneYPoss"] = {{284,261},{257,261}},
				["SkillBook"] = 50300,
				["SkillBookCount"] = 21,
				["aStone"] = 20643,
				["aStonePoss"] = {{{298,289},{298,241},{243,241},{243,289}},{{298,289},{298,241},{243,289},{243,241}},
								  {{298,289},{243,241},{298,241},{243,289}},{{298,289},{243,241},{243,289},{298,241}},
								  {{298,289},{243,289},{298,241},{243,241}},{{298,289},{243,289},{243,241},{298,241}},
								  {{298,241},{298,289},{243,241},{243,289}},{{298,241},{298,289},{243,289},{243,241}},
								  {{298,241},{243,241},{298,289},{243,289}},{{298,241},{243,241},{243,289},{298,289}},
								  {{298,241},{243,289},{298,289},{243,241}},{{298,241},{243,289},{243,241},{298,289}},
								  {{243,241},{298,289},{298,241},{243,289}},{{243,241},{298,289},{243,289},{298,241}},
								  {{243,241},{298,241},{298,289},{243,289}},{{243,241},{298,241},{243,289},{298,289}},
								  {{243,241},{243,289},{298,289},{298,241}},{{243,241},{243,289},{298,241},{298,289}},
								  {{243,289},{298,289},{298,241},{243,241}},{{243,289},{298,289},{243,241},{298,241}},
								  {{243,289},{298,241},{298,289},{243,241}},{{243,289},{298,241},{243,241},{298,289}},
								  {{243,289},{243,241},{298,289},{298,241}},{{243,289},{243,241},{298,241},{298,289}}},
				["SummonItem"] = 30813,
				["King"] = 4311,
				["KingPoss"] = {271,245},
				["FinalBoss"] = 4312,
				["FinalBossPoss"] = {271,230},
				}
			end
			return ChamberWisdom.Settings
		end
		function InDungeon()
			local s = ChamberWisdom.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20638.chat.gameforge.npc.dungeon0010 with not ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ChamberWisdom.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ChamberWisdom.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("ChamberWisdomIndex"))
				else
					game.set_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."",0)
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
			say(gameforge.npc.dungeon0011)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0012)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = ChamberWisdom.Setting()
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
				pc.setqf("ChamberWisdom", 1)
				pc.setqf("ChamberWisdomRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			timer("ChamberWisdomRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("ChamberWisdom") == 1 or d.getf("level") == 99 then
				game.set_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."",0)
				pc.setqf("ChamberWisdomRelogin", 0)
			end
		end
		when login with not ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			local e = pc.get_empire()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."",0)
				pc.setqf("ChamberWisdomRelogin", 0)
				pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
			end
		end
		when ChamberWisdomExit.timer begin
			local s = ChamberWisdom.Setting()
			local e = pc.get_empire()
			pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
		end
		when ChamberWisdomRelogin.timer begin
			local s = ChamberWisdom.Setting()
			pc.setqf("ChamberWisdomRelogin", 0)
			game.set_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."",0)
		end
		when login with ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			if pc.getqf("ChamberWisdomRelogin") == d.get_map_index() then
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
				timer("ChamberWisdomExit", 5)
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
			pc.setqf("ChamberWisdomRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("ChamberWisdomRelogin", s.TimeLimit*60)
			d.setf("e", pc.get_empire())
			if pc.getqf("ChamberWisdom") == 1 then
				game.set_event_flag("ChamberWisdom_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("ChamberWisdomIndex", d.get_map_index())
				d.notice(string.format("~%s~ Encuentra la %s! Libera al %s",s.DungeonName, mob_name(s.nStone), mob_name(s.FinalBoss)))
				d.set_unique("nStoneBook",d.spawn_mob_dir(s.nStone, s.nStonePoss[1], s.nStonePoss[2], 5))
				server_timer("ChamberWisdom10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("ChamberWisdom", 2)
			end
		end
		when 20647.chat."Espiritu del Juicio" with ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if pc.getqf("ChamberWisdom") != 2 then
				say("[ENTER]La Inscripcion esta grabada en Idioma Antiguo[ENTER]Se logra decifrar una Inscripcion[ENTER][ENTER]")
				say_gold(string.format("¡Encuentra el %s! Abre los %s", item_name(s.SummonItem), mob_name(s.aStone)))
				say_gold(string.format("Unicamente el Lider del grupo abrira el %s[ENTER]", mob_name(s.nStone)))
				return
			end
			say("[ENTER]La Inscripcion esta grabada en Idioma Antiguo[ENTER]Se logra decifrar una Inscripcion[ENTER][ENTER]")
			say_gold(string.format("¡Encuentra las %s![ENTER]Destruye los %s[ENTER]", item_name(s.UnlockItem), mob_name(s.StoneX)))
			d.notice(string.format("¡Libera los %s en el Orden Correcto!", mob_name(s.aStone)))
			server_timer("ChamberWisdomTimeDelay", 1, d.get_map_index())
			pc.setqf("ChamberWisdom",0)
			d.setf("i", number(1,table.getn(s.aStonePoss)))
			d.setf("mCount",0)
			d.setf("Step",1)
		end
		when 20647.take with ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			if item.get_vnum() == s.SummonItem and d.getf("Step") == 5 then
				d.notice(string.format("El %s ha sido Insertado! El %s se esta Aproximando",item_name(s.SummonItem),mob_name(s.FinalBoss)))
				server_timer("ChamberWisdomTimeDelay", 5, d.get_map_index())
				item.remove()
			end
		end
		when 20643.take or 20644.take or 20645.take or 20646.take with ChamberWisdom.InDungeon() begin
			local s = ChamberWisdom.Setting()
			local itemVnum = item.get_vnum()
			if itemVnum == s.UnlockItem then
				item.remove()
				if d.getf("Step") == 0 then
					return
				elseif d.getf("Step") == 1 and npc.get_race() == s.aStone+0 then
					d.notice(string.format("Correcto! El Primero de los %s ha sido Liberado!", mob_name(s.aStone)))
					d.setf("Step", d.getf("Step")+1)
					npc.kill()
					d.spawn_mob_dir(s.StoneX, s.StoneXPoss[1],s.StoneXPoss[2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[1][1],s.StoneYPoss[1][2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[2][1],s.StoneYPoss[2][2], 7)
				elseif d.getf("Step") == 2 and npc.get_race() == s.aStone+1 then
					d.notice(string.format("Correcto! El Segundo de los %s ha sido Liberado!", mob_name(s.aStone)))
					d.setf("Step", d.getf("Step")+1)
					npc.kill()
					d.spawn_mob_dir(s.StoneX, s.StoneXPoss[1],s.StoneXPoss[2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[1][1],s.StoneYPoss[1][2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[2][1],s.StoneYPoss[2][2], 7)
				elseif d.getf("Step") == 3 and npc.get_race() == s.aStone+2 then
					d.notice(string.format("Correcto! El Tercero de los %s ha sido Liberado!", mob_name(s.aStone)))
					d.setf("Step", d.getf("Step")+1)
					npc.kill()
					d.spawn_mob_dir(s.StoneX, s.StoneXPoss[1],s.StoneXPoss[2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[1][1],s.StoneYPoss[1][2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[2][1],s.StoneYPoss[2][2], 7)
				elseif d.getf("Step") == 4 and npc.get_race() == s.aStone+3 then
					d.notice(string.format("Correcto! El Cuarto de los %s ha sido Liberado!", mob_name(s.aStone)))
					d.notice(string.format("El %s esta Aproximandose",mob_name(s.King)))
					server_timer("ChamberWisdomTimeDelay", 5, d.get_map_index())
					d.clear_regen()
					npc.kill()
				else
					d.notice(string.format("Incorrecto! Has Fallado al Liberar el %s!", mob_name(s.aStone)))
					if d.getf("Step") != 1 then
						d.notice(string.format("Los %s Liberados se han Regenerado!", mob_name(s.aStone)))
					end
					d.setf("Step", 1)
					d.spawn_mob_dir(s.StoneX, s.StoneXPoss[1],s.StoneXPoss[2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[1][1],s.StoneYPoss[1][2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[2][1],s.StoneYPoss[2][2], 7)
					for j = 1, 4, 1  do
						if d.is_unique_dead("aSt"..j) then
							d.set_unique("aSt"..j, d.spawn_mob_dir(s.aStone+j-1, s.aStonePoss[d.getf("i")][j][1], s.aStonePoss[d.getf("i")][j][2], 1))
						end
					end
				end
			end
		end
		when kill with ChamberWisdom.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = ChamberWisdom.Setting()
			if d.getf("level") == 99 then
				return
			elseif npc.get_race() == s.StoneX or npc.get_race() == s.StoneY then
				d.setf("mCount", d.getf("mCount")+1)
				if d.getf("mCount") == table.getn(s.StoneYPoss)+1 then
					d.notice(string.format("Has Destruido los %s! Libera los %s!",mob_name(s.StoneX),mob_name(s.aStone)))
					game.drop_item_with_ownership(s.UnlockItem, 1)
					d.setf("mCount", 0)
				end
			elseif mobVnum == s.King then
				d.notice(string.format("Has Eliminado el %s! Inserta el %s en el %s!",mob_name(s.King),item_name(s.SummonItem),mob_name(s.nStone)))
				game.drop_item_with_ownership(s.SummonItem, 1)
				for i = 1, s.SkillBookCount, 1  do
					game.drop_item_with_ownership(s.SkillBook, 1)
				end
				d.setf("Step", d.getf("Step")+1)
			elseif mobVnum == s.FinalBoss then
				d.notice(string.format("Has Eliminado el %s! El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss),s.DungeonName))
				server_timer("ChamberWisdomEndTimers", 60*3, d.get_map_index())
				d.setf("level", 99)
				d.clear_regen()
				d.kill_all()
				if party.is_party() then
					local pids = {party.get_member_pids()}
					notice_all(string.format("El Grupo de %s ha Derrtotado el %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss)))
					party.setf("level",d.getf("level"))
					for i, pid in next, pids, nil do
						q.begin_other_pc_block(pid)
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
						q.end_other_pc_block()
					end
				else
					pc.setqf("level", d.getf("level"))
					notice_all(string.format("Increible! %s ha Derrtotado el %s!",pc.get_name(),mob_name(s.FinalBoss)))
					dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
				end
			end
		end
		when ChamberWisdomTimeDelay.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ChamberWisdom.Setting()
				if d.getf("Step") == 99 then
					return
				elseif d.getf("Step") == 1 then
					d.notice(string.format("Los %s han sido Invocados! Encuentra el %s",mob_name(s.King),item_name(s.UnlockItem)))
					d.set_regen_file("data/dungeon/ChamberWisdom/regen.txt")
					d.spawn_mob_dir(s.StoneX, s.StoneXPoss[1],s.StoneXPoss[2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[1][1],s.StoneYPoss[1][2], 7)
					d.spawn_mob_dir(s.StoneY, s.StoneYPoss[2][1],s.StoneYPoss[2][2], 7)
					for j = 1, 4, 1  do
						d.set_unique("aSt"..j, d.spawn_mob_dir(s.aStone+j-1, s.aStonePoss[d.getf("i")][j][1], s.aStonePoss[d.getf("i")][j][2], 1))
					end
				elseif d.getf("Step") == 4 then
					d.notice(string.format("El %s ha Aparecido! Eliminalo!",mob_name(s.King)))
					d.spawn_mob_dir(s.King, s.KingPoss[1],s.KingPoss[2], 1)
				elseif d.getf("Step") == 5 then
					d.purge_unique("nStoneBook")
					d.notice(string.format("La %s ha Aparecido! Eliminala!",mob_name(s.FinalBoss)))
					d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], 1))
				end
			end
		end
		when ChamberWisdom10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ChamberWisdom.Setting()
				server_timer("ChamberWisdom05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when ChamberWisdom05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ChamberWisdom.Setting()
				server_timer("ChamberWisdom10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when ChamberWisdom10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ChamberWisdom.Setting()
				server_timer("ChamberWisdomEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
				d.notice(gameforge.dungeon.ntc004)
			end
		end
		when ChamberWisdomEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ChamberWisdom.Setting()
				local e = d.getf("e")
				d.set_warp_location(s.Outdoor[e],s.OutdoorCoord[e][1] + s.OutdoorPoss[e][1], s.OutdoorCoord[e][2] + s.OutdoorPoss[e][2])
				game.set_event_flag("ChamberWisdom_"..pc.getqf("ChamberWisdomIndex").."",0)
				d.setf("ChamberWisdomFail", 1)
				d.exit_all()
			end
		end
	end
end
