--[[
 DungeonLib, Dungeon Information System Library, Version 1.8
 Copyright 2019 Owsap Productions
]]

dungeonLib = {}
dungeonInfo = {}
dungeonInfo.table = {
	-- game.get_event_flags
	--[[
	{
		["type"] = 2, -- Dungeon type [ 0 (Unkown), 1 (Private), 2 (Global) ]
		["organization"] = 0, -- Dungeon organization [ 0 (None), 1 (Party), 2 (Guild) ]
		["level_limit"] = 75, -- Dungeon level limit [ max_level ]
		["party_members"] = 8, -- Dungeon party members [ max_members (0) Unlimited ]
		["map"] = 66, -- Dungeon map index
		["cooldown"] = 0, -- [ 0 (None) ] | Ex: 60 * 60 * 3 = 3 hours
		["duration"] = 0, -- [ 0 (None) ] | Ex: 60 * 60 * 3 = 3 hours
		["entrance_map"] = 65, -- Entrance map index
		["strength_bonus"] = 63, -- Strength bonus id against dungeon monsters
		["resistance_bonus"] = 35, -- Resistance bonus id against dungeon monsters
		["item_vnum"] = 0, -- Required dungeon item
	},
	]]
	{ -- Slim
	------------------------------------------------------------------ 00
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = 30,
		["party_members"] = 2,
		["map"] = 261,
		["map_coords"] = {{4096+405,8960+70},{0+877,1024+1389},{0,0}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 65,
		["strength_bonus"] = 20,
		["resistance_bonus"] = 38,
		["item_vnum"] = 30415,
	},
	{ -- Bibilioteca Alejandria
	------------------------------------------------------------------ 01
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = 45,
		["party_members"] = 3,
		["map"] = 265,
		["map_coords"] = {{3072+407,8192+48},{1024+896,2048+466},{0,0}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 65,
		["strength_bonus"] = 21,
		["resistance_bonus"] = 89,
		["item_vnum"] = 30811,
	},
	{ -- Minotauro
	------------------------------------------------------------------ 02
		["type"] = 1,
		["organization"] = 1,
		["level_limit"] = 60,
		["party_members"] = 3,
		["map"] = 209,
		["map_coords"] = {{25884, 67968},{25884, 67968},{25884, 67968}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 64,
		["strength_bonus"] = 18,
		["resistance_bonus"] = 88,
		["item_vnum"] = 30410,
	},
	{ -- Torre Demoniaca
	------------------------------------------------------------------ 03
		["type"] = 2,
		["organization"] = 0,
		["level_limit"] = 45,
		["party_members"] = 3,
		["map"] = 66,
		["map_coords"] = {{6158, 1647},{6158, 1647},{6158, 1647}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 65,
		["strength_bonus"] = 22,
		["resistance_bonus"] = 89,
		["item_vnum"] = 0,
	},
	{ -- Catacumbas del Diablo
	------------------------------------------------------------------ 04
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 80,
		["party_members"] = 3,
		["map"] = 216,
		["map_coords"] = {{6326, 1636},{6326, 1636},{6326, 1636}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 65,
		["strength_bonus"] = 21,
		["resistance_bonus"] = 89,
		["item_vnum"] = 30320,
	},
	{ -- Cubil de la Baronesa
	------------------------------------------------------------------ 05
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 80,
		["party_members"] = 3,
		["map"] = 217,
		["map_coords"] = {{7041, 5216},{7041, 5216},{7041, 5216}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 63,
		["strength_bonus"] = 18,
		["resistance_bonus"] = 38,
		["item_vnum"] = 30324,
	},
	{ -- Beran
	------------------------------------------------------------------ 06
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 85,
		["party_members"] = 3,
		["map"] = 79,
		["map_coords"] = {{1536+319,12032+174},{1536+319,12032+174},{1536+319,12032+174}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 79,
		["strength_bonus"] = 22,
		["resistance_bonus"] = 36,
		["item_vnum"] = 30179,
	},
	{ -- Purgatorio Infernal
	------------------------------------------------------------------ 07
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 95,
		["party_members"] = 4,
		["map"] = 351,
		["map_coords"] = {{5981, 7069},{5981, 7069},{5981, 7069}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 62,
		["strength_bonus"] = 22,
		["resistance_bonus"] = 35,
		["item_vnum"] = 50136,
	},
	{ -- Torre de Vigilancia
	------------------------------------------------------------------ 08
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 95,
		["party_members"] = 4,
		["map"] = 352,
		["map_coords"] = {{3841, 1861},{3841, 1861},{3841, 1861}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 61,
		["strength_bonus"] = 22,
		["resistance_bonus"] = 87,
		["item_vnum"] = 50135,
	},
	{ -- Arboreal del Trueno
	------------------------------------------------------------------ 09
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 110,
		["party_members"] = 5,
		["map"] = 210,
		["map_coords"] = {{8291,14186},{8291,14186},{8291,14186}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 210,
		["strength_bonus"] = 20,
		["resistance_bonus"] = 36,
		["item_vnum"] = 50137,
	},
	{ -- Hidra
	------------------------------------------------------------------ 10
		["type"] = 2,
		["organization"] = 1,
		["level_limit"] = 110,
		["party_members"] = 5,
		["map"] = 300,
		["map_coords"] = {{11069, 17911},{11069, 17911},{11069, 17911}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 301,
		["strength_bonus"] = 18,
		["resistance_bonus"] = 87,
		["item_vnum"] = 50150,
	},
	{ -- Meley
	------------------------------------------------------------------ 11
		["type"] = 2,
		["organization"] = 2,
		["level_limit"] = 110,
		["party_members"] = 5,
		["map"] = 212,
		["map_coords"] = {{5978, 6992},{5978, 6992},{5978, 6992}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 62,
		["strength_bonus"] = 18,
		["resistance_bonus"] = 35,
		["item_vnum"] = 0,
	},
	{ -- Dragon Definitivo
	------------------------------------------------------------------ 12
		["type"] = 2,
		["organization"] = 2,
		["level_limit"] = 115,
		["party_members"] = 5,
		["map"] = 305,
		["map_coords"] = {{11759,15749},{11759,15749},{11759,15749}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 304,
		["strength_bonus"] = 22,
		["resistance_bonus"] = 35,
		["item_vnum"] = 50151,
	},
	{ -- Piramide Kefren
	------------------------------------------------------------------ 13
		["type"] = 2,
		["organization"] = 2,
		["level_limit"] = 125,
		["party_members"] = 6,
		["map"] = 252,
		["map_coords"] = {{9728+914,7168+587},{9728+914,7168+587},{9728+914,7168+587}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 251,
		["strength_bonus"] = 21,
		["resistance_bonus"] = 38,
		["item_vnum"] = 30401,
	},
	{ -- Templo del Zodiaco
	------------------------------------------------------------------ 14
		["type"] = 2,
		["organization"] = 2,
		["level_limit"] = 125,
		["party_members"] = 6,
		["map"] = 221,
		["map_coords"] = {{117,7168+696},{117,7168+696},{117,7168+696}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 222,
		["strength_bonus"] = 21,
		["resistance_bonus"] = 88,
		["item_vnum"] = 72327,
	},
	{ -- SerpentQueen
	------------------------------------------------------------------ 15
		["type"] = 2,
		["organization"] = 2,
		["level_limit"] = 125,
		["party_members"] = 6,
		["map"] = 267,
		["map_coords"] = {{0+65,14080+683},{0+65,14080+683},{0+65,14080+683}},
		["cooldown"] = 60*60*1,
		["duration"] = 60*60*1,
		["entrance_map"] = 266,
		["strength_bonus"] = 21,
		["resistance_bonus"] = 88,
		["item_vnum"] = 53713,
	},
}

dungeonInfo.map_name = {
	[0] = "Desconocido",
	[65] = "Templo Oscuro",
	[61] = "Monte Sohan",
	[62] = "Tierra De Fuego",
	[63] = "Desierto",
	[73] = "Gruta Dos",
	[64] = "Valle de Orcos",
	[301] = "Aldea Cape",
	[251] = "Desierto Kefren",
	[261] = "Cueva Slime",
	[66] = "Torre Demoniaca",
	[209] = "Laberinto Minotauro",
	[216] = "Catacumbas Del Diablo",
	[217] = "Cubil De Baronesa",
	[79] = "Sala Del Beran",
	[351] = "Purgatorio Infernal",
	[352] = "Torre De Vigilancia",
	[210] = "Sala Arborea",
	[300] = "Embarcacion Royal Yacht",
	[304] = "Trueno",
	[212] = "Reina Meley",
	[221] = "Templo del Zodiaco",
	[222] = "Valle YinYang",
	[305] = "Domador Dragon",
	[252] = "Piramide Kefren",
	[265] = "Biblioteca Alejandria",
	[266] = "Tierras Profanas",
	[267] = "Calabozo Nagga",
}
dungeonInfo.bonus_name = {
	[0] = "Ninguno",
	[18] = "Fuerza Animales",
	[19] = "Fuerza Orcos",
	[20] = "Fuerza Misticos",
	[21] = "Fuerza Nomuertos",
	[22] = "Fuerza Demonios",
	[35] = "Resistencia Fuego",
	[36] = "Resistencia Rayo",
	[38] = "Resistencia Viento",
	[87] = "Resistencia Hielo",
	[88] = "Resistencia Tierra",
	[89] = "Resistencia Oscuridad",
}

function dungeonLib.UpdateRanking(player_id, player_name, level, dungeon_id)
	local query = mysql_query("SELECT * FROM player.dungeon_ranking WHERE dungeon_id = '"..dungeon_id.."' and player_name = '"..player_name.."';")
	if table.getn(query) > 0 then
		return mysql_query("UPDATE player.dungeon_ranking SET level = "..level..", finished = finished + 1 WHERE dungeon_id = "..dungeon_id.." and player_name = '"..player_name.."';")
	else
		return mysql_query("INSERT INTO player.dungeon_ranking VALUES("..player_id..", '"..player_name.."', "..level..", 1, "..dungeon_id..", NOW());")
	end
end

function dungeonLib.get_rank_finalizado(dungeonID, name, pointType)
	local dungeonID = tonumber(dungeonID) - 1
	local name = tostring(name)
	local pointType = tonumber(pointType)
	local c,query = mysql_direct_query("SELECT finished FROM player.dungeon_ranking WHERE dungeon_id = "..dungeonID.." and player_name = '"..name.."';")

	if table.getn(query) > 0 then
		if pointType == 1 then return query[1].finished
		else return 0 end
	else return 0 end
end

--function dungeonLib.get_rank_damage(dungeonID, name, pointType)
--	local dungeonID = tonumber(dungeonID) - 1
--	local name = tostring(name)
--	local pointType = tonumber(pointType)
--	local c,query = mysql_direct_query("SELECT ataque FROM player.dungeon_ataque WHERE dungeon_id = "..dungeonID.." and player_name = '"..name.."';")
--
--	if table.getn(query) > 0 then
--		if pointType == 1 then return query[1].ataque
--		else return 0 end
--	else return 0 end
--end

function dungeonLib.update()
	local dungeonTable = dungeonInfo.table

	if table.getn(dungeonTable) == 0 then return end

	cmdchat(string.format("DungeonInfo %d", q.getcurrentquestindex()))
	cmdchat(string.format("CleanDungeonInfo"))

	for index in ipairs(dungeonTable) do
		dungeonType = dungeonTable[index]["type"]
		dungeonOrganization = dungeonTable[index]["organization"]
		dungeonLevelLimit = dungeonTable[index]["level_limit"]
		dungeonPartyMembers = dungeonTable[index]["party_members"]
		dungeonMap = dungeonTable[index]["map"]
		dungeonMapIndex = dungeonMap

		if pc.get_empire() == 0 then
			return
		elseif pc.get_empire() == 1 then
			dungeonMapCoordX = dungeonTable[index]["map_coords"][1][1]
			dungeonMapCoordY = dungeonTable[index]["map_coords"][1][2]
		elseif pc.get_empire() == 2 then
			dungeonMapCoordX = dungeonTable[index]["map_coords"][2][1]
			dungeonMapCoordY = dungeonTable[index]["map_coords"][2][2]
		elseif pc.get_empire() == 3 then
			dungeonMapCoordX = dungeonTable[index]["map_coords"][3][1]
			dungeonMapCoordY = dungeonTable[index]["map_coords"][3][2]
		end

		dungeonCooldown = dungeonTable[index]["cooldown"]
		dungeonDuration = dungeonTable[index]["duration"]
		dungeonEntranceMap = dungeonTable[index]["entrance_map"]
		dungeonStrengthBonus = dungeonTable[index]["strength_bonus"]
		dungeonResistanceBonus = dungeonTable[index]["resistance_bonus"]
		dungeonItemVnum = dungeonTable[index]["item_vnum"]

		dungeonFinished = dungeonLib.get_rank_finalizado(index, pc.get_name(), 1)
		--dungeonHighestDamage = dungeonLib.get_rank_damage(index, pc.get_name(), 1)
		--dungeonFastestTime = 0

		dungeonMapName = dungeonInfo.map_name[dungeonMap]
		dungeonEntranceMapName = dungeonInfo.map_name[dungeonEntranceMap]
		dungeonStrengthBonusName = dungeonInfo.bonus_name[dungeonStrengthBonus]
		dungeonResistanceBonusName = dungeonInfo.bonus_name[dungeonResistanceBonus]

		dungeonMapName = string.gsub(dungeonMapName, " ", "_")
		dungeonEntranceMapName = string.gsub(dungeonEntranceMapName, " ", "_")
		dungeonStrengthBonusName = string.gsub(dungeonStrengthBonusName, " ", "_")
		dungeonResistanceBonusName = string.gsub(dungeonResistanceBonusName, " ", "_")

	----cmdchat(string.format("UpdateDungeonInfo %d %d %d %d %s %d %d %d %d %d %s %s %s %d %d %d %d",
		cmdchat(string.format("UpdateDungeonInfo %d %d %d %d %s %d %d %d %d %d %s %s %s %d %d",
			dungeonType,
			dungeonOrganization,
			dungeonLevelLimit,
			dungeonPartyMembers,
			dungeonMapName,
			dungeonMapIndex,
			dungeonMapCoordX,
			dungeonMapCoordY,
			dungeonCooldown,
			dungeonDuration,
			dungeonEntranceMapName,
			dungeonStrengthBonusName,
			dungeonResistanceBonusName,
			dungeonItemVnum,
			dungeonFinished
			--dungeonFastestTime,
			--dungeonHighestDamage
		))
	end
end
