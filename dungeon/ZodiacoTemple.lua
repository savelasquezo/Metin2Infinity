quest ZodiacoTemple begin
	state start begin
		function Setting()
			if ZodiacoTemple.Settings == nil then
				ZodiacoTemple.Settings = {
				["DungeonName"] = "Templo del Zodiaco",
				["DungeonInfoIndex"] = 14,
				["Level"] = 120,
				["TimeLimit"] = 75,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 60524,
				["KeyItem"] = 72327,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 221,
				["IndexCoord"] = {13072,14080},
				["IndexPoss"] = {{262,225},{768,215},{256,727},{768,727},{256,1240},{768,1244},{1280,725},{1288,207},{1285,1242}},
				["Outdoor"] = 222,
				["OutdoorCoord"] = {0,7168},
				["OutdoorPoss"] = {117,696},
				---------------------------------------
				---------------------------------------
				["aStoneLv1"] = 20471,
				["aStoneLv1Poss"] = {261,251,1},
				["StoneLv3"] = 8062,
				["StoneLv3Poss"] = {{275,738,1},{238,738,1},{226,751,1},{285,751,1},{240,766,1},{272,766,1},{231,777,1},{282,777,1},{242,792,1},{270,792,1},{256,804,1}},
				["KingLv4"] = 2703,
				["KingLv4Poss"] = {{748,743,5},{751,763,5},{738,777,5},{752,793,5},{771,801,5},{786,792,5},{802,777,5},{785,760,5},{789,742,5}},
				["FinalBoss"] = 2750,
				["FinalBossPoss"] = {257,1307,5},
				["KeyItemLv6"] = 33025,
				["KillCountLv6Drop"] = 100,
				["aStoneLv6"] = 20390,
				["aStoneLv6Poss"] = {{{768,1314,5},{773,1314,5},{763,1314,5}},{{768,1314,5},{763,1314,5},{773,1314,5}},{{773,1314,5},{768,1314,5},{763,1314,5}},
									 {{773,1314,5},{763,1314,5},{768,1314,5}},{{763,1314,5},{768,1314,5},{773,1314,5}},{{763,1314,5},{773,1314,5},{768,1314,5}}},
				["KingLv8"] = 2721,
				["KingLv8Poss"] = {{1271,272,5},{1271,255,5},{1257,245,5},{1266,227,5},{1306,225,5},{1319,242,5},{1305,256,5},{1314,270,5},{1291,279,5}},
				["FinalBossBonus"] = 2751,
				["FinalBossBonusPoss"] = {1285,1300,5},
				}
			end
			return ZodiacoTemple.Settings
		end
		function InDungeon()
			local s = ZodiacoTemple.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 60524.chat.gameforge.npc.dungeon0140 with not ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ZodiacoTemple.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = ZodiacoTemple.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[pc.getqf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[pc.getqf("level")][2])*100, pc.getqf("ZodiacoTempleIndex"))
				else
					game.set_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."",0)
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
			say(gameforge.npc.dungeon0141)
			wait()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say(gameforge.npc.dungeon0142)
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = ZodiacoTemple.Setting()
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
				pc.setqf("ZodiacoTemple", 1)
				pc.setqf("ZodiacoTempleRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when 20471.chat.gameforge.npc.dungeon0140 with ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("...")
			say("")
			say_gold("PROXIMAMENTE")
			say_white("SungMahi")
			say("")
		end
		when logout with ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			timer("ZodiacoTempleRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("ZodiacoTempleFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."",0)
				pc.setqf("ZodiacoTempleRelogin", 0)
			end
		end
		when login with not ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."",0)
				pc.setqf("ZodiacoTempleRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when ZodiacoTempleExit.timer begin
			local s = ZodiacoTemple.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when ZodiacoTempleRelogin.timer begin
			local s = ZodiacoTemple.Setting()
			pc.setqf("ZodiacoTempleRelogin", 0)
			game.set_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."",0)
		end
		when login with ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			if pc.getqf("ZodiacoTempleRelogin") == d.get_map_index() then
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
				timer("ZodiacoTempleExit", 5)
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
			pc.setqf("ZodiacoTempleRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("ZodiacoTempleRelogin", s.TimeLimit*60)
			if pc.getqf("ZodiacoTemple") == 1 then
				game.set_event_flag("ZodiacoTemple_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("ZodiacoTempleIndex", d.get_map_index())
				d.notice(string.format("~%s~ Selecciona el Teletransportador Zodiacal",s.DungeonName))
				d.spawn_mob_dir(s.aStoneLv1, s.aStoneLv1Poss[1], s.aStoneLv1Poss[2], s.aStoneLv1Poss[3])
				server_timer("ZodiacoTemple10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				d.regen_file("data/dungeon/ZodiacoTemple/regen1.txt")
				d.setf("ZodiacoTempleLog", 0)
				pc.setqf("ZodiacoTemple", 0)
				d.setf("level",1)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			end
		end
		when 20452.chat.gameforge.npc.dungeon0140 or 20453.chat.gameforge.npc.dungeon0140 or 20454.chat.gameforge.npc.dungeon0140 or 20455.chat.gameforge.npc.dungeon0140 or
			 20456.chat.gameforge.npc.dungeon0140 or 20457.chat.gameforge.npc.dungeon0140 or 20458.chat.gameforge.npc.dungeon0140 or 20459.chat.gameforge.npc.dungeon0140 or
			 20460.chat.gameforge.npc.dungeon0140 or 20461.chat.gameforge.npc.dungeon0140 or 20462.chat.gameforge.npc.dungeon0140 or 20463.chat.gameforge.npc.dungeon0140 begin
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			local s = ZodiacoTemple.Setting()
			local mobVnum = npc.get_race()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and not party.is_leader() then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc003,s.DungeonName))
				return
			end
			if d.getf("ZodiacoTempleLog") ==1 then
				say_red(gameforge.dungeon.msm001)
				say("")
				say(string.format("¡El %s ha acumulada mucha Energia!", s.DungeonName))
				say_gold("Enfriamiento")
				say_white(""..TimeToWait.."")
				say("")
				return
			end
			say("")
			say(string.format("¡El %s ha sido Sellado en esta Estatua!", mob_name(npc.get_race())))
			say("Si liberas el Sello solo tendras 1 Hora para recorrer")
			say("Las feroces salas del Templo Zodiacal")
			say_gold("¿Iniciar Templo del Zodiaco?")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				local s = ZodiacoTemple.Setting()
				local boosVnum = s.FinalBoss + (mobVnum - 20452)*10
				d.notice(string.format("<%s> El Espiritu del %s ha resurgido! Seran teletransportados al Nivel 2!", s.DungeonName, mob_name(npc.get_race())))
				server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
				d.setf("ZodiacoTempleLog", 1)
				d.setf("level", 2)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				d.setf("FinalBoss", boosVnum)
				d.setf("i", number(1,table.getn(s.aStoneLv6Poss)))
				npc.purge()
			end
		end
		when 20390.chat.gameforge.npc.dungeon0140 or 20391.chat.gameforge.npc.dungeon0140 or 20392.chat.gameforge.npc.dungeon0140 with ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			local FinalBossVnum = d.getf("FinalBoss")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say(string.format("¡El Espiritu del %s ha sido Liberado!", mob_name(FinalBossVnum)))
			say(string.format("Ha renacido en la sala mas profunda del %s", s.DungeonName))
		end
		when 20390.take or 20391.take or 20392.take with ZodiacoTemple.InDungeon() begin
			local s = ZodiacoTemple.Setting()
			local mobVnum = npc.get_race()
			if item.get_vnum() == s.KeyItemLv6 then
				d.setf("KeyItemLv6Use", 0)
				item.remove()
				if d.getf("StoneStp") == 0 then
					return
				elseif d.getf("StoneStp") == 1 and mobVnum == s.aStoneLv6+0 then
					d.notice(string.format("<%s> Correcto! El %s ha sido Eliminado!", s.DungeonName, mob_name(s.aStoneLv6)))
					d.setf("StoneStp", d.getf("StoneStp")+1)
					npc.kill()
				elseif d.getf("StoneStp") == 2 and mobVnum == s.aStoneLv6+1 then
					d.notice(string.format("<%s> Correcto! El %s ha sido Eliminado!", s.DungeonName, mob_name(s.aStoneLv6)))
					d.setf("StoneStp", d.getf("StoneStp")+1)
					npc.kill()
				elseif d.getf("StoneStp") == 3 and mobVnum == s.aStoneLv6+2 then
					d.notice(string.format("<%s> Correcto! Seran teletransportados a los Niveles Secretos!", s.DungeonName))
					server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
					d.setf("level", 7)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
					d.clear_regen()
					d.kill_all()
				else
					d.notice(string.format("<%s> Incorrecto! Seras teletransportados a la Sala Zodiacal!", s.DungeonName))
					server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
					d.setf("StoneStp", 0)
					d.setf("level", 1)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				end
			end
		end
		when kill with ZodiacoTemple.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = ZodiacoTemple.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			elseif d.getf("level") == 3 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv3 then
					local n = d.getf("KillCountLv3") + 1
					d.setf("KillCountLv3", n)
					if n == table.getn(s.StoneLv3Poss) then
						d.notice(string.format("<%s> Has Eliminado los %s! Seran teletransportados al Nivel 4!", s.DungeonName, mob_name(s.StoneLv3)))
						server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
						d.setf("KillCountLv3", 0)
						d.setf("level", 4)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						pc.setqf("level", d.getf("level"))
					end
				end
			elseif d.getf("level") == 4 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv4 or mobVnum == s.KingLv4+1 or mobVnum == s.KingLv4+2 then
					local n = d.getf("KillCountLv4") + 1
					d.setf("KillCountLv4", n)
					if n == table.getn(s.KingLv4Poss) then
						d.notice(string.format("<%s> Has Eliminado los %s! Seran teletransportados al Nivel 5!", s.DungeonName, mob_name(s.KingLv4)))
						server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
						d.setf("KillCountLv4", 0)
						d.setf("level", 5)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
						pc.setqf("level", d.getf("level"))
					end
				end
			elseif d.getf("level") == 5 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local FinalBossVnum = d.getf("FinalBoss")
				if mobVnum == FinalBossVnum then
					d.notice(string.format("<%s> Has Eliminado al %s! Seran teletransportados al Nivel 6!", s.DungeonName, mob_name(FinalBossVnum)))
					server_timer("ZodiacoTempleJumpTimer", 15, d.get_map_index())
					d.setf("level", 6)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						local pids = {party.get_member_pids()}
						notice_all(string.format("El Grupo de %s ha Derrtotado al %s!",pc.get_name(party.get_leader_pid()),mob_name(FinalBossVnum)))
						party.setf("level",d.getf("level"))
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						pc.setqf("level", d.getf("level"))
						notice_all(string.format("Increible! %s ha Derrtotado al %s!",pc.get_name(),mob_name(FinalBossVnum)))
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
					end
				end
			elseif d.getf("level") == 6 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local n = d.getf("KillCountLv6") + 1
				d.setf("KillCountLv6", n)
				if n >= s.KillCountLv6Drop and d.getf("KeyItemLv6Use") == 0 then
					d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv6)))
					game.drop_item_with_ownership(s.KeyItemLv6, 1)
					d.setf("KeyItemLv6Use", 1)
					d.setf("KillCountLv6", 0)
				end
			elseif d.getf("level") == 7 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
			elseif d.getf("level") == 8 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv8 or mobVnum == s.KingLv8+1 or mobVnum == s.KingLv8+2 then
					local n = d.getf("KillCountLv8") + 1
					d.setf("KillCountLv8", n)
					if n == table.getn(s.KingLv8Poss) then
						d.notice(string.format("<%s> Has Eliminado los %s! Seran teletransportados al Nivel 9!", s.DungeonName, mob_name(s.KingLv8)))
						server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
						d.setf("KillCountLv8", 0)
						d.setf("level", 9)
						if party.is_party() then
							party.setf("level",d.getf("level"))
						end
					end
				end
			elseif d.getf("level") == 9 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				local FinalBossVnum = d.getf("FinalBoss")+1
				if mobVnum == FinalBossVnum then
					d.notice(string.format("Has Eliminado el %s! El Sello del %s se esta Recuperando! 3min Restantes!", mob_name(FinalBossVnum), s.DungeonName))
					server_timer("ZodiacoTempleEndTimers", 60*3, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
					if party.is_party() then
						local pids = {party.get_member_pids()}
						notice_all(string.format("El Grupo de %s ha Derrtotado el %s!",pc.get_name(party.get_leader_pid()),mob_name(FinalBossVnum)))
						party.setf("level",d.getf("level"))
						for i, pid in next, pids, nil do
							q.begin_other_pc_block(pid)
							dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
							q.end_other_pc_block()
						end
					else
						pc.setqf("level", d.getf("level"))
						notice_all(string.format("Increible! %s ha Derrtotado el %s!",pc.get_name(),mob_name(FinalBossVnum)))
						dungeonLib.UpdateRanking(pc.get_player_id(), pc.get_name(), pc.get_level(), s.DungeonInfoIndex)
					end
				end
			end
		end
		when ZodiacoTempleCheckTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has debilitado las fuerzas del %s ! Seran teletransportados al Nivel 3!", s.DungeonName, mob_name(d.getf("FinalBoss"))))
						server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
						d.setf("level", 3)
					end
				elseif d.getf("level") == 7 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has debilitado las fuerzas del %s ! Seran teletransportados al Nivel 8!", s.DungeonName, mob_name(d.getf("FinalBoss"))))
						server_timer("ZodiacoTempleJumpTimer", 5, d.get_map_index())
						d.setf("level", 8)
					end
				end
			else
				clear_server_timer("ZodiacoTempleCheckTime", get_server_timer_arg())
			end
		end
		when ZodiacoTempleJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 1 then
					d.notice(string.format("El Sello del %s se esta Recuperando! 1min Restantes!", s.DungeonName))
					server_timer("ZodiacoTempleEndTimers", 60*1, d.get_map_index())
					d.spawn_mob_dir(s.aStoneLv1, s.aStoneLv1Poss[1], s.aStoneLv1Poss[2], s.aStoneLv1Poss[3])
					d.regen_file("data/dungeon/ZodiacoTemple/regen1.txt")
				elseif d.getf("level") == 2 then
					d.notice(string.format("Nivel 2 ~ Elimina el ejercito del %s!", mob_name(d.getf("FinalBoss"))))
					d.regen_file("data/dungeon/ZodiacoTemple/regen2.txt")
					server_loop_timer("ZodiacoTempleCheckTime", 5, d.get_map_index())
				elseif d.getf("level") == 3 then
					d.notice(string.format("Nivel 3 ~ Destruye los %s!", mob_name(s.StoneLv3)))
					clear_server_timer("ZodiacoTempleCheckTime", get_server_timer_arg())
					d.regen_file("data/dungeon/ZodiacoTemple/regen3.txt")
					d.setf("KillCountLv3", 0)
					for i = 1, table.getn(s.StoneLv3Poss), 1 do
						d.spawn_mob_dir(s.StoneLv3, s.StoneLv3Poss[i][1],s.StoneLv3Poss[i][2], s.StoneLv3Poss[i][3])
					end
				elseif d.getf("level") == 4 then
					d.notice(string.format("Nivel 4 ~ Elimina los %s!", mob_name(s.KingLv4)))
					d.regen_file("data/dungeon/ZodiacoTemple/regen4.txt")
					d.setf("KillCountLv4", 0)
					for i = 1, table.getn(s.KingLv4Poss), 1 do
						d.spawn_mob_dir(s.KingLv4+number(0,2), s.KingLv4Poss[i][1],s.KingLv4Poss[i][2], s.KingLv4Poss[i][3])
					end
				elseif d.getf("level") == 5 then
					local FinalBossVnum = d.getf("FinalBoss")
					d.notice(string.format("Nivel 5 ~ Elimina al %s!", mob_name(FinalBossVnum)))
					d.regen_file("data/dungeon/ZodiacoTemple/regen5.txt")
					d.spawn_mob_dir(FinalBossVnum, s.FinalBossPoss[1],s.FinalBossPoss[2], s.FinalBossPoss[3])
				elseif d.getf("level") == 6 then
					d.notice(string.format("Nivel 6 ~ Encuentra el %s Real! Accederas a los Niveles Especiales!", mob_name(s.aStoneLv6)))
					d.set_regen_file("data/dungeon/ZodiacoTemple/regen6.txt")
					d.setf("KeyItemLv6Use", 0)
					d.setf("KillCountLv6", 0)
					d.setf("StoneStp", 1)
					for j = 1, 3, 1 do
						d.spawn_mob_dir(s.aStoneLv6+j-1, s.aStoneLv6Poss[d.getf("i")][j][1], s.aStoneLv6Poss[d.getf("i")][j][2], s.aStoneLv6Poss[d.getf("i")][j][3])
					end
				elseif d.getf("level") == 7 then
					d.notice(string.format("Nivel 7 ~ Elimina el ejercito del %s!", mob_name(d.getf("FinalBoss"))))
					d.regen_file("data/dungeon/ZodiacoTemple/regen7.txt")
					server_loop_timer("ZodiacoTempleCheckTime", 5, d.get_map_index())
				elseif d.getf("level") == 8 then
					d.notice(string.format("Nivel 8 ~ Elimina los %s!", mob_name(s.KingLv8)))
					clear_server_timer("ZodiacoTempleCheckTime", get_server_timer_arg())
					d.regen_file("data/dungeon/ZodiacoTemple/regen8.txt")
					d.setf("KillCountLv8", 0)
					for i = 1, table.getn(s.KingLv8Poss), 1 do
						d.spawn_mob_dir(s.KingLv8+number(0,2), s.KingLv8Poss[i][1],s.KingLv8Poss[i][2], s.KingLv8Poss[i][3])
					end
				elseif d.getf("level") == 9 then
					local FinalBossVnum = d.getf("FinalBoss")+1
					d.notice(string.format("Nivel 9 ~ Elimina al %s!", mob_name(FinalBossVnum)))
					d.regen_file("data/dungeon/ZodiacoTemple/regen9.txt")
					d.spawn_mob_dir(FinalBossVnum, s.FinalBossBonusPoss[1],s.FinalBossBonusPoss[2], s.FinalBossBonusPoss[3])
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when ZodiacoTemple10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				server_timer("ZodiacoTemple05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when ZodiacoTemple05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				server_timer("ZodiacoTemple10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when ZodiacoTemple10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				server_timer("ZodiacoTempleEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when ZodiacoTempleEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = ZodiacoTemple.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("ZodiacoTemple_"..pc.getqf("ZodiacoTempleIndex").."",0)
				d.setf("ZodiacoTempleFail", 1)
				d.exit_all()
			end
		end
	end
end
