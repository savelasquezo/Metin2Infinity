--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
DirectorPuterePuncte = get_locale_base_path().."/quest/Putere/"

function citire_puncte_putere()
	local FisierPuterePuncte = DirectorPuterePuncte..pc.get_name().."_puncte_putere.txt"

	local bonus1, bonus2, bonus3, bonus4
	
	if io.open(FisierPuterePuncte, "r") != nil then
		io.input(FisierPuterePuncte)
		bonus1 = tonumber(io.read())
		bonus2= tonumber(io.read())
		bonus3 = tonumber(io.read())
		bonus4 = tonumber(io.read())
		io.input():close()
	else
		bonus1 = 0
		bonus2 = 0
		bonus3 = 0
		bonus4 = 0
	end
	
	local total_puncte = bonus1 + bonus2 + bonus3 + bonus4
	local puncte_disponibile = pc.get_level() - total_puncte
	
	cmdchat("status_putere "..bonus1.." "..bonus2.." "..bonus3.." "..bonus4.." "..puncte_disponibile)
	
	return bonus1, bonus2, bonus3, bonus4, puncte_disponibile
end

function plusare_putere(nr_buton)
	local FisierPuterePuncte = DirectorPuterePuncte..pc.get_name().."_puncte_putere.txt"

	local bonus1, bonus2, bonus3, bonus4, puncte_disponibile = citire_puncte_putere()
		
	if puncte_disponibile > 0 then
		if nr_buton == 1 then
			if bonus1 == 99 then
				chat("Statutul maxim pentru fiecare bonus este 99.")
				return
			end
			bonus1 = bonus1 + 1
		elseif nr_buton == 2 then
			if bonus2 == 99 then
				chat("Statutul maxim pentru fiecare bonus este 99.")
				return
			end
			bonus2 = bonus2 + 1
		elseif nr_buton == 3 then
			if bonus3 == 99 then
				chat("Statutul maxim pentru fiecare bonus este 99.")
				return
			end
			bonus3 = bonus3 + 1
		elseif nr_buton == 4 then
			if bonus4 == 99 then
				chat("Statutul maxim pentru fiecare bonus este 99.")
				return
			end
			bonus4 = bonus4 + 1
		end
		
		io.output(FisierPuterePuncte)
		io.write(tostring(bonus1).."\n")
		io.write(tostring(bonus2).."\n")
		io.write(tostring(bonus3).."\n")
		io.write(tostring(bonus4).."\n")
		io.flush()
		io.close()
				
	else
		chat("Din pacate nu mai ai puncte disponibile.")
	end
	
	local total_puncte = bonus1 + bonus2 + bonus3 + bonus4
	local puncte_disponibile = pc.get_level() - total_puncte
	
	cmdchat("status_putere "..bonus1.." "..bonus2.." "..bonus3.." "..bonus4.." "..puncte_disponibile)
end

function citire_baraputere()
	local FisierPutereBara = DirectorPuterePuncte..pc.get_name().."_bara_putere.txt"

	local bara
	
	if io.open(FisierPutereBara, "r") != nil then
		io.input(FisierPutereBara)
		bara = tonumber(io.read())
		io.input():close()
	else
		bara = 100
	end
	
	return bara
end

function bara_putere(valoare)
	local FisierPutereBara = DirectorPuterePuncte..pc.get_name().."_bara_putere.txt"

	local bara = citire_baraputere()
	
	if valoare == 99999 then
		io.output(FisierPutereBara)
		io.write("100\n")
		io.flush()
		io.close()
		cmdchat("actualizare_bara_putere 100")
	else
		local bara_ramasa = bara - valoare
		if bara_ramasa > 100 then
			bara_ramasa = 100
		end
		io.output(FisierPutereBara)
		io.write(tostring(bara_ramasa).."\n")
		io.flush()
		io.close()
		
		cmdchat("actualizare_bara_putere "..bara_ramasa)
	end
			
	return 1
end

function resetare_putere()
	local FisierPuterePuncte = DirectorPuterePuncte..pc.get_name().."_puncte_putere.txt"
		
	io.output(FisierPuterePuncte)
	io.write("0\n")
	io.write("0\n")
	io.write("0\n")
	io.write("0\n")
	io.flush()
	io.close()
	cmdchat("status_putere 0 0 0 0 "..pc.get_level())
end