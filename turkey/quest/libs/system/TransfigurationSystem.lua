quest TransfigurationSystem begin
	state start begin
		when 60003.chat."Transfiguracion" begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_title(string.format("~%s~", mob_name(npc.get_race())))
			say("")
			say("Transfigurar equipamiento te permdite modificar")
			say("el aspecto de tu equipo conservando todas sus")
			say("caracteristicas y bonificaciones.")
			say_item("Transfigurador", 72325, "")
			say("¿Quieres Transfigurar tu Equipamiento?")
			say("")
			local confirm = select("Transfigurar", "Cancelar")
			if confirm == 2 then
				return
			end
			setskin(NOWINDOW)
			pc.open_changelook(true)
		end
	end
end
