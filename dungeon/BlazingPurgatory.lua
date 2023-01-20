quest BlazingPurgatory begin
	state start begin
		function Setting()
			if BlazingPurgatory.Settings == nil then
				BlazingPurgatory.Settings = {
				["DungeonName"] = "Purgatorio Infernal",
				["DungeonInfoIndex"] = 7,
				["Level"] = 95,
				["TimeLimit"] = 60,
				["TimeToRetry"] = 1,
				["PartyMinCount"] = 2,
				["NPC"] = 20394,
				["KeyItem"] = 50136,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 351,
				["IndexCoord"] = {7424,6144},
				["IndexPoss"] = {338,595},
				["Outdoor"] = 62,
				["OutdoorCoord"] = {5888,6144},
				["OutdoorPoss"] = {259,926},
				---------------------------------------
				---------------------------------------
				["aStoneX"] = 20385,
				["aStoneXPoss"] = {352,362,1},
				["IndexArea"] = {7500,6200,8174,6894},
				["nStoneX"] = 20387,
				["nStoneXPoss"] = {{320,394,135},{293,359,90},{333,321,210},{378,320,152},{400,355,90},{394,401,223}},
				["mStoneX"] = 20388,
				["mStoneXPoss"] = {{268,447,135},{234,359,90},{300,264,210},{454,217,135},{470,355,90},{467,469,239}},
				["aStoneLv2"] = 20386,
				["aStoneLv2Poss"] = {195,352,1},
				["KeyItemLv2"] = 30329,
				["KeyItemLv2Prob"] = 35,
				["KeyItemLv2Success"] = 20,
				["KeyItemLv2SuccessPlus"] = 15,
				["KingLv4"] = 6051,
				["KingLv4Poss"] = {470,175,1},
				["aStoneLv5"] = 20386,
				["aStoneLv5Poss"] = {{486,345,1},{511,336,1},{525,349,1},{521,365,1},{503,372,1},{486,365,1},{500,354,1}},
				["KeyItemLv5"] = 30330,
				["KeyItemLv5Prob"] = 20,
				["StoneLv6"] = 8057,
				["StoneLv6Poss"] = {511,480,1},
				["FinalBoss"] = 6091,
				["FinalBossPoss"] = {686,637,1},
				["IndexFinalBossPoss"] = {8109,6867},
				}
			end
			return BlazingPurgatory.Settings
		end
		function InDungeon()
			local s = BlazingPurgatory.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 20394.chat.gameforge.npc.dungeon0070 with not BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = BlazingPurgatory.Setting()
					if party.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					elseif d.getf("level") == 7 then
						pc.warp(s.IndexFinalBossPoss[1], s.IndexFinalBossPoss[2], party.getf("IndexDungeon"))
					else
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, party.getf("IndexDungeon"))
					end
				else
					return
				end
			elseif pc.get_player_id() == game.get_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."") then
				say(gameforge.dungeon.npc018)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc019)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = BlazingPurgatory.Setting()
					if pc.getqf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc020)
						return
					elseif d.getf("level") == 7 then
						pc.warp(s.IndexFinalBossPoss[1], s.IndexFinalBossPoss[2], pc.getqf("BlazingPurgatoryIndex"))
					else
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[1])*100, (s.IndexCoord[2]+ s.IndexPoss[2])*100, pc.getqf("BlazingPurgatoryIndex"))
					end
				else
					game.set_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."",0)
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
					local s = BlazingPurgatory.Setting()
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
				pc.setqf("BlazingPurgatory", 1)
				pc.setqf("BlazingPurgatoryRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1])*100, (s.IndexCoord[2] + s.IndexPoss[2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1], s.IndexCoord[2] + s.IndexPoss[2])
				end
			end
		end
		when logout with BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			timer("BlazingPurgatoryRelogin", 5*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("BlazingPurgatoryFail") == 1 or d.getf("level") == 99 then
				game.set_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."",0)
				pc.setqf("BlazingPurgatoryRelogin", 0)
			end
		end
		when login with not BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			if pc.get_map_index() == s.Index then
				game.set_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."",0)
				pc.setqf("BlazingPurgatoryRelogin", 0)
				pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
			end
		end
		when BlazingPurgatoryExit.timer begin
			local s = BlazingPurgatory.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when BlazingPurgatoryRelogin.timer begin
			local s = BlazingPurgatory.Setting()
			pc.setqf("BlazingPurgatoryRelogin", 0)
			game.set_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."",0)
		end
		when login with BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			if pc.getqf("BlazingPurgatoryRelogin") == d.get_map_index() then
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
				timer("BlazingPurgatoryExit", 5)
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
			pc.setqf("BlazingPurgatoryRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			timer("BlazingPurgatoryRelogin", s.TimeLimit*60)
			if pc.getqf("BlazingPurgatory") == 1 then
				game.set_event_flag("BlazingPurgatory_"..d.get_map_index().."",pc.get_player_id())
				pc.setqf("BlazingPurgatoryIndex", d.get_map_index())
				d.spawn_mob_dir(s.aStoneX, s.aStoneXPoss[1], s.aStoneXPoss[2], s.aStoneXPoss[3])
				server_timer("BlazingPurgatory10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("BlazingPurgatory", 2)
				d.setf("level",0)
				if party.is_party() then
					party.setf("level",d.getf("level"))
				else
					pc.setqf("level", d.getf("level"))
				end
				for i= 1,table.getn(s.nStoneXPoss) do
					d.set_unique("nStone"..i, d.spawn_mob_ac_dir(s.nStoneX, s.nStoneXPoss[i][1], s.nStoneXPoss[i][2], s.nStoneXPoss[i][3]))
					d.set_unique("mStone"..i, d.spawn_mob_ac_dir(s.mStoneX, s.mStoneXPoss[i][1], s.mStoneXPoss[i][2], s.mStoneXPoss[i][3]))
				end
			end
		end
		when 20385.chat."Am-heh" with BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			if party.is_party() and not party.is_leader() then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc003,s.DungeonName))
				return
			end
			if d.getf("BlazingPurgatory") == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				say("¡Am-heh ha despertado, nadie podra Escapar!")
				say("Las puertas al Purgatorio estaran cerradas.")
				say("")
				pc.setqf("BlazingPurgatory", 0)
				wait()
			end
			if d.getf("Info") == 0 then
				if d.getf("FinishLevel") == table.getn(s.nStoneXPoss) then
					d.setf("level",table.getn(s.nStoneXPoss)+1)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					pc.setqf("level", d.getf("level"))
				else
					local zSc = number(1,table.getn(s.nStoneXPoss))
					local SetLevel = 0
					d.setf("level",table.getn(s.nStoneXPoss)+1)
					for i=1,table.getn(s.nStoneXPoss)*10 do
						SetLevel = SetLevel + 1
						if SetLevel > table.getn(s.nStoneXPoss) then
							SetLevel = 1
						end
						if not d.is_unique_dead("nStone"..SetLevel) then
							zSc = zSc - 1
							if zSc == 0 then
								d.setf("level",SetLevel)
								if party.is_party() then
									party.setf("level",d.getf("level"))
								end
								pc.setqf("level", d.getf("level"))
								d.setf("FinishLevel",d.getf("FinishLevel")+1)
								break
							end
						end
					end
				end
			end
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if d.getf("level") == 1 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Falta %s Monstruos![ENTER]",d.count_monster()))
					say("!Elimina todos los Monstruos en la Sala![ENTER]")
					return
				end
				say(string.format("[ENTER]Elimina las Fuerzas Infernales del %s[ENTER]Enfrentate a las criaturas Infernales[ENTER]" ,s.DungeonName))
				d.notice(string.format("Am-heh~ Elimina las Fuerzas Infernales del %s" ,s.DungeonName))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				server_loop_timer("BlazingPurgatoryCheckTime", 5, d.get_map_index())
			elseif d.getf("level") == 2 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Encuentra el %s!",item_name(s.KeyItemLv2)))
					say("¡Activa el Mecanismo Am-heh Infernal![ENTER]")
					return
				end
				say(string.format("[ENTER]¡Activa el Am-heh Infernal![ENTER]Encuentra el %s[ENTER]Elimina criaturas Infernales hasta Encontrarlo[ENTER]" ,item_name(s.KeyItemLv2)))
				d.notice(string.format("Am-heh~ Encuentra el %s" ,item_name(s.KeyItemLv2)))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.set_regen_file ("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				d.setf("KeyItemLv2Use", 0)
				d.setf("KeyItemLv2Plus", 0)
				d.spawn_mob_ac_dir(s.aStoneLv2, s.aStoneLv2Poss[1], s.aStoneLv2Poss[2], s.aStoneLv2Poss[3])
			elseif d.getf("level") == 3 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Falta %s Monstruos![ENTER]",d.count_monster()))
					say("!Elimina todos los Monstruos en la Sala![ENTER]")
					return
				end
				say(string.format("[ENTER]Elimina las fuerzas Magmaticas del %s[ENTER]Enfrentate a las criaturas Magmaticas[ENTER]" ,s.DungeonName))
				d.notice(string.format("Am-heh~ Elimina las fuerzas Magmaticas del %s" ,s.DungeonName))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				server_loop_timer("BlazingPurgatoryCheckTime", 5, d.get_map_index())
			elseif d.getf("level") == 4 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Eliminar al %s![ENTER]",mob_name(s.KingLv4)))
					say("!Enfrenta las fuerzas magmaticas del General Infernal![ENTER]")
					return
				end
				say(string.format("[ENTER]Elimina al %s[ENTER]Enfrentate a las criaturas Magmaticas[ENTER]" ,mob_name(s.KingLv4)))
				d.notice(string.format("Am-heh~ Elimina al %s!" ,mob_name(s.KingLv4)))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.set_regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				d.spawn_mob_ac_dir(s.KingLv4, s.KingLv4Poss[1], s.KingLv4Poss[2], s.KingLv4Poss[3])
			elseif d.getf("level") == 5 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Activa los %s En el Orden Correcto![ENTER] Inserta las %s[ENTER] ",mob_name(s.aStoneLv5), item_name(s.KeyItemLv5)))
					say("!Libera la energia Ignea delas criaturas Infernales![ENTER]")
					return
				end
				say(string.format("[ENTER]¡Activa los %s Inserta las %s![ENTER]" ,mob_name(s.aStoneLv5), item_name(s.KeyItemLv5)))
				d.notice(string.format("Am-heh~ Activa los %s Inserta las %s en el Orden Correcto!" ,mob_name(s.aStoneLv5), item_name(s.KeyItemLv5)))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.set_regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				d.setf("KeyItemLv5Use", 0)
				d.setf("CountStoneLv5",1)
				local zStonePoss = {0,0,0,0,0,0,0}
				for i = 1, table.getn(zStonePoss) do
					local zSc = number(1,table.getn(zStonePoss))
					local SetStone = 0
					for j = 1, table.getn(s.aStoneLv5Poss)*10 do
						SetStone = SetStone + 1
						if SetStone > table.getn(zStonePoss) then
							SetStone = 1
						end
						if zStonePoss[SetStone] == 0 then
							zSc = zSc - 1
							if zSc == 0 then
								zStonePoss[SetStone] = 1
								d.set_unique("aStoneLv5_"..SetStone, d.spawn_mob_ac_dir(s.aStoneLv5, s.aStoneLv5Poss[i][1], s.aStoneLv5Poss[i][2], s.aStoneLv5Poss[i][3]))
								break
							end
						end
					end
				end
			elseif d.getf("level") == 6 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Eliminar el %s![ENTER]",mob_name(s.StoneLv6)))
					say("!Enfrenta la fuente de energia Infernal![ENTER]")
					return
				end
				say(string.format("[ENTER]Elimina el %s[ENTER]Enfrentate a las criaturas Magmaticas[ENTER]" ,mob_name(s.StoneLv6)))
				d.notice(string.format("Am-heh~ Elimina el %s!" ,mob_name(s.StoneLv6)))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.set_regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				d.spawn_mob_ac_dir(s.StoneLv6, s.StoneLv6Poss[1], s.StoneLv6Poss[2], s.StoneLv6Poss[3])
			elseif d.getf("level") == 7 then
				if d.getf("Info") == d.getf("level") then
					say(string.format("[ENTER]!Eliminar el %s![ENTER]",mob_name(s.FinalBoss)))
					say("!Enfrenta la fuente de energia Infernal![ENTER]")
					return
				end
				say(string.format("[ENTER]Elimina el %s[ENTER]Enfrentate a las criaturas Magmaticas[ENTER]" ,mob_name(s.FinalBoss)))
				d.notice(string.format("Am-heh~ Elimina al %s!", mob_name(s.FinalBoss)))
				d.kill_unique("nStone"..d.getf("level"))
				d.kill_unique("mStone"..d.getf("level"))
				d.setf("Info",d.getf("level"))
				d.set_regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				d.spawn_mob_ac_dir(s.FinalBoss, s.FinalBossPoss[1], s.FinalBossPoss[2], s.FinalBossPoss[3])
				d.jump_all(s.IndexFinalBossPoss[1],s.IndexFinalBossPoss[2])
			end
		end
		when 20386.take with BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			local itemVnum = item.get_vnum()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 2 and itemVnum == s.KeyItemLv2 then
				item.remove()
				if number(1,100) <= s.KeyItemLv2Success + d.getf("KeyItemLv2Plus") then
					d.notice(string.format("<%s> El %s ha Funcionado! Libera el Sello de %s!",s.DungeonName,item_name(s.KeyItemLv2), mob_name(s.aStoneX)))
					d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
					d.setf("Info", 0)
					d.clear_regen()
					npc.purge()
				else
					d.notice(string.format("<%s> El %s ha Fallado! Intentalo Nuevamente",s.DungeonName, item_name(s.KeyItemLv2)))
					d.setf("KeyItemLv2Plus", d.getf("KeyItemLv2Plus") + s.KeyItemLv2SuccessPlus)
					d.setf("KeyItemLv2Use", 0)
				end
			elseif d.getf("level") == 5 and itemVnum == s.KeyItemLv5 then
				if d.count_monster() <= 100 then
					d.regen_file("data/dungeon/BlazingPurgatory/regen"..d.getf("level")..".txt")
				end
				d.setf("KeyItemLv5Use", 0)
				item.remove()
				if npc.get_vid() == nil then
					return
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_1") then
					if d.getf("CountStoneLv5") == 1 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_2") then 
					if d.getf("CountStoneLv5") == 2 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_3") then
					if d.getf("CountStoneLv5") == 3 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_4") then
					if d.getf("CountStoneLv5") == 4 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_5") then
					if d.getf("CountStoneLv5") == 5 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				elseif npc.get_vid() == d.get_unique_vid("aStoneLv5_6") then
					if d.getf("CountStoneLv5") == 6 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera la Siguiente %s",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.setf("CountStoneLv5",d.getf("CountStoneLv5")+1)
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				else
					if d.getf("CountStoneLv5") == 7 then
						d.notice(string.format("<%s> La %s ha sido Activada! Libera el Sello de %s!",s.DungeonName, item_name(s.KeyItemLv5), mob_name(s.aStoneLv5)))
						d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
						d.setf("Info", 0)
						d.clear_regen()
						npc.purge()
					else
						d.notice(string.format("Incorrecto! La %s era Falsa! Intentalo Nuevamente!",item_name(s.KeyItemLv5)))
					end
				end
			end
		end
		when kill with BlazingPurgatory.InDungeon() begin
			local s = BlazingPurgatory.Setting()
			local mobVnum = npc.get_race()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if number(1,100) <= s.KeyItemLv2Prob and d.getf("KeyItemLv2Use") == 0 then
					d.notice(string.format("Encontraste el %s!",item_name(s.KeyItemLv2)))
					game.drop_item_with_ownership(s.KeyItemLv2, 1)
					d.setf("KeyItemLv2Use", 1)
				end
			elseif d.getf("level") == 4 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.KingLv4 then
					d.notice(string.format("Has Eliminado al %s! Libera el Sello de %s!",mob_name(mobVnum), mob_name(s.aStoneX)))
					d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
					d.setf("Info", 0)
					d.clear_regen()
				end
			elseif d.getf("level") == 5 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if number(1,100) <= s.KeyItemLv5Prob and d.getf("KeyItemLv5Use") == 0 then
					d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv5)))
					game.drop_item_with_ownership(s.KeyItemLv5, 1)
					d.setf("KeyItemLv5Use", 1)
				end
			elseif d.getf("level") == 6 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.StoneLv6 then
					d.notice(string.format("Has Eliminado el %s! Libera el Sello de %s!",mob_name(mobVnum), mob_name(s.aStoneX)))
					d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
					d.setf("Info", 0)
					d.clear_regen()
				end
			elseif d.getf("level") == 7 then
				if party.is_party() and party.getf("level") != d.getf("level") then
					party.setf("level",d.getf("level"))
				end
				pc.setqf("level", d.getf("level"))
				if mobVnum == s.FinalBoss then
					d.notice(string.format("Has Eliminado al %s! El Sello del %s se esta Recuperandoo! 3min Restantes!", mob_name(npc.get_race()), s.DungeonName))
					server_timer("BlazingPurgatoryEndTimers", 60*3, d.get_map_index())
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
		when BlazingPurgatoryCheckTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = BlazingPurgatory.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 1 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has Eliminado las fuerzas Infernales! Libera el Sello de %s!", s.DungeonName, mob_name(s.aStoneX)))
						d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
						d.setf("Info", 0)
						d.clear_regen()
						clear_server_timer("BlazingPurgatoryCheckTime", get_server_timer_arg())
						return
					end
				elseif d.getf("level") == 3 then
					if d.count_monster() == 0 then
						d.notice(string.format("<%s> Has eliminado las fuerzas Magmaticas! Libera el Sello de %s!", s.DungeonName, mob_name(s.aStoneX)))
						d.purge_area(s.IndexArea[1]*100,s.IndexArea[2]*100,s.IndexArea[3]*100,s.IndexArea[4]*100)
						d.setf("Info", 0)
						d.clear_regen()
						clear_server_timer("BlazingPurgatoryCheckTime", get_server_timer_arg())
						return
					end
				end
			else
				clear_server_timer("BlazingPurgatoryCheckTime", get_server_timer_arg())
			end
		end
		when BlazingPurgatory10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = BlazingPurgatory.Setting()
				server_timer("BlazingPurgatory05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when BlazingPurgatory05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = BlazingPurgatory.Setting()
				server_timer("BlazingPurgatory10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when BlazingPurgatory10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = BlazingPurgatory.Setting()
				server_timer("BlazingPurgatoryEndTimers", 5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when BlazingPurgatoryEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = BlazingPurgatory.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				game.set_event_flag("BlazingPurgatory_"..pc.getqf("BlazingPurgatoryIndex").."",0)
				d.setf("BlazingPurgatoryFail", 1)
				d.exit_all()
			end
		end
	end
end

