--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
quest oxevent_manager begin
    state start begin
		when letter with pc.get_map_index() == 113 begin	
			send_letter("OX yarismasini birak")		
		end
	
		when button or info begin		
			say_title("Evento OX")
			say("¿Estás seguro de que quieres abandonar el concurso?")	
			say("")
			local s=select("Si","Cancelar")
			
				if s==2 then			
				send_letter("Abandonar el concurso OX")
				return				
			end
			
			local empire = pc.get_empire()
			if empire== 1 then
				pc.warp(425400, 928900)
			elseif  empire == 2 then 
				pc.warp(63200, 166700)
			elseif  empire == 3 then 
				pc.warp(950400, 268400)
			end
		end
		
        when 20011.chat."Anuncio del evento OX" begin
		
			addimage(7, 12, "event_ox.tga")
			say("")
			say("")
			say("")
			say("")
			say("")
			say("")
            say( "Estado Ox: " ) 
				if game.get_event_flag("EventOxEventQz") == 0 then
					say_gold("   Desactivado")
				elseif game.get_event_flag("EventOxEventQz") == 1 then
					say_gold("   Activo")
				end
			say("")
			say("Anuncio del evento OX:")
			say("Nuestro evento es en las mañanas o las tardes.")
			say("Se organiza a las siguientes horas los fines de semana:")
			say_blue("12:00 - 21:00")
			say_red("La competencia OX termina llegando a las 3 por dia.")
			say("")
		end
        when 20011.chat."Competencia OX" begin
			addimage(7, 8, "event_ox.tga")
			say("")
			say("")
			say("")
			say("")
			say("")
			say("")
            say_title("Uriel:")
            say ( "Hola amigo, ven aquí!" ) 
            say ( "Déjame mostrarte algo interesante." )
            say ( "El evento Ox, Puedo llevarte allí." )
            say ( "¡Escuché que los jugadores ganan grandes recompensas!" )
			say ( "" )
			
            wait()
			
			if pc.get_level() <= 14 then
			
			say_title("Uriel:")
			say ( "Tu nivel es muy bajo." )
			say ( "sube un poco para participar [ENTER]" )
			say_orange ( "Nivel mínimo de participación: 15" )
			say ( "" )
			return
			end
			
            if game.get_event_flag("EventOxEventQz") == 0 then
			
                say_title("Uriel:")
                say ( "No he escuchado que habrá competencia hoy" )
                say ( "les avisaré cuando sepa algo." )
                say ( "" )
								
				
            elseif game.get_event_flag("EventOxEventQz") == 1 then
				
                say_title( "Uriel:" )
                say ( "Deseas unirte al concurso" )
                say ( "O solo deseas mirar?[ENTER]" )
				
                local s = select( "Entrar" , "Espectar", "Cancelar" )
				
				if s == 1 then
				
					say_title("Uriel:")
					say ( "Te llevaré a la zona de competencia de inmediato." )
                    say ( "[ENTER]" )				
					horse.unride()
					horse.unsummon()
					--pc.polymorph(101, 3600)
                    wait()
					pc.warp(896500, 24600)
					elseif s == 2 then
				
					say_title("Uriel:")
					say ( "¿Solo quieres ser espectador? Ok, tu eliges." )
                    say ( "Te llevare para que observes.[ENTER]" )
					horse.unride()
					horse.unsummon()
					--pc.polymorph(101, 3600)
                    wait()
                    pc.warp(896300, 28900)
                end
            elseif game.get_event_flag("EventOxEventQz") == 2 then
			
					say_title("Uriel:")
					say ( "Lo siento el evento ya comenzo ..." )
                    say ( "Pero si quieres, puedes unirte como espectador.[ENTER]" )
					say ( "" )
				
                local s = select( "Espectar" , "Cancelar")
                if s == 1 then
				
					say_title("Uriel:")
                    say ( "Te llevare ahi inmediatamente.[ENTER]" )
					horse.unride()
					horse.unsummon()
					--pc.polymorph(101, 3600)
                    wait()
                    pc.warp(896300, 28900)
                end
            end
        end
	end
end
