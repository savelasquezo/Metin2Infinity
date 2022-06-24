quest AntiEXP begin
	state start begin
		when login begin
			if pc.getqf("AntiEXP") == 1 then
				pc.block_exp()
				chat("AntiExperiencia Activado !")
			end
		end
		when 72321.use begin
			if pc.getqf("AntiEXP") == 0 then
				pc.block_exp()
				pc.setqf("AntiEXP", 1)
				chat("AntiExperiencia Activado")
			elseif pc.getqf("AntiEXP") == 1 then
				pc.unblock_exp()
				pc.setqf("AntiEXP", 0)
				chat("AntiExperiencia Inhabilitado!")
			end
		end
	end
end
