quest Achievements begin
	state start begin
		function get_mob_info(mobVnum)
			mob_info_map = {
			[591 ] = {'Capitan Bestial', 1},
			[691 ] = {'Jefe Orco', 3},
			[792 ] = {'Lider Oscuro', 3},
			[2091] = {'Reina Aracnida', 2},
			[2093] = {'Reina Aracnida Oscura', 3},
			[1091] = {'Rey Demonio', 1},
			[1092] = {'Rey Demonio Soberbio', 3},
			[1901] = {'Zorro Nueve Colas', 5},
			[1304] = {'Tigre Fantasma Amarillo', 5},
			[2206] = {'Rey Llama', 5},
			[1615] = {'Gran Ogro', 5},
			[2191] = {'Tortuga Gigante', 5},
			[1191] = {'Bruja de Hielo Poderosa', 2},
			[1192] = {'Bruja de Hielo Poderosa', 5},
			[2307] = {'Gran Arbol', 5},
			[2306] = {'Gran Arbol Fantasma', 7},
			[1093] = {'Segador Muerte', 22},
			[3090] = {'Senor Gnoll', 5},
			[3191] = {'Polifemo', 5},
			[3190] = {'Arges', 5},
			[3290] = {'Reksasa', 5},
			[3291] = {'Martyaxwar', 5},
			[3390] = {'Principe Lemur', 5},
			[3490] = {'General Kappa', 5},
			[3491] = {'Triton', 5},
			[3590] = {'Cara de Huesos', 5},
			[3591] = {'General Rojo', 5},
			[3592] = {'Cara de Huesos Brutal', 5},
			[3593] = {'General Rojo Brutal', 5},
			[3690] = {'General Langosta', 5},
			[3691] = {'Rey Cangrejo', 5},
			[3790] = {'Gergola', 5},
			[3791] = {'Rey Yabba', 5},
			[2094] = {'Baron', 5},
			[2092] = {'Baronesa', 25},
			[2597] = {'Caronte', 5},
			[2598] = {'Azrael', 25},
			[2495] = {'Beran Setaou', 27},
			[6091] = {'Arrador', 30},
			[6191] = {'Nemere', 30},
			[4167] = {'Slime', 10},
			[4312] = {'Juicio', 15},
			[4110] = {'Minotauro', 20},
			[6409] = {'Jotun', 35},
			[3965] = {'Hidra', 10},
			[20420] = {'Meley', 35},
			[6520] = {'Dragon Definitivo', 40},
			[2750] = {'Zodiacal', 35},
			[2751] = {'Zodiacal', 35},
			[2760] = {'Zodiacal', 35},
			[2761] = {'Zodiacal', 35},
			[2770] = {'Zodiacal', 35},
			[2771] = {'Zodiacal', 35},
			[2780] = {'Zodiacal', 35},
			[2781] = {'Zodiacal', 35},
			[2790] = {'Zodiacal', 35},
			[2791] = {'Zodiacal', 35},
			[2800] = {'Zodiacal', 35},
			[2801] = {'Zodiacal', 35},
			[2810] = {'Zodiacal', 35},
			[2811] = {'Zodiacal', 35},
			[2820] = {'Zodiacal', 35},
			[2821] = {'Zodiacal', 35},
			[2830] = {'Zodiacal', 35},
			[2831] = {'Zodiacal', 35},
			[2840] = {'Zodiacal', 35},
			[2841] = {'Zodiacal', 35},
			[2850] = {'Zodiacal', 35},
			[2851] = {'Zodiacal', 35},
			[2860] = {'Zodiacal', 35},
			[2861] = {'Zodiacal', 35},
							}
			mobVnum = tonumber(mobVnum)
			return mob_info_map[mobVnum]
		end
		when kill begin
			if npc.is_pc() then
				return
			end
			local mob_info = Achievements.get_mob_info(npc.get_race())
			if null != mob_info then
				local mobName = mob_info[1]
				local mobPnts = mob_info[2]
				mysql_direct_query ( "UPDATE account.account SET drs = drs + " .. mobPnts .. " WHERE id = " .. pc . get_account_id ( ) .. " ;" )
				syschat("Has Logrado Derrotar: " .. mobName .. "." )
				syschat("Obtienes (" .. mobPnts .. ") Puntos de Logros." )
			end
		end
	end
end
