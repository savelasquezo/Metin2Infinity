quest TotalWar begin
	state start begin
		function Setting()
			return {
				["Index"] = 200,
				["MaxLevel"] = 130,
				["MaxLife"] = 10,
				["MinLife"] = 3,
				["NPC"] = 20011,
				["IndexCoord"] = {83200,0},
				["IndexPoss"] = {226,98},
			}
		end
		function InEvent()
			local s = TotalWar.Setting()
			return pc.get_map_index() == s.Index
		end
		when 20011.chat."GM~Guerra Total" with pc.is_gm() begin
			local s = TotalWar.Setting()
			local eflag = game.get_event_flag("TotalWar")
			local Online = pc.arena_online(s.Index)
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Guerra Total~")
			say("")
			if pc.get_map_index() != s.Index then
				say_white("¡Evento Guerra Total!")
				say("Evento PvP Todos contra Todos")
				say("")
				say_gold("¿Teletransportar al Evento?")
				say("")
				if select("Aceptar","Cancelar") == 1 then
					pc.warp(s.IndexCoord[1]+s.IndexPoss[1],s.IndexCoord[2]+s.IndexPoss[1])
				end
			elseif eflag == 0 then
				say_white("¡Actualmente el Evento no esta Activo!")
				say_gold("¿Activar el Evento GuerraTotal?")
				say("")
				local ac = select("Aceptar","Cancelar")
				if ac == 1 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce Nivel Minimo!")
					say("")
					local minn = tonumber(input())
					game.set_event_flag("TotalWarMin",minn)
					if minn == nil or minn == 0 or minn > s.MaxLevel then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce Nivel Maximo!")
					say("")
					local maxm = tonumber(input())
					game.set_event_flag("TotalWarMax",maxm)
					if maxm == nil or maxm == 0 or maxm > s.MaxLevel then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					if minn > maxm then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Minimo debe ser Mayor al Valor Maximo!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce Numero de Vidas!")
					say("")
					local Life = tonumber(input())
					game.set_event_flag("TotalWarLife",Life)
					if Life == nil or Life == 0 or Life > s.MaxLife or Life < s.MinLife then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce el Vnum del Premio!")
					say_green("~GANADOR~")
					say("")
					local reward1 = tonumber(input(''))
					game.set_event_flag("TotalWarReward",reward1)
					if reward1 == nil or reward1 == 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce la Cantidad del Premio!")
					say_green("~GANADOR~")
					say("")
					local count1 = tonumber(input(''))
					game.set_event_flag("TotalWarRewardCount",count1)
					if count1 == nil or count1 == 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce el Vnum del Premio!")
					say_red("~PERDEDOR~")
					say("")
					local reward2 = tonumber(input(''))
					game.set_event_flag("TotalWarRewardFailed",reward2)
					if reward2 == nil or reward2 == 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡Introduce la Cantidad del Premio!")
					say_red("~PERDEDOR~")
					say("")
					local count2 = tonumber(input(''))
					game.set_event_flag("TotalWarRewardFailedCount",count2)
					if count2 == nil or count2 == 0 then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title("~Guerra Total~")
						say_red("~Error~")
						say("")
						say_white("¡Valor Invalido!")
						say("")
						return
					end
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_green("Estado del Evento")
					say_white("~Configurado~")
					say("")
					wait()
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Caracteristicas~")
					say("")
					say_white("Vidas: "..game.get_event_flag("TotalWarLife").."")
					say_white("Nivel: "..game.get_event_flag("TotalWarMin").." ~ "..game.get_event_flag("TotalWarMax").." ")
					say("")
					say_green("~GANADOR~")
					say_white("Recompenza: "..item_name(game.get_event_flag("TotalWarReward")).." x "..game.get_event_flag("TotalWarRewardCount").." ")
					say("")
					say_red("~PERDEDOR~")
					say_white("Recompenza: "..item_name(game.get_event_flag("TotalWarRewardFailed")).." x "..game.get_event_flag("TotalWarRewardFailedCount").." ")
					say("")
					say_gold("¿Quieres Activar el Evento?")
					say("")
					local fc = select("Aceptar","Cancelar")
					if fc == 2 then
						return
					end
					if fc == 1 then
						game.set_event_flag("TotalWar",1)
						global_setvarchar("TotalWarLider",0)
						game.set_event_flag("TotalWarLiderScore",0)
						notice_all("Evento Guerra Total Activado! Habla al "..mob_name(s.NPC).." para Ingresar! Nivel: "..minn.."- "..maxm.."")
						notice_all("Recompenza Ganador: "..item_name(reward1).." x "..count1.."")
						notice_all("Premio Participacion: "..item_name(reward2).." x "..count2.."")
					end
				end
			elseif eflag == 1 then
				say_gold("¿Iniciar Evento?")
				say_white("Online: "..Online.."")
				say("")
				local basla = select("Aceptar","Cancelar")
				if basla == 1 then
					server_timer("TotalWarDelay",10)
					loop_timer("LoopTotalWarMsM",10)
					notice_all("Evento Guerra Total Iniciado! El Registro al Evento ha Finalizado!")
					notice_in_map("El Evento Guerra Total Iniciara en 10 Segundos!")
				end
			elseif eflag == 2 then
				say_white("¡Actualmente el Evento esta Activo!")
				say("")
				local Lider = global_getvarchar("TotalWarLider")
				if Lider == "" then
					Lider = "<Null>"
				end
				local Puntos = game.get_event_flag("TotalWarLiderScore")
				say_title("~Estadísticas~")
				say_white("Online: "..Online.."")
				say_white("Lider: "..Lider.."")
				say_white("Asesinatos: "..Puntos.."")
				say("")
				say_gold("¿Cancelar el Evento GuerraTotal?")
				say("")
				local kapa = select("Aceptar","Cancelar")
				if kapa == 1 then
					say("TotalWar cerrada.")
					game.set_event_flag("TotalWar",0)
					game.set_event_flag("TotalWarMin",0)
					game.set_event_flag("TotalWarMax",0)
					game.set_event_flag("TotalWarReward",0)
					global_setvarchar("TotalWarLider",0)
					game.set_event_flag("TotalWarLiderScore",0)
					notice_all("Evento Guerra Total ha Finalizado!")
					warp_all_to_village(s.Index)
				end
			end
		end
		when logout with game.get_event_flag("TotalWar") >= 1 and TotalWar.InEvent() begin
			if pc.is_gm() == false then
				pc.setqf("TotalWarState",1)
			end
		end
		when login with game.get_event_flag("TotalWar") == 1 and TotalWar.InEvent() begin
			local s = TotalWar.Setting()
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Guerra Total~")
			if pc.count_item(39037) > 0 or pc.count_item(39038) > 0 or pc.count_item(39039) > 0 or pc.count_item(71018) > 0 or pc.count_item(71020) > 0 or 
			   pc.count_item(72723) > 0 or pc.count_item(72724) > 0 or pc.count_item(72725) > 0 or pc.count_item(72726) > 0 or pc.count_item(70069) > 0 or 
			   pc.count_item(27001) > 0 or pc.count_item(27002) > 0 or pc.count_item(27003) > 0 or pc.count_item(27007) > 0 then
				say_red(gameforge.dungeon.msm001)
				say("")
				say("¡Imposible Ingresar con Regeneradores de HP!")
				say("Guardalos en el Almacen e Intentalo Nuevamente")
				say("")
				say_item (item_name(39039) , 39037 , "")
				say("")
				timer("TotalWarExitElixir", 5)
				return
			end
			say("")
			say_white("Enfrentate a todos en una feroz Lucha PvP")
			say_white("El Ultimo en la Arena sera el Vencedor")
			say_white("¡Elimina la competencia & hazte con la Recompenza!")
			say("")
			say_gold("¡Recompenza Ganador!")
			say_item (""..item_name(game.get_event_flag("TotalWarReward")).." x "..game.get_event_flag("TotalWarRewardCount").."",game.get_event_flag("TotalWarReward"),"")
			say_title("¡Premio Participacion!")
			say_item (""..item_name(game.get_event_flag("TotalWarRewardFailed")).." x "..game.get_event_flag("TotalWarRewardFailedCount").."",game.get_event_flag("TotalWarRewardFailed"),"")
			say_gold("~Vidas~")
			say_white(""..game.get_event_flag("TotalWarLife").."")
			say("")
			loop_timer("LoopTotalWarLogin",1)
		end
		when 20011.chat."Guerra Total" with game.get_event_flag("TotalWar") == 1 and not TotalWar.InEvent() begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("¡TotalWar está actualmente Activa!")
			say("¿Quieres entrar al Evento Guerra Toral?")
			say("")
			local gir = select("Aceptar","Cancelar")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			local TotalWarMin = game.get_event_flag("TotalWarMin")
			local TotalWarMax = game.get_event_flag("TotalWarMax")
			local level = pc.get_level()
			pc.setqf("AntiBug",get_time()+10)
			if gir == 1 then
				if pc.getqf("AntiBug") < get_time() then
					say_red(gameforge.dungeon.msm001)
					say("")
					say_gold("¡Tiempo Expirado!")
					say_white("Intentalo Nuevamente")
					say("")
					return
				end
				if level < TotalWarMin then
					say_red(gameforge.dungeon.msm001)
					say("")
					say_gold("¡Nivel Insuficiente!")
					say_white("Nivel Minimo:"..TotalWarMin.."")
					say("")
					return
				end
				if level > TotalWarMax then
					say_red(gameforge.dungeon.msm001)
					say("")
					say_gold("¡Nivel Inaceptable")
					say_white("Nivel Maximo:"..TotalWarMax.."")
					say("")
					return
				end
				if game.get_event_flag("TotalWar") != 1 then
					say_red(gameforge.dungeon.msm001)
					say("")
					say_gold("¡El Registro ya ha Finalizado!")
					say_white("Imposible ingresar al Evento")
					say("")
					return
				end
				if pc.count_item(39037) > 0 or pc.count_item(39038) > 0 or pc.count_item(39039) > 0 or pc.count_item(71018) > 0 or pc.count_item(71020) > 0 or 
				   pc.count_item(72723) > 0 or pc.count_item(72724) > 0 or pc.count_item(72725) > 0 or pc.count_item(72726) > 0 or pc.count_item(70069) > 0 or 
				   pc.count_item(27001) > 0 or pc.count_item(27002) > 0 or pc.count_item(27003) > 0 or pc.count_item(27007) > 0 then
					say_red(gameforge.dungeon.msm001)
					say("")
					say("¡Imposible Ingresar con Regeneradores de HP!")
					say("Guardalos en el Almacen e Intentalo Nuevamente")
					say("")
					say_item (item_name(39039) , 39037 , "")
					say("")
					return
				end
				pc.warp(83200,0)
			end
		end
		when kill with game.get_event_flag("TotalWar") == 2 and TotalWar.InEvent() begin
			local s = TotalWar.Setting()
			if npc.is_pc() then
				pc.arena_killer_mode()
				local kills = pc.getqf("WarKills")
				local vid = pc.select(tonumber(npc.get_vid()))
				local Lider = global_getvarchar("TotalWarLider")
				local Puntos = game.get_event_flag("TotalWarLiderScore")
				if Lider == "" then
					Lider = "<Null>"
				end
				if vid == 0 then
					return
				else
					local Life = pc.getqf("WarLife")
					pc.setqf("WarLife",Life+1)
					if Life+1 >= game.get_event_flag("TotalWarLife") then
						if Lider == pc.get_name() then
							global_setvarchar("TotalWarLider",pc.get_name())
							game.set_event_flag("TotalWarLiderScore",kills+1)
						end
						syschat("Haz Muerto "..game.get_event_flag("TotalWarLife").." Veces en la Arena de Guerra! Serás Teletransportado a la Ciudad!")
						syschat("¡Suerte en el Proximo Evento!")
						pc.setqf("WarLife",0)
						pc.arena_hemen_dog()
						timer("TotalWarExitPlater",3)
					else
						syschat("¡Advertencia! Haz Muerto "..(Life+1).." Veces!! Serás Teletransportado de la Arena en la Muerte Numero "..game.get_event_flag("TotalWarLife").."!")
					end
					pc.select(vid)
					local Lider = global_getvarchar("TotalWarLider")
					if Lider == "" then
						Lider = "<Null>"
					end
					local kills = pc.getqf("WarKills")
					pc.setqf("WarKills",pc.getqf("WarKills")+1)
					if pc.getqf("WarKills") >= game.get_event_flag("TotalWarLiderScore") then
						if Lider == pc.get_name() then
							syschat("¡Lideras la Arena de Guerra! Haz Asesinado "..pc.getqf("WarKills").." Combatientes!")
							game.set_event_flag("TotalWarLiderScore",(kills+1))
						else
							syschat("¡Felicidades! "..pc.get_name().." Te has convertido en el Líder de la Arena de Guerra!")
							global_setvarchar("TotalWarLider",pc.get_name())
							game.set_event_flag("TotalWarLiderScore",(kills+1))
						end
					else
						syschat("¡Eliminado! Te Acercas al Lider de la Arena "..global_getvarchar("TotalWarLider").."! Puntaje Actual: "..pc.getqf("WarKills").." - Puntaje Lider: "..game.get_event_flag("TotalWarLiderScore").."")
					end
				end
			end
		end
		when TotalWarDelay.server_timer begin
			local s = TotalWar.Setting()
			local Online = pc.arena_online(s.Index)
			pc.arena_baslat(s.Index)
			game.set_event_flag("TotalWar",2)
			notice_all("El Evento Guerra Total ha Iniciado!")
		end
		when LoopTotalWarLogin.timer begin
			local s = TotalWar.Setting()
			if game.get_event_flag("TotalWar") == 2 then
				pc.arena_killer_mode()
			end
			local Lider = global_getvarchar("TotalWarLider")
			if Lider == "" then
				Lider = "<Null>"
			end
			local eflag = game.get_event_flag("TotalWar")
			if eflag == 3 then
				if Lider == pc.get_name() then
					game.set_event_flag("TotalWar",4)
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_title("~Guerra Total~")
					say("")
					say_gold("¡VICTORIA!")
					say("¡Has Logrado permanecer en pie hasta el Final!")
					say_white("Eres el ganador de la Guerra Total")
					say("")
					say_green("~Recompenzas~")
					say_gold(""..game.get_event_flag("TotalWarLiderScore").." MDs")
					say("")
					say_item (""..item_name(game.get_event_flag("TotalWarReward")).."",game.get_event_flag("TotalWarReward"),"")
					say(""..game.get_event_flag("TotalWarRewardCount").."")
					say("")
					mysql_query("UPDATE account.account SET coins = coins+'"..game.get_event_flag("TotalWarLiderScore").."' WHERE id='"..pc.get_account_id().."'")
					pc.give_item2(game.get_event_flag("TotalWarReward"),game.get_event_flag("TotalWarRewardCount"))
					cleartimer("LoopTotalWarLogin")
				end
			end
		end
		when LoopTotalWarMsM.timer begin
			local s = TotalWar.Setting()
			local Lider = global_getvarchar("TotalWarLider")
			if game.get_event_flag("TotalWar") != 2 then 
				return
			end
			if Lider == "" then
				Lider = "<Null>"
			end
			if pc.arena_online(s.Index) == 1 then
				notice_all("Evento Guerra Total ha Finalizado!")
				notice_all(""..Lider.." Ha Ganado el Evento Guerra Total!")
				game.set_event_flag("TotalWar",3)
				server_timer("TotalWarEnd",120)
				cleartimer("LoopTotalWarMsM")
			elseif game.get_event_flag("TotalWarLiderScore") != 0 then
				notice_in_map(""..global_getvarchar("TotalWarLider").." Lidera la Guerra Total! ~ Asesinatos: "..game.get_event_flag("TotalWarLiderScore").."")
				notice_in_map("Online Actuales: "..pc.arena_online(s.Index).."")
			end
		end
		when TotalWarEnd.server_timer begin
			local s = TotalWar.Setting()
			game.set_event_flag("TotalWar",0)
			game.set_event_flag("TotalWarMin",0)
			game.set_event_flag("TotalWarMax",0)
			game.set_event_flag("TotalWarReward",0)
			global_setvarchar("TotalWarLider",0)
			game.set_event_flag("TotalWarLiderScore",0)
			warp_all_to_village(s.Index)
		end
		when TotalWarExitElixir.timer begin
			warp_to_village()
		end
		when TotalWarExitPlater.timer begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Guerra Total~")
			say("")
			say_red("¡DERROTA!")
			say("¡Haz muerto "..game.get_event_flag("TotalWarLife").." veces, has sido Eliminado!")
			say("Gracias por participar en la Guerra Total")
			say_white("Seras Teletansportado a la Ciudad")
			say("")
			say_green("~Recompenzas~")
			say_gold(""..pc.getqf("WarKills").." MDs")
			say("")
			say_item (""..item_name(game.get_event_flag("TotalWarRewardFailed")).."",game.get_event_flag("TotalWarRewardFailed"),"")
			say(""..game.get_event_flag("TotalWarRewardFailedCount").."")
			say("")
			mysql_query("UPDATE account.account SET coins = coins+'"..pc.getqf("WarKills").."' WHERE id='"..pc.get_account_id().."'")
			pc.give_item2(game.get_event_flag("TotalWarRewardFailed"),game.get_event_flag("TotalWarRewardFailedCount"))
			warp_to_village()
		end
		when login with not TotalWar.InEvent() begin
			pc.setqf("WarLife",0)
			pc.setqf("WarKills",0)
			pc.setqf("TotalWarState",0)
		end
	end
end
