quest EventEasterEggDungeon begin
	state start begin
		function Setting()
			if EventEasterEggDungeon.Settings == nil then
				EventEasterEggDungeon.Settings = {
				["DungeonName"] = "Lamdascua",
				["DungeonInfoIndex"] = false,
				["Level"] = {30,65,90},
				["TimeLimit"] = 90,
				["TimeToRetry"] = 3,
				["PartyMinCount"] = 2,
				["NPC"] = 30129,
				["KeyItem"] = 53642,
				["KeyItemType"] = 0, --(0) Only Leader / (1) All
				["KeyCount"] = 1,
				["Index"] = 407,
				["IndexCoord"] = {4840,22528},
				["IndexPoss"] = {{198,241},{564,159}},
				["Outdoor"] = 406,
				["OutdoorCoord"] = {5840,22528},
				["OutdoorPoss"] = {107,1172},
				---------------------------------------
				---------------------------------------
				["StoneLv1"] = {60560,60561,60562},
				["StoneLv1Poss"] = {208,363,5},
				["aStoneLv2"] = 60573,
				["aStoneLv2Poss"] = {{548,177,1},{599,168,1},{624,195,1},{648,225,1},{626,236,1},{648,268,1},{573,300,1},{549,256,1},{533,210,1},{563,209,1}},
				["ItemCountLv2"] = 10,
				["ItemLv2"] = 53641,
				["KeyItemLv2"] = 53643,
				["xStoneLv2"] = 60575,
				["xStoneLv2Poss"] = {617,356,6},
				["nStone"] = 60576,
				["nStoneLv2Poss"] = {609,363,5},
				["nStoneLv3Poss"] = {597,477,5},
				["KeyItemLv3"] = 53643,
				["KingLv3"] = {60577,60578,60579},
				["KingLv3Poss"] = {598,467,5},
				["aStoneLv4"] = {60569,60570,60571,60572},
				["aStoneLv4Poss"] = {593,598,5},
				["ItemLv4"] = 53644,
				["ItemLv4Prob"] = 5,
				["FinalBoss"] = {60557,60558,60559},
				["FinalBossPoss"] = {593,588,7},
				}
			end
			return EventEasterEggDungeon.Settings
		end
		function InDungeon()
			local s = EventEasterEggDungeon.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		function InEasterMap()
			local s = EventEasterEggDungeon.Setting()
			return pc.get_map_index() == s.Outdoor
		end
		when 30129.chat."Lamdascua" with EventEasterEggDungeon.InEasterMap() begin
			local s = EventEasterEggDungeon.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = EventEasterEggDungeon.Setting()
					if d.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					if party.getf("level") > table.getn(s.IndexPoss) then
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[table.getn(s.IndexPoss)][1])*100, (s.IndexCoord[2]+ s.IndexPoss[table.getn(s.IndexPoss)][2])*100, party.getf("IndexDungeon"))
					else
						pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
					end
				else
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
			elseif pc.count_item (s.KeyItem) < s.KeyCount then
				say_red(gameforge.dungeon.msm001)
				say_white(string.format(gameforge.dungeon.npc017, item_name(s.KeyItem), s.KeyCount))
				say_item (item_name(s.KeyItem) , s.KeyItem , "")
				say("")
				return
			end
			say("...")
			--say(string.format(gameforge.ancient_pyramid.npc001,s.DungeonName, s.DungeonName))
			wait( )
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("...")
			--say(string.format(gameforge.ancient_pyramid.npc002,s.DungeonName))
			say_item (""..item_name(s.KeyItem).."" , s.KeyItem , "")
			say("")
			if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
				if party.is_party() and party.get_member_pids() != nil then
					local cantEnterMembersItem = {{},{}}
					local cantEnterMembersLvls = {{},{}}
					local pids = {party.get_member_pids()}
					local s = EventEasterEggDungeon.Setting()
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
				if pc.get_level() == nil then
					return
				elseif pc.get_level() > s.Level[3] then
					pc.setqf("EventEasterEggDungeonLevel", 3)
				elseif pc.get_level() > s.Level[2] then
					pc.setqf("EventEasterEggDungeonLevel", 2)
				elseif pc.get_level() > s.Level[1] then
					pc.setqf("EventEasterEggDungeonLevel", 1)
				end
				pc.setqf("EventEasterEggDungeon", 1)
				pc.setqf("EventEasterEggDungeonRelogin", 0)
				if not party.is_party() then
					d.new_jump(s.Index, (s.IndexCoord[1] + s.IndexPoss[1][1])*100, (s.IndexCoord[2] + s.IndexPoss[1][2])*100)
				else
					d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
				end
			end
		end
		when logout with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("EventEasterEggDungeonFail") == 1 or d.getf("level") == 99 then
				pc.setqf("EventEasterEggDungeonRelogin", 0)
			end
		end
		when login with not EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if pc.get_map_index() == s.Index then
				if party.is_party() and d.find(party.getf("IndexDungeon")) then
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
				end
			end
		end
		when EventEasterEggDungeonExit.timer begin
			local s = EventEasterEggDungeon.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when EventEasterEggDungeonRelogin.timer begin
			local s = EventEasterEggDungeon.Setting()
			pc.setqf("EventEasterEggDungeonRelogin", 0)
		end
		when login with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if pc.getqf("EventEasterEggDungeonRelogin") == d.get_map_index() then
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
				timer("EventEasterEggDungeonExit", 5)
				return
			end
			if s.KeyItemType == 1 then
				if pc.count_item (s.KeyItem) < s.KeyCount then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say_red(gameforge.dungeon.msm001)
					say("")
					timer("EventEasterEggDungeonExit", 5)
					return
				end
				pc.remove_item(s.KeyItem, s.KeyCount)
			end
			if party.is_party() then
				party.setf("IndexDungeon", d.get_map_index())
			end
			pc.setqf("EventEasterEggDungeonRelogin", d.get_map_index())
			timer("EventEasterEggDungeonRelogin", s.TimeLimit*60)
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if pc.getqf("EventEasterEggDungeon") == 1 then
				d.setf("EventEasterEggDungeonLevel",pc.getqf("EventEasterEggDungeonLevel"))
				d.notice(string.format("~Nivel 1~ Destruye el %s! Enfrentate al Ejercito de %s!", mob_name(s.StoneLv1[d.getf("EventEasterEggDungeonLevel")]), s.DungeonName))
				d.spawn_mob_dir(s.StoneLv1[d.getf("EventEasterEggDungeonLevel")], s.StoneLv1Poss[1], s.StoneLv1Poss[2], s.StoneLv1Poss[3])
				server_timer("EventEasterEggDungeon10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("EventEasterEggDungeon", 0)
				d.setf("level",1)
				d.set_regen_file("data/dungeon/EventEasterEggDungeon/regen"..d.getf("level").."_"..d.getf("EventEasterEggDungeonLevel")..".txt")
				if party.is_party() then
					party.setf("level",d.getf("level"))
				end
			end
		end
		when 60572.chat."Lamdascua" with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if d.getf("level") != 5 then
				return
			else
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if party.is_party() and not party.is_leader() then
					say_red(gameforge.dungeon.msm001)
					say(string.format(gameforge.dungeon.npc003,s.DungeonName))
					return
				end
				say(string.format("¡Has finalizado el ritual de Invocacion![ENTER]Activa la %s & Enfrentate a %s",mob_name(s.aStoneLv4[table.getn(s.aStoneLv4)]),s.DungeonName))
				say("")
				if select("Activar", "Cancelar") == 1 then
					local FinalBoss = s.FinalBoss[d.getf("EventEasterEggDungeonLevel")]
					d.notice(string.format("La Ofrenda de Pascua ha sido Aceptada! El %s se Aproxima!", mob_name(FinalBoss)))
					server_timer("EventEasterEggDungeonDelayTime", 10, d.get_map_index())
					npc.purge()
				end
			end
		end
		when 60576.take with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if d.getf("level") == nil then
				return
			elseif d.getf("level") == 2 and d.getf("KeyItemLv2Use") == 1 then
				if item.get_vnum() == s.KeyItemLv2 then
					d.notice(string.format("~Nivel 3~ Elimina al %s!", mob_name(s.KingLv3[d.getf("EventEasterEggDungeonLevel")])))
					d.spawn_mob_dir(s.KingLv3[d.getf("EventEasterEggDungeonLevel")], s.KingLv3Poss[1],s.KingLv3Poss[2], s.KingLv3Poss[3])
					d.spawn_mob_dir(s.nStone, s.nStoneLv3Poss[1],s.nStoneLv3Poss[2], s.nStoneLv3Poss[3])
					d.setf("KeyItemLv2Use", 0)
					d.setf("level",3)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.regen_file("data/dungeon/EventEasterEggDungeon/regen"..d.getf("level").."_"..d.getf("EventEasterEggDungeonLevel")..".txt")
					item.remove()
					npc.kill()
				end
			elseif  d.getf("level") == 3 and d.getf("KeyItemLv3Use") == 1 then
				if item.get_vnum() == s.KeyItemLv3 then
					d.notice(string.format("~Nivel 4~ Ofrenda Los %s! Invoca al %s!", item_name(s.ItemLv4), mob_name(s.FinalBoss[d.getf("EventEasterEggDungeonLevel")])))
					d.spawn_mob_dir(s.aStoneLv4[1], s.aStoneLv4Poss[1],s.aStoneLv4Poss[2], s.aStoneLv4Poss[3])
					d.setf("KeyItemLv3Use",0)
					d.setf("KeyItemLv4Use",0)
					d.setf("ItemCountLv4",1)
					d.setf("level",4)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.set_regen_file("data/dungeon/EventEasterEggDungeon/regen"..d.getf("level").."_"..d.getf("EventEasterEggDungeonLevel")..".txt")
					item.remove()
					npc.kill()
				end
			end
		end
		when 60575.take with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if item.get_vnum() == s.ItemLv2 then
				if d.getf("ItemCountLv2") == s.ItemCountLv2 and pc.count_item (s.ItemLv2) == s.ItemCountLv2 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say("")
					say(string.format("¡Increible has recolectado todas las %s![ENTER]Usando la %s abriras el %s", item_name(s.ItemLv2), item_name(s.KeyItemLv2), mob_name(s.nStone)))
					say("")
					pc.remove_item(s.ItemLv2,s.ItemCountLv2)
					pc.give_item2(s.KeyItemLv2)
					d.setf("KeyItemLv2Use",1)
					d.clear_regen()
					npc.purge()
				else
					local c = s.ItemCountLv2 - pc.count_item (s.ItemLv2)
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", s.DungeonName))
					say("")
					say(string.format("¡La Temporada de %s ha Comenzado![ENTER]Necesitas la %s si quieres Continuar", item_name(s.ItemLv2), item_name(s.KeyItemLv2)))
					say("")
					say_gold(string.format("~%s~",item_name(s.ItemLv2)))
					say_white(""..c.."")
					say("")
				end
			end
		end
		when 60575.chat."Temporada de Zanahorias" with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if d.getf("ItemCountLv2") == s.ItemCountLv2 and pc.count_item (s.ItemLv2) == s.ItemCountLv2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", s.DungeonName))
				say("")
				say(string.format("¡Increible has recolectado todas las %s![ENTER]Usando la %s abriras el %s", item_name(s.ItemLv2), item_name(s.KeyItemLv2), mob_name(s.nStone)))
				say("")
				pc.remove_item(s.ItemLv2,s.ItemCountLv2)
				pc.give_item2(s.KeyItemLv2)
				d.setf("KeyItemLv2Use",1)
				d.clear_regen()
				npc.purge()
			else
				local c = s.ItemCountLv2 - pc.count_item (s.ItemLv2)
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", s.DungeonName))
				say("")
				say(string.format("¡La Temporada de %s ha Comenzado![ENTER]Necesitas la %s si quieres Continuar", item_name(s.ItemLv2), item_name(s.KeyItemLv2)))
				say("")
				say_gold(string.format("~%s~",item_name(s.ItemLv2)))
				say_white(""..c.."")
				say("")
			end
		end
		when 60569.take or 60570.take or 60571.take with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			if item.get_vnum() == s.ItemLv4 and d.getf("KeyItemLv4Use") == 1 then
				local n = d.getf("ItemCountLv4") +1
				pc.remove_item(s.ItemLv4,1)
				d.setf("ItemCountLv4", n)
				d.setf("KeyItemLv4Use",0)
				npc.purge()
				d.spawn_mob_dir(s.aStoneLv4[d.getf("ItemCountLv4")], s.aStoneLv4Poss[1],s.aStoneLv4Poss[2], s.aStoneLv4Poss[3])
				if d.getf("ItemCountLv4") == table.getn(s.aStoneLv4) then
					local FinalBoss = s.FinalBoss[d.getf("EventEasterEggDungeonLevel")]
					d.notice(string.format("La %s ha sido Completada! Invoca al %s!",mob_name(s.aStoneLv4[table.getn(s.aStoneLv4)]), mob_name(FinalBoss)))
					d.setf("level",5)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.clear_regen()
				else
					d.regen_file("data/dungeon/EventEasterEggDungeon/regen"..d.getf("level").."_"..d.getf("EventEasterEggDungeonLevel")..".txt")
				end
			end
		end
		when 60573.click with EventEasterEggDungeon.InDungeon() begin
			local s = EventEasterEggDungeon.Setting()
			local n = d.getf("ItemCountLv2") + 1
			d.setf("ItemCountLv2", n)
			pc.give_item2(s.ItemLv2)
			npc.purge()
		end
		when kill with EventEasterEggDungeon.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = EventEasterEggDungeon.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 1 then
				if mobVnum == s.StoneLv1[d.getf("EventEasterEggDungeonLevel")] then
					local FinalBoss = s.FinalBoss[d.getf("EventEasterEggDungeonLevel")]
					d.notice(string.format("<%s> Has debilitado las fuerzas de %s ! Seran teletransportados al Nivel 2!", s.DungeonName, mob_name(FinalBoss)))
					server_timer("EventEasterEggDungeonJumpTimer", 5, d.get_map_index())
					d.setf("level",2)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.kill_all()
					d.clear_regen()
				end
			elseif d.getf("level") == 2 then
				if party.is_party() and party.getf("level") !=2 then
					party.setf("level",d.getf("level"))
				end
			elseif d.getf("level") == 3 then
				if mobVnum == s.KingLv3[d.getf("EventEasterEggDungeonLevel")] then
					d.notice(string.format("El %s ha sido Eliminado!", mob_name(s.KingLv3[d.getf("EventEasterEggDungeonLevel")])))
					game.drop_item_with_ownership(s.KeyItemLv3,1)
					d.setf("KeyItemLv3Use",1)
				end
			elseif d.getf("level") == 4 then
				if number(1,100) <= s.ItemLv4Prob and d.getf("KeyItemLv4Use") == 0 then
					syschat("<"..s.DungeonName.."> Has encontrado un Huevo Lamdascua!")
					game.drop_item_with_ownership(s.ItemLv4,1)
					d.setf("KeyItemLv4Use",1)
				end
			elseif d.getf("level") == 5 then
				local FinalBoss = s.FinalBoss[d.getf("EventEasterEggDungeonLevel")]
				if mobVnum == FinalBoss then
					notice_all(string.format("El Grupo de %s ha Derrtotado al %s!",pc.get_name(party.get_leader_pid()),mob_name(FinalBoss)))
					d.notice(string.format("Has Eliminado al %s! El Sello de la %s se esta Recuperando! 1min Restantes!",mob_name(FinalBoss),s.DungeonName))
					server_timer("EventEasterEggDungeonEndTimers", 60*1, d.get_map_index())
					d.setf("level", 99)
					if party.is_party() then
						party.setf("level",d.getf("level"))
					end
					d.clear_regen()
					d.kill_all()
				end
			end
		end
		when EventEasterEggDungeonDelayTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				if d.getf("level") == 99 then
					return
				else
					local FinalBoss = s.FinalBoss[d.getf("EventEasterEggDungeonLevel")]
					d.notice(string.format("<%s> El %s ha sido Invocado!",s.DungeonName, mob_name(FinalBoss)))
					d.spawn_mob_dir(FinalBoss, s.FinalBossPoss[1],s.FinalBossPoss[2], s.FinalBossPoss[3])
				end
			end
		end
		when EventEasterEggDungeonJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.notice(string.format("~Nivel 2~ Encuentra las %s! Libera el Sello de %s ", mob_name(s.aStoneLv2), s.DungeonName))
					d.set_regen_file("data/dungeon/EventEasterEggDungeon/regen"..d.getf("level").."_"..d.getf("EventEasterEggDungeonLevel")..".txt")
					d.spawn_mob_dir(s.xStoneLv2, s.xStoneLv2Poss[1],s.xStoneLv2Poss[2], s.xStoneLv2Poss[3])
					d.spawn_mob_dir(s.nStone, s.nStoneLv2Poss[1],s.nStoneLv2Poss[2], s.nStoneLv2Poss[3])
					for i = 1, table.getn(s.aStoneLv2Poss), 1 do
						d.spawn_mob_dir(s.aStoneLv2, s.aStoneLv2Poss[i][1],s.aStoneLv2Poss[i][2], s.aStoneLv2Poss[i][3])
					end
					d.setf("ItemCountLv2", 0)
					d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
				end
			end
		end
		when EventEasterEggDungeon10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				server_timer("EventEasterEggDungeon05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when EventEasterEggDungeon05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				server_timer("EventEasterEggDungeon10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when EventEasterEggDungeon10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				server_timer("EventEasterEggDungeonEndTimers",  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when EventEasterEggDungeonEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventEasterEggDungeon.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				d.setf("EventEasterEggDungeonFail", 1)
				d.exit_all()
			end
		end
	end
end
