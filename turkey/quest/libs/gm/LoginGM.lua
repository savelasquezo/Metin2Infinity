quest LoginGM begin
	state start begin
		when login with not pc.is_gm() begin
			if game.get_event_flag("Mantenimiento") == 1 and pc.getqf("UserMantenimiento") == 1 then
				addimage(20, 12, "password_inventory.tga")
				say("")
				say("")
				say("")
				say("")
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("¡MANTENIMIENTO!")
				say("")
				pc.setqf("UserMantenimiento",0)
				command("logout")
			end
			pc.setqf("UserMantenimiento",1)
			loop_timer("MantenimientoCheck",5)
		end
		when MantenimientoCheck.timer begin
			if game.get_event_flag("Mantenimiento") == 1 and pc.getqf("UserMantenimiento") == 1 then
				addimage(20, 12, "password_inventory.tga")
				say("")
				say("")
				say("")
				say("")
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("¡MANTENIMIENTO!")
				say("")
				pc.setqf("UserMantenimiento",0)
				command("logout")
			end
		end
	end
end

