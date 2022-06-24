--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
function input_number (sentence)
     say (sentence)
     local n = nil
     while n == nil do
         n = tonumber (input())
         if n != nil then
             break
         end
         say ("input number")
     end
     return n
 end
ITEM_NONE = 0
ITEM_WEAPON = 1
ITEM_ARMOR = 2

WEAPON_SWORD = 0
WEAPON_DAGGER = 1
WEAPON_BOW = 2
WEAPON_TWO_HANDED = 3
WEAPON_BELL = 4
WEAPON_FAN = 5
WEAPON_ARROW = 6
WEAPON_MOUNT_SPEAR = 7

--dofile( get_locale_base_path() .. "/quest/GFquestlib.lua")

function get_today_count(questname, flag_name)
    local today = math.floor(get_global_time() / 86400)
    local today_flag = flag_name.."_today"
    local today_count_flag = flag_name.."_today_count"
    local last_day = pc.getf(questname, today_flag)
    if last_day == today then
        return pc.getf(questname, today_count_flag)
    else
        return 0
    end
end
-- "$flag_name"_today unix_timestamp % 86400
-- "$flag_name"_count count
function inc_today_count(questname, flag_name, count)
    local today = math.floor(get_global_time() / 86400)
    local today_flag = flag_name.."_today"
    local today_count_flag = flag_name.."_today_count"
    local last_day = pc.getqf(questname, today_flag)
    if last_day == today then
        pc.setf(questname, today_count_flag, pc.getf(questname, today_count_flag) + 1)
    else
        pc.setf(questname, today_flag, today)
        pc.setf(questname, today_count_flag, 1)
    end
end

function LIB_duration(ipe) 
	-- if have == nil then
	-- seconds = ipe - get_global_time()
	-- chat("nil")
	-- else
	-- seconds = (get_global_time() + ipe) - get_global_time()
	-- chat("no nil")
	-- end
	
	if ipe >= get_global_time() then
	seconds = ipe - get_global_time()
	--chat("nil")
	else
	seconds = (get_global_time() + ipe) - get_global_time()
	--chat("no nil")
	end
	
	
	local days = 0
	local hours = math.floor(seconds / 3600)
	local mins = math.floor((seconds - (hours*3600)) / 60)
	local secs = math.floor(seconds - hours*3600 - mins*60 )
	local t = ""
	if tonumber(hours) >= 24 then
		days = math.floor(hours / 24)
		hours = math.floor(hours - (days*24))
	end
	if tonumber(days) == 1 then
		t = t..days.." Gun "
	elseif tonumber(days) >= 1 then
		t = t..days.." Gun "
	end
	if tonumber(hours) == 1 then
		t = t..hours.." Saat "
	elseif tonumber(hours) >= 1 then
		t = t..hours.." Saat "
	end
	if tonumber(mins) == 1 then
		t = t..mins.." Dakika "
	elseif tonumber(mins) >= 1 then
		t = t..mins.." Dakika "
	end
	if tonumber(secs) == 1 then
		t = t..secs.." Saniye "
	elseif tonumber(secs) >= 1 then
		t = t..secs.." Saniye "
	end
	if t == "" then
		return "(!)"
	end
	return t
end

function say_npc()
	say_title(""..mob_name(npc.get_race()).."")
end

-- This function will return true always in window os,
--  but not in freebsd.
-- (In window os, RAND_MAX = 0x7FFF = 32767.)
function drop_gamble_with_flag(drop_flag)
        local dp, range = pc.get_killee_drop_pct()
        dp = 40000 * dp / game.get_event_flag(drop_flag)
        if dp < 0 or range < 0 then
            return false
        end
        return dp >= number(1, range)
end


function tablo_kontrol ( e, t )
    for _,v in pairs(t) do
        if (v==e) then 
            return true 
        end
    end
    return false
end

function setvarchar(name, var)
	local laenge = string.len (var)
	local setchar = 0
	local save_name = 0
	local letter = 0
	while laenge > setchar do
		setchar = setchar + 1
		letter = string.sub (var, setchar, setchar)
		letter = string.byte(letter, 1)
		save_name = ""..name.."_char_"..setchar..""
		pc.setqf(save_name, letter)
	end
	local save_laenge=""..name.."laenge"
	pc.setqf(save_laenge, laenge)
end

function getvarchar(name)
	local save_laenge = ""..name.."laenge"
	local laenge = pc.getqf(save_laenge)
	local save_name = 0
	local var = ""
	local letter = 0
	local getchar = 0
	while laenge > getchar do
		getchar = getchar + 1
		save_name = ""..name.."_char_"..getchar..""
		letter = pc.getqf(save_name)
		if letter!=0 then
			letter = string.char(letter)
		else
			letter = ""
		end
		var = ""..var..""..letter..""
	end
	return var
end

function delvarchar(name)
	local save_laenge = ""..name.."laenge"
	local laenge = pc.getqf(save_laenge)
	local getchar = 0
	while laenge > getchar do
		getchar = getchar + 1
		local save_name = ""..name.."_char_"..getchar..""
		pc.delqf(save_name)
	end
	pc.delqf(save_laenge)
end

function global_setvarchar(name, var)
	local laenge = string.len (var)
	local setchar = 0
	local save_name = 0
	local letter = 0
	while laenge > setchar do
		setchar = setchar + 1
		letter = string.sub (var, setchar, setchar)
		letter = string.byte(letter)
		if letter==91 or letter==93 then
			letter=32
		end
		save_name = ""..name.."_char_"..setchar..""
		game.set_event_flag(save_name, letter)
	end
	local save_laenge=""..name.."laenge"
	game.set_event_flag(save_laenge, laenge)
end

function global_getvarchar(name)
	local save_laenge = ""..name.."laenge"
	local laenge = game.get_event_flag(save_laenge)
	local save_name = 0
	local var = ""
	local letter = 0
	local getchar = 0
	while laenge > getchar do
		getchar = getchar + 1
		save_name = ""..name.."_char_"..getchar..""
		letter = game.get_event_flag(save_name)
		if letter!=0 then
			letter = string.char(letter)
		else
			letter = ""
		end
		
		var = ""..var..""..letter..""
	end
	return var
end

function actual_time()
	return os.date()
end

function actual_timestamp()
	return os.time()
end

function search_time(h,m,s)
	local out = {}
	out.h = os.date("%H")+h
	out.m = os.date("%M")+m
	out.s = os.date("%S")+s
	while out.h >= 24 do
		out.h = out.h - 24
	end
	while out.m >= 60 do
		out.m = out.m - 60
	end
	while out.s >= 60 do
		out.s = out.s - 60
	end
	if out.h < 10 then
		out.h = "0"..out.h
	end
	if out.m < 10 then
		out.m = "0"..out.m
	end
	if out.s < 10 then
		out.s = "0"..out.s
	end
	return out
end

function SendAchievement(Achievement, new_points, count)
	local Achievement = string.gsub(Achievement, " ", "_")
	if count != nil then
		if count != 1 then
			Achievement = Achievement.."#"..count
		end
	end
	cmdchat("achievement "..Achievement.."%"..new_points.."")
end

PetExpTable = { 
	[1] = 300, [2] = 600, [3] = 900, 
	[4] = 1200, [5] = 1500, [6] = 1800, 
	[7] = 2100, [8] = 2400, [9] = 2700, 
	[10] = 3000, [11] = 3300, [12] = 3600, 
	[13] = 3900, [14] = 4200, [15] = 4500, 
	[16] = 4800, [17] = 5100, [18] = 5400, 
	[19] = 5700, [20] = 6000, [21] = 6300, 
	[22] = 6600, [23] = 6900, [24] = 7200, 
	[25] = 7500, [26] = 7800, [27] = 8100, 
	[28] = 8400, [29] = 8700, [30] = 9000,
	[31] = 9300, [32] = 9600, [33] = 9900, 
	[34] = 10200, [35] = 10500, [36] = 10800, 
	[37] = 11100, [38] = 11400, [39] = 11700, 
	[40] = 12000, [41] = 12300, [42] = 12600, 
	[43] = 12900, [44] = 13200, [45] = 13500, 
	[46] = 13800, [47] = 14100, [48] = 14400, 
	[49] = 14700, [50] = 15000,	[51] = 15300, 
	[52] = 15600, [53] = 15900, [54] = 16200, 
	[55] = 16500, [56] = 16800, [57] = 17100, 
	[58] = 17400, [59] = 17700, [60] = 18000,
	[61] = 18300, [62] = 18600, [63] = 18900, 
	[64] = 19200, [65] = 19500, [66] = 19800, 
	[67] = 20100, [68] = 20400, [69] = 20700, 
	[70] = 21000, [71] = 21300, [72] = 21600, 
	[73] = 21900, [74] = 22200, [75] = 22500, 
	[76] = 22800, [77] = 23100, [78] = 23400, 
	[79] = 23700, [80] = 24000,	[81] = 24300, 
	[82] = 24600, [83] = 24900, [84] = 25200, 
	[85] = 25500, [86] = 25800, [87] = 26100, 
	[88] = 26400, [89] = 26700, [90] = 27000,
	[91] = 27300, [92] = 27600, [93] = 27900, 
	[94] = 28200, [95] = 28500, [96] = 28800, 
	[97] = 29100, [98] = 29400, [99] = 29700, 
	[100] = 30000, [101] = 30300, [102] = 30600, 
	[103] = 30900, [104] = 31200, [105] = 31500, 
	[106] = 31800, [107] = 32100, [108] = 32400, 
	[109] = 32700, [110] = 33000, [111] = 33300, 
	[112] = 33600, [113] = 33900, [114] = 34200, 
	[115] = 34500, [116] = 34800, [117] = 35100, 
	[118] = 35400, [119] = 35700, [120] = 36000,
	[121] = 36300, [122] = 36600, [123] = 36900, 
	[124] = 37200, [125] = 37500, [126] = 37800, 
	[127] = 38100, [128] = 38400, [129] = 38700, 
	[130] = 39000, [131] = 39300, [132] = 39600, 
	[133] = 39900, [134] = 40200, [135] = 40500, 
	[136] = 40800, [137] = 41100, [138] = 41400, 
	[139] = 41700, [140] = 42000, [141] = 42300, 
	[142] = 42600, [143] = 42900, [144] = 43200, 
	[145] = 43500, [146] = 43800, [147] = 44100, 
	[148] = 44400, [149] = 44700, [150] = 45000,
}


PetBonus = {
	{ "Ofansif", { "Saldiri Degeri","Buyulu Saldiri Degeri", }, { "Savascilara Karsi Guclu","Ninjalara Karsi Guclu","Suralara Karsi Guclu","Samanlara Karsi Guclu","Canavarlara Karsi Guclui", }, { "Kritik Vurus Sansi","Delici Vurus Sansi", }, { "Sersemletme Sansi","Zehirleme Sansi","Yavaslatma Sansi", }, },
	{ "Defansif", { "Savunma","Buyu Savunmasi", }, { "Kilic Savunmasi","?ftel Savunmasi","Bicak Savunmasi","Can Savunmasi","Yelpaze Savunmasi","Ok Savunmasi","Buyuye Karsi Dayanikllik", }, { "Max HP","Max SP", }, { "HP Uretimi","SP Uretimi", }, },
	{ 1, { 53,55, }, { 59,60,61,62,63, }, { 15,16, }, { 13,12,14, }, },
	{ 2, { 54,56, }, { 29,30,31,32,33,34,37, }, { 1,2, }, { 10,11, }, },
}


PetArray = {
	{53001, "atesankasi", "Ates Ankasi", 30068, PetExpTable, { 3,1,3,1, }, },
	{53002, "buzankasi", "Buz Ankasi", 30068, PetExpTable, { 3,3,1,1, }, },
	{53003, "rengeyigi", " Ren Geyigi", 30068, PetExpTable, { 3,1,1,3, }, },
	{53005, "gencazrail", "Genc Azrail", 30068, PetExpTable, { 2,1,3,2, }, },
	{53006, "genckurt", " Genc Kurt", 30068, PetExpTable, { 1,3,1,3, }, },
	{53007, "gencaslan", " Genc Aslan", 30068, PetExpTable, { 1,1,3,3, }, },
	{53008, "gencdomuz", "Genc Domuz", 30068, PetExpTable, { 1,3,3,1, }, },
	{53009, "genckaplan", "Genc Kaplan", 30068, PetExpTable, { 2,3,2,1, }, },
}


PET_NAME 				= 1
PET_LEVEL				= 2
PET_EXP					= 3


PET_TYPE				= 1
PET_BON1				= 2
PET_BON2				= 3
PET_BON3				= 4
PET_BON4				= 5


PET_SUMMON				= 0
PET_UNSUMMON			= 1


PET_READ				= 0
PET_WRITE				= 1


PET_DATA				= 0
PET_BONUS				= 1


function inizializza(i)
	say_title(" Evcil Hayvan ")
	say("")
	say(" Merhaba , ?ce Evcil Hayvan?a ?im Vermelisin ")
	local scelta = select(" Tamam "," Daha Sonra ")
	if scelta == 2 then
		return -1
	end
	say_title(" Evcil Hayvan ")
	say("")
	say(" Evcil Hayvan?a Hangi ?mi Vermek ?tiyorsun? ")
	say("")
	say_reward(" ?im: ")
	local PetName = tostring(input())
	if PetName == "" then
		say_title(" Evcil Hayvan ")
		say("")
		say_reward(" Boþ B?akamazs?! ")
		return -1
	end
	local DATA_PATH = "locale/turkey/quest/object/pet/"
	local LOCAL_PATH = pc.get_name().."/"
	local PET_FILE = PetArray[i][2]..".txt"
	local PET_BONUS_FILE = PetArray[i][2].."_bonus.txt"
	if pc.getqf("local_path2") != 1 then
		os.execute("cd "..DATA_PATH.." && mkdir "..LOCAL_PATH.." && chmod 777 "..LOCAL_PATH)
		pc.setqf("local_path2", 1)
	end
	local file = io.open(DATA_PATH..LOCAL_PATH..PET_FILE , "w")
	file:write(PetName.."\n1\n0\n") --nome livello exp
	io.close(file)
	local bonus = io.open(DATA_PATH..LOCAL_PATH..PET_BONUS_FILE , "w")
	bonus:write("0\n0\n0\n0\n0\n")	
	io.close(bonus)
	os.execute("cd "..DATA_PATH..LOCAL_PATH.." && chmod 777 *.txt") 
	return 0
end


function GetGrade(i)
	local PetLevel = tonumber(data_tool(i, PET_LEVEL, PET_DATA, PET_READ))
	local x = 0
	local y = 0
	local Grade = 1
	while true do
		x = x + 1
		y = y + 1
		if y == 10 then
			Grade = Grade + 1
			y = 0
		end
		if x == PetLevel then 
			return Grade
		end
	end
end
	
function evoca(i, stato)
	local bonus = { 3,4,5,6, }
	local status = PetArray[i][6]
	local PetGrade = tonumber(GetGrade(i))
	local PetName = data_tool(i, PET_NAME, PET_DATA, PET_READ)
	local PetLevel = tonumber(data_tool(i, PET_LEVEL, PET_DATA, PET_READ))
	local horse_level = horse.get_level()
	local apply = 0
	local level = 21 + i
	if stato == PET_SUMMON then
		local z = 1
		while true do
			if bonus[z] == nil then break end
			apply = PetGrade*status[z]
			affect.add_collect(bonus[z], apply, 60*60*8)
			z = z + 1
		end
		horse.set_level(level)
		horse.set_name(PetName)
		horse.summon()
		chat(" Evcil Hayvan???ðýrd?. ")
		horse.set_level(horse_level)
	else
		local z = 1
		while true do
			if bonus[z] == nil then break end
			apply = PetGrade*status[z]
			affect.remove_collect(bonus[z], apply, 60*60*8)
			z = z + 1
		end
		horse.set_level(level)
		horse.unsummon()
		chat(" Evcil Hayvan??G?derdin. ")
		horse.set_level(horse_level)
	end
end


function PetInfo(x)
	while true do
		say_title(" Evcil Hayvan ")
		say("")
		say(" 4 Tane "..PetBonus[x][1].." Teknik Vard?")
		say(" Aþaðýdaki Kategorilerden Bunlara Ulaþabilirsin. ")
		local y = 0
		if x == 1 then
			y = select( " Sald??Teknikleri "," Savaþ Teknikleri "," Vuruþ Teknikleri "," ??c? Teknikler "," Geri D? ")
		else
			y = select( " Savunma Teknikleri "," Korunma Teknikleri "," Yaþam Teknikleri "," Yenileyici Teknikler "," Geri D? ")
		end
		if y == 5 then
			break
		end
		while true do
			say_title(" Evcil Hayvan ")
			say("Informazioni abilita':")
			say("")
			say("Con l'apprendimento di questa tecnica potrai")
			say("incrementare il valore "..PetBonus[x][1])
			say("Tecniche disponibili:")
			say("")
			local z = 1
			while true do
				if PetBonus[x][y+1][z] == nil then break end
				say_reward(PetBonus[x][y+1][z])
				z = z + 1
			end
			local b = select(" Geri D? ")
			if b == 1 then
				break
			end
		end
	end
end


function PetSet(i, t)
	say_title(" Evcil Hayvan ")
	say("")
	say(" "..PetBonus[t][1].." Tekni?mi Se?ek ?tiyorsun? ")
	say("")
	local conferma = select(" Evet "," Hay? ")
	if conferma == 2 then
		return
	end
	say_title(" Evcil Hayvan ")
	say("")
	say(" Yeni Beceriler Geliþtirip Hayvan??Güçlendire- ")
	say(" bilirsin."..PetBonus[t][1].." Tekni? Se?ek ?tedi?ne ")
	say(" Eminmisin? E?r Tekni?ni Se?ikten Sonra ")
	say(" Be?nmezsen Yetene? De?þebilirsin. ")
	local k = select(" Evet "," Hay? ")
	if k == 2 then
		return
	end
	local w = 2
	local bonus = {}
	local bon = {}
	while true do
		if PetBonus[t][w] == nil then break end
		say_title(" Evcil Hayvan ")
		say(" Yetenek Se?e : ")
		say("")
		say_reward(" Yaln? Birini Se?bilirsin Dikkatli Se?m Yap ")
		say("")
		local x = select_table( PetBonus[t][w] )
		bonus[w-1] = x
		bon[w-1] = PetBonus[t][w][x]
		w = w + 1
	end
	say_title(" Evcil Hayvan ")
	say("")
	say(" Yetenek Se?min ? ?kilde :")
	say("")
	say(" Yetenek 1:  "..bon[1])
	say(" Yetenek 2:  "..bon[2])
	say(" Yetenek 3:  "..bon[3])
	say(" Yetenek 4:  "..bon[4])
	say("")
	say_reward(" Onayl?ormusun? ")
	say("")
	local c = select(" Evet "," Hay? ")
	if c == 2 then
		return
	end
	data_tool(i, t.."\n"..bonus[1].."\n"..bonus[2].."\n"..bonus[3].."\n"..bonus[4].."\n", PET_BONUS, PET_WRITE)
end


function PetMenuAbi(i)
	local check = tonumber(data_tool(i, PET_TYPE, PET_BONUS, PET_READ))
	local status = PetArray[i][6]
	local PetGrade = tonumber(GetGrade(i))
	local PetType = tonumber(data_tool(i, PET_TYPE, PET_BONUS, PET_READ))
	local bon1 = tonumber(data_tool(i, PET_BON1, PET_BONUS, PET_READ))
	local bon2 = tonumber(data_tool(i, PET_BON2, PET_BONUS, PET_READ))
	local bon3 = tonumber(data_tool(i, PET_BON3, PET_BONUS, PET_READ))
	local bon4 = tonumber(data_tool(i, PET_BON4, PET_BONUS, PET_READ))
	if check == 0 then
		while true do
			say_title(" Evcil Hayvan ")
			say(" Merhaba,")
			say(" Burada Evcil Hayvaninin Yetene?ni Se?bilirsin. ")
			say(" Konu Hakk?da Bilgin Yoksa Bilgi Kismindan, ")
			say(" Bakabilirsin. ")
			local z = select( "Ofansif","Defans","Bilgi","Kapat")
			if z == 1 then
				PetSet(i, z)
				return
			elseif z == 2 then
				PetSet(i, z)
				return
			elseif z == 3 then
				while true do
					say_title(" Evcil Hayvan ")
					say("")
					say(" 4 Farkli Yetenek S???Vard?, ")
					say(" Sald??Stiline Ba??Olarak. ")
					say("")
					local x = select( "Ofansif Stil","Defansif Stil"," Geri D? ")
					if x == 1 then
						PetInfo(x)
					elseif x == 2 then
						PetInfo(x)
					elseif x == 3 then
						break
					end
				end
			elseif z == 4 then
				break
			end
		end
	else
		say_title(" Evcil Hayvan ")
		say("")
		say_reward(" Ne Yapmak ?tiyorsun? ")
		say("")
		local y = select(" Mevcut Yetenekler "," Yetenek S??la "," Geri D? ")
		if y == 1 then
			local point = {}
			local p = 1
			while true do
				if status[p] == nil then break end
				point[p] = status[p]*PetGrade
				p = p + 1
			end
			say_title(" Evcil Hayvan ")
			say(" Mevcut ?ellikleri: ")
			say("")
			say_reward(" Statlar? ")
			say("VIT:  +"..point[1])
			say("INT:  +"..point[2])
			say("STR:  +"..point[3])
			say("DEX:  +"..point[4])
			say("")
			say_reward(" Yetenekleri: ")
			say(PetBonus[PetType][2][bon1]..":  +"..PetGrade)
			say(PetBonus[PetType][3][bon2]..":  +"..PetGrade)
			say(PetBonus[PetType][4][bon3]..":  +"..PetGrade)
			say(PetBonus[PetType][5][bon4]..":  +"..PetGrade)
		elseif y == 2 then
			say_title(" Evcil Hayvan ")
			say(" Yetene?ni S??lamak ?tedi?nden Eminmisin?")
			say(" E?r ?leysen Se?ek ?tedi?n Yetene? Se?")
			local j = select(" Ofansif Stil "," Defansif Stil "," Geri D? ")
			if j == 1 then
				PetSet(i, j)
			elseif j == 2 then
				PetSet(i, j)
			else
				return
			end
		elseif y == 3 then
			return
		end
	end
end


function show_pet_menu(i)
	local PetName = data_tool(i, PET_NAME, PET_DATA, PET_READ)
	local PetRace = PetArray[i][3]
	local PetFood = PetArray[i][4]
	local PetGrade = tonumber(GetGrade(i))
	local PetLevel = tonumber(data_tool(i, PET_LEVEL, PET_DATA, PET_READ))
	local PetExp = tonumber(data_tool(i, PET_EXP, PET_DATA, PET_READ))
	local PetNextExp = PetArray[i][5][PetLevel]
	while true do
		say_title(" Evcil Hayvan ")
		say("")
		say(" Ne Yapmak ?tiyorsun? ")
		say("")
		local s = select(" Pet ?ellikleri ", " Peti Besle ", " Pet Yetenekleri ", " Di?r ", " Kapat " )
		if s == 4 then
			say_title(" Evcil Hayvan ")
			say("")
			say(" Ne Yapmak ?tiyorsun? ")
			say("")
			local z = select( " ?im Ver ", " G?der ", " Geri D? ", " Kapat " )
			if z == 1 then
				say_title(" Evcil Hayvan ")
				say("")
				say(" Evcil Hayvan?a Hangi ?mi Vermek ?tiyorsun? ")
				say("")
				say_reward("?im :")
				local PetNewName = tostring(input())
				if PetNewName == "" then
					say_title(" Evcil Hayvan ")
					say("")
					say_reward(" Boþ B?akamazs?! ")
					return
				end
				if PetNewName == nome then
					say_title(" Evcil Hayvan ")
					say("")
					say_reward(" Ayn??mi Veremezsin! ")
					return
				end
				data_tool(i, PetNewName.."\n"..PetLevel.."\n"..PetExp.."\n", PET_DATA, PET_WRITE)
				evoca(i, PET_UNSUMMON)
				evoca(i, PET_SUMMON)
				return
			elseif z == 2 then
				evoca(i, PET_UNSUMMON)
				return
			elseif z == 3 then
			elseif z == 4 then
				break
			end
		elseif s == 1 then
			say_title(" Evcil Hayvan ")
			say("")
			say(" ?im: "..PetName.." ")
			say(" S??: "..PetRace.." ")
			say(" Level: "..PetLevel.." ")
			say(" Yetenek Seviyesi: "..PetGrade.." ")
			say(" Exp: "..PetExp.." / "..PetNextExp.." ")
			say(" Sa??: "..horse.get_health_pct().."% ")
			say(" Dayan?l??: "..horse.get_stamina_pct().."% ")
			say(" Yeme?: "..item_name(PetFood).." ")
			return
		elseif s == 2 then
			if pc.countitem(PetFood) > 0 then
				say_title(" Evcil Hayvan ")
				say("")
				say(" Evcil Hayvan? Art? Karn?Tok ")
				pc.removeitem(PetFood, 1)
				horse.feed()
				return
			else
				say_title(" Evcil Hayvan ")
				say("")
				say(" Evcil Hayvan? Beslemek Ýçin "..item_name(PetFood).." Adl?")
				say(" Yeme? Sahip Olmal??. ")
				say("")
				return
			end
		elseif s == 3 then
			if PetLevel >= 10 then
				PetMenuAbi(i)
				return
			else
				say_title(" Evcil Hayvan ")
				say("")
				say_reward(" Yetenekler 10 Level ?t?Evcil Hayvanlar Ýçindir ")
				return
			end
		elseif s == 5 then
			break
		end
	end
end


function PetGiveExp(i, Point)
	local PetName = data_tool(i, PET_NAME, PET_DATA, PET_READ)
	local PetLevel = tonumber(data_tool(i, PET_LEVEL, PET_DATA, PET_READ))
	local PetExp = tonumber(data_tool(i, PET_EXP, PET_DATA, PET_READ))
	local PetNextExp = PetArray[i][5][PetLevel]
	if PetLevel == 150 then
		return
	end
	local PetNewExp = PetExp + Point
	while true do
		if PetNewExp < PetNextExp then break end
		PetNewExp = PetNewExp - PetNextExp
		PetLevel = PetLevel + 1
	end
	data_tool(i, PetName.."\n"..PetLevel.."\n"..PetNewExp.."\n", PET_DATA, PET_WRITE)
end


function data_tool(i, linea, tipo, modo)
	local DATA_PATH = "locale/turkey/quest/object/pet//"
	local LOCAL_PATH = pc.get_name().."/"
	local x = 1
	local file = ""
	local PET_FILE = ""
	local PET_BACKUP = ""
	if tipo == PET_DATA then
		PET_FILE = PetArray[i][2]..".txt"
		PET_BACKUP = PetArray[i][2]..".bak"
	elseif tipo == PET_BONUS then
		PET_FILE = PetArray[i][2].."_bonus.txt"
		PET_BACKUP = PetArray[i][2].."_bonus.bak"
	end
	if modo == PET_READ then
		file = io.open(DATA_PATH..LOCAL_PATH..PET_FILE, "r")
		while true do
			local line = file:read("*l")
			if line == nil then 
				break 
			end
			text = string.gsub(line, "\n", "")
			if x == linea then 
				io.close(file)
				return text
			end
			x = x + 1
		end
		io.close(file)
	elseif modo == PET_WRITE then
		os.execute("cd "..DATA_PATH..LOCAL_PATH.." && mv "..PET_FILE.." "..PET_BACKUP)
		file = io.open(DATA_PATH..LOCAL_PATH..PET_FILE, "w")
		file:write(linea)
		io.close(file)
		os.execute("cd "..DATA_PATH..LOCAL_PATH.." && chmod 777 "..PET_FILE)
	end
end

get_mob_level =
    {
        [2051] = 65,
        [2052] = 67,
        [2053] = 69,
        [2054] = 71,
        [2055] = 73,
        [11116] = 90,
        [2061] = 60,
        [2062] = 62,
        [2063] = 64,
        [2064] = 66,
        [2065] = 68,
        [2071] = 70,
        [2072] = 72,
        [2073] = 74,
        [2074] = 76,
        [2075] = 78,
        [2076] = 78,
        [11117] = 90,
        [2091] = 60,
        [2092] = 79,
        [2093] = 65,
        [2094] = 72,
        [2095] = 70,
        [2101] = 19,
        [2102] = 37,
        [2103] = 39,
        [2104] = 44,
        [2105] = 47,
        [2106] = 48,
        [2107] = 51,
        [2108] = 54,
        [5131] = 22,
        [2401] = 87,
        [5132] = 25,
        [2402] = 89,
        [5133] = 27,
        [2131] = 60,
        [2132] = 62,
        [2133] = 64,
        [2134] = 66,
        [2135] = 68,
        [101] = 1,
        [102] = 3,
        [103] = 4,
        [2152] = 37,
        [105] = 9,
        [106] = 13,
        [107] = 16,
        [108] = 7,
        [109] = 10,
        [110] = 12,
        [111] = 15,
        [112] = 19,
        [113] = 21,
        [114] = 18,
        [115] = 24,
        [5141] = 35,
        [131] = 8,
        [132] = 9,
        [133] = 11,
        [134] = 14,
        [135] = 18,
        [136] = 21,
        [137] = 12,
        [138] = 15,
        [139] = 17,
        [140] = 20,
        [141] = 24,
        [142] = 26,
        [143] = 24,
        [144] = 29,
        [151] = 9,
        [152] = 16,
        [153] = 10,
        [154] = 21,
        [2203] = 70,
        [2204] = 71,
        [2205] = 72,
        [2206] = 73,
        [2207] = 78,
        [171] = 1,
        [172] = 3,
        [173] = 4,
        [174] = 6,
        [175] = 9,
        [2224] = 71,
        [177] = 16,
        [178] = 7,
        [179] = 10,
        [180] = 12,
        [181] = 15,
        [182] = 19,
        [183] = 21,
        [184] = 18,
        [185] = 24,
        [2234] = 71,
        [2235] = 72,
        [191] = 30,
        [192] = 31,
        [193] = 33,
        [194] = 35,
        [5153] = 49,
        [5157] = 54,
        [2291] = 75,
        [2292] = 99,
        [2293] = 99,
        [5161] = 30,
        [2301] = 65,
        [2302] = 67,
        [2303] = 69,
        [2304] = 70,
        [2305] = 71,
        [2306] = 84,
        [2307] = 86,
        [2311] = 74,
        [2312] = 76,
        [2313] = 77,
        [2314] = 80,
        [2315] = 82,
        [301] = 18,
        [302] = 20,
        [303] = 25,
        [304] = 25,
        [8501] = 35,
        [8502] = 30,
        [8503] = 25,
        [8504] = 5,
        [8505] = 10,
        [8506] = 12,
        [8507] = 15,
        [8508] = 20,
        [8509] = 25,
        [8510] = 21,
        [8511] = 11,
        [331] = 18,
        [332] = 20,
        [333] = 25,
        [334] = 25,
        [351] = 18,
        [352] = 20,
        [353] = 25,
        [354] = 25,
        [2403] = 89,
        [2404] = 90,
        [2411] = 91,
        [2412] = 93,
        [2413] = 95,
        [2414] = 97,
        [2451] = 84,
        [5127] = 54,
        [2452] = 86,
        [2431] = 80,
        [2432] = 82,
        [2433] = 82,
        [2434] = 83,
        [2454] = 90,
        [391] = 23,
        [392] = 26,
        [393] = 28,
        [394] = 31,
        [395] = 23,
        [396] = 26,
        [397] = 28,
        [398] = 31,
        [401] = 26,
        [402] = 27,
        [403] = 29,
        [404] = 30,
        [405] = 33,
        [406] = 35,
        [8600] = 73,
        [8601] = 86,
        [8602] = 73,
        [8603] = 86,
        [8604] = 73,
        [8605] = 86,
        [8606] = 73,
        [8607] = 86,
        [8608] = 73,
        [8609] = 86,
        [8610] = 73,
        [8611] = 86,
        [8612] = 73,
        [8613] = 86,
        [8614] = 73,
        [8615] = 86,
        [8616] = 86,
        [11108] = 70,
        [431] = 31,
        [432] = 33,
        [433] = 35,
        [434] = 36,
        [435] = 38,
        [436] = 40,
        [2491] = 93,
        [2492] = 95,
        [2493] = 97,
        [2494] = 88,
        [2495] = 90,
        [451] = 26,
        [452] = 27,
        [453] = 29,
        [454] = 30,
        [455] = 33,
        [456] = 35,
        [2505] = 83,
        [2506] = 84,
        [2507] = 85,
        [2508] = 79,
        [2509] = 80,
        [2510] = 81,
        [2511] = 82,
        [2512] = 83,
        [2513] = 84,
        [2514] = 86,
        [1175] = 65,
        [491] = 32,
        [492] = 37,
        [493] = 39,
        [494] = 45,
        [2543] = 81,
        [2544] = 82,
        [2545] = 83,
        [2546] = 84,
        [2547] = 86,
        [501] = 29,
        [502] = 32,
        [503] = 35,
        [504] = 36,
        [531] = 35,
        [532] = 37,
        [533] = 40,
        [534] = 42,
        [2591] = 89,
        [2592] = 89,
        [2593] = 89,
        [2594] = 89,
        [2595] = 89,
        [2596] = 89,
        [2597] = 91,
        [2598] = 91,
        [551] = 29,
        [552] = 32,
        [553] = 35,
        [554] = 36,
        [2482] = 92,
        [2483] = 94,
        [2484] = 96,
        [5134] = 29,
        [591] = 42,
        [595] = 42,
        [601] = 26,
        [602] = 29,
        [603] = 31,
        [604] = 33,
        [2151] = 19,
        [104] = 6,
        [631] = 34,
        [632] = 36,
        [633] = 39,
        [634] = 40,
        [635] = 44,
        [636] = 46,
        [637] = 49,
        [2155] = 47,
        [2156] = 48,
        [651] = 34,
        [652] = 36,
        [653] = 39,
        [654] = 40,
        [2157] = 51,
        [656] = 46,
        [657] = 49,
        [2158] = 54,
        [2501] = 79,
        [2502] = 80,
        [2503] = 81,
        [5001] = 10,
        [2504] = 82,
        [691] = 50,
        [692] = 55,
        [693] = 60,
        [701] = 35,
        [702] = 38,
        [703] = 41,
        [704] = 44,
        [705] = 48,
        [706] = 49,
        [707] = 51,
        [731] = 52,
        [732] = 53,
        [733] = 54,
        [734] = 54,
        [735] = 55,
        [736] = 56,
        [737] = 57,
        [751] = 35,
        [752] = 38,
        [753] = 41,
        [754] = 44,
        [755] = 48,
        [756] = 49,
        [757] = 51,
        [771] = 52,
        [772] = 53,
        [773] = 54,
        [774] = 54,
        [775] = 55,
        [776] = 56,
        [777] = 57,
        [7050] = 35,
        [2481] = 91,
        [791] = 54,
        [792] = 62,
        [793] = 64,
        [794] = 72,
        [795] = 54,
        [796] = 62,
        [7051] = 31,
        [7001] = 52,
        [7002] = 53,
        [2191] = 67,
        [7004] = 54,
        [7005] = 55,
        [7006] = 56,
        [7007] = 56,
        [7008] = 52,
        [2192] = 72,
        [7010] = 54,
        [11107] = 70,
        [7012] = 52,
        [7013] = 53,
        [7014] = 54,
        [7015] = 54,
        [7016] = 55,
        [7017] = 56,
        [7018] = 56,
        [7019] = 59,
        [7020] = 59,
        [7021] = 60,
        [7022] = 61,
        [7023] = 62,
        [7024] = 64,
        [7025] = 66,
        [7026] = 67,
        [7027] = 70,
        [7028] = 72,
        [7029] = 35,
        [7030] = 31,
        [7031] = 33,
        [7032] = 35,
        [7033] = 36,
        [7034] = 38,
        [7035] = 40,
        [7036] = 52,
        [7037] = 53,
        [7038] = 54,
        [7039] = 54,
        [7040] = 55,
        [7041] = 56,
        [7042] = 57,
        [7043] = 81,
        [7044] = 81,
        [901] = 49,
        [902] = 51,
        [903] = 53,
        [904] = 55,
        [905] = 58,
        [906] = 58,
        [907] = 59,
        [5004] = 80,
        [5005] = 85,
        [7054] = 36,
        [2541] = 79,
        [7056] = 40,
        [7057] = 52,
        [7058] = 53,
        [7059] = 54,
        [7060] = 54,
        [2542] = 80,
        [7062] = 56,
        [2201] = 69,
        [7064] = 81,
        [7065] = 81,
        [7066] = 82,
        [7067] = 83,
        [7068] = 83,
        [2202] = 69,
        [7070] = 85,
        [7071] = 33,
        [7072] = 35,
        [7073] = 36,
        [7074] = 38,
        [155] = 24,
        [932] = 51,
        [933] = 53,
        [934] = 55,
        [935] = 58,
        [936] = 58,
        [937] = 59,
        [7082] = 83,
        [7083] = 83,
        [7084] = 84,
        [7085] = 85,
        [7086] = 35,
        [7087] = 36,
        [7088] = 38,
        [7089] = 40,
        [7090] = 54,
        [7091] = 55,
        [7092] = 56,
        [7093] = 57,
        [7094] = 83,
        [7095] = 83,
        [7096] = 84,
        [7097] = 85,
        [991] = 59,
        [992] = 60,
        [993] = 61,
        [1001] = 57,
        [1002] = 58,
        [1003] = 59,
        [1004] = 60,
        [5101] = 22,
        [5102] = 25,
        [5103] = 27,
        [5104] = 29,
        [5111] = 35,
        [5112] = 37,
        [5113] = 39,
        [5114] = 40,
        [5115] = 41,
        [5116] = 42,
        [5121] = 45,
        [5122] = 47,
        [5123] = 49,
        [5124] = 52,
        [5125] = 53,
        [5126] = 54,
        [1031] = 67,
        [1032] = 69,
        [1033] = 70,
        [1034] = 71,
        [1035] = 72,
        [1036] = 73,
        [1037] = 71,
        [1038] = 72,
        [1039] = 73,
        [1040] = 74,
        [1041] = 75,
        [2222] = 69,
        [5142] = 37,
        [5143] = 39,
        [5144] = 40,
        [5145] = 41,
        [5146] = 42,
        [2223] = 70,
        [11109] = 70,
        [5151] = 45,
        [5152] = 47,
        [176] = 13,
        [5154] = 52,
        [5155] = 53,
        [5156] = 54,
        [1061] = 67,
        [1062] = 69,
        [1063] = 70,
        [1064] = 71,
        [1065] = 72,
        [1066] = 73,
        [1067] = 71,
        [1068] = 72,
        [1069] = 73,
        [1070] = 74,
        [1071] = 75,
        [2227] = 90,
        [1091] = 75,
        [1092] = 75,
        [1093] = 78,
        [1094] = 75,
        [1095] = 82,
        [1096] = 75,
        [2231] = 69,
        [1101] = 62,
        [1102] = 63,
        [1103] = 64,
        [1104] = 64,
        [1105] = 65,
        [1106] = 66,
        [1107] = 66,
        [2233] = 70,
        [1131] = 81,
        [1132] = 81,
        [1133] = 82,
        [1134] = 83,
        [1135] = 83,
        [1136] = 84,
        [1137] = 85,
        [1151] = 52,
        [1152] = 53,
        [1153] = 54,
        [1154] = 54,
        [1155] = 55,
        [1156] = 56,
        [1157] = 56,
        [2221] = 69,
        [1171] = 62,
        [1172] = 63,
        [1173] = 64,
        [1174] = 64,
        [2153] = 39,
        [1176] = 66,
        [1177] = 66,
        [1191] = 70,
        [1192] = 70,
        [11110] = 70,
        [2154] = 44,
        [11505] = 100,
        [11506] = 100,
        [11507] = 100,
        [11508] = 100,
        [11509] = 100,
        [11510] = 100,
        [2225] = 72,
        [1301] = 57,
        [1302] = 59,
        [1303] = 58,
        [1304] = 75,
        [1305] = 61,
        [1306] = 75,
        [1307] = 80,
        [1308] = 40,
        [1309] = 65,
        [1310] = 95,
        [7045] = 82,
        [7046] = 83,
        [2226] = 60,
        [7047] = 83,
        [7048] = 84,
        [1331] = 57,
        [1332] = 59,
        [1333] = 58,
        [1334] = 75,
        [1335] = 61,
        [5002] = 75,
        [5003] = 1,
        [7052] = 33,
        [11111] = 70,
        [7053] = 35,
        [7055] = 38,
        [1401] = 66,
        [1402] = 73,
        [1403] = 77,
        [7061] = 55,
        [7003] = 54,
        [7063] = 57,
        [5162] = 43,
        [7069] = 84,
        [5163] = 55,
        [931] = 49,
        [7076] = 54,
        [2232] = 69,
        [1501] = 69,
        [1502] = 72,
        [1503] = 76,
        [7078] = 55,
        [7079] = 56,
        [7080] = 57,
        [7081] = 82,
        [7075] = 40,
        [11100] = 50,
        [7077] = 54,
        [7009] = 53,
        [1601] = 68,
        [1602] = 70,
        [1603] = 75,
        [11101] = 50,
        [11102] = 50,
        [11113] = 90,
        [11103] = 50,
        [11104] = 50,
        [7049] = 85,
        [11105] = 50,
        [11106] = 70,
        [655] = 44,
        [1901] = 72,
        [1902] = 77,
        [1903] = 82,
        [1904] = 40,
        [1905] = 65,
        [1906] = 95,
        [11112] = 90,
        [2453] = 88,
        [11114] = 90,
        [2001] = 43,
        [2002] = 45,
        [2003] = 48,
        [2004] = 50,
        [2005] = 52,
        [11115] = 90,
        [2031] = 50,
        [2032] = 52,
        [2033] = 54,
        [2034] = 56,
        [2035] = 58,
        [2036] = 58,
		[3401] = 88,
		[3402] = 89,
		[3403] = 90,
		[3404] = 91,
		[3405] = 92,
		[3501] = 88,
		[3502] = 89,
		[3503] = 90,
		[3504] = 91,
		[3505] = 92,
		[3601] = 88,
		[3602] = 89,
		[3603] = 90,
		[3604] = 91,
		[3605] = 92,
		[3001] = 118,
		[3002] = 119,
		[3003] = 120,
		[3004] = 121,
		[3005] = 122,
		[3201] = 118,
		[3202] = 119,
		[3203] = 120,
		[3204] = 121,
		[3205] = 122,
		[3101] = 138,
		[3102] = 139,
		[3103] = 140,
		[3104] = 141,
		[3105] = 142,
		[3551] = 138,
		[3552] = 139,
		[3553] = 140,
		[3554] = 141,
		[3555] = 142,
		[3701] = 138,
		[3702] = 139,
		[3703] = 140,
		[3704] = 141,
		[3705] = 142,
}


function apply_bonus(i, mode)
	local PetGrade = tonumber(GetGrade(i))
	local a = tonumber(data_tool(i, PET_BON1, PET_BONUS, PET_READ))
	local b = tonumber(data_tool(i, PET_BON2, PET_BONUS, PET_READ))
	local c = tonumber(data_tool(i, PET_BON3, PET_BONUS, PET_READ))
	local d = tonumber(data_tool(i, PET_BON4, PET_BONUS, PET_READ))
	local e = tonumber(data_tool(i, PET_TYPE, PET_BONUS, PET_READ))
	local bon1 = PetBonus[e+2][2][a]
	local bon2 = PetBonus[e+2][3][b]
	local bon3 = PetBonus[e+2][4][c]
	local bon4 = PetBonus[e+2][5][d]
	if mode == PET_SUMMON then
		affect.add_collect(bon1, PetGrade, 60*60*8)
		affect.add_collect(bon2, PetGrade, 60*60*8)
		affect.add_collect(bon3, PetGrade, 60*60*8)
		affect.add_collect(bon4, PetGrade, 60*60*8)
	elseif mode == PET_UNSUMMON then
		affect.remove_collect(bon1, PetGrade, 60*60*8)
		affect.remove_collect(bon2, PetGrade, 60*60*8)
		affect.remove_collect(bon3, PetGrade, 60*60*8)
		affect.remove_collect(bon4, PetGrade, 60*60*8)
	end

end