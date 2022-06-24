quest ZonePvM begin
	state start begin
		function Setting()
			if ZonePvM.Settings == nil then
				ZonePvM.Settings = {
				["DungeonName"] = "ZonaPvM",
				["Level"] = {30,105,150},
				["TimeLimit"] = 45,
				["TimeToRetry"] = 12,
				["PartyMinCount"] = 2,
				["NPC"] = 9007,--PENDIENTE
				["KeyItem"] = 0,
				["KeyItemType"] = 2, --(0) Only Leader / (1) All / (2) Notting
				["KeyCount"] = 1,
				["Index"] = 49,
				["IndexCoord"] = {8680,9216},
				["IndexPoss"] = {18,127},
				["Outdoor"] = {1,21},
				["OutdoorCoord"] = {{4096,8960},{0,1024}},
				["OutdoorPoss"] = {{597,682},{557,555}},
				---------------------------------------
				---------------------------------------
				["Life"] = 5,
				["aStone"] = 20471,
				["aStonePoss"] = {148,127,7},
				["Stone"] = {{8001,8002,8003,8004,8005},{8006,8007,8008,8009,8010},{8011,8012,8013,8014,8015}},
				["StonePoss"] = {{147,119,1},{147,135,1},{124,119,1},{124,135,1}},
				["King"] = {{191,192,193,194,591},{191,192,193,194,691},{191,192,193,194,791}},
				["KingPoss"] = {138,127,7},
				["StoneFinal"] = {8074,8075,8076},
				["StoneFinalPoss"] = {{147,119,1},{147,135,1},{124,119,1},{124,135,1}},
				["FinalBoss"] = {6091,6191,1665},
				["FinalBossPoss"] = {138,127,7},
				} 
			end
			return ZonePvM.Settings
		end
		function InDungeon()
			local s = ZonePvM.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 40016.chat.gameforge.npc.dungeon0150 with not ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if game.get_event_flag("ZonePvM") == 0 then
				say("EL EVENTO ESTA APAGADO")
				return
			elseif game.get_event_flag("ZonePvM") == 1 and pc.getqf("ZonePvMLife") <= 0 then
				say("Ya has sido derrotado")
				return
			elseif party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ZonePvM.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ZonePvM.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("ZonePvMIndex"))
				else
					game.set_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."",0)
					return
				end
			elseif pc.get_level() < s.Level[1] then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc001,s.Level[1], s.DungeonName))
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
			elseif pc.count_item (s.KeyItem) < s.KeyCount and s.KeyItemType != 2 then
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
					local s = ZonePvM.Setting()
					for i, pid in next, pids, nil do
						q.begin_other_pc_block(pid)
						if s.KeyItemType == 1 then 
							if pc.count_item (s.KeyItem) < s.KeyCount then
								table.insert(cantEnterMembersItem[1], pc.get_name())
							end
						end
						if pc.get_level() < s.Level[1] then
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
						say(string.format(gameforge.dungeon.npc005, s.Level[1]))
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
				elseif pc.get_level() > s.Level[1] then
					pc.setqf("ZonePvMLevel", 1)--Hard
				elseif pc.get_level() > s.Level[2] then
					pc.setqf("ZonePvMLevel", 2)--Norm
				elseif pc.get_level() > s.Level[3] then
					pc.setqf("ZonePvMLevel", 3)--Easy
				end
				pc.setqf("ZonePvM", 1)
				pc.setqf("ZonePvMRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			timer("ZonePvMRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("ZonePvMFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."",0)
				pc.setqf("ZonePvMRelogin", 0)
			end
		end
		when login with not ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			local e = pc.get_empire()
			if pc.get_map_index() == s.Index then
				if party.is_party() and d.find(party.getf("IndexDungeon")) then
					if party.getf("level") == 99 then
						pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
				elseif pc.get_player_id() == game.get_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."") then
					if pc.getqf("level") == 99 then
						pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("ZonePvMIndex"))
				else
					pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
				end
			end
		end
		when ZonePvMExit.timer begin
			local s = ZonePvM.Setting()
			local e = pc.get_empire()
			pc.warp((s.OutdoorCoord[e][1]+s.OutdoorPoss[e][1])*100, (s.OutdoorCoord[e][2]+s.OutdoorPoss[e][2])*100, s.Outdoor[e])
		end
		when ZonePvMRelogin.timer begin
			local s = ZonePvM.Setting()
			pc.setqf("ZonePvMRelogin", 0)
			game.set_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."",0)
		end
		when login with ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			if pc.getqf("ZonePvMRelogin") == d.get_map_index() then
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
				timer("ZonePvMExit", 5)
				return
			end
			if s.KeyItemType == 1 then
				if pc.count_item (s.KeyItem) < s.KeyCount then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say_red(gameforge.dungeon.msm001)
					say("")
					timer("ZonePvMExit", 5)
					return
				end
				pc.remove_item(s.KeyItem, s.KeyCount)
			end
			if party.is_party() then
				party.setf("IndexDungeon", d.get_map_index())
			end
			d.setf("e", pc.get_empire())
			pc.setqf("ZonePvMLife", s.Life)
			pc.setqf("ZonePvMRelogin", d.get_map_index())
			timer("ZonePvMRelogin", s.TimeLimit*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if pc.getqf("ZonePvM") == 1 then
				game.set_event_flag("ZonePvM_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("ZonePvMIndex", d.get_map_index())
				d.spawn_mob_dir(s.aStone, s.aStonePoss[1], s.aStonePoss[2], s.aStonePoss[3])
				server_timer("ZonePvM10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.setf("level",0)
				pc.setqf("ZonePvM", 0)
				d.setf("ZonePvMInfo",0)
				d.setf("ZonePvMLevel",pc.getqf("ZonePvMLevel"))
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			end
		end
		when 00000.chat."Informacion" with game.get_event_flag("ZonePvM") == 1 and ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("INFORMACION")
			say("")
		end
		when 00000.chat."Zona PvM" with game.get_event_flag("ZonePvM") == 2 and ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			local d = d.getf("ZonePvMLevel")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if d.getf("level") == 99 then
				say("INFORMACION")
				say("")
				return
			elseif d.getf("ZonePvMInfo") != 1 and d.getf("level") <= table.getn(s.King[d]) then
				say("Infromacion e Inicio")
				if select("Iniciar","Cancelar") == 1 then
					if d.getf("ZonePvMInfo") == 1 then
						return
					end
					d.setf("level",d.getf("level")+1)
					server_loop_timer('ZonePvMCheckTime', 5, d.get_map_index())
					d.regen_file("data/dungeon/ZonePvM/regen"..d.."_"..d.getf("level")..".txt")
					d.spawn_mob_dir(s.King[d][d.getf("level")], s.KingPoss[1], s.KingPoss[2], s.KingPoss[3])
					for i = 1, table.getn(s.StonePoss), 1  do 
						d.spawn_mob_dir(s.Stone[d][d.getf("level")], s.StonePoss[i][1],s.StonePoss[i][2],s.StonePoss[i][3])
					end
					d.setf("ZonePvMInfo",1)
					return
				elseif d.getf("ZonePvMInfo") != 1 and d.getf("level") == table.getn(s.King[d])+1 then
					say("Infromacion e Inicio")
					if select("¡Final!","Cancelar") == 1 then
						if d.getf("ZonePvMInfo") == 1 then
							return
						end
						d.setf("level",d.getf("level")+1)
						server_loop_timer('ZonePvMCheckTime', 5, d.get_map_index())
						d.regen_file("data/dungeon/ZonePvM/regen"..d.."_X.txt")
						d.spawn_mob_dir(s.FinalBoss[d], s.FinalBossPoss[1], s.FinalBossPoss[2], s.FinalBossPoss[3])
						for i = 1, table.getn(s.StoneFinalPoss), 1  do 
							d.spawn_mob_dir(s.StoneFinal[d], s.StoneFinalPoss[i][1],s.StoneFinalPoss[i][2],s.StoneFinalPoss[i][3])
						end
						d.setf("ZonePvMInfo",1)
						return
					end
				end
			end
		end
		when kill with ZonePvM.InDungeon() begin
			local s = ZonePvM.Setting()
			local mobVnum = npc.get_race()
			local d = d.getf("ZonePvMLevel")
			local Life = pc.getqf("ZonePvMLife")
			if d.getf("level") == 99 then
				return
			elseif npc.is_pc() and pc.select(tonumber(npc.get_vid())) != 0 then
				pc.setqf("ZonePvMLife",Life-1)
				if Life-1 <= 0 then
					syschat("<"..s.DungeonName.."> ¡Haz Muerto #"..game.get_event_flag("ZonePvMLife").." en la "..s.DungeonName.."!")
					syschat("Serás Teletransportado a la Ciudad!")
					pc.setqf("ZonePvMLife",0)
					timer("ZonePvMExit",3)
				else
					syschat("¡Advertencia! Haz Muerto #"..(Life-1).."!! Serás Teletransportado de la "..s.DungeonName.." en la Muerte #"..game.get_event_flag("ZonePvMLife").."")
				end
			elseif d.getf("level") <= table.getn(s.King[d]) and d.getf("ZonePvMInfo") == 1 then
				if mobVnum == s.Stone[d][d.getf("level")] then
					affect.add_collect(apply.APPLY_ATTBONUS_MONSTER, 5, 60*5)
					syschat("<"..s.DungeonName.."> Aumento la Fuerza contra Monstruos 5% (5min)")
				elseif mobVnum == s.King[d][d.getf("level")] then
					d.notice(string.format("<%s> Haz Eliminado %s!", s.DungeonName ,mob_name(mobVnum)))
					d.clear_regen()
					d.kill_all()
					d.spawn_mob_dir(s.aStone, s.aStonePoss[1], s.aStonePoss[2], s.aStonePoss[3])
				end
			elseif d.getf("level") == table.getn(s.King[d])+1 and d.getf("ZonePvMInfo") == 1 then
				if mobVnum == s.StoneFinal[d] then
					affect.add_collect(apply.APPLY_ATTBONUS_MONSTER, 5, 60*5)
					syschat("<"..s.DungeonName.."> Aumento la Fuerza contra Monstruos 5% (5min)")
				elseif mobVnum == s.FinalBoss[d] then
					d.notice(string.format("<%s> ¡Increible! Haz Eliminado %s! EL Desafio PvM ha Finalizdo!", s.DungeonName ,mob_name(mobVnum)))
					d.notice(string.format("El Sello de la %s se esta Recuperando! 3min Restantes!",mob_name(s.FinalBoss[d]),s.DungeonName))
					server_timer("ZonePvMEndTimers", 60*3, d.get_map_index())
					game.set_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."",0)
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
				end
			end
		end
		when ZonePvMCheckTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZonePvM.Setting()
				if d.getf("level") != 99 then
					if d.count_monster() == 0 and d.getf("ZonePvMInfo") != 0 then
						d.setf("ZonePvMInfo",0)
						return
					end
				end
			else
				clear_server_timer("ZonePvMCheckTime", d.get_map_index())
			end
		end
		when ZonePvM10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZonePvM.Setting()
				server_timer("ZonePvM05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when ZonePvM05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZonePvM.Setting()
				server_timer("ZonePvM10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when ZonePvM10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZonePvM.Setting()
				server_timer("ZonePvMEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when ZonePvMEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZonePvM.Setting()
				local e = d.getf("e")
				d.set_warp_location(s.Outdoor[e],s.OutdoorCoord[e][1] + s.OutdoorPoss[e][1], s.OutdoorCoord[e][2] + s.OutdoorPoss[e][2])
				game.set_event_flag("ZonePvM_"..pc.getqf("ZonePvMIndex").."",0)
				d.setf("ZonePvMFail", 1)
				d.exit_all()
			end
		end
	end
end

