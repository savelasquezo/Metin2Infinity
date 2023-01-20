quest FixDragonSoul begin
	state start begin
		when login with ds.is_qualified() begin
			ds.give_qualification()
		end
	end
end
