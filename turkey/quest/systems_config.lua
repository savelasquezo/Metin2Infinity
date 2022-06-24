--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
ACCOUNT_SQL = "account"
PLAYER_SQL = "player"
COMMON_SQL = "common"
LOG_SQL = "log"
WEBLOG_SQL = "web"

SERVER_NAME_BIG = "ARVEN2"
SERVER_NAME_SMALL = "Arven2"
SERVER_SITE = "https://bestproduction-projects.com"
FORUM_SITE = "https://bestproduction-projects.com"
MARKET_SITE = "https://bestproduction-projects.com"
DESTEK_SITE = "https://bestproduction-projects.com"

GUILD_LEVEL_LIMIT = 100
--GUILD_MAX_YANG = 100000000
GUILD_CREATE_ITEM = true
GUILD_CREATE_ITEM_VNUM = 70101

nesne_market_aktif = 1 -- Nesne marketi acmýssanýz 1 yapýn
emek_server = 1

function costum_body()
	local settings = {}
	costum_body_man = {
		--{41100,1}, {41101,1}, {41102,1}, {41103,1}, {41104,1}, {41105,1}, {41106,1}, {41107,1}, {41108,1}, {41109,1},
		{41001,1}, {41003,1}, {41005,1}, {41007,1}, {41009,1}, {41011,1}, {41013,1}, {41015,1}, {41017,1}, {41019,1},
		{41021,1}, {41023,1}, {41025,1}, {41027,1}, {41029,1}, {41031,1}, {41033,1}, {41035,1}, {41037,1}, {41039,1},
		{41041,1}, {41043,1}, {41045,1}, {41047,1}, {41049,1}, {41051,1}, {41053,1},
	}
	costum_body_woman = {
		--{41100,1}, {41101,1}, {41102,1}, {41103,1}, {41104,1}, {41105,1}, {41106,1}, {41107,1}, {41108,1}, {41109,1},
		{41002,1}, {41004,1}, {41006,1}, {41008,1}, {41010,1}, {41012,1}, {41014,1}, {41016,1}, {41018,1}, {41020,1},
		{41022,1}, {41024,1}, {41026,1}, {41028,1}, {41030,1}, {41032,1}, {41034,1}, {41036,1}, {41038,1}, {41040,1}, 
		{41042,1}, {41044,1}, {41046,1}, {41048,1}, {41050,1}, {41052,1}, {41054,1},
	}
end

function costum_hair()
	local settings = {}
	costum_hair_man = {
		{45001,1}, {45003,1}, {45005,1}, {45007,1}, {45009,1}, {45011,1}, {45013,1}, {45014,1}, {45016,1}, {45018,1},
		{45020,1}, {45022,1}, {45024,1}, {45026,1}, {45028,1}, {45030,1}, {45032,1}, {45034,1}, {45036,1}, {45038,1},
		{45040,1}, {45042,1}, {45044,1}, {45046,1}, {45048,1}, {45050,1}, {45052,1}, {45054,1}, {45056,1}, {45058,1},
		{45060,1}, {45062,1}, {45064,1}, {45066,1}, {45067,1}, {45068,1}, {45070,1}, {45072,1},
	}
	costum_hair_woman = {
		{45002,1}, {45004,1}, {45006,1}, {45008,1}, {45010,1}, {45012,1}, {45015,1}, {45017,1}, {45019,1}, {45021,1},
		{45023,1}, {45025,1}, {45027,1}, {45029,1}, {45031,1}, {45033,1}, {45035,1}, {45037,1}, {45039,1}, {45041,1},
		{45043,1}, {45045,1}, {45047,1}, {45049,1}, {45051,1}, {45053,1}, {45055,1}, {45057,1}, {45059,1}, {45061,1},
		{45063,1}, {45065,1}, {45069,1}, {45071,1}, {45073,1},
	}
end

function pets()
	local settings = {}
	pets_table = {
		{53001,1}, {53002,1}, {53003,1}, {53004,1}, {53005,1}, {53006,1}, {53007,1}, {53008,1}, {53009,1}, {53010,1},
		{53011,1}, {53012,1}, {53013,1}, {53014,1},	{53015,1}, {53016,1}, {53017,1}, {53018,1}, {53019,1}, {53020,1}, 
		{53021,1}, {53022,1}, {53023,1}, {53024,1}, {53025,1}, {53026,1}, {53027,1}, {53028,1}, {53029,1}, {53030,1},
		{53031,1}, {53032,1}, {53033,1}, {53034,1},	{53035,1}, {53036,1}, {53037,1}, {53038,1}, {53039,1}, {53040,1},
		{53041,1}, {53042,1}, {53043,1}, {53044,1},	{53045,1}, {53046,1}, {53047,1}, {53048,1},	{53049,1}, {53050,1}, 
		{53051,1}, {53052,1}, {53053,1}, {53054,1},	{53055,1}, {53056,1}, {53057,1}, {53058,1},	{53059,1}, {53060,1},
		{53061,1}, {53062,1}, {53063,1}, {53064,1},	{53065,1}, {53066,1}, {53067,1}, {53068,1}, {53069,1}, {53070,1},
		{53071,1}, {53072,1},
	}
end

function normal_saclar()
	
end

function afro_hair()
	local settings = {}
		warrior_man = {
			{74013,1}, {74014,1}, {74015,1}, {74016,1}, {74017,1}, {74018,1}, {74019,1}
		}
		warrior_woman = {
			{75013,1}, {75014,1}, {75015,1}, {75016,1}, {75017,1}, {75018,1}, {75019,1}
		}
		assasian_man = {
			{75213,1}, {75214,1}, {75215,1}, {75216,1}, {75217,1}, {75218,1}, {75219,1}
		}
		assasian_woman = {
			{74263,1}, {74264,1}, {74265,1}, {74266,1}, {74267,1}, {74268,1}, {74269,1}
		}
		sura_man = {
			{74513,1}, {74514,1}, {74515,1}, {74516,1}, {74517,1}, {74518,1}, {74519,1}
		}
		sura_woman = {
			{75413,1}, {75414,1}, {75415,1}, {75416,1}, {75417,1}, {75418,1}, {75419,1}
		}
		shaman_man = {
			{75613,1}, {75614,1}, {75615,1}, {75616,1}, {75617,1}, {75618,1}, {75619,1}
		}
		shaman_woman = {
			{74763,1}, {74764,1}, {74765,1}, {74766,1}, {74767,1}, {74768,1}, {74769,1}
		}
end

function afro_hair_box()
	local settings = afro_hair()
	if pc.get_job() == 0 then
		if pc.get_sex() == 0 then
			afra_vnum = get_random_vnum_from_table(warrior_man)
		elseif pc.get_sex() == 1 then
			afra_vnum = get_random_vnum_from_table(warrior_woman)
		end
	elseif pc.get_job() == 1 then
		if pc.get_sex() == 0 then
			afra_vnum = get_random_vnum_from_table(assasian_man)
		elseif pc.get_sex() == 1 then
			afra_vnum = get_random_vnum_from_table(assasian_woman)
		end
	elseif pc.get_job() == 2 then
		if pc.get_sex() == 0 then
			afra_vnum = get_random_vnum_from_table(sura_man)
		elseif pc.get_sex() == 1 then
			afra_vnum = get_random_vnum_from_table(sura_woman)
		end
	elseif pc.get_job() == 3 then
		if pc.get_sex() == 0 then
			afra_vnum = get_random_vnum_from_table(shaman_man)
		elseif pc.get_sex() == 1 then
			afra_vnum = get_random_vnum_from_table(shaman_woman)
		end
	end
	pc.give_item2_select(afra_vnum)
	item.log("AFRO_HAIR_BOX", item_name(afra_vnum))
end


function costum_body_1_5_day()
	local settings = costum_body()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_body_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_body_woman)
	end
	
	local sure = number(1,5)
	local remain_time = 86400 * (number(1,sure))
	pc.give_item2_select(costume_vnum)
	item.log("1_5_DAY_COSTUME_BODY_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)

	item.set_value(0, 1, 750)
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 1)
end

function costum_body_7_day()
	local settings = costum_body()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_body_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_body_woman)
	end
	
	local remain_time = 86400 * 7
	pc.give_item2_select(costume_vnum)
	item.log("7_DAY_COSTUME_BODY_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 1500)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 2)
end

function costum_body_15_day()
	local settings = costum_body()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_body_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_body_woman)
	end
	
	local remain_time = 86400 * 15
	pc.give_item2_select(costume_vnum)
	item.log("15_DAY_COSTUME_BODY_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end

function costum_body_30_day()
	local settings = costum_body()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_body_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_body_woman)
	end
	
	local remain_time = 86400 * 30
	pc.give_item2_select(costume_vnum)
	item.log("30_DAY_COSTUME_BODY_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end

function costum_hair_1_5_day()
	local settings = costum_hair()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_hair_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_hair_woman)
	end
	
	local sure = number(1,5)
	local remain_time = 86400 * (number(1,sure))
	pc.give_item2_select(costume_vnum)
	item.log("1_5_DAY_COSTUME_HAIR_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	item.set_value(0, 1, 750)
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 1)
end

function costum_hair_7_day()
	local settings = costum_hair()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_hair_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_hair_woman)
	end
	
	local remain_time = 86400 * 7
	pc.give_item2_select(costume_vnum)
	item.log("7_DAY_COSTUME_HAIR_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 1500)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 2)
end

function costum_hair_15_day()
	local settings = costum_hair()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_hair_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_hair_woman)
	end
	
	local remain_time = 86400 * 15
	pc.give_item2_select(costume_vnum)
	item.log("15_DAY_COSTUME_HAIR_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end

function costum_hair_30_day()
	local settings = costum_hair()
	-- sex = 0 = male
	if pc.get_sex() == 0 then
		costume_vnum = get_random_vnum_from_table(costum_hair_man)
	else
		costume_vnum = get_random_vnum_from_table(costum_hair_woman)
	end
	
	local remain_time = 86400 * 30
	pc.give_item2_select(costume_vnum)
	item.log("30_DAY_COSTUME_HAIR_BOX", item_name(costume_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	local rand1 = number(1,2)
	local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	if (rand2 == 1) then
		item.set_value(2, 15, 10)
	else
		item.set_value(2, 16, 10)
	end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end

function pets_1_day()
	local settings = pets()
	
	pets_vnum = 53042

	local remain_time = 86400 * 1
	pc.give_item2_select(pets_vnum)
	item.set_socket(0, get_global_time() + remain_time)
	
	item.set_value(0, 43, 20)
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 4)
end

function pets_1_5_day()
	local settings = pets()
	
	pets_vnum = get_random_vnum_from_table(pets_table)
	
	local sure = number(1,5)
	local remain_time = 86400 * (number(1,sure))
	pc.give_item2_select(pets_vnum)
	item.log("1_5_DAY_PET_BOX", item_name(pets_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	item.set_value(0, 1, 750)
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 1)
end

function pets_7_day()
	local settings = pets()

	pets_vnum = get_random_vnum_from_table(pets_table)

	local remain_time = 86400 * 7
	pc.give_item2_select(pets_vnum)
	item.log("7_DAY_PET_BOX", item_name(pets_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	--local rand2 = number(1,2)
	item.set_value(0, 1, 1500)
	item.set_value(1, 17, 10)
	--if (rand2 == 1) then
	--	item.set_value(2, 15, 10)
	--else
	--	item.set_value(2, 16, 10)
	--end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 2)
end

function pets_15_day()
	local settings = pets()
	
	pets_vnum = get_random_vnum_from_table(pets_table)
	
	local remain_time = 86400 * 15
	pc.give_item2_select(pets_vnum)
	item.log("15_DAY_PET_BOX", item_name(pets_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	--local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	--if (rand2 == 1) then
	--	item.set_value(2, 15, 10)
	--else
	--	item.set_value(2, 16, 10)
	--end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end

function pets_30_day()
	local settings = pets()
	
	pets_vnum = get_random_vnum_from_table(pets_table)
	
	local remain_time = 86400 * 30
	pc.give_item2_select(pets_vnum)
	item.log("30_DAY_PET_BOX", item_name(pets_vnum))
	item.set_socket(0, get_global_time() + remain_time)
	
	--local rand2 = number(1,2)
	item.set_value(0, 1, 2000)
	item.set_value(1, 17, 10)
	--if (rand2 == 1) then
	--	item.set_value(2, 15, 10)
	--else
	--	item.set_value(2, 16, 10)
	--end
	item.set_value(8, 0, remain_time/86400)
	item.set_value(9, 0, 3)
end


