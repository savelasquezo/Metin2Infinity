quest NotificationSystem begin
	state start begin
		function read_notice_line(l)
			return read_server_line("/usr/game/share/locale/turkey/quest/system/text_file.txt", l)
		end
		
		when login begin
			loop_timer("loop_notificari", 5)
		end
		
		when loop_notificari.timer begin
			local version = read_server_line("/usr/game/share/locale/turkey/quest/system/version.txt", 1)
			local lineas = 0
			
			if tonumber(version) > pc.getqf("state_of_quest") then
			
				for line in io.lines("/usr/game/share/locale/turkey/quest/system/text_file.txt") do
					lineas = lineas + 1
				end
				
				cmdchat("open_notice_info")
				
				for i = 1,lineas do
					cmdchat("write_notice_info "..string.gsub(NotificationSystem.read_notice_line(i), ' ', '_'))
				end
				
				pc.setqf("state_of_quest", version)
			end
		end
	end
end
