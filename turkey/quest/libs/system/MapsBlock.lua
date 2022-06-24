quest MapsBlock begin
	state start begin
		when login begin
			local IndexByLvl = 
			{
				[210] = 110,
				[209] = 90,
				[355] = 1,
				[356] = 1,
				[357] = 1,
				[104] = 45,
				[72]  = 75,
				[73]  = 75,
				[71]  = 55,
				[70]  = 65,
				[68]  = 65,
				[67]  = 55,
				[301]  = 90,
				[302]  = 90,
				[303]  = 90,
				[251]  = 120,
				[222]  = 100,
			}
			if null != IndexByLvl[pc.get_map_index()] then
				if pc.get_level() < IndexByLvl[pc.get_map_index()] then
					warp_to_village()
				end
			end
		end
	end
end
