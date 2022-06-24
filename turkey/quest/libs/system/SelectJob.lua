quest SelectJob begin
	state start begin
		when login or levelup with pc.get_level()>=5 and pc.get_skill_group()==0 begin
			if pc.getf('SelectJob', 'selecting') != 1 then
				cmdchat('SELECT_JOB QID#'..q.getcurrentquestindex())
				cmdchat('SELECT_JOB OPEN#')
				pc.setf('SelectJob', 'selecting', 1)
			end
		end
		when logout begin
			cmdchat('SELECT_JOB CLOSE#')
			pc.setf('SelectJob', 'selecting', 0)
		end
		when button begin
			if pc.get_skill_group()==0 then 
				cmdchat('SELECT_JOB INPUT#1')
				local group = split(input(cmdchat('SELECT_JOB SEND#')), '#')
				local point = pc.get_level()-1
				cmdchat('SELECT_JOB INPUT#0')
				if group[1] == '1' then
					pc.set_skill_group(1)
					pc.set_skill_point(point)
					syschat("<System> Obtienes "..point.." Puntos de Habilidad")
					pc.setf('SelectJob', 'selecting', 0)
				elseif group[1] == '2' then
					if pc.get_job()==4 then
						pc.set_skill_group(1)
						pc.set_skill_point(point)
						syschat("<System> Obtienes "..point.." Puntos de Habilidad")
					else
						pc.set_skill_group(2)
						pc.set_skill_point(point)
						syschat("<System> Obtienes "..point.." Puntos de Habilidad")
					end
					pc.setf('SelectJob', 'selecting', 0)
				else
					syschat("<System> Seleccion de Habilidades")
					syschat("<Error> Grupo de Habilidades Invalido.")
				end
			else
				syschat("<System> Seleccion de Habilidades")
				syschat("<Error> Ya Has Seleccionado Habilidades.")
			end
		end
	end
end
