quest guild_building_melt begin
	state start begin
		function GetOreRefineCost(cost)
			if pc.empire != npc.empire then
			return 10 * cost
			end
			if pc.get_guild() == npc.get_guild() then
			return cost * 3
			end
			return cost
		end
		function GetOreRefineGoodPct()
			return 100
		end
		function GetOreRefineBadPct()
			return 75
		end
		function GetMyRefineNum(race)
			return race - 20060 + 50601
		end
		function IsRefinableRawOre(vnum)
			return vnum >= 50601 and vnum <= 50618
		end
		function DoRefineDiamond(pct)
			local from_postfix
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)
			local to_postfix
			say("Un Diamante se fabrica con 30 piedras Diamante")
			say_item("Piedras Diamante", 50601, "")
			if item.count >= 30 then
			say(string.format("La Probabilidad de Exito %s Porciento.[ENTER]Necesitas %s Yang.[ENTER]Quieres Intentarlo? ", pct, guild_building_melt.GetOreRefineCost(10000)))
			say("")
			local s =  select("Si", "No")
				if s == 1 then
					if pc.get_gold() < guild_building_melt.GetOreRefineCost(10000) then
						say("Necesitas mas Yang.")
						say("")
						return
					end
					if pc.diamond_refine(10000, pct) then
						say("Felicidades! El proceso fue un exito.[ENTER]Ahora tienes: ")
						say("")
						say_item(to_name, to_vnum, "")
						say("")
					else
						say("Desgraciadamente ha Fallado!")
						say("")
					end
				end
			else
				say(string.format("No tienes 30 %s. ",from_name))
				say("")
			end
		end
		function DoRefine(pct)
			local from_postfix
			local from_name = item_name(item.vnum)
			local to_vnum = item.vnum + 20
			local to_name = item_name(to_vnum)
			local to_postfix
			say(string.format("Con 30 %s y una Piedra (+0 +1 +2 +3)[ENTER]Las Piedras Espiritu deben estar en Inventario 1[ENTER]Fabricare %s. ",  from_name , to_name ))
			if item.count >= 30 then
				say(string.format("La Probabilidad de Exito %s Porciento.[ENTER]Necesitas %s Yang.[ENTER]Quieres Intentarlo? ", pct, guild_building_melt.GetOreRefineCost(10000)))
				local s =  select("Si", "No")
				if s == 1 then
					if pc.get_gold() < guild_building_melt.GetOreRefineCost(3000) then
						say("Necesitas mas Yang.")
						return
					end
					local selected_item_cell = select_item()
					if selected_item_cell == 0 then
						say("Si una Piedra de Espiritu no puedo fabricarlo.")
						say("")
						return
					end
					local old_item = item.get_id()
					if (not item.select_cell(selected_item_cell)) or item.vnum < 28000 or item.vnum >= 28400 then
						say("Este no es un objeto valido.")
						say("")
						return
					end
					item. select(old_item , old_item )
					if pc.ore_refine(3000, pct, selected_item_cell) then
						say("Felicidades! El proceso fue un exito.[ENTER]Ahora tienes: ")
						say("")
						say_item(to_name, to_vnum, "")
						say("")
					else
						say("Desgraciadamente ha Fallado!")
						say("")
					end
				end
			else
				say(string.format("No tienes 30 %s. ",from_name))
				say("")
			end
		end
		when 20060.take or 20061.take or 20062.take or 20063.take or 20064.take or 20065.take or 20066.take or 20067.take or 20068.take or 20069.take or 20070.take or
			 20071.take or 20072.take with guild_building_melt.GetMyRefineNum(npc.race) == item.vnum or item.vnum == 51001 begin
			if item.vnum == 50601 then
				guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineGoodPct())
			else
				guild_building_melt.DoRefine(guild_building_melt.GetOreRefineGoodPct())
			end
		end
		when 20060.take or 20061.take or 20062.take or 20063.take or 20064.take or 20065.take or 20066.take or 20067.take or 20068.take or 20069.take or 20070.take or
			 20071.take or 20072.take with guild_building_melt.IsRefinableRawOre(item.vnum) and guild_building_melt.GetMyRefineNum(npc.race) != item.vnum or item.vnum == 51001 begin
			if item.vnum == 50601 then
				guild_building_melt.DoRefineDiamond(guild_building_melt.GetOreRefineBadPct())
			else
				guild_building_melt.DoRefine(guild_building_melt.GetOreRefineBadPct())
			end
		end
		when 20060.click or 20061.click or 20062.click or 20063.click or 20064.click or 20065.click or 20066.click or 20067.click or 20068.click or 20069.click or 20070.click or
			 20071.click or 20072.click with npc.get_guild() == pc.get_guild() and pc.isguildmaster() begin
			say("Contratar un Alquimista Tendra un costo de 300000 Yang")
			if pc.get_gold() < 300000 then
				say("Necesitas mas 300000 Yang.")
				say("")
				return
			end
			local sel = 20063
			if 20063 == npc.get_race() then
				say("Ya teines un Alquimista de Gremio.")
				say("")
			else
				pc.changegold(-3000000)
				building.reconstruct(sel)
			end
		end
	end
end
