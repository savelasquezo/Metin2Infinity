quest TeleportationRing begin
	state start begin
		when 70058.use begin
			raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
			say_yellow ( "TELETRANSPORTADOR" )
			say("~Seleccion el Destino~")
			say("")
			local main_set = select ("Imperios","Asentamientos","Areas Neutrales","Avanzadas","Cabo del Dragon","SungMahi","Cancelar")
			if main_set == 7 then
				return
			elseif main_set == 1 then
				local warp = {
				-- Legion Dragon
				{
					{"Legion_Dragon",5},
					{ 409600+596*100, 896000+682*100},
					{ 409600+596*100, 896000+682*100},
					{ 409600+596*100, 896000+682*100},
				},
				-- Legion Bestial
				{
					{"Legion_Bestial",5},
					{ 557*100, 102400+555*100},
					{ 557*100, 102400+555*100},
					{ 557*100, 102400+555*100},
				},
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ("Orden Dragon","Legion Bestial","Cancelar")
				local empire = pc.get_empire()
				if main_set4 == 3 then
					return
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			elseif main_set == 2 then
				local warp = {
				-- Asentamiento Dragon
				{
					{"Asentamiento_Dragon",15},
					{ 307200+558*100, 819200+561*100},
					{ 307200+558*100, 819200+561*100},
					{ 307200+558*100, 819200+561*100},
				},
				-- Asentamiento Bestial
				{
					{"Asentamiento_Bestial",15},
					{ 102400+352*100, 204800+297*100},
					{ 102400+352*100, 204800+297*100},
					{ 102400+352*100, 204800+297*100},
				},
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ("Asentamiento Dragon","Asentamiento Bestial","Cancelar")
				local empire = pc.get_empire()
				if main_set4 == 3 then
					return
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			elseif main_set == 3 then
				local warp = {
				-- Valle Seugryong
				{
					{"Valle_Seugryong",30},
					{ 2560000+654*100, 6656000+1422*100},
					{ 2560000+654*100, 6656000+1422*100},
					{ 2560000+654*100, 6656000+1422*100},
				},
				-- Desierto Yongi
				{
					{"Desierto_Yongi",35},
					{ 204800+152*100, 486400+143*100 },
					{ 204800+152*100, 486400+143*100 },
					{ 204800+152*100, 486400+143*100 },
				},
				-- Monte Sohan
				{
					{"Monte_Sohan",45},
					{ 358400+105*100, 153600+210*100 },
					{ 358400+105*100, 153600+210*100 },
					{ 358400+105*100, 153600+210*100 },
				},
				-- Tierra de Fuego
				{
					{"Tierra_Fuego",45},
					{ 588800+1418*100, 614400+754*100 },
					{ 588800+1418*100, 614400+754*100 },
					{ 588800+1418*100, 614400+754*100 },
				}
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ("Valle Seugryong","Desierto Yongbi","Monte Sohan","Tierra de Fuego","Cancelar")
				local empire = pc.get_empire()
				if main_set4 == 5 then
					return
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			elseif main_set == 4 then
				local warp = {
				-- Jungla Makako
				{
					{"Jungla_Makako",50},
					{ 537600+179*100, 256000+657*100},
					{ 537600+179*100, 256000+657*100},
					{ 537600+179*100, 256000+657*100},
				},
				-- Cueva de Arañas I
				{
					{"Cueva_de_Aracnida",50},
				},
				-- Cueva de Arañas II
				{
					{"Gruta_Exilio",75},
				},
				-- Tierra de Gigantes
				{
					{"Tierra_Gigantes",65},
					{ 819200+1371*100, 716800+62*100},
					{ 819200+1371*100, 716800+62*100},
					{ 819200+1371*100, 716800+62*100},
				},
				-- Pantanos Negros
				{
					{"Bosque_Fantasma",55},
					{ 281600+309*100, 1881*100},
					{ 281600+309*100, 1881*100},
					{ 281600+309*100, 1881*100},
				},
				-- Bosque Rojo
				{
					{"Bosque_Rojo",75},
					{ 1049600+703*100, 706*100},
					{ 1049600+703*100, 706*100},
					{ 1049600+703*100, 706*100},
				},
				-- Templo Oscuro
				{
					{"Templo_Oscuro",45},
					{ 537600+777*100, 51200+1139*100},
					{ 537600+777*100, 51200+1139*100},
					{ 537600+777*100, 51200+1139*100},
				}
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ("Jungla Do Makako", "Cueva Aracnida", "Gura del Exilio", "Tierra de Gigantes","Pantanos Negros","Bosque Rojo","Templo Oscuro","Cancelar")
				local empire = pc.get_empire()
				if main_set4 == 8 then
					return
				elseif main_set4 == 2 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_yellow("~Seleccion Zona~")
					say("")
					local main_set4 = select ("Cueva Aracnida 1", "Cueva Aracnida 2")
					local warp = {
					-- Cueva de Arañas 1
					{
						{"Cueva_de_Aracnida_1",50},
						{ 51200+88*100, 486400+102*100},
						{ 51200+88*100, 486400+102*100},
						{ 51200+88*100, 486400+102*100},
					},
					-- Cueva de Arañas 2
					{
						{"Cueva_de_Aracnida_2",55},
						{ 665600+385*100, 435200+274*100},
						{ 665600+385*100, 435200+274*100},
						{ 665600+385*100, 435200+274*100},
					},
								}
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				elseif main_set4 == 3 then
					raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
					say_yellow("~Seleccion Zona~")
					say("")
					local main_set4 = select ("Gruta del Exilio 1", "Gruta del Exilio 2")
					local warp = {
					-- Gruta del Exilio 1
					{
						{"Gruta_Exilio_1",75},
						{ 100*100, 1203200+57*100},
						{ 100*100, 1203200+57*100},
						{ 100*100, 1203200+57*100},
					},
					-- Gruta del Exilio 2
					{
						{"Gruta_Exilio_2",75},
						{ 153600+882*100, 1203200+716*100},
						{ 153600+882*100, 1203200+716*100},
						{ 153600+882*100, 1203200+716*100},
					},
								}
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			elseif main_set == 5 then
				local warp = {
				-- Aldea Cape
				{
					{"Aldea_Cape",90},
					{1024000+803*100,1664000+1245*100},
					{1024000+803*100,1664000+1245*100},
					{1024000+803*100,1664000+1245*100},
				},
				-- Bahia Nephirt
				{
					{"Bahia_Nephirt",100},
					{1049600+375*100,1510400+1457*100},
					{1049600+375*100,1510400+1457*100},
					{1049600+375*100,1510400+1457*100},
				},
				-- Montañas Trueno
				{
					{"Montañas_Trueno",100},
					{1126400+81*100,1510400+1442*100},
					{1126400+81*100,1510400+1442*100},
					{1126400+81*100,1510400+1442*100},
				},
				-- Acantilado Gautama
				{
					{"Acantilado_Gautama",105},
					{1177600+487*100,1664000+171*100},
					{1177600+487*100,1664000+171*100},
					{1177600+487*100,1664000+171*100},
				},
				-- Arboreal
				{
					{"Arboreal",110},
					{768000+500*100,1408000+970*100},
					{768000+500*100,1408000+970*100},
					{768000+500*100,1408000+970*100},
				}
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ( "Aldea Cape" , "Bahia Nephirt" , "Montañas Trueno" , "Acantilado Gautama", "Arboreal" ,"Cancelar" ) 
				local empire = pc.get_empire()
				if main_set4 == 6 then
					return
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			elseif main_set == 6 then
				local warp = {
				---- Aldea SungMahi
				--{
				--	{"Aldea_SungMahi",120},
				--	{ 1049600+190*100, 435200+375*100},
				--	{ 1049600+190*100, 435200+375*100},
				--	{ 1049600+190*100, 435200+375*100},
				--},
				---- Valle SungMa
				--{
				--	{"Tierra_Profana",125},
				--	{ 1152000+715*100, 435200+568*100},
				--	{ 1152000+715*100, 435200+568*100},
				--	{ 1152000+715*100, 435200+568*100},
				--},
				---- Tundra Maldita
				--{
				--	{"Imperio_SungMahi",130},
				--	{ 1049600+503*100, 435200+56*100},
				--	{ 1049600+503*100, 435200+56*100},
				--	{ 1049600+503*100, 435200+56*100},
				--},
				-- Kefren
				{
					{"Kefren",120},
					{ 972800+113*100, 716800+1423*100},
					{ 972800+113*100, 716800+1423*100},
					{ 972800+113*100, 716800+1423*100},
				},
				-- Valle Ying
				{
					{"Valle Ying",100},
					{ 400*100, 716800+93*100},
					{ 400*100, 716800+93*100},
					{ 400*100, 716800+93*100},
				},
				--Tierras Profanas
				{
					{"Tirras Profanas",130},
					{ 300*100, 1408000+65*100},
					{ 300*100, 1408000+65*100},
					{ 300*100, 1408000+65*100},
				},
				--Valle Arcatraz
				{
					{"Valle Arcatraz",130},
					{ 128000+575*100, 1510400+695*100},
					{ 128000+575*100, 1510400+695*100},
					{ 128000+575*100, 1510400+695*100},
				}
							}
				raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
				say_yellow("~Seleccion Zona~")
				say("")
				local main_set4 = select ("Kefren","Valle del Ying","Tierras Profanas","Valle Arcatraz","Cancelar") 
				local empire = pc.get_empire()
				if main_set4 == 5 then
					return
				elseif main_set4 != 0 then
					if pc.get_level() < warp[main_set4][1][2] then
						raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
						say_title(string.format("~%s~", "Teletransportador"))
						say("")
						say("¡Nivel Insuficiente!")
						say_gold("Nivel: "..warp[main_set4][1][2].." ")
						say("")
						return
					end
					pc.warp(warp[main_set4][empire+1][1], warp[main_set4][empire+1][2])
				end
			end
		end
	end
end
