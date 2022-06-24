quest TrainingBattle begin
	state start begin
		when login or levelup with pc.level >= 5 begin
			set_state(information)
		end
	end
	state information begin
		when letter begin
			local v = find_npc_by_vnum(20414)
			if v != 0 then
				target.vid("__TARGET__", v, "Entrenamiento de Batalla")
			end
			send_letter("Entrenamiento de Batalla")
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Entrenamiento de Batalla~")
			say("")
			say("Aventurero, Ven a hablar con migo")
			say("Tengo algo importante que decirte.")
			say("")
		end
		when __TARGET__.target.click or	20414."Iniciar Entrenamiento" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Entrenamiento de Batalla~")
			say("")
			say("¡Bienvenido "..pc.get_name().."!")
			say("Este sera tu entrenamiento mas importante")
			say("ya que con este sera la iniciacion a tus")
			say("proximas aventuras, aqui aprenderas como ")
			say("Tienes que eliminar a los jefes neutrales")
			say("y definitivos de cada mapa y mazmorra.")
			say("")
			say("Elimina el Muñeco de Practica A Habilidades.")
			say("")
			pc.setqf("TrainingBattle",0)
			set_state(go_to_disciple)
		end
	end
	state go_to_disciple begin
		when letter begin
			q.set_counter("Entrenamiento: ", 1 - pc.getqf("kill_count"))
		end
		when leave begin
			target.delete("__TARGET__")
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Entrenamiento de Batalla")
			q.set_title("Entrenamiento")
			q.start()
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Entrenamiento de Batalla~")
			say("")
			say("Debes ir a destruir el objetivo de practica.")
			say("")
		end
		when 60409.kill with pc.getqf("TrainingBattle") == 0 begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Entrenamiento de Batalla~")
			say("")
			say("Felicidades, has logrado completar el")
			say("Entrenamiento, ven a hablar con migo")
			say("Para darte una grandiosa recompensa.")
			say("")
			pc.setqf("TrainingBattle",1)
			setstate(report)
		end
	end
	state report begin
		when letter begin
			local v = find_npc_by_vnum(20414)
			if v != 0 then
				target.vid("__TARGET__", v, "Entrenamiento de Batalla")
			end
			send_letter("Entrenamiento Finalizado")
		end
		when leave begin
			target.delete("__TARGET__")
			q.done()
		end
		when letter begin
			setskin(NOWINDOW)
			makequestbutton("Entrenamiento Finalizado")
			q.set_title("Entrenamiento Finalizado")
			q.start()
		end
		when button or info begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say("~Entrenamiento Finalizado~")
			say("")
			say("Ven y habla con migo, para culminar")
			say("Tu entrenamiento.")
			say("")
		end
		when __TARGET__.target.click or	20414.chat."Entrenamiento Finalizado" begin
			target.delete("__TARGET__")
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title("~Entrenamiento Finalizado~")
			say("")
			say("Felicidades Aventurero, ahora te dare la runa")
			say("Legado de nuestro reino que te acompañara")
			say("Y permitira que seas cada ves mas poderoso")
			say("Buena suerte.")
			say("")
			if pc.get_empire() == 1 then
				pc.give_item2(67001,1)
			end
			if pc.get_empire() == 2 then
				pc.give_item2(67501,1)
			end
			set_state(__complete)
		end
	end
	state __complete begin
	end
end
