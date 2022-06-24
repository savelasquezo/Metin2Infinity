quest EventChristmasDungeon begin
	state start begin
		function Setting()
			if EventChristmasDungeon.Settings == nil then
				EventChristmasDungeon.Settings = {
				["DungeonName"] = "Lamdavidad",
				["DungeonInfoIndex"] = false,
				["Level"] = {30,65,90},
				["TimeLimit"] = 90,
				["TimeToRetry"] = 3,
				["PartyMinCount"] = 2,
				["NPC"] = 60478,
				["KeyItem"] = 90104,
				["KeyCount"] = 1,
				["Index"] = 402,
				["IndexCoord"] = {0,3328},
				["IndexPoss"] = {{545,160},{175,540},{1045,380}},
				["Outdoor"] = 401,
				["OutdoorCoord"] = {22528,3328},
				["OutdoorPoss"] = {545,160},
				---------------------------------------
				---------------------------------------
				["KeyItemLv1"] = 90102,
				["KillCountLv1Drop"] = 30,
				["aStoneLv1"] = 60473,
				["aStoneLv1Poss"] = {{554,339,1},{504,324,1},{619,315,1},{620,282,1},{600,340,1}},
				["KingLv1"] = 60439,
				["KingLv1Poss"] = {569,332,1},
				["aStoneLv2"] = 60477,
				["aStoneLv2Poss"] = {195,540,7},
				["StoneLv2"] = 60467,
				["StoneLv2Poss"] = {{231,478,1},{261,571,1},{202,621,1},{133,565,1},{150,493,1}},
				["KeyItemLv2"] = 90100,
				["KillCountLv2Drop"] = 30,
				["xStoneLv2"] = 20472,
				["nStoneLv2"] = 20473,
				["StoneLv3"] = 60470,
				["StoneLv3Poss"] = {{1040,390,1},{1016,408,1},{1020,448,1},{1053,469,1},{1089,437,1},{1070,394,1}},
				["FinalBoss"] = 60433,
				["FinalBossPoss"] = {1050,430,1},
				}
			end
			return EventChristmasDungeon.Settings
		end
		function InDungeon()
			local s = EventChristmasDungeon.Setting()
			return pc.get_map_index() >= s.Index*10000 and pc.get_map_index() < (s.Index+1)*10000
		end
		when 60478.chat."Lamdavidad" with pc.get_map_index() == 401 begin
			local s = EventChristmasDungeon.Setting()
			local TimeToWait = osTime(math.floor(pc.getqf("TimeToRetry")- get_global_time()))
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			if party.is_party() and d.find(party.getf("IndexDungeon")) then
				say(gameforge.dungeon.npc007)
				say_white(string.format("~%s~",s.DungeonName))
				say_gold(gameforge.dungeon.npc008)
				if select(gameforge.dungeon.msm002,gameforge.dungeon.msm003) == 1 then
					local s = EventChristmasDungeon.Setting()
					if d.getf("level") == 99 then
						say_red(gameforge.dungeon.msm001)
						say_gold(gameforge.dungeon.npc009)
						return
					end
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					return
				end
			elseif pc.get_level() < s.Level[1] then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc001,s.Level[1], s.DungeonName))
				return
			elseif not party.is_party() then --or party.get_near_count() < s.PartyMinCount then
				say_red(gameforge.dungeon.msm001)
				say(string.format(gameforge.dungeon.npc002,s.DungeonName, s.PartyMinCount))
				return
			elseif not party.is_leader() then
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
				local s = EventChristmasDungeon.Setting()
				if pc.count_item (s.KeyItem) < s.KeyCount then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title(string.format("~%s~", mob_name(npc.get_race())))
					say_white(string.format(gameforge.dungeon.npc004, item_name(s.KeyItem), s.KeyCount))
					say_item (item_name(s.KeyItem) , s.KeyItem , "")
					say("")
					return
				end
				if pc.get_level() == nil then
					return
				elseif pc.get_level() > s.Level[3] then
					pc.setqf("ChristmasDungeonLevel", 2)
				elseif pc.get_level() > s.Level[2] then
					pc.setqf("ChristmasDungeonLevel", 1)
				elseif pc.get_level() > s.Level[1] then
					pc.setqf("ChristmasDungeonLevel", 0)
				end
				pc.setqf("EventChristmasDungeon", 1)
				d.new_jump_party(s.Index, s.IndexCoord[1] + s.IndexPoss[1][1], s.IndexCoord[2] + s.IndexPoss[1][2])
			end
		end
		when logout with EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if d.getf("EventChristmasDungeonFail") == 1 or d.getf("level") == 99 then
				pc.setqf("EventChristmasDungeonRelogin", 0)
			end
		end
		when login with not EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			if pc.get_map_index() == s.Index then
				if party.is_party() and d.find(party.getf("IndexDungeon")) then
					pc.warp((s.IndexCoord[1]+ s.IndexPoss[party.getf("level")][1])*100, (s.IndexCoord[2]+ s.IndexPoss[party.getf("level")][2])*100, party.getf("IndexDungeon"))
				else
					pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
				end
			end
		end
		when EventChristmasDungeonExit.timer begin
			local s = EventChristmasDungeon.Setting()
			pc.warp((s.OutdoorCoord[1]+s.OutdoorPoss[1])*100, (s.OutdoorCoord[2]+s.OutdoorPoss[2])*100, s.Outdoor)
		end
		when login with EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			if pc.getqf("EventChristmasDungeonRelogin") == d.get_map_index() then
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
				timer("EventChristmasDungeonExit", 5)
				return
			end
			party.setf("IndexDungeon", d.get_map_index())
			pc.setqf("EventChristmasDungeonRelogin", d.get_map_index())
			pc.setqf("TimeToRetry", get_time() + 60*60*s.TimeToRetry)
			if pc.getqf("EventChristmasDungeon") == 1 then
				d.setf("ChristmasDungeonLevel",pc.getqf("ChristmasDungeonLevel"))
				d.setf("aStoneLv1Count",0)
				d.setf("KeyItemLv1Use", 0)
				d.setf("KillCountLv1", 0)
				pc.remove_item(s.KeyItem, s.KeyCount)
				d.notice(string.format("~Nivel 1~ Desbloquea los %s! Encuentra los %s!", mob_name(s.aStoneLv1), item_name(s.KeyItemLv1)))
				local x = s.aStoneLv1Poss
				local c = {{x[1][1],x[1][2],x[1][3]},{x[2][1],x[2][2],x[2][3]},{x[3][1],x[3][2],x[3][3]},{x[4][1],x[4][2],x[4][3]},{x[5][1],x[5][2],x[5][3]}}
				for i = 1, table.getn(c), 1 do
					local n = number(1,table.getn(c))
					d.set_unique("aStoneLv1_"..i.."", d.spawn_mob_dir(s.aStoneLv1, c[n][1], c[n][2], c[n][3]))
					table.remove(c,n)
				end
				d.set_regen_file("data/dungeon/EventChristmasDungeon/regen1_"..d.getf("ChristmasDungeonLevel")..".txt")
				server_timer("EventChristmasDungeon10minLeft", (s.TimeLimit - 10)*60, d.get_map_index())
				pc.setqf("EventChristmasDungeon", 0)
				d.setf("UnloockStone", 0)
				d.setf("level",1)
				party.setf("level",d.getf("level"))
			end
		end
		when 20472.take with EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			if d.getf("level") == 2 and d.getf("StepLv2") == 2 then
				if item.get_vnum() == s.KeyItemLv2 then
					d.notice(string.format("La %s ha sido Activada!", mob_name(s.xStoneLv2)))
					d.setf("nStoneLv2", d.getf("nStoneLv2")+1)
					d.setf("KeyItemLv2Use", 0)
					item.remove()
					npc.kill()
					if d.getf("nStoneLv2") >= 5 then
						d.notice(string.format("El Espiritu de la Navidad ha sido activado! Libera la %s", mob_name(s.aStoneLv2)))
						d.setf("nStoneLv2", 0)
						d.setf("StepLv2", 3)
					end
				end
			end
		end
		when 60477.chat."Estrellas Navideñas" with EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			local n = d.getf("StepLv2")
			if d.getf("level") == 2 then
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_title(string.format("~%s~", mob_name(npc.get_race())))
				say("")
				if n == nil then
					return
				elseif n == 1 then
					say("¡El Espiritu de la Navidad esta Atrapado!")
					say_white(string.format("Destruye los %s",mob_name(s.StoneLv2 + d.getf("ChristmasDungeonLevel"))))
					say("")
				elseif n == 2 then
					say("¡El Espiritu de la Navidad esta Apagado!")
					say("Ilumina la oscuridad de la Festividad")
					say_white(string.format("Encuentra las %s",item_name(s.KeyItemLv2)))
					say_item (item_name(s.KeyItemLv2) , s.KeyItemLv2 , "")
					say("")
				elseif n == 3 then
					say_gold("¡El Espiritu de la Navidad ha sido Liberado!")
					say("")
					d.notice(string.format("El Espiritu de la Navidad ha Revivido! Seran teletransportados al Nivel 3", mob_name(s.aStoneLv1)))
					server_timer("EventChristmasDungeonJumpTimer", 5, d.get_map_index())
					d.setf("level", 3)
					party.setf("level",d.getf("level"))
					d.clear_regen()
					d.kill_all()
				end
			end
		end
		when 60473.take with EventChristmasDungeon.InDungeon() begin
			local s = EventChristmasDungeon.Setting()
			local NpcVid = npc.get_vid()
			local StoneT = d.getf("aStoneLv1Count")
			if item.get_vnum() == s.KeyItemLv1 then
				if NpcVid == nil then
					return
				elseif NpcVid == d.get_unique_vid("aStoneLv1_1") then
					if StoneT != 0 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv1)))
					else
						d.notice(string.format("Correcto! EL Primer %s ha sido Destruida!", mob_name(s.aStoneLv1)))
						d.setf("aStoneLv1Count",1)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv1_2") then
					if StoneT != 1 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv1)))
					else
						d.notice(string.format("Correcto! EL Segundo %s ha sido Destruido!", mob_name(s.aStoneLv1)))
						d.setf("aStoneLv1Count",2)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv1_3") then
					if StoneT != 2 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv1)))
					else
						d.notice(string.format("Correcto! EL Tercer %s ha sido Destruido!", mob_name(s.aStoneLv1)))
						d.setf("aStoneLv1Count",3)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv1_4") then
					if StoneT != 3 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv1)))
					else
						d.notice(string.format("Correcto! EL Cuarto %s ha sido Destruido!", mob_name(s.aStoneLv1)))
						d.setf("aStoneLv1Count",4)
						npc.purge()
					end
				elseif NpcVid == d.get_unique_vid("aStoneLv1_5") then
					if StoneT != 4 then
						d.notice(string.format("Incorrecto! EL %s era el Equivocado! La Llave fue Destruida!", mob_name(s.aStoneLv1)))
					else
						d.notice(string.format("Correcto! EL Quinto %s ha sido Destruido!", mob_name(s.aStoneLv1)))
						server_timer("EventChristmasDungeonDelayTime", 5, d.get_map_index())
						d.setf("aStoneLv1Count",5)
						d.setf("UnloockStone", 1)
						d.clear_regen()
						d.purge()
					end
				else
					return
				end
				d.setf("KeyItemLv1Use", 0)
				item.remove()
			end
		end
		when kill with EventChristmasDungeon.InDungeon() begin
			local mobVnum = npc.get_race()
			local s = EventChristmasDungeon.Setting()
			if d.getf("level") == 99 then
				return
			elseif d.getf("level") == 1 then
				local n = d.getf("KillCountLv1") + 1
				d.setf("KillCountLv1", n)
				if d.getf("UnloockStone") == nil then
					return
				elseif d.getf("UnloockStone") == 0 then
					if n >= s.KillCountLv1Drop*(d.getf("ChristmasDungeonLevel")+1) and d.getf("KeyItemLv1Use") == 0 then
						d.setf("KeyItemLv1Use", 1)
						d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv1)))
						game.drop_item_with_ownership(s.KeyItemLv1, 1)
						d.setf("KillCountLv1", 0)
					end
				elseif d.getf("UnloockStone") == 1 then
					if mobVnum == s.KingLv1 + d.getf("ChristmasDungeonLevel") then
						d.notice(string.format("Has Eliminado al %s! Seran teletransportados al Nivel 2", mob_name(s.KingLv1+d.getf("ChristmasDungeonLevel"))))
						server_timer("EventChristmasDungeonJumpTimer", 5, d.get_map_index())
						d.clear_regen()
						d.kill_all()
						d.setf("level", 2)
						party.setf("level",d.getf("level"))
					end
				end
			elseif d.getf("level") == 2 then
				if mobVnum == s.StoneLv2 + d.getf("ChristmasDungeonLevel") and d.getf("StepLv2") == 1 then
					local n = d.getf("StoneCountLv2") + 1
					d.setf("StoneCountLv2", n)
					if n >= table.getn(s.StoneLv2Poss) then
						d.notice(string.format("El Espiritu de la Navidad ha resurgido! Encuentra los %s", item_name(s.KeyItemLv2)))
						d.set_regen_file("data/dungeon/EventChristmasDungeon/regen2_"..d.getf("ChristmasDungeonLevel")..".txt")
						d.setf("KillCountLv2", 0)
						d.setf("StepLv2", 2)
						d.setf("nStoneLv2", 0)
						d.setf("KeyItemLv2Use", 0)
					else
						d.notice(string.format("La %s ha sido Destruida! La %s ha Aparecido!",mob_name(s.StoneLv2 + d.getf("ChristmasDungeonLevel")),mob_name(s.xStoneLv2)))
					end
				elseif d.getf("StepLv2") == 2 then
					local n = d.getf("KillCountLv2") + 1
					d.setf("KillCountLv2", n)
					if n >= s.KillCountLv2Drop*(d.getf("ChristmasDungeonLevel")+1) and d.getf("KeyItemLv2Use") == 0 then
						d.setf("KeyItemLv2Use", 1)
						d.notice(string.format("Encontraste la %s!",item_name(s.KeyItemLv2)))
						game.drop_item_with_ownership(s.KeyItemLv2, 1)
						d.setf("KillCountLv2", 0)
					end
				end
			elseif d.getf("level") == 3 then
				if mobVnum == s.StoneLv3+d.getf("ChristmasDungeonLevel") then
					local StoneLv3Count = d.getf("StoneLv3Count")
					local FinalBossVid = d.getf("FinalBossVid")
					if StoneLv3Count > 0 then
						d.notice(string.format("¡Advertencia! El %s ha desatado su Furia!",  mob_name(s.FinalBoss+d.getf("ChristmasDungeonLevel"))))
						d.notice("Aumenta el Ataque & la Resistencia ha Desminuido!")
						d.setf("StoneLv3Count", StoneLv3Count-1)
						npc.set_vid_attack_mul(FinalBossVid,10/(StoneLv3Count + 1))
						npc.set_vid_damage_mul(FinalBossVid,10/(StoneLv3Count + 1))
					end
				elseif mobVnum == s.FinalBoss+d.getf("ChristmasDungeonLevel") then
					notice_all(string.format("El Grupo de %s ha Derrtotado al %s!",pc.get_name(party.get_leader_pid()),mob_name(s.FinalBoss+ d.getf("ChristmasDungeonLevel"))))
					d.notice(string.format("Has Eliminado al %s! El Sello de la %s se esta Recuperando! 1min Restantes!",mob_name(s.FinalBoss+ d.getf("ChristmasDungeonLevel")),s.DungeonName))
					server_timer("EventChristmasDungeonEndTimers", 60*1, d.get_map_index())
					d.setf("level", 99)
					d.clear_regen()
					d.kill_all()
				end
			end
		end
		when EventChristmasDungeonJumpTimer.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 2 then
					d.notice(string.format("~Nivel 2~ Desbloquea la %s! Destruye los %s ", mob_name(s.aStoneLv2), mob_name(s.StoneLv2+d.getf("ChristmasDungeonLevel"))))
					d.spawn_mob_dir(s.aStoneLv2, s.aStoneLv2Poss[1], s.aStoneLv2Poss[2], s.aStoneLv2Poss[3])
					for i = 1, table.getn(s.StoneLv2Poss), 1 do
						d.spawn_mob_dir(s.StoneLv2+d.getf("ChristmasDungeonLevel"), s.StoneLv2Poss[i][1],s.StoneLv2Poss[i][2], 1)
					end
					d.setf("StoneCountLv2", 0)
					d.setf("StepLv2", 1)
				elseif d.getf("level") == 3 then
					d.notice(string.format("~Nivel 3~ Elimina al %s! Salva la Lamdavidad! ", mob_name(s.FinalBoss+d.getf("ChristmasDungeonLevel"))))
					d.set_regen_file("data/dungeon/EventChristmasDungeon/regen3_"..d.getf("ChristmasDungeonLevel")..".txt")
					d.notice(string.format("Los %s determinan el Ataque & Resistencia del %s!", mob_name(s.StoneLv3+d.getf("ChristmasDungeonLevel")), mob_name(s.FinalBoss)))
					for i = 1, table.getn(s.StoneLv3Poss), 1 do
						d.spawn_mob_dir(s.StoneLv3+d.getf("ChristmasDungeonLevel"), s.StoneLv3Poss[i][1],s.StoneLv3Poss[i][2], s.StoneLv3Poss[i][3])
					end
					local FinalBossVid = d.set_unique("FinalBoss", d.spawn_mob_dir(s.FinalBoss+d.getf("ChristmasDungeonLevel"),s.FinalBossPoss[1],s.FinalBossPoss[2],s.FinalBossPoss[3]))
					d.setf("StoneLv3Count", table.getn(s.StoneLv3Poss))
					d.setf("FinalBossVid", FinalBossVid)
				end
				d.jump_all((s.IndexCoord[1] + s.IndexPoss[d.getf("level")][1]), (s.IndexCoord[2] + s.IndexPoss[d.getf("level")][2]))
			end
		end
		when EventChristmasDungeonDelayTime.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				if d.getf("level") == 99 then
					return
				elseif d.getf("level") == 1 then
					d.notice(string.format("El %s ha sido Invocado! Eliminalo", mob_name(s.KingLv1+d.getf("ChristmasDungeonLevel"))))
					d.spawn_mob_dir(s.KingLv1+d.getf("ChristmasDungeonLevel"), s.KingLv1Poss[1], s.KingLv1Poss[2], s.KingLv1Poss[3])
				end
			end
		end
		when EventChristmasDungeon10minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				server_timer("EventChristmasDungeon05minLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc001,s.DungeonName))
			end
		end
		when EventChristmasDungeon05minLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				server_timer("EventChristmasDungeon10secLeft", 60*5, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc002,s.DungeonName))
			end
		end
		when EventChristmasDungeon10secLeft.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				server_timer("EventChristmasDungeonEndTimers",  5*1, d.get_map_index())
				d.notice(string.format(gameforge.dungeon.ntc003,s.DungeonName))
			end
		end
		when EventChristmasDungeonEndTimers.server_timer begin
			if d.select(get_server_timer_arg()) then
				local s = EventChristmasDungeon.Setting()
				d.set_warp_location(s.Outdoor,s.OutdoorCoord[1] + s.OutdoorPoss[1], s.OutdoorCoord[2] + s.OutdoorPoss[2])
				d.setf("EventChristmasDungeonFail", 1)
				d.exit_all()
			end
		end
	end
end
