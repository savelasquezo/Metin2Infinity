quest reset_training begin
	state start begin
		when 9006.chat."Restablecer Habilidades" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if pc.get_skill_group() == 0 then
				say("Todavia no has empezado ningun entrenamiento!")
				say("Mientras no gastes ningun punto de habilidad.")
				say("podras restablecerlas.")
				say("")
				return
			end
			say("Hola, has venido al sitio correcto. tus ojos")
			say("muestran mucho dolor. Permito a las personas")
			say("olvidar sus habilidades para que puedan empezar")
			say("de nuevo el entrenamiento.")
			say("")
			local s = select("Restablecer Habilidades","Cancelar")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			if s == 1 then
				say("Has olvidado tus habilidades puedes empezar")
				say("de nuevo el entrenamiento.")
				say("")
				character_group = pc.get_job()
				if character_group == 0 or character_group == 4 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Corporal")
						say("")
						pc.set_skill_level(1,0)
						pc.set_skill_level(2,0)
						pc.set_skill_level(3,0)
						pc.set_skill_level(4,0)
						pc.set_skill_level(5,0)
						pc.set_skill_level(6,0)
						pc.set_skill_level(7,0)
						pc.set_skill_level(16,0)
						pc.set_skill_level(17,0)
						pc.set_skill_level(18,0)
						pc.set_skill_level(19,0)
						pc.set_skill_level(20,0)
						pc.set_skill_level(21,0)
						pc.set_skill_level(22,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Mental")
						say("")
						pc.set_skill_level(1,0)
						pc.set_skill_level(2,0)
						pc.set_skill_level(3,0)
						pc.set_skill_level(4,0)
						pc.set_skill_level(5,0)
						pc.set_skill_level(6,0)
						pc.set_skill_level(7,0)
						pc.set_skill_level(16,0)
						pc.set_skill_level(17,0)
						pc.set_skill_level(18,0)
						pc.set_skill_level(19,0)
						pc.set_skill_level(20,0)
						pc.set_skill_level(21,0)
						pc.set_skill_level(22,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
				end
				if character_group == 1 or character_group == 5 then -- ninja
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Asesino")
						say("")
						pc.set_skill_level(31,0)
						pc.set_skill_level(32,0)
						pc.set_skill_level(33,0)
						pc.set_skill_level(34,0)
						pc.set_skill_level(35,0)
						pc.set_skill_level(36,0)
						pc.set_skill_level(37,0)
						pc.set_skill_level(46,0)
						pc.set_skill_level(47,0)
						pc.set_skill_level(48,0)
						pc.set_skill_level(49,0)
						pc.set_skill_level(50,0)
						pc.set_skill_level(51,0)
						pc.set_skill_level(52,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Arquero")
						say("")
						pc.set_skill_level(31,0)
						pc.set_skill_level(32,0)
						pc.set_skill_level(33,0)
						pc.set_skill_level(34,0)
						pc.set_skill_level(35,0)
						pc.set_skill_level(36,0)
						pc.set_skill_level(37,0)
						pc.set_skill_level(46,0)
						pc.set_skill_level(47,0)
						pc.set_skill_level(48,0)
						pc.set_skill_level(49,0)
						pc.set_skill_level(50,0)
						pc.set_skill_level(51,0)
						pc.set_skill_level(52,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
				end
				if character_group == 2 or character_group == 6 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Magia Negra")
						say("")
						pc.set_skill_level(61,0)
						pc.set_skill_level(62,0)
						pc.set_skill_level(63,0)
						pc.set_skill_level(64,0)
						pc.set_skill_level(65,0)
						pc.set_skill_level(66,0)
						pc.set_skill_level(67,0)
						pc.set_skill_level(76,0)
						pc.set_skill_level(77,0)
						pc.set_skill_level(78,0)
						pc.set_skill_level(79,0)
						pc.set_skill_level(80,0)
						pc.set_skill_level(81,0)
						pc.set_skill_level(82,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Armamento")
						say("")
						pc.set_skill_level(61,0)
						pc.set_skill_level(62,0)
						pc.set_skill_level(63,0)
						pc.set_skill_level(64,0)
						pc.set_skill_level(65,0)
						pc.set_skill_level(66,0)
						pc.set_skill_level(67,0)
						pc.set_skill_level(76,0)
						pc.set_skill_level(77,0)
						pc.set_skill_level(78,0)
						pc.set_skill_level(79,0)
						pc.set_skill_level(80,0)
						pc.set_skill_level(81,0)
						pc.set_skill_level(82,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
				end
				if character_group == 3 or character_group == 7 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Dragon")
						say("")
						pc.set_skill_level(91,0)
						pc.set_skill_level(92,0)
						pc.set_skill_level(93,0)
						pc.set_skill_level(94,0)
						pc.set_skill_level(95,0)
						pc.set_skill_level(96,0)
						pc.set_skill_level(97,0)
						pc.set_skill_level(106,0)
						pc.set_skill_level(107,0)
						pc.set_skill_level(108,0)
						pc.set_skill_level(109,0)
						pc.set_skill_level(110,0)
						pc.set_skill_level(111,0)
						pc.set_skill_level(112,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Luz")
						say("")
						pc.set_skill_level(91,0)
						pc.set_skill_level(92,0)
						pc.set_skill_level(93,0)
						pc.set_skill_level(94,0)
						pc.set_skill_level(95,0)
						pc.set_skill_level(96,0)
						pc.set_skill_level(97,0)
						pc.set_skill_level(106,0)
						pc.set_skill_level(107,0)
						pc.set_skill_level(108,0)
						pc.set_skill_level(109,0)
						pc.set_skill_level(110,0)
						pc.set_skill_level(111,0)
						pc.set_skill_level(112,0)
						pc.set_skill_point(0)
						pc.set_skill_group(0)
						command("logout")
					end
				end
			end
			if s == 2 then
				say("Si cambias de opinion, vuelve a visitarme.")
				say("")
			end
		end
		when 71002.use begin
			if pc.get_skill_group() == 0 then
				say_title("Cambio de Doctrinas:")
				say("�Todavia no has empezado ningun entrenamiento!")
				say("Mientras no gastes ningun punto de habilidad.")
				say("podras restablecerlas.")
				say("")
				return
			end
			if pc.get_job() == 4 then
				say_title("Cambio de Doctrinas:")
				say("El Entrenamiento de Lobuno no pueden cambiar")
				say("Imposible seguir otro entrenamiento.")
				say("")
				return
			end
			say_title("Reseteo de Habilidades")
			say("Este pergamino te permite cambiar las habilidades")
			say("conservando sus puntos de habilidad.")
			say("Deseas utilizarlo ahora?")
			say("")
			local s = select("Restablecer Habilidades","Cancelar")
			say("")
			if s == 1 then
				if pc.count_item(71002) == 0 then
					return
				end
				character_group = pc.get_job()
				if character_group == 0 or character_group == 4 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Corporal")
						say("")
						pc.set_skill_group(2)
						pc.set_skill_level(16,pc.get_skill_level(1))
						pc.set_skill_level(17,pc.get_skill_level(2))
						pc.set_skill_level(18,pc.get_skill_level(3))
						pc.set_skill_level(19,pc.get_skill_level(4))
						pc.set_skill_level(20,pc.get_skill_level(5))
						pc.set_skill_level(21,pc.get_skill_level(6))
						pc.set_skill_level(22,pc.get_skill_level(7))
						item.remove(71002)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Mental")
						say("")
						pc.set_skill_group(1)
						pc.set_skill_level(1,pc.get_skill_level(16))
						pc.set_skill_level(2,pc.get_skill_level(17))
						pc.set_skill_level(3,pc.get_skill_level(18))
						pc.set_skill_level(4,pc.get_skill_level(19))
						pc.set_skill_level(5,pc.get_skill_level(20))
						pc.set_skill_level(6,pc.get_skill_level(21))
						pc.set_skill_level(7,pc.get_skill_level(22))
						item.remove(71002)
						command("logout")
					end
				end
				if character_group == 1 or character_group == 5 then -- ninja
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Asesino")
						say("")
						pc.set_skill_group(2)
						pc.set_skill_level(46,pc.get_skill_level(31))
						pc.set_skill_level(47,pc.get_skill_level(32))
						pc.set_skill_level(48,pc.get_skill_level(33))
						pc.set_skill_level(49,pc.get_skill_level(34))
						pc.set_skill_level(50,pc.get_skill_level(35))
						pc.set_skill_level(51,pc.get_skill_level(36))
						pc.set_skill_level(52,pc.get_skill_level(37))
						item.remove(71002)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Arquero")
						say("")
						pc.set_skill_group(1)
						pc.set_skill_level(31,pc.get_skill_level(46))
						pc.set_skill_level(32,pc.get_skill_level(47))
						pc.set_skill_level(33,pc.get_skill_level(48))
						pc.set_skill_level(34,pc.get_skill_level(49))
						pc.set_skill_level(35,pc.get_skill_level(50))
						pc.set_skill_level(36,pc.get_skill_level(51))
						pc.set_skill_level(37,pc.get_skill_level(52))
						item.remove(71002)
						command("logout")
					end
				end
				if character_group == 2 or character_group == 6 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Magia Negra")
						say("")
						pc.set_skill_group(2)
						pc.set_skill_level(76,pc.get_skill_level(61))
						pc.set_skill_level(77,pc.get_skill_level(62))
						pc.set_skill_level(78,pc.get_skill_level(63))
						pc.set_skill_level(79,pc.get_skill_level(64))
						pc.set_skill_level(80,pc.get_skill_level(65))
						pc.set_skill_level(81,pc.get_skill_level(66))
						pc.set_skill_level(82,pc.get_skill_level(67))
						item.remove(71002)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Armamento")
						say("")
						pc.set_skill_group(1)
						pc.set_skill_level(61,pc.get_skill_level(76))
						pc.set_skill_level(62,pc.get_skill_level(77))
						pc.set_skill_level(63,pc.get_skill_level(78))
						pc.set_skill_level(64,pc.get_skill_level(79))
						pc.set_skill_level(65,pc.get_skill_level(80))
						pc.set_skill_level(66,pc.get_skill_level(81))
						pc.set_skill_level(67,pc.get_skill_level(82))
						item.remove(71002)
						command("logout")
					end
				end
				if character_group == 3 or character_group == 7 then
					character_skillgroup = pc.get_skill_group()
					if character_skillgroup == 1 then
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Dragon")
						say("")
						pc.set_skill_group(2)
						pc.set_skill_level(106,pc.get_skill_level(91))
						pc.set_skill_level(107,pc.get_skill_level(92))
						pc.set_skill_level(108,pc.get_skill_level(93))
						pc.set_skill_level(109,pc.get_skill_level(94))
						pc.set_skill_level(110,pc.get_skill_level(95))
						pc.set_skill_level(111,pc.get_skill_level(96))
						pc.set_skill_level(112,pc.get_skill_level(97))
						item.remove(71002)
						command("logout")
					end
					if character_skillgroup == 2 then 
						say_title("Reseteo de Habilidades")
						say("Las habilidades han sido restablecidas")
						say("Ahora puedes entrenar un nuevo camino.")
						say("Haz Adquirido la Doctrina Luz")
						say("")
						pc.set_skill_group(1)
						pc.set_skill_level(91,pc.get_skill_level(106))
						pc.set_skill_level(92,pc.get_skill_level(107))
						pc.set_skill_level(93,pc.get_skill_level(108))
						pc.set_skill_level(94,pc.get_skill_level(109))
						pc.set_skill_level(95,pc.get_skill_level(110))
						pc.set_skill_level(96,pc.get_skill_level(111))
						pc.set_skill_level(97,pc.get_skill_level(112))
						item.remove(71002)
						command("logout")
					end
				end
			elseif s == 2 then
				return
			end
		end
	end
end

