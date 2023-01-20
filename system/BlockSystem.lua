quest BlockSystem begin
	state start begin
		when login begin
			local setmod={
				{"block_exchange",         1,   "Comercio"},
				{"block_party_invite",     2,   "Grupo"},
				{"block_guild_invite",     4,   "Gremio"},
				{"block_whisper",          8,   "Mensajes"},
				{"block_messenger_invite", 16,  "Amistad"},
				{"block_party_request",    32,  "Equipo"},
				{"block_view_equipment",   64,  "Equipamiento"},
				{"block_point_exp",        128, "Experiencia"},
				{"block_duello_mode",      256, "Duelo"},
				{"block_view_bonus",       512, "Bonificaciones"}
			}
			local retnum=0
			local retstr=""
			table.foreachi(setmod,
				function(num,str)
					if(pc.getf("game_option",setmod[num][1])==1)then
						retnum=(retnum+setmod[num][2])
						local delim=""
						if(retstr~="")then delim="" end
						retstr=(retstr..delim.." "..setmod[num][3])
					end
				end
			)
			if(retnum~=0)then
				syschat("Bloqueo:"..retstr)
			end
			pc.send_block_mode(retnum)
		end
	end
end
