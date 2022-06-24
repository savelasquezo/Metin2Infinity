quest SecuritySystem begin
	state start begin
		function get_input(par)
			cmdchat("getinputbegin")
			local ret = input(cmdchat(par))
			cmdchat("getinputend")
			return ret
		end
		when login begin
			cmdchat("guvenlipc_q "..q.getcurrentquestindex()) 
		end
		when button begin
			if tablo_kontrol(pc.get_map_index(),{212, 216, 217, 222, 351, 352, 353, 354, 355, 358, 79, 66, 660000}) then 
				syschat("<System> Seguridad")
				syschat("<Error> Imposible usar este sistema en este Mapa.")
				return 
			end
			cmdchat("getinputbegin")
			local INPUT = input(cmdchat("guvenlipcquestislem"))
			cmdchat("getinputend")
			if INPUT == "sistemac" then
				if pc.guvenli_pc_kontrol() == false then 
					syschat("<System> Seguridad")
					syschat("<Error> Debe Registrar este PC como una Conexion Segura.")
					return
				end
				pc.guvenli_pc_islem(1)
				syschat("<Security> Sistema Activado")
			elseif INPUT == "sistemkapa" then
				pc.guvenli_pc_islem(0)
				syschat("<Security> Sistema Desactivado")
			elseif INPUT == "pcsil" then
				local mac = SecuritySystem.get_input("guvenlipc")
				pc.guvenli_pc_sil(mac)
				syschat_kirmizi("<Security> Ordenador Eliminado")
			elseif INPUT == "pcekle" then
				local mac = SecuritySystem.get_input("guvenlipc")
				if pc.guvenli_pc_hwid_kontrol(mac) == true then 
					syschat_kirmizi("<Security> Ordenador Ya ha sido Agregado.")
					return
				end
				pc.guvenli_pc_ekle(mac)
				syschat_yesil("<Security> Ordenador Agregado Exitosamente!")
			end
		end
		
	end
end
