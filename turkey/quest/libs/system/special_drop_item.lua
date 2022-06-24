quest special_drop_item begin
	state start begin
		when kill begin
			local limit = 30
			local minrang = pc.get_level() - limit
			if npc.is_pc() then
				return 
			end
			if npc.get_level() >= minrang then
				--Libros Combos
				if number(1,7350) == 1 then
					if pc . get_level ( ) > 30 then
						game.drop_item_with_ownership(math.random(50304,50306), 1)
					end
				end
				--Libros Lider
				if number(1,5350) == 1 then
					if pc . get_level ( ) > 35 then
						game.drop_item_with_ownership(math.random(50301,50303), 1)
					end
				end
				--Mineria
				if number(1,7150) == 1 then
					if pc . get_level ( ) > 30 then
						game.drop_item_with_ownership(50600, 1)
					end
				end
				--Pildora de sangre
				if number(1,1250) == 1 then
					if pc . get_level ( ) > 30 then
						game.drop_item_with_ownership(70014, 1)
					end
				end
				--Alubia Zen
				if number(1,1750) == 1 then
					if pc . get_level ( ) > 50 then
						game.drop_item_with_ownership(70102, 1)
					end
				end
				--Pergamino Bendicion
				if number(1,3215) == 1 then
					if pc . get_level ( ) > 20 then
						game.drop_item_with_ownership(25040, 1)
					end
				end
				--Libro de Mision Facil
				if pc.get_level ( ) >= 10 and pc.get_level ( ) <=  30 then
					if number(1,3250) == 1 then
						game.drop_item_with_ownership(50307, 1)
					end
				end
				--Libro de Mision Normal
				if pc.get_level ( ) >= 15 and pc.get_level ( ) <=  65 then
					if number(1,5250) == 1 then
						game.drop_item_with_ownership(50308, 1)
					end
				end
				--Libro de Mision Dificil
				if pc.get_level ( ) >= 55 and pc.get_level ( ) <=  90 then
					if number(1,7550) == 1 then
						game.drop_item_with_ownership(50309, 1)
					end
				end
				--Libro de Mision Experto
				if pc.get_level ( ) >= 90 and pc.get_level ( ) <= 130 then
					if number(1,9750) == 1 then
						game.drop_item_with_ownership(50310, 1)
					end
				end
				--Llave de Plata
				if number(1,1835) == 1 then
					if pc.get_level() >= 30 then
						game.drop_item_with_ownership(50009, 1)
					end
				end
				--Llave de Dorada
				if number(1,1835) == 1 then
					if pc.get_level() >= 30 then
						game.drop_item_with_ownership(50008, 1)
					end
				end
				--Cofre Plateado
				if number(1,3535) == 1 then
					if pc.get_level() >= 30 then
						game.drop_item_with_ownership(50007, 1)
					end
				end
				--Cofre Plateado+
				if number(1,3535) == 1 then
					if pc.get_level() >= 55 then
						game.drop_item_with_ownership(50013, 1)
					end
				end
				--Cofre Dorado
				if number(1,3535) == 1 then
					if pc.get_level() >= 30 then
						game.drop_item_with_ownership(50006, 1)
					end
				end
				--Cofre Dorado+
				if number(1,3535) == 1 then
					if pc.get_level() >= 55 then
						game.drop_item_with_ownership(50012, 1)
					end
				end
			end
		end
	end
end
