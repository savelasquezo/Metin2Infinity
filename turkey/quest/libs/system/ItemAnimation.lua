quest ItemAnimation begin
	state start begin
		when 66000.use or 66001.use or 66002.use or 66003.use or 66004.use or 66005.use or 66006.use or 66007.use or 66008.use or 66009.use begin
			local r = item.get_value(0)
			if pc.is_busy() == true then
				syschat("<System> ¡Imposible hacerlo en este Momento!")
				return
			end
			command("mixamo_"..r.."")
		end
	end
end
