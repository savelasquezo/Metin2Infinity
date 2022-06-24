--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
dofile('locale/turkey/quest/questing.lua')
dofile('locale/turkey/quest/questlib_extra.lua')
dofile('locale/turkey/quest/questlib_plus.lua')
guildstorage_path = "/usr/game/share/locale/turkey/quest/BESTProduction/Guildstorage/"
dofile('locale/turkey/quest/systems_config.lua')
dofile(get_locale_base_path().."/quest/events_mgr_text.lua")
dofile(get_locale_base_path().."/quest/dungeonLib.lua")
CONFIRM_NO = 0
CONFIRM_YES = 1
CONFIRM_OK = 1
CONFIRM_TIMEOUT = 2

MALE = 0
FEMALE = 1

siralama = {}
loncasiralamasi = {}
kirmiziejder = {}
ejder = {}
barones = {}
nemere = {}
razador = {}
azrail = {}
lusifer = {}
meley = {}

item3 = {}

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

function split(str, delim, maxNb)
    if str == nil then return str end
    if string.find(str, delim) == nil then return { str } end
    if maxNb == nil or maxNb < 1 then maxNb = 0 end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    if nb ~= maxNb then result[nb + 1] = string.sub(str, lastPos) end
    return result
end

mysql_query = function(query)
	local version = 55
    if not pre then
        local rt = io.open('CONFIG','r'):read('*all')
        pre,_= string.gsub(rt,'.+PLAYER_SQL:%s(%S+)%s(%S+)%s(%S+)%s(%S+).+','-h%1 -u%2 -p%3 -D%4')
    end
    math.randomseed(os.time())
    local fi,t,out = 'mysql_data_'..math.random(10^9)+math.random(2^4,2^10),{},{}
	if version == 51 then
		os.execute('mysql '..pre..' --e='..string.format('%q',query)..' > '..fi)
	elseif version == 55 then
		os.execute('mysql '..pre..' -e'..string.format('%q',query)..' > '..fi)
	else
		return 0
	end
    for av in io.open(fi,'r'):lines() do table.insert(t,split(av,'\t')) end; os.remove(fi);
    for i = 2, table.getn(t) do table.foreach(t[i],function(a,b)
        out[i-1]               = out[i-1] or {}
        out[i-1][a]            = tonumber(b) or b or 'NULL'
        out[t[1][a]]           = out[t[1][a]] or {}
        out[t[1][a]][i-1]      = tonumber(b) or b or 'NULL'
    end) end
    out.__lines = t[1]
    return out
end

function item3.get_attr(var)
 return item.get_attr_type(var),item.get_attr_value(var)
end

guildstorage_path = "locale/turkey/quest/BESTProduction/sistemler/"

function getinput(par)
	cmdchat("getinputbegin")
	local ret = input(cmdchat(par))
	cmdchat("getinputend")
	return ret
end

GLOBAL_INGAME_RANGLISTEN_VARIABLE = {}

--quest.create = function(f) return coroutine.create(f) end
--quest.process = function(co,args) return coroutine.resume(co, args) end
setstate = q.setstate
newstate = q.setstate

q.set_clock = function(name, value) q.set_clock_name(name) q.set_clock_value(value) end
q.set_counter = function(name, value) q.set_counter_name(name) q.set_counter_value(value) end
c_item_name = function(vnum) return ("[ITEM value;"..vnum.."]") end
c_mob_name = function(vnum) return ("[MOB value;"..vnum.."]") end

-- d.set_folder = function (path) raw_script("[SET_PATH path;"..path.."]") end
-- d.set_folder = function (path) path.show_cinematic("[SET_PATH path;"..path.."]") end
-- party.run_cinematic = function (path) party.show_cinematic("[RUN_CINEMATIC value;"..path.."]") end

newline = "[ENTER]"
function color256(r, g, b) return "[COLOR r;"..(r/255.0).."|g;"..(g/255.0).."|b;"..(b/255.0).."]" end
function color(r,g,b) return "[COLOR r;"..r.."|g;"..g.."|b;"..b.."]" end
function delay(v) return "[DELAY value;"..v.."]" end
function setcolor(r,g,b) raw_script(color(r,g,b)) end
function setdelay(v) raw_script(delay(v)) end
function resetcolor(r,g,b) raw_script("[/COLOR]") end
function resetdelay(v) raw_script("[/DELAY]") end
function say_blue(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_red(name) say(color256(210, 105, 30)..name..color256(196, 196, 196)) end
function say_green(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_black(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_white(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_yellow(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_blue2(name) say(color256(0, 206, 209)..name..color256(0, 206, 209)) end
function chat_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end

function say_light_yellow(name) say(color256(255,255,128)..name..color256(196, 196, 196)) end
function say_acik_mavi(name) say(color256(0, 255, 255)..name..color256(196, 196, 196)) end
function say_orange(name) say(color256(255,191,24)..name..color256(196, 196, 196)) end
function say_light_blue(name) say(color256(130, 192, 255)..name..color256(196, 196, 196)) end
function say_light_green(name) say(color256(112, 233, 112)..name..color256(196, 196, 196)) end
function say_light_kahverengi(name) say(color256(210, 105, 30)..name..color256(196, 196, 196)) end
function say_dark_orange(name) say(color256(255, 140, 0)..name..color256(196, 196, 196)) end
function say_aqua(name) say(color256(0, 255, 255)..name..color256(196, 196, 196)) end
function say_crimson(name) say(color256(220, 20, 60)..name..color256(196, 196, 196)) end

function say_kingdom_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end
function say_kingdom_yellow(name) say(color256(255, 215, 0)..name..color256(196, 196, 196)) end
function say_kingdom_blue(name) say(color256(16, 78, 139)..name..color256(196, 196, 196)) end

function say_alert(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end
function say_gm(name) say(color256(238, 201, 0)..name..color256(196, 196, 196)) end
function say_gm_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end

function say_help_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_help(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_help_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_event_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_event(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_event_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function chat_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
lonca_skor_bilgi = {}
kufur_list = {}
hapistekiler = {}

function trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end

-- minimap¿¡ µ¿±×¶ó¹Ì Ç¥½Ã
function addmapsignal(x,y) raw_script("[ADDMAPSIGNAL x;"..x.."|y;"..y.."]") end

-- minimap µ¿±×¶ó¹Ìµé ¸ðµÎ Å¬¸®¾î
function clearmapsignal() raw_script("[CLEARMAPSIGNAL]") end

-- Å¬¶óÀÌ¾ðÆ®¿¡¼­ º¸¿©ÁÙ ´ëÈ­Ã¢ ¹è°æ ±×¸²À» Á¤ÇÑ´Ù.
function setbgimage(src) raw_script("[BGIMAGE src;") raw_script(src) raw_script("]") end

-- ´ëÈ­Ã¢¿¡ ÀÌ¹ÌÁö¸¦ º¸¿©ÁØ´Ù.
function addimage(x,y,src) raw_script("[IMAGE x;"..x.."|y;"..y) raw_script("|src;") raw_script(src) raw_script("]") end

function makequestbutton(name)
	raw_script("[QUESTBUTTON idx;")
	raw_script(""..q.getcurrentquestindex()) 
	raw_script("|name;")
	raw_script(name) raw_script("]")
end

function make_quest_button_ex(name, icon_type, icon_name)
	test_chat(icon_type)
	test_chat(icon_name)
	raw_script("[QUESTBUTTON idx;")
	raw_script(""..q.getcurrentquestindex()) 
	raw_script("|name;")
	raw_script(name)
	raw_script("|icon_type;")
	raw_script(icon_type)
	raw_script("|icon_name;")
	raw_script(icon_name)
	raw_script("]")
end

function make_quest_button(name) makequestbutton(name) end

function send_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) set_skin(NOWINDOW) q.set_title(name) q.set_icon(icon_name) q.start() end
function resend_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) q.set_title(name) q.set_icon(icon_name) q.start() end
function resend_letter(title) makequestbutton(title) q.set_title(title) q.start() end
function send_letter(name) makequestbutton(name) set_skin(NOWINDOW) q.set_title(name) q.start() end
function clear_letter() q.done() end

function send_letter_blue(name) send_letter_ex(name, "ex", "scroll_open_blue.tga") end
function send_letter_golden(name) send_letter_ex(name, "ex", "scroll_open_golden.tga") end
function send_letter_green(name) send_letter_ex(name, "ex", "scroll_open_green.tga") end
function send_letter_purple(name) send_letter_ex(name, "ex", "scroll_open_purple.tga") end

function send_letter_blue_blink(name) send_letter_ex(name, "blink,ex", "scroll_open_blue.tga") end
function send_letter_golden_blink(name) send_letter_ex(name, "blink,ex", "scroll_open_golden.tga") end
function send_letter_green_blink(name) send_letter_ex(name, "blink,ex", "scroll_open_green.tga") end
function send_letter_purple_blink(name) send_letter_ex(name, "blink,ex", "scroll_open_purple.tga") end

function send_letter_blue_text(name) send_letter_ex(name, "blue,ex", "scroll_open_blue.tga") end
function send_letter_golden_text(name) send_letter_ex(name, "golden,ex", "scroll_open_golden.tga") end
function send_letter_green_text(name) send_letter_ex(name, "green,ex", "scroll_open_green.tga") end
function send_letter_purple_text(name) send_letter_ex(name, "purple,ex", "scroll_open_purple.tga") end

function send_letter_blue_blink_text(name) send_letter_ex(name, "blink,blue,ex", "scroll_open_blue.tga") end
function send_letter_golden_blink_text(name) send_letter_ex(name, "blink,golden,ex", "scroll_open_golden.tga") end
function send_letter_green_blink_text(name) send_letter_ex(name, "blink,green,ex", "scroll_open_green.tga") end
function send_letter_purple_blink_text(name) send_letter_ex(name, "blink,purple,ex", "scroll_open_purple.tga") end

function say_title(name) say(color256(255, 230, 186)..name..color256(196, 196, 196)) end
function say_reward(name) say(color256(255, 200, 200)..name..color256(196, 196, 196)) end
function say_blue(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_blekit(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_red(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_green(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_black(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_white(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_yellow(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_blue2(name) say(color256(0, 206, 209)..name..color256(0, 206, 209)) end 

function note(text)
    notice_all('|>~ '..text)
end

function genel_veri(gelen_miktar)   
    gelen2 = tostring(gelen_miktar)   
    local gelen = gelen_miktar    
    local sayac = 10   
    local basamak = 1   
    local ilkhal = basamak   
    while true do   
        if gelen / sayac >= 1 then   
            basamak = basamak + 1   
            sayac = sayac * 10   
        else   
            break   
        end   
    end   
    t = {}   
    sonucText = ""   
    for i=1, string.len(gelen2) do   
        t[i]= (string.sub(gelen2,i,i))   
    end   
    for k , v in pairs(t) do--1324   
        if (basamak  == 9 or basamak == 6 or basamak == 3) and sonucText !=  "" then   
            sonucText = sonucText.."."   
            sonucText = sonucText..v   
        else   
            sonucText = sonucText..v   
        end   
        basamak = basamak - 1   
    end   
    return sonucText   
end

function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if str == nil then
        return str
    end
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end
function getn2(list)
    local i = 0
    table.foreachi(list, function(a,b) i = i+1 end)
    return i
end
function join(delimiter, list)
  local len = getn(list)
  if len == 0 then 
    return "" 
  end
  local string = list[1]
  for i = 2, len do 
    string = string .. delimiter .. list[i] 
  end
  return string
end

function is_table(var)
    if (type(var) == "table") then
        return true
    else
        return false
    end
end
function is_number(var)
    if (type(var) == "number") then
        return true
    else
        return false
    end
end
function is_string(var)
    if (type(var) == "string") then
        return true
    else
        return false
    end
end

function in_table ( e, t )
    for _,v in pairs(t) do
        if (v==e) then 
            return true 
        end
    end
    return false
end
function in_text(str,te)
    for i = 0,string.len(str) do
        if string.sub(str, i,i+string.len(te)-1) == te then
            return i
        end
    end
    return -1
end
function machweg(str,weg)
    while in_text(str,weg) == true do
        for i = 0,string.len(str) do
            if string.sub(str, i,i+string.len(weg)-1) == weg then
                str = string.sub(str,0,i-1)..string.sub(str,i+string.len(weg),string.len(str))
            end
        end
    end
    return str
end

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

function numlen(num)
    return string.len(tostring(num))
end

function delay_s(delay)
    delay = delay or 1
    local time_to = os.time() + delay
    while os.time() < time_to do end
end
function distance(x1,y1,x2,y2)

    dx=x2-x1
    dy=y2-y1
 
    dist=math.sqrt(math.pow(dx,2)+math.pow(dy,2))
 
    return dist
end


function makereadonly(t)
    -- the metatable
    local mt = { __index = t,
                 __newindex = function(t, k, v)
                     error("trying to modify constant field " .. tostring(k), 2)
                 end
    }
    return setmetatable({}, mt)
end

function allwords ()
   local line = io.read()
   local pos = 1
   return function()
    while line do 
        local s, e = string.find(line, "%w+", pos)
        if s then
            pos = e + 1
            return string.sub(line, s, e)
        else
            line = io.read()
            pos = 1
        end
    end
    return nil
   end
end

function case(wert,...)
arg.n = nil
for _,b in arg do
    if b[1] == wert or b[1] == nil then
        return b[2]()
    end
end
end
function is(n, f)
    return {n, f}
end
function def(f)
    return {nil, f}
end

-- generate when a linebreak in the functions: d.notice,notice,notice_all
function notice_multiline( str , func )
    local p = 0
    local i = 0
    while true do
        i = string.find( str, "%[ENTER%]", i+1 )
        if i == nil then
            if string.len(str) > p then
                func( string.sub( str, p, string.len(str) ) )
            end
            break
        end
        func( string.sub( str, p, i-1 ) )
        p = i + 7
    end
end 

function makequestbutton(name)
    raw_script("[QUESTBUTTON idx;")
    raw_script(""..q.getcurrentquestindex()) 
    raw_script("|name;")
    raw_script(name) raw_script("]")
end

function make_quest_button_ex(name, icon_type, icon_name)
    test_chat(icon_type)
    test_chat(icon_name)
    raw_script("[QUESTBUTTON idx;")
    raw_script(""..q.getcurrentquestindex()) 
    raw_script("|name;")
    raw_script(name)
    raw_script("|icon_type;")
    raw_script(icon_type)
    raw_script("|icon_name;")
    raw_script(icon_name)
    raw_script("]")
end

function make_quest_button(name) makequestbutton(name) end

function send_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) set_skin(NOWINDOW) q.set_title(name) q.set_icon(icon_name) q.start() end
function resend_letter_ex(name, icon_type, icon_name) make_quest_button_ex(name, icon_type, icon_name) q.set_title(name) q.set_icon(icon_name) q.start() end
function resend_letter(title) makequestbutton(title) q.set_title(title) q.start() end

function send_letter(name) makequestbutton(name) setskin(NOWINDOW) q.set_title(name) q.start() end
function clear_letter() q.done() end

function say_title(name) say(color256(255, 230, 186)..name..color256(196, 196, 196)) end
function say_reward(name) say(color256(255, 200, 200)..name..color256(196, 196, 196)) end
function say_blue(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_blekit(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_red(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_green(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_black(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_white(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_yellow(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_blue2(name) say(color256(0, 206, 209)..name..color256(0, 206, 209)) end
function chat_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end

function say_light_yellow(name) say(color256(255,255,128)..name..color256(196, 196, 196)) end
function say_yellow(name) say(color256(255,255,53)..name..color256(196, 196, 196)) end
function say_orange(name) say(color256(255,191,24)..name..color256(196, 196, 196)) end
function say_light_blue(name) say(color256(130, 192, 255)..name..color256(196, 196, 196)) end
function say_red(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end

function say_kingdom_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end
function say_kingdom_yellow(name) say(color256(255, 215, 0)..name..color256(196, 196, 196)) end
function say_kingdom_blue(name) say(color256(16, 78, 139)..name..color256(196, 196, 196)) end

function say_alert(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_gm(name) say(color256(238, 201, 0)..name..color256(196, 196, 196)) end
function say_gm_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end

function say_help_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_help(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_help_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_event_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_event(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_event_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_pc_name() say(pc.get_name()..":") end
function say_size(width, height) say("[WINDOW_SIZE width;"..width.."|height;"..height.."]") end
function setmapcenterposition(x,y)
    raw_script("[SETCMAPPOS x;")
    raw_script(x.."|y;")
    raw_script(y.."]")
end
function say_item(name, vnum, desc)
    say("[INSERT_IMAGE image_type;item|idx;"..vnum.."|title;"..name.."|desc;"..desc.."|index;".. 0 .."|total;".. 1 .."]")
end
function say_show_item(vnum)
    say("[INSERT_IMAGE image_type;item|idx;"..vnum.."|index;".. 0 .."|total;".. 1 .."]")
end
function say_item_vnum(vnum)
    say_item(item_name(vnum), vnum, "")
end
function say_item_vnum_inline(vnum,index,total)
    if index >= total then
        return
    end
    if total > 3 then
        return
    end
    raw_script("[INSERT_IMAGE image_type;item|idx;"..vnum.."|title;"..item_name(vnum).."|desc;".."".."|index;"..index.."|total;"..total.."]")
end
function pc_is_novice()
    if pc.get_skill_group()==0 then
        return true
    else
        return false
    end
end
function pc_get_exp_bonus(exp, text)
    say_reward(text)
    pc.give_exp2(exp)
    set_quest_state("levelup", "run")
end
function pc_get_village_map_index(index)
    return village_map[pc.get_empire()][index]
end
function pc_has_even_id()
    return math.mod(pc.get_player_id(),2) == 0
end

function pc_get_account_id()
    return math.mod(pc.get_account_id(), 2) !=0
end

village_map = {
    {1, 3},
    {21, 23},
    {41, 43},
}

function npc_is_same_empire()
    if pc.get_empire()==npc.empire then
        return true
    else
        return false
    end
end

function npc_get_skill_teacher_race(pc_empire, pc_job, sub_job)
    if 1==sub_job then
        if 0==pc_job then
            return WARRIOR1_NPC_LIST[pc_empire]
        elseif 1==pc_job then
            return ASSASSIN1_NPC_LIST[pc_empire]
        elseif 2==pc_job then
            return SURA1_NPC_LIST[pc_empire]
        elseif 3==pc_job then
            return SHAMAN1_NPC_LIST[pc_empire]
        end	
    elseif 2==sub_job then
        if 0==pc_job then
            return WARRIOR2_NPC_LIST[pc_empire]
        elseif 1==pc_job then
            return ASSASSIN2_NPC_LIST[pc_empire]
        elseif 2==pc_job then
            return SURA2_NPC_LIST[pc_empire]
        elseif 3==pc_job then
            return SHAMAN2_NPC_LIST[pc_empire]
        end	
    end

    return 0
end 


function pc_find_square_guard_vid()
    if pc.get_empire()==1 then 
        return find_npc_by_vnum(11000) 
    elseif pc.get_empire()==2 then
        return find_npc_by_vnum(11002)
    elseif pc.get_empire()==3 then
        return find_npc_by_vnum(11004)
    end
    return 0
end

function pc_find_skill_teacher_vid(sub_job)
    local vnum=npc_get_skill_teacher_race(pc.get_empire(), pc.get_job(), sub_job)
    return find_npc_by_vnum(vnum)
end

function pc_find_square_guard_vid()
    local pc_empire=pc.get_empire()
    if pc_empire==1 then
        return find_npc_by_vnum(11000)
    elseif pc_empire==2 then
        return find_npc_by_vnum(11002)
    elseif pc_empire==3 then
        return find_npc_by_vnum(11004)
    end
end

function npc_is_same_job()
    local pc_job=pc.get_job()
    local npc_vnum=npc.get_race()

    -- test_chat("pc.job:"..pc.get_job())
    -- test_chat("npc_race:"..npc.get_race())
    -- test_chat("pc.skill_group:"..pc.get_skill_group())
    if pc_job==0 then
        if table_is_in(WARRIOR1_NPC_LIST, npc_vnum) then return true end
        if table_is_in(WARRIOR2_NPC_LIST, npc_vnum) then return true end
    elseif pc_job==1 then
        if table_is_in(ASSASSIN1_NPC_LIST, npc_vnum) then return true end
        if table_is_in(ASSASSIN2_NPC_LIST, npc_vnum) then return true end
    elseif pc_job==2 then
        if table_is_in(SURA1_NPC_LIST, npc_vnum) then return true end
        if table_is_in(SURA2_NPC_LIST, npc_vnum) then return true end
    elseif pc_job==3 then
        if table_is_in(SHAMAN1_NPC_LIST, npc_vnum) then return true end
        if table_is_in(SHAMAN2_NPC_LIST, npc_vnum) then return true end
    end

    return false
end

function npc_get_job()
    local npc_vnum=npc.get_race()

    if table_is_in(WARRIOR1_NPC_LIST, npc_vnum) then return COND_WARRIOR_1 end
    if table_is_in(WARRIOR2_NPC_LIST, npc_vnum) then return COND_WARRIOR_2 end
    if table_is_in(ASSASSIN1_NPC_LIST, npc_vnum) then return COND_ASSASSIN_1 end
    if table_is_in(ASSASSIN2_NPC_LIST, npc_vnum) then return COND_ASSASSIN_2 end
    if table_is_in(SURA1_NPC_LIST, npc_vnum) then return COND_SURA_1 end
    if table_is_in(SURA2_NPC_LIST, npc_vnum) then return COND_SURA_2 end
    if table_is_in(SHAMAN1_NPC_LIST, npc_vnum) then return COND_SHAMAN_1 end
    if table_is_in(SHAMAN2_NPC_LIST, npc_vnum) then return COND_SHAMAN_2 end
    return 0

end

function time_min_to_sec(value)
    return 60*value
end

function time_hour_to_sec(value)
    return 3600*value
end

function next_time_set(value, test_value)
    local nextTime=get_time()+value
    if is_test_server() then
        nextTime=get_time()+test_value
    end
    pc.setqf("__NEXT_TIME__", nextTime)
end

function next_time_is_now(value)
    if get_time()>=pc.getqf("__NEXT_TIME__") then
        return true
    else
        return false
    end
end

function table_get_random_item(self)
    return self[number(1, table.getn(self))]
end

function table_is_in(self, test)
    for i = 1, table.getn(self) do
        if self[i]==test then
            return true
        end
    end
    return false
end


function giveup_quest_menu(title)
    local s=select("ÁøÇàÇÑ´Ù", "Æ÷±âÇÑ´Ù")
    if 2==s then 
    say(title.." Äù½ºÆ®¸¦ Á¤¸»·Î")
    say("Æ÷±âÇÏ½Ã°Ú½À´Ï±î?")
    local s=select("³×, ±×·¸½À´Ï´Ù", "¾Æ´Õ´Ï´Ù")
    if 1==s then
        say(title.."Äù½ºÆ®¸¦ Æ÷±âÇß½À´Ï´Ù")
        restart_quest()
    end
    end
end

function restart_quest()
    set_state("start")
    q.done()
end

function complete_quest()
    set_state("__COMPLETE__")
    q.done()
end

function giveup_quest()
    set_state("__GIVEUP__")
    q.done()
end

function complete_quest_state(state_name)
    set_state(state_name)
    q.done()
end

function test_chat(log)
    if is_test_server() then
        chat(log)
    end
end

function bool_to_str(is)
    if is then
        return "true"
    else
        return "false"
    end
end

WARRIOR1_NPC_LIST 	= {20300, 20320, 20340, }
WARRIOR2_NPC_LIST 	= {20301, 20321, 20341, }
ASSASSIN1_NPC_LIST 	= {20302, 20322, 20342, }
ASSASSIN2_NPC_LIST 	= {20303, 20323, 20343, }
SURA1_NPC_LIST 		= {20304, 20324, 20344, }
SURA2_NPC_LIST 		= {20305, 20325, 20345, }
SHAMAN1_NPC_LIST 	= {20306, 20326, 20346, }
SHAMAN2_NPC_LIST 	= {20307, 20327, 20347, }
WOLFMAN1_NPC_LIST	= {20402, 20402, 20402,}
WOLFMAN2_NPC_LIST	= {20402, 20402, 20402,}

function skill_group_dialog(e, j, g) -- e = Á¦±¹, j = Á÷¾÷, g = ±×·ì
    e = 1 -- XXX ¸Þ½ÃÁö°¡ ³ª¶óº°·Î ÀÖ´Ù°¡ ÇÏ³ª·Î ÅëÇÕµÇ¾úÀ½
    

    -- ´Ù¸¥ Á÷¾÷ÀÌ°Å³ª ´Ù¸¥ Á¦±¹ÀÏ °æ¿ì
    if pc.job != j then
        say(locale.skill_group.dialog[e][pc.job][3])
    elseif pc.get_skill_group() == 0 then
        if pc.level < 5 then
            say(locale.skill_group.dialog[e][j][g][1])
            return
        end
        say(locale.skill_group.dialog[e][j][g][2])
        local answer = select(locale.yes, locale.no)

        if answer == 1 then
            --say(locale.skill_group.dialog[e][j][g][2])
            pc.set_skill_group(g)
        else
            --say(locale.skill_group.dialog[e][j][g][3])
        end
    --elseif pc.get_skill_group() == g then
        --say(locale.skill_group.dialog[e][j][g][4])
    --else
        --say(locale.skill_group.dialog[e][j][g][5])
    end
end

function show_horse_menu()
    if horse.is_mine() then			
        say(locale.horse_menu.menu)

        local s = 0
        if horse.is_dead() then
            s = select(locale.horse_menu.revive, locale.horse_menu.ride, locale.horse_menu.unsummon, locale.horse_menu.close)
        else
            s = select(locale.horse_menu.feed, locale.horse_menu.ride, locale.horse_menu.unsummon, locale.horse_menu.close)
        end

        if s==1 then
            if horse.is_dead() then
                horse.revive()
            else
                local food = horse.get_grade() + 50054 - 1
                if pc.countitem(food) > 0 then
                pc.removeitem(food, 1)
                horse.feed()
                else
                say(locale.need_item_prefix..item_name(food)..locale.need_item_postfix);
                end
            end
        elseif s==2 then
            horse.ride()
        elseif s==3 then
            horse.unsummon()
        elseif s==4 then
            -- do nothing
        end
    end
end

npc_index_table = {
    ['race'] = npc.getrace,
    ['empire'] = npc.get_empire,
}

pc_index_table = {
    ['weapon']		= pc.getweapon,
    ['level']		= pc.get_level,
    ['hp']		= pc.gethp,
    ['maxhp']		= pc.getmaxhp,
    ['sp']		= pc.getsp,
    ['maxsp']		= pc.getmaxsp,
    ['exp']		= pc.get_exp,
    ['nextexp']		= pc.get_next_exp,
    ['job']		= pc.get_job,
    ['money']		= pc.getmoney,
    ['gold'] 		= pc.getmoney,
    ['name'] 		= pc.getname,
    ['playtime'] 	= pc.getplaytime,
    ['leadership'] 	= pc.getleadership,
    ['empire'] 		= pc.getempire,
    ['skillgroup'] 	= pc.get_skill_group,
    ['x'] 		= pc.getx,
    ['y'] 		= pc.gety,
    ['local_x'] 	= pc.get_local_x,
    ['local_y'] 	= pc.get_local_y,
}

item_index_table = {
    ['vnum']		= item.get_vnum,
    ['name']		= item.get_name,
    ['size']		= item.get_size,
    ['count']		= item.get_count,
    ['type']		= item.get_type,
    ['sub_type']	= item.get_sub_type,
    ['refine_vnum']	= item.get_refine_vnum,
    ['level']		= item.get_level,
}

guild_war_bet_price_table = 
{
    10000,
    30000,
    50000,
    100000
}

function npc_index(t,i) 
    local npit = npc_index_table
    if npit[i] then
    return npit[i]()
    else
    return rawget(t,i)
    end
end

function pc_index(t,i) 
    local pit = pc_index_table
    if pit[i] then
    return pit[i]()
    else
    return rawget(t,i)
    end
end

function item_index(t, i)
    local iit = item_index_table
    if iit[i] then
    return iit[i]()
    else
    return rawget(t, i)
    end
end

setmetatable(pc,{__index=pc_index})
setmetatable(npc,{__index=npc_index})
setmetatable(item,{__index=item_index})

--coroutineÀ» ÀÌ¿ëÇÑ ¼±ÅÃÇ× Ã³¸®
function select(...)
    return q.yield('select', arg)
end

function select_table(table)
    return q.yield('select', table)
end

-- coroutineÀ» ÀÌ¿ëÇÑ ´ÙÀ½ ¿£ÅÍ ±â´Ù¸®±â
function wait()
    q.yield('wait')
end

function input()
    return q.yield('input')
end

function confirm(vid, msg, timeout)
    return q.yield('confirm', vid, msg, timeout)
end

function select_item()
    setskin(NOWINDOW)
    return q.yield('select_item')
end

--Àü¿ª º¯¼ö Á¢±Ù°ú °ü·ÃµÈ °è¿­
NOWINDOW = 0
NORMAL = 1
CINEMATIC = 2
SCROLL = 3

WARRIOR = 0
ASSASSIN = 1
SURA = 2
SHAMAN = 3
WOLFMAN = 4

COND_WARRIOR_0 = 8
COND_WARRIOR_1 = 16
COND_WARRIOR_2 = 32
COND_WARRIOR = 56

COND_ASSASSIN_0 = 64
COND_ASSASSIN_1 = 128
COND_ASSASSIN_2 = 256
COND_ASSASSIN = 448

COND_SURA_0 = 512
COND_SURA_1 = 1024
COND_SURA_2 = 2048
COND_SURA = 3584

COND_SHAMAN_0 = 4096
COND_SHAMAN_1 = 8192
COND_SHAMAN_2 = 16384
COND_SHAMAN = 28672

COND_WOLFMAN_0 = 32768
COND_WOLFMAN_1 = 65536
COND_WOLFMAN_2 = 131072
COND_WOLFMAN = 229376

PART_MAIN = 0
PART_HAIR = 3

GUILD_CREATE_ITEM_VNUM = 70101

QUEST_SCROLL_TYPE_KILL_MOB = 1
QUEST_SCROLL_TYPE_KILL_ANOTHER_EMPIRE = 2

apply = {
    ["MAX_HP"]		= 1,
    ["MAX_SP"]		= 2,
    ["CON"]			= 3,
    ["INT"]			= 4,
    ["STR"]			= 5,
    ["DEX"]			= 6,
    ["ATT_SPEED"]		= 7,
    ["MOV_SPEED"]		= 8,
    ["CAST_SPEED"]		= 9,
    ["HP_REGEN"]		= 10,
    ["SP_REGEN"]		= 11,
    ["POISON_PCT"]		= 12,
    ["STUN_PCT"]		= 13,
    ["SLOW_PCT"]		= 14,
    ["CRITICAL_PCT"]	= 15,
    ["PENETRATE_PCT"]	= 16,
    ["ATTBONUS_HUMAN"]	= 17,
    ["ATTBONUS_ANIMAL"]	= 18,
    ["ATTBONUS_ORC"]	= 19,
    ["ATTBONUS_MILGYO"]	= 20,
    ["ATTBONUS_UNDEAD"]	= 21,
    ["ATTBONUS_DEVIL"]	= 22,
    ["STEAL_HP"]		= 23,
    ["STEAL_SP"]		= 24,
    ["MANA_BURN_PCT"]	= 25,
    ["DAMAGE_SP_RECOVER"]	= 26,
    ["BLOCK"]		= 27,
    ["DODGE"]		= 28,
    ["RESIST_SWORD"]	= 29,
    ["RESIST_TWOHAND"]	= 30,
    ["RESIST_DAGGER"]	= 31,
    ["RESIST_BELL"]		= 32,
    ["RESIST_FAN"]		= 33,
    ["RESIST_BOW"]		= 34,
    ["RESIST_FIRE"]		= 35,
    ["RESIST_ELEC"]		= 36,
    ["RESIST_MAGIC"]	= 37,
    ["RESIST_WIND"]		= 38,
    ["REFLECT_MELEE"]	= 39,
    ["REFLECT_CURSE"]	= 40,
    ["POISON_REDUCE"]	= 41,
    ["KILL_SP_RECOVER"]	= 42,
    ["EXP_DOUBLE_BONUS"]	= 43,
    ["GOLD_DOUBLE_BONUS"]	= 44,
    ["ITEM_DROP_BONUS"]	= 45,
    ["POTION_BONUS"]	= 46,
    ["KILL_HP_RECOVER"]	= 47,
    ["IMMUNE_STUN"]		= 48,
    ["IMMUNE_SLOW"]		= 49,
    ["IMMUNE_FALL"]		= 50,
    ["SKILL"]		= 51,
    ["BOW_DISTANCE"]	= 52,
    ["ATT_GRADE_BONUS"]	= 53,
    ["DEF_GRADE_BONUS"]	= 54,
    ["MAGIC_ATT_GRADE"]	= 55,
    ["MAGIC_DEF_GRADE"]	= 56,
    ["CURSE_PCT"]		= 57,
    ["MAX_STAMINA"]		= 58,
    ["ATTBONUS_WARRIOR"]	= 59,
    ["ATTBONUS_ASSASSIN"]	= 60,
    ["ATTBONUS_SURA"]	= 61,
    ["ATTBONUS_SHAMAN"]	= 62,
    ["ATTBONUS_MONSTER"]	= 63,
    ["MALL_EXPBONUS"]   = 66,
    ["MAX_HP_PCT"]  = 69,
    ["MAX_SP_PCT"]  = 70,

    ["MALL_DEFBONUS"] = 65,

    ["NORMAL_HIT_DEFEND_BONUS"] = 74,
	["ATTBONUS_WOLFMAN"] = 94,
	["RESIST_WOLFMAN"] = 95,
	["RESIST_CLAW"] = 96,
}

-- ·¹º§¾÷ Äù½ºÆ® -_-
special = {}

special.fortune_telling = 
{
--  { prob	Å©¸®	item	money	remove money
    { 1,	0,	20,	20,	0	}, -- 10
    { 499,	0,	10,	10,	0	}, -- 5
    { 2500,	0,	5,	5,	0	}, -- 1
    { 5000,	0,	0,	0,	0	},
    { 1500,	0,	-5,	-5,	20000	},
    { 499,	0,	-10,	-10,	20000	},
    { 1,	0,	-20,	-20,	20000	},
}

special.questscroll_reward =
{
    {1,	1500,	3000,	30027,	0,	0    },
    {2,	1500,	3000,	30028,	0,	0    },
    {3,	1000,	2000,	30034,	30018,	0    },
    {4,	1000,	2000,	30034,	30011,	0    },
    {5,	1000,	2000,	30011,	30034,	0    },
    {6,	1000,	2000,	27400,	0,	0    },
    {7,	2000,	4000,	30023,	30003,	0    },
    {8,	2000,	4000,	30005,	30033,	0    },
    {9,	2000,	8000,	30033,	30005,	0    },
    {10,	4000,	8000,	30021,	30033,	30045},
    {11,	4000,	8000,	30045,	30022,	30046},
    {12,	5000,	12000,	30047,	30045,	30055},
    {13,	5000,	12000,	30051,	30017,	30058},
    {14,	5000,	12000,	30051,	30007,	30041},
    {15,	5000,	15000,	30091,	30017,	30018},
    {16,	3500,	6500,	30021,	30033,	0    },
    {17,	4000,	9000,	30051,	30033,	0    },
    {18,	4500,	10000,	30056,	30057,	30058},
    {19,	4500,	10000,	30059,	30058,	30041},
    {20,	5000,	15000,	0,	0,	0    },
}

special.active_skill_list = {
    {
        { 1, 2, 3, 4, 5, 6, 7},
        { 16, 17, 18, 19, 20, 21, 22},
    },
    {
        {31, 32, 33, 34, 35, 36, 37},
        {46, 47, 48, 49, 50, 51, 52},
    },
    {
        {61, 62, 63, 64, 65, 66, 67},
        {76, 77, 78, 79, 80, 81, 82},
    },
    {
        {91, 92, 93, 94, 95, 96, 97},
        {106, 107, 108, 109, 110, 111, 112},
    },
	{
        {170, 171, 172, 173, 174, 175, 176},
    },
}

special.skill_reset_cost = {
    2000,
    2000,
    2000,
    2000,
    2000,
    2000,
    4000,
    6000,
    8000,
    10000,
    14000,
    18000,
    22000,
    28000,
    34000,
    41000,
    50000,
    59000,
    70000,
    90000,
    101000,
    109000,
    114000,
    120000,
    131000,
    141000,
    157000,
    176000,
    188000,
    200000,
    225000,
    270000,
    314000,
    348000,
    393000,
    427000,
    470000,
    504000,
    554000,
    600000,
    758000,
    936000,
    1103000,
    1276000,
    1407000,
    1568000,
    1704000,
    1860000,
    2080000,
    2300000,
    2700000,
    3100000,
    3500000,
    3900000,
    4300000,
    4800000,
    5300000,
    5800000,
    6400000,
    7000000,
    8000000,
    9000000,
    10000000,
    11000000,
    12000000,
    13000000,
    14000000,
    15000000,
    16000000,
    17000000,
}

special.levelup_img = 
{
    [170] = "dog.tga",
    [171] = "wolfman.tga",
    [172] = "wolfman.tga",
    [173] = "wolfman.tga",
    [174] = "wolfman.tga",
    [175] = "wolfman.tga",
    [176] = "wolfman.tga",
    [177] = "wolfman.tga",
    [178] = "wild_boar.tga",
    [179] = "wild_boar.tga",
    [180] = "bear.tga",
    [181] = "bear.tga",
    [182] = "bear.tga",
    [183] = "bear.tga",
    [184] = "tiger.tga",
    [185] = "tiger.tga",

    [351] = "bak_inf.tga",
    [352] = "bak_gung.tga",
    [353] = "bak_gen1.tga",
    [354] = "bak_gen2.tga",
    
    [402] = "402.tga",

    [451] = "huk_inf.tga",
    [452] = "huk_dol.tga",
    [453] = "huk_gen1.tga",
    [454] = "huk_gen2.tga",
    [456] = "456.tga",

    [551] = "o_inf.tga",
    [552] = "o_jol.tga",
    [553] = "o_gung.tga",
    [554] = "o_jang.tga",

    [651] = "ung_inf.tga",
    [652] = "ung_chuk.tga",
    [653] = "ung_tu.tga",

    [751] = "mil_chu.tga",
    [752] = "mil_na.tga",
    [753] = "mil_na.tga",
    [754] = "mil_na.tga",
    [755] = "mil_jip.tga",
    [756] = "756.tga",
    [757] = "757.tga",

    [771] = "mil_chu.tga",
    [772] = "mil_na.tga",
    [773] = "mil_na.tga",
    [774] = "mil_na.tga",
    [775] = "mil_jip.tga",
    [776] = "776.tga",
    [777] = "777.tga",

    [931] = "sigwi.tga",
    [932] = "932.tga",
    [933] = "gwoijil.tga",
    [934] = "934.tga",
    [935] = "935.tga",
    [936] = "936.tga",
    [937] = "937.tga",
    
    [1001] = "1001.tga",
    [1002] = "1002.tga",
    [1003] = "1003.tga",
    [1004] = "1004.tga",
    
    [1061] = "1061.tga",
    [1063] = "1063.tga",
    [1064] = "1064.tga",
    [1065] = "1065.tga",
    [1066] = "1066.tga",
    [1068] = "1068.tga",
    [1069] = "1069.tga",

    [1070] = "1070.tga",
    [1071] = "1071.tga",

    [1101] = "1101.tga",
    [1102] = "1102.tga",
    [1104] = "1104.tga",
    [1105] = "1105.tga",
    [1106] = "1106.tga",
    [1107] = "1107.tga",

    [1131] = "1131.tga",
    [1132] = "1132.tga",
    [1133] = "1133.tga",
    [1135] = "1135.tga",
    [1136] = "1136.tga",
    [1137] = "1137.tga",

    [1301] = "1301.tga",
    [1303] = "1303.tga",
    [1305] = "1305.tga",

    [2001] = "spider.tga",
    [2002] = "spider.tga",
    [2003] = "spider.tga",
    [2004] = "spider.tga",
    [2005] = "spider.tga",

    [2051] = "spider.tga",
    [2052] = "spider.tga",
    [2053] = "spider.tga",
    [2054] = "spider.tga",
    [2055] = "spider.tga",

    [2031] = "2031.tga",
    [2032] = "2032.tga",
    [2033] = "2033.tga",
    [2034] = "2034.tga",

    [2061] = "2061.tga",
    [2062] = "2062.tga",
    [2063] = "2063.tga",

    [2102] = "2102.tga",
    [2103] = "2103.tga",
    [2106] = "2106.tga",
    
    [2131] = "2131.tga",
    [2158] = "2158.tga",
    
    [2201] = "2201.tga",
    [2202] = "2202.tga",
    [2204] = "2204.tga",
    [2205] = "2205.tga",
    
    [2301] = "2301.tga",
    [2302] = "2302.tga",
    [2303] = "2303.tga",
    [2304] = "2304.tga",
    [2305] = "2305.tga",
    
    [2311] = "2311.tga",
    [2312] = "2312.tga",
    [2313] = "2313.tga",
    [2314] = "2314.tga",
    [2315] = "2315.tga",

    [5123] = "5123.tga",
    [5124] = "5124.tga",
    [5125] = "5125.tga",
    [5126] = "5126.tga",
    

}

special.levelup_quest = {
    -- monster kill  monster   kill
    --    vnum		qty.		 vnum		qty.	 exp percent
{	0	,	0	,	0	,	0	,	0	}	,	--	lev	1
{	171	,	10	,	172	,	5	,	10	}	,	--	lev	2
{	171	,	20	,	172	,	10	,	10	}	,	--	lev	3
{	172	,	15	,	173	,	5	,	10	}	,	--	lev	4
{	173	,	10	,	174	,	10	,	10	}	,	--	lev	5
{	174	,	20	,	178	,	10	,	10	}	,	--	lev	6
{	178	,	10	,	175	,	5	,	10	}	,	--	lev	7
{	178	,	20	,	175	,	10	,	10	}	,	--	lev	8
{	175	,	15	,	179	,	5	,	10	}	,	--	lev	9
{	175	,	20	,	179	,	10	,	10	}	,	--	lev	10
{	179	,	10	,	180	,	5	,	10	}	,	--	lev	11
{	180	,	15	,	176	,	10	,	10	}	,	--	lev	12
{	176	,	20	,	181	,	5	,	10	}	,	--	lev	13
{	181	,	15	,	177	,	5	,	10	}	,	--	lev	14
{	181	,	20	,	177	,	10	,	10	}	,	--	lev	15
{	177	,	15	,	184	,	5	,	10	}	,	--	lev	16
{	177	,	20	,	184	,	10	,	10	}	,	--	lev	17
{	184	,	10	,	182	,	10	,	10	}	,	--	lev	18
{	182	,	20	,	183	,	10	,	10	}	,	--	lev	19
{	183	,	20	,	352	,	15	,	10	}	,	--	lev	20
{	352	,	20	,	185	,	10	,	"2-10"	}	,	--	lev	21
{	185	,	25	,	354	,	10	,	"2-10"	}	,	--	lev	22
{	354	,	20	,	451	,	40	,	"2-10"	}	,	--	lev	23
{	451	,	60	,	402	,	80	,	"2-10"	}	,	--	lev	24
{	551	,	80	,	454	,	20	,	"2-10"	}	,	--	lev	25
{	552	,	80	,	456	,	20	,	"2-10"	}	,	--	lev	26
{	456	,	30	,	554	,	20	,	"2-10"	}	,	--	lev	27
{	651	,	35	,	554	,	30	,	"2-10"	}	,	--	lev	28
{	651	,	40	,	652	,	30	,	"2-10"	}	,	--	lev	29
{	652	,	40	,	2102	,	30	,	"2-10"	}	,	--	lev	30
{	652	,	50	,	2102	,	45	,	"2-5"	}	,	--	lev	31
{	653	,	45	,	2051	,	40	,	"2-5"	}	,	--	lev	32
{	751	,	35	,	2103	,	30	,	"2-5"	}	,	--	lev	33
{	751	,	40	,	2103	,	40	,	"2-5"	}	,	--	lev	34
{	752	,	40	,	2052	,	30	,	"2-5"	}	,	--	lev	35
{	754	,	20	,	2106	,	20	,	"2-5"	}	,	--	lev	36
{	773	,	30	,	2003	,	20	,	"2-5"	}	,	--	lev	37
{	774	,	40	,	2004	,	20	,	"2-5"	}	,	--	lev	38
{	756	,	40	,	2005	,	30	,	"2-5"	}	,	--	lev	39
{	757	,	40	,	2158	,	20	,	"2-5"	}	,	--	lev	40
{	931	,	40	,	5123	,	25	,	"2-5"	}	,	--	lev	41
{	932	,	30	,	5123	,	30	,	"2-5"	}	,	--	lev	42
{	932	,	40	,	2031	,	35	,	"2-5"	}	,	--	lev	43
{	933	,	40	,	2031	,	40	,	"2-5"	}	,	--	lev	44
{	771	,	50	,	2032	,	45	,	"2-5"	}	,	--	lev	45
{	772	,	30	,	5124	,	30	,	"2-5"	}	,	--	lev	46
{	933	,	35	,	5125	,	30	,	"2-5"	}	,	--	lev	47
{	934	,	40	,	5125	,	35	,	"2-5"	}	,	--	lev	48
{	773	,	40	,	2033	,	45	,	"2-5"	}	,	--	lev	49
{	774	,	40	,	5126	,	20	,	"2-5"	}	,	--	lev	50
{	775	,	50	,	5126	,	30	,	"1-4"	}	,	--	lev	51
{	934	,	45	,	2034	,	45	,	"1-4"	}	,	--	lev	52
{	934	,	50	,	2034	,	50	,	"1-4"	}	,	--	lev	53
{	776	,	40	,	1001	,	30	,	"1-4"	}	,	--	lev	54
{	777	,	40	,	1301	,	35	,	"1-4"	}	,	--	lev	55
{	935	,	50	,	1002	,	30	,	"1-4"	}	,	--	lev	56
{	935	,	60	,	1002	,	40	,	"1-4"	}	,	--	lev	57
{	936	,	45	,	1303	,	40	,	"1-4"	}	,	--	lev	58
{	936	,	50	,	1303	,	45	,	"1-4"	}	,	--	lev	59
{	937	,	45	,	1003	,	40	,	"1-4"	}	,	--	lev	60
{	1004	,	50	,	2061	,	60	,	"2-4"	}	,	--	lev	61
{	1305	,	45	,	2131	,	55	,	"2-4"	}	,	--	lev	62
{	1305	,	50	,	1101	,	45	,	"2-4"	}	,	--	lev	63
{	2062	,	50	,	1102	,	45	,	"2-4"	}	,	--	lev	64
{	1104	,	40	,	2063	,	40	,	"2-4"	}	,	--	lev	65
{	2301	,	50	,	1105	,	45	,	"2-4"	}	,	--	lev	66
{	2301	,	55	,	1105	,	50	,	"2-4"	}	,	--	lev	67
{	1106	,	50	,	1061	,	50	,	"2-4"	}	,	--	lev	68
{	1107	,	45	,	1061	,	50	,	"2-4"	}	,	--	lev	69
{	2302	,	55	,	2201	,	55	,	"2-4"	}	,	--	lev	70
{	2303	,	55	,	2202	,	55	,	"2-4"	}	,	--	lev	71
{	2303	,	60	,	2202	,	60	,	"2-4"	}	,	--	lev	72
{	2304	,	55	,	1063	,	55	,	"2-4"	}	,	--	lev	73
{	2305	,	50	,	1063	,	55	,	"2-4"	}	,	--	lev	74
{	1064	,	50	,	2204	,	50	,	"2-4"	}	,	--	lev	75
{	2205	,	45	,	1065	,	50	,	"2-4"	}	,	--	lev	76
{	2311	,	50	,	1068	,	50	,	"2-4"	}	,	--	lev	77
{	1070	,	50	,	1066	,	55	,	"2-4"	}	,	--	lev	78
{	1070	,	50	,	1069	,	50	,	"2-4"	}	,	--	lev	79
{	1071	,	50	,	2312	,	55	,	"2-4"	}	,	--	lev	80
{	1071	,	55	,	2312	,	50	,	"2-4"	}	,	--	lev	81
{	2313	,	55	,	2314	,	45	,	"2-4"	}	,	--	lev	82
{	2313	,	55	,	2314	,	45	,	"2-4"	}	,	--	lev	83
{	1131	,	60	,	2315	,	45	,	"5-10"}	,	--	lev	84
{	1131	,	60	,	2315	,	45	,	"5-10"}	,	--	lev	85
{	1132	,	60	,	1135	,	50	,	"5-10"}	,	--	lev	86
{	1132	,	60	,	1135	,	50	,	"5-10"}	,	--	lev	87
{	1133	,	60	,	1136	,	50	,	"5-10"}	,	--	lev	88
{	1133	,	60	,	1137	,	50	,	"5-10"}	,	--	lev	89
{	1132	,	60	,	1137	,	40	,	"5-10"}	,	--	lev	90

}

special.levelup_reward1 = 
{
    -- warrior assassin  sura  shaman
    {     0,        0,      0,      0 },
    { 11200,    11400,  11600,  11800 }, -- °©¿Ê
    { 12200,    12340,  12480,  12620 }, -- Åõ±¸
    { 13000,    13000,  13000,  13000 }  -- ¹æÆÐ
}

-- levelup_reward1 Å×ÀÌºí Å©±âº¸´Ù ·¹º§ÀÌ ³ô¾ÆÁö¸é ¾Æ·¡
-- Å×ÀÌºíÀ» ÀÌ¿ëÇÏ¿© ¾ÆÀÌÅÛÀ» ÁØ´Ù.
special.levelup_reward3 = {
    -- pct   item #  item count
    {   33,  27002,  10 }, -- 25%
    {   67,  27005,  10 }, -- 25%
  --{   75,  27101,   5 }, -- 25%
    {  100,  27114,   5 }, -- 25%
}

special.levelup_reward_gold21 = 
{
    { 10000,	20 },
    { 20000,	50 },
    { 40000,	25 },
    { 80000,	3 },
    { 100000,	2 },
}
special.levelup_reward_gold31 =
{
    { 20000,	20 },
    { 40000,	40 },
    { 60000,	25 },
    { 80000,	10 },
    { 100000,	5 },
}
special.levelup_reward_gold41 =
{
    { 40000,	20 },
    { 60000,	40 },
    { 80000,	25 },
    { 100000,	10 },
    { 150000,	5 },
}
special.levelup_reward_gold51 =
{
    { 60000,	20 },
    { 80000,	40 },
    { 100000,	25 },
    { 150000,	10 },
    { 200000,	5 },
}

special.levelup_reward_exp21 =
{
    { 2,	9 },
    { 3,	14 },
    { 4,	39 },
    { 6,	24 },
    { 8,	9 },
    { 10,	4 },
}

special.levelup_reward_exp31 = 
{
    { 2,	10 },
    { 2.5,	15 },
    { 3,	40 },
    { 3.5,	25 },
    { 4,	8 },
    { 4.5,	5 },
    { 5,	2 },
}
special.levelup_reward_exp41 = 
{
    { 2,	10 },
    { 2.5,	15 },
    { 3,	40 },
    { 3.5,	25 },
    { 4,	8 },
    { 4.5,	5 },
    { 5,	2 },
}
special.levelup_reward_exp51 = 
{
    { 1,	10 },
    { 1.5,	15 },
    { 2,	40 },
    { 2.5,	25 },
    { 3,	8 },
    { 3.5,	5 },
    { 4,	2 },
}
special.levelup_reward_exp84 =
{
    { 5,	9 },
    { 6,	14 },
    { 7,	39 },
    { 8,	24 },
    { 9,	9 },
    { 10,	4 },
}

special.levelup_reward_item_21 =
{
    -- no couple ring
    { { 27002, 10 }, { 27005, 10 }, { 27114, 10 } }, -- lev 21
    { 15080, 15100, 15120, 15140 }, -- lev 22
    { 16080, 16100, 16120, 16140 }, -- lev 23
    { 17080, 17100, 17120, 17140 }, -- lev 24
    { { 27002, 10 }, { 27005, 10 }, { 27114, 10 } }, -- lev 25
    { { 27003, 20 }, { 27006, 20 }, { 27114, 10 } }, -- over lev 25

    -- with couple ring
    -- { { 27002, 10 }, { 27005, 10 }, { 27114, 10 }, { 70301, 1 } }, -- lev 21
    -- { 15080, 15100, 15120, 15140, 70301 }, -- lev 22
    -- { 16080, 16100, 16120, 16140, 70301 }, -- lev 23
    -- { 17080, 17100, 17120, 17140, 70301 }, -- lev 24
    -- { { 27002, 10 }, { 27005, 10 }, { 27114, 10 }, { 70301, 1 } }, -- lev 25
    -- { { 27003, 20 }, { 27006, 20 }, { 27114, 10 } }, -- over lev 25
}

special.warp_to_pos = {
-- ½Â·æ°î
    {
    { 402100, 673900 }, 
    { 270400, 739900 },
    { 321300, 808000 },
    },
--µµ¿°È­Áö
    {
--A 5994 7563 
--B 5978 6222
--C 7307 6898
    { 599400, 756300 },
    { 597800, 622200 },
    { 730700, 689800 },
    },
--¿µºñ»ç¸·
    {
--A 2178 6272
    { 217800, 627200 },
--B 2219 5027
    { 221900, 502700 },
--C 3440 5025
    { 344000, 502500 },
    },
--¼­ÇÑ»ê
    {
--A 4342 2906
    { 434200, 290600 },
--B 3752 1749
    { 375200, 174900 },
--C 4918 1736
    { 491800, 173600 },
    },
}

special.devil_tower = 
{
    --{ 123, 608 },
    { 2048+126, 6656+384 },
    { 2048+134, 6656+147 },
    { 2048+369, 6656+629 },
    { 2048+369, 6656+401 },
    { 2048+374, 6656+167 },
    { 2048+579, 6656+616 },
    { 2048+578, 6656+392 },
    { 2048+575, 6656+148 },
}

special.lvq_map = {
    { -- "A1" 1
        {},
    
        { { 440, 565 }, { 460, 771 }, { 668, 800 },},
        { { 440, 565 }, { 460, 771 }, { 668, 800 },},
        { { 440, 565 }, { 460, 771 }, { 668, 800 },},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        
        {{496, 401}, {494, 951}, {542, 1079}, {748, 9741},},
        {{853,557}, {845,780}, {910,956},},
        {{853,557}, {845,780}, {910,956},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        {{340, 179}, {692, 112}, {787, 256}, {898, 296},},
        
        {{224,395}, {137,894}, {206,830}, {266,1067},},
        {{224,395}, {137,894}, {206,830}, {266,1067},},
        {{224,395}, {137,894}, {206,830}, {266,1067},},
        {{405,74}},
        {{405,74}},
        {{405,74}},
        {{405,74}},
        {{405,74}},
        {{405,74}},
        {{405,74}},
        
        {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}},
        
        {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}}, {{405,74}},
    },


    { -- "A2" 2
        {},
        
        {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }},
        
        {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }},
        
        {{ 640,1437 }}, {{ 640,1437 }}, {{ 640,1437 }}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}},
        
        {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}}, {{640,1437}},
        
        {{640,1437}},
        {{640,1437}},
        {{640,1437}},
        {{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
        {{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
        {{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
        {{244,1309}, {4567,1080}, {496,885}, {798,975}, {1059,1099}, {855,1351},},
        {{193,772}, {390,402}, {768,600}, {1075,789}, {1338,813},},
        {{193,772}, {390,402}, {768,600}, {1075,789}, {1338,813},},
    },



    { -- "A3" 3
        {},

        {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }},
        {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }}, {{ 948,804 }},

        {{ 948,804 }},
        {{ 948,804 }},
        {{ 948,804 }},
        {{438, 895}, {725, 864}, {632, 671},},
        {{438, 895}, {725, 864}, {632, 671},},
        {{438, 895}, {725, 864}, {632, 671},},
        {{438, 895}, {725, 864}, {632, 671},},
        {{438, 895}, {725, 864}, {632, 671},},
        {{847, 412}, {844, 854}, {823, 757}, {433, 407},},
        {{847, 412}, {844, 854}, {823, 757}, {433, 407},},
        {{847, 412}, {844, 854}, {823, 757}, {433, 407},},
        {{847, 412}, {844, 854}, {823, 757}, {433, 407},},
        {{847, 412}, {844, 854}, {823, 757}, {433, 407},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{316,168}, {497,130}, {701,157}, {858,316},},
        {{200,277}, {130,646}, {211,638}, {291,851},},
        {{200,277}, {130,646}, {211,638}, {291,851},},
        {{200,277}, {130,646}, {211,638}, {291,851},},
        {{100,150}},
        {{100,150}},
        {{100,150}},
        {{100,150}},
        {{100,150}},
        {{100,150}},
    },

    {}, -- 4
    {}, -- 5
    {}, -- 6
    {}, -- 7
    {}, -- 8
    {}, -- 9
    {}, -- 10
    {}, -- 11
    {}, -- 12
    {}, -- 13
    {}, -- 14
    {}, -- 15
    {}, -- 16
    {}, -- 17
    {}, -- 18
    {}, -- 19
    {}, -- 20

    { -- "B1" 21
        {},
        
        {{412,635}, {629,428}, {829,586},},
        {{412,635}, {629,428}, {829,586},},
        {{412,635}, {629,428}, {829,586},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},
        {{329,643}, {632,349}, {905,556},},

        {{329,643}, {632,349}, {905,556},},
        {{866,822}, {706,224}, {247,722},},
        {{866,822}, {706,224}, {247,722},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
        {{617,948}, {353,221},},
    
        {{496,1089}, {890,1043},},
        {{496,1089}, {890,1043},},
        {{496,1089}, {890,1043},},
        {{876,1127}},
        {{876,1127}},
        {{876,1127}},
        {{876,1127}},
        {{876,1127}},
        {{876,1127}},
        {{876,1127}},
    
        {{876,1127}}, {{876,1127}}, {{876,1127}}, {{876,1127}}, {{876,1127}},	{{876,1127}},	{{876,1127}},	{{876,1127}},	{{876,1127}}, {{876,1127}},
        {{876,1127}}, {{876,1127}}, {{876,1127}}, {{908,87}},	{{908,87}},		{{908,87}},		{{908,87}},		{{908,87}},		{{908,87}},
    },

    { -- "B2" 22
        {},

        {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }},
        {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }},
        {{ 95,819 }}, {{ 95,819 }}, {{ 95,819 }}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}},
        {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}}, {{746,1438}},

        {{746,1438}},
        {{746,1438}},
        {{746,1438}},
        {{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
        {{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
        {{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
        {{ 172,810}, {288,465}, {475,841}, {303,156}, {687,466},},
        {{787,235}, {1209,382}, {1350,571}, {1240,852}, {1254,1126}, {1078,1285}, {727,1360},},
        {{787,235}, {1209,382}, {1350,571}, {1240,852}, {1254,1126}, {1078,1285}, {727,1360},},
    },


    { -- "B3" 23
        {},
        
        {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }},
        {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }}, {{ 106,88 }},

         {{ 106,88 }},
        {{ 106,88 }},
        {{ 106,88 }},
        {{230, 244}, {200, 444}, {594, 408},},
        {{230, 244}, {200, 444}, {594, 408},},
        {{230, 244}, {200, 444}, {594, 408},},
        {{230, 244}, {200, 444}, {594, 408},},
        {{230, 244}, {200, 444}, {594, 408},},
        {{584,204}, {720,376}, {861,272},},
        {{584,204}, {720,376}, {861,272},},
        {{584,204}, {720,376}, {861,272},},
        {{584,204}, {720,376}, {861,272},},
        {{584,204}, {720,376}, {861,272},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{566,694}, {349,574}, {198,645},},
        {{816,721}, {489,823},},
        {{816,721}, {489,823},},
        {{816,721}, {489,823},},
        {{772,140}},
        {{772,140}},
        {{772,140}},
        {{772,140}},
        {{772,140}},
        {{772,140}},
    },

    {}, -- 24
    {}, -- 25
    {}, -- 26
    {}, -- 27
    {}, -- 28
    {}, -- 29
    {}, -- 30
    {}, -- 31
    {}, -- 32
    {}, -- 33
    {}, -- 34
    {}, -- 35
    {}, -- 36
    {}, -- 37
    {}, -- 38
    {}, -- 39
    {}, -- 40

    { -- "C1" 41
        {},

        {{385,446}, {169,592}, {211,692}, {632,681},},
        {{385,446}, {169,592}, {211,692}, {632,681},},
        {{385,446}, {169,592}, {211,692}, {632,681},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        {{385,374}, {227,815}, {664,771},},
        
        {{385,374}, {227,815}, {664,771},},
        {{169,362}, {368,304}, {626,409}, {187,882}, {571,858},},
        {{169,362}, {368,304}, {626,409}, {187,882}, {571,858},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        {{178,275}, {365,242}, {644,313}, {194,950}, {559,936},},
        
        {{452,160}, {536,1034}, {184,1044},},
        {{452,160}, {536,1034}, {184,1044},},
        {{452,160}, {536,1034}, {184,1044},},
        {{137,126}},
        {{137,126}},
        {{137,126}},
        {{137,126}},
        {{137,126}},
        {{137,126}},
        {{137,126}},
        
        {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}},
        {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}}, {{137,126}},
    },

    { -- "C2" 42
        {},

        {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
        {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
        {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
        {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}}, {{1409,139}},
    
        {{1409,139}},
        {{1409,139}},
        {{1409,139}},
        {{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
        {{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
        {{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
        {{991,222}, {1201,525}, {613,232}, {970,751}, {1324,790},},
        {{192,211}, {247,600}, {249,882}, {987,981}, {1018,1288}, {1303,1174},},
        {{192,211}, {247,600}, {249,882}, {987,981}, {1018,1288}, {1303,1174},},
    },

    { -- "C3" 43
        {},

        {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}},
        {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}}, {{901,151}},
    
        {{901,151}},
        {{901,151}},
        {{901,151}},
        {{421, 189}, {167, 353},},
        {{421, 189}, {167, 353},},
        {{421, 189}, {167, 353},},
        {{421, 189}, {167, 353},},
        {{421, 189}, {167, 353},},
        {{679,459}, {505,709},},
        {{679,459}, {505,709},},
        {{679,459}, {505,709},},
        {{679,459}, {505,709},},
        {{679,459}, {505,709},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{858,638}, {234,596},},
        {{635,856}, {324,855},},
        {{635,856}, {324,855},},
        {{635,856}, {324,855},},
        {{136,899}},
        {{136,899}},
        {{136,899}},
        {{136,899}},
        {{136,899}},
        {{136,899}},
    },

    {}, -- 44
    {}, -- 45
    {}, -- 46
    {}, -- 47
    {}, -- 48
    {}, -- 49
    {}, -- 50
    {}, -- 51
    {}, -- 52
    {}, -- 53
    {}, -- 54
    {}, -- 55
    {}, -- 56
    {}, -- 57
    {}, -- 58
    {}, -- 59
    {}, -- 60
}

function BuildSkillList(job, group)
    local skill_vnum_list = {}
    local skill_name_list = {}

    if pc.get_skill_group() != 0 then
        local skill_list = special.active_skill_list[job+1][group]
                
        table.foreachi( skill_list,
            function(i, t)
                local lev = pc.get_skill_level(t)

                if lev > 0 then
                    local name = locale.GM_SKILL_NAME_DICT[t]

                    if name != nil then
                        table.insert(skill_vnum_list, t)
                        table.insert(skill_name_list, name)
                    end
                end
            end
        )
    end

    table.insert(skill_vnum_list, 0)
    table.insert(skill_name_list, gameforge.locale.cancel)

    return { skill_vnum_list, skill_name_list }
end

--BEGIN EDIT created for Heavens cave pre event, Arne 23Sept09
-- Table for storing character names,
char_name_list = {}
   char_name_list[1] = {}
   char_name_list[2] = {}
   char_name_list[3] = {}
   char_name_list[4] = {}
   char_name_list[5] = {}
   char_name_list[6] = {}
   char_name_list[7] = {}
   char_name_list[8] = {}
   char_name_list[9] = {}
   char_name_list[10] = {}

--no return, just used for storing a name into the list
function store_charname_by_id(id, charname, charid)
       char_name_list[id]["name"] = charname
       char_name_list[id]["eid"] = charid
    return nil
end

-- returns the name of a given list item, id is the highscore slot
function return_charname_by_id(charid)
    local counter = 11
    repeat
        counter = counter -1
    until char_name_list[counter]["eid"] == charid
    return char_name_list[counter]["name"]
end

 function get_map_name_by_number(number)
map_name = {
--EmpireNr-MapNrs
        [1] = {[1] = gameforge.functions._100_say, [2] = gameforge.functions._130_say, [3] = gameforge.functions._130_say,  [4] = gameforge.functions._160_say, [61] = gameforge.functions._200_say, [62] = gameforge.functions._210_say, [63] = gameforge.functions._220_say, [64] = gameforge.functions._190_say, [65] = gameforge.functions._230_say, [72] = gameforge.functions._240_say, [73] = gameforge.functions._240_say,},
        [2] = {[1] = gameforge.functions._110_say, [2] = gameforge.functions._140_say, [3] = gameforge.functions._140_say,  [4] = gameforge.functions._170_say, [61] = gameforge.functions._200_say, [62] = gameforge.functions._210_say, [63] = gameforge.functions._220_say, [64] = gameforge.functions._190_say, [65] = gameforge.functions._230_say, [72] = gameforge.functions._240_say, [73] = gameforge.functions._240_say,},
        [3] = {[1] = gameforge.functions._120_say, [2] = gameforge.functions._150_say, [3] = gameforge.functions._150_say,  [4] = gameforge.functions._180_say, [61] = gameforge.functions._200_say, [62] = gameforge.functions._210_say, [63] = gameforge.functions._220_say, [64] = gameforge.functions._190_say, [65] = gameforge.functions._230_say, [72] = gameforge.functions._240_say, [73] = gameforge.functions._240_say,},
}
    return map_name[pc.get_empire()][number]
end
--END EDIT 

PREMIUM_EXP             = 0
PREMIUM_ITEM            = 1
PREMIUM_SAFEBOX         = 2
PREMIUM_AUTOLOOT        = 3
PREMIUM_FISH_MIND       = 4
PREMIUM_MARRIAGE_FAST   = 5
PREMIUM_GOLD            = 6

-- point type start
POINT_NONE                 = 0
POINT_LEVEL                = 1
POINT_VOICE                = 2
POINT_EXP                  = 3
POINT_NEXT_EXP             = 4
POINT_HP                   = 5
POINT_MAX_HP               = 6
POINT_SP                   = 7
POINT_MAX_SP               = 8  
POINT_STAMINA              = 9  --½ºÅ×¹Ì³Ê
POINT_MAX_STAMINA          = 10 --ÃÖ´ë ½ºÅ×¹Ì³Ê

POINT_GOLD                 = 11
POINT_ST                   = 12 --±Ù·Â
POINT_HT                   = 13 --Ã¼·Â
POINT_DX                   = 14 --¹ÎÃ¸¼º
POINT_IQ                   = 15 --Á¤½Å·Â
POINT_DEF_GRADE			= 16
POINT_ATT_SPEED            = 17 --°ø°Ý¼Óµµ
POINT_ATT_GRADE			= 18 --°ø°Ý·Â MAX
POINT_MOV_SPEED            = 19 --ÀÌµ¿¼Óµµ
POINT_CLIENT_DEF_GRADE		= 20 --¹æ¾îµî±Þ
POINT_CASTING_SPEED        = 21 --ÁÖ¹®¼Óµµ (Äð´Ù¿îÅ¸ÀÓ*100) / (100 + ÀÌ°ª) = ÃÖÁ¾ Äð´Ù¿î Å¸ÀÓ
POINT_MAGIC_ATT_GRADE      = 22 --¸¶¹ý°ø°Ý·Â
POINT_MAGIC_DEF_GRADE      = 23 --¸¶¹ý¹æ¾î·Â
POINT_EMPIRE_POINT         = 24 --Á¦±¹Á¡¼ö
POINT_LEVEL_STEP           = 25 --ÇÑ ·¹º§¿¡¼­ÀÇ ´Ü°è.. (1 2 3 µÉ ¶§ º¸»ó 4 µÇ¸é ·¹º§ ¾÷)
POINT_STAT                 = 26 --´É·ÂÄ¡ ¿Ã¸± ¼ö ÀÖ´Â °³¼ö
POINT_SUB_SKILL			= 27 --º¸Á¶ ½ºÅ³ Æ÷ÀÎÆ®
POINT_SKILL				= 28 --¾×Æ¼ºê ½ºÅ³ Æ÷ÀÎÆ®
POINT_WEAPON_MIN			= 29 --¹«±â ÃÖ¼Ò µ¥¹ÌÁö
POINT_WEAPON_MAX			= 30 --¹«±â ÃÖ´ë µ¥¹ÌÁö
POINT_PLAYTIME             = 31 --ÇÃ·¹ÀÌ½Ã°£
POINT_HP_REGEN             = 32 --HP È¸º¹·ü
POINT_SP_REGEN             = 33 --SP È¸º¹·ü

POINT_BOW_DISTANCE         = 34 --È° »çÁ¤°Å¸® Áõ°¡Ä¡ (meter)

POINT_HP_RECOVERY          = 35 --Ã¼·Â È¸º¹ Áõ°¡·®
POINT_SP_RECOVERY          = 36 --Á¤½Å·Â È¸º¹ Áõ°¡·®

POINT_POISON_PCT           = 37 --µ¶ È®·ü
POINT_STUN_PCT             = 38 --±âÀý È®·ü
POINT_SLOW_PCT             = 39 --½½·Î¿ì È®·ü
POINT_CRITICAL_PCT         = 40 --Å©¸®Æ¼ÄÃ È®·ü
POINT_PENETRATE_PCT        = 41 --°üÅëÅ¸°Ý È®·ü
POINT_CURSE_PCT            = 42 --ÀúÁÖ È®·ü

POINT_ATTBONUS_HUMAN       = 43 --ÀÎ°£¿¡°Ô °­ÇÔ
POINT_ATTBONUS_ANIMAL      = 44 --µ¿¹°¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_ORC         = 45 --¿õ±Í¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_MILGYO      = 46 --¹Ð±³¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_UNDEAD      = 47 --½ÃÃ¼¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_DEVIL       = 48 --¸¶±Í(¾Ç¸¶)¿¡°Ô µ¥¹ÌÁö % Áõ°¡
POINT_ATTBONUS_INSECT      = 49 --¹ú·¹Á·
POINT_ATTBONUS_FIRE        = 50 --È­¿°Á·
POINT_ATTBONUS_ICE         = 51 --ºù¼³Á·
POINT_ATTBONUS_DESERT      = 52 --»ç¸·Á·
POINT_ATTBONUS_MONSTER     = 53 --¸ðµç ¸ó½ºÅÍ¿¡°Ô °­ÇÔ
POINT_ATTBONUS_WARRIOR     = 54 --¹«»ç¿¡°Ô °­ÇÔ
POINT_ATTBONUS_ASSASSIN	= 55 --ÀÚ°´¿¡°Ô °­ÇÔ
POINT_ATTBONUS_SURA		= 56 --¼ö¶ó¿¡°Ô °­ÇÔ
POINT_ATTBONUS_SHAMAN		= 57 --¹«´ç¿¡°Ô °­ÇÔ

-- ADD_TRENT_MONSTER
POINT_ATTBONUS_TREE     	= 58 --³ª¹«¿¡°Ô °­ÇÔ 20050729.myevan UNUSED5 
-- END_OF_ADD_TRENT_MONSTER
POINT_RESIST_WARRIOR		= 59 --¹«»ç¿¡°Ô ÀúÇ×
POINT_RESIST_ASSASSIN		= 60 --ÀÚ°´¿¡°Ô ÀúÇ×
POINT_RESIST_SURA			= 61 --¼ö¶ó¿¡°Ô ÀúÇ×
POINT_RESIST_SHAMAN		= 62 --¹«´ç¿¡°Ô ÀúÇ×

POINT_STEAL_HP             = 63 --»ý¸í·Â Èí¼ö
POINT_STEAL_SP             = 64 --Á¤½Å·Â Èí¼ö

POINT_MANA_BURN_PCT        = 65 --¸¶³ª ¹ø

--/ ÇÇÇØ½Ã º¸³Ê½º =/

POINT_DAMAGE_SP_RECOVER    = 66 --°ø°Ý´çÇÒ ½Ã Á¤½Å·Â È¸º¹ È®·ü

POINT_BLOCK                = 67 --ºí·°À²
POINT_DODGE                = 68 --È¸ÇÇÀ²

POINT_RESIST_SWORD         = 69
POINT_RESIST_TWOHAND       = 70
POINT_RESIST_DAGGER        = 71
POINT_RESIST_BELL          = 72
POINT_RESIST_FAN           = 73
POINT_RESIST_BOW           = 74  --È­»ì   ÀúÇ×   : ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_FIRE          = 75  --È­¿°   ÀúÇ×   : È­¿°°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_ELEC          = 76  --Àü±â   ÀúÇ×   : Àü±â°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_MAGIC         = 77  --¼ú¹ý   ÀúÇ×   : ¸ðµç¼ú¹ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò
POINT_RESIST_WIND          = 78  --¹Ù¶÷   ÀúÇ×   : ¹Ù¶÷°ø°Ý¿¡ ´ëÇÑ ´ë¹ÌÁö °¨¼Ò

POINT_REFLECT_MELEE        = 79 --°ø°Ý ¹Ý»ç

--/ Æ¯¼ö ÇÇÇØ½Ã =/
POINT_REFLECT_CURSE		= 80 --ÀúÁÖ ¹Ý»ç
POINT_POISON_REDUCE		= 81 --µ¶µ¥¹ÌÁö °¨¼Ò

--/ Àû ¼Ò¸ê½Ã =/
POINT_KILL_SP_RECOVER		= 82 --Àû ¼Ò¸ê½Ã MP È¸º¹
POINT_EXP_DOUBLE_BONUS		= 83
POINT_GOLD_DOUBLE_BONUS		= 84
POINT_ITEM_DROP_BONUS		= 85

--/ È¸º¹ °ü·Ã =/
POINT_POTION_BONUS			= 86
POINT_KILL_HP_RECOVERY		= 87

POINT_IMMUNE_STUN			= 88
POINT_IMMUNE_SLOW			= 89
POINT_IMMUNE_FALL			= 90
--========

POINT_PARTY_ATTACKER_BONUS		= 91
POINT_PARTY_TANKER_BONUS		= 92

POINT_ATT_BONUS			= 93
POINT_DEF_BONUS			= 94

POINT_ATT_GRADE_BONUS		= 95
POINT_DEF_GRADE_BONUS		= 96
POINT_MAGIC_ATT_GRADE_BONUS	= 97
POINT_MAGIC_DEF_GRADE_BONUS	= 98

POINT_RESIST_NORMAL_DAMAGE		= 99

POINT_HIT_HP_RECOVERY		= 100
POINT_HIT_SP_RECOVERY 		= 101
POINT_MANASHIELD			= 102 --Èæ½Å¼öÈ£ ½ºÅ³¿¡ ÀÇÇÑ ¸¶³ª½¯µå È¿°ú Á¤µµ

POINT_PARTY_BUFFER_BONUS		= 103
POINT_PARTY_SKILL_MASTER_BONUS	= 104

POINT_HP_RECOVER_CONTINUE		= 105
POINT_SP_RECOVER_CONTINUE		= 106

POINT_STEAL_GOLD			= 107 
POINT_POLYMORPH			= 108 --º¯½ÅÇÑ ¸ó½ºÅÍ ¹øÈ£
POINT_MOUNT				= 109 --Å¸°íÀÖ´Â ¸ó½ºÅÍ ¹øÈ£

POINT_PARTY_HASTE_BONUS		= 110
POINT_PARTY_DEFENDER_BONUS		= 111
POINT_STAT_RESET_COUNT		= 112 --ÇÇÀÇ ´Ü¾à »ç¿ëÀ» ÅëÇÑ ½ºÅÝ ¸®¼Â Æ÷ÀÎÆ® (1´ç 1Æ÷ÀÎÆ® ¸®¼Â°¡´É)

POINT_HORSE_SKILL			= 113

POINT_MALL_ATTBONUS		= 114 --°ø°Ý·Â +x%
POINT_MALL_DEFBONUS		= 115 --¹æ¾î·Â +x%
POINT_MALL_EXPBONUS		= 116 --°æÇèÄ¡ +x%
POINT_MALL_ITEMBONUS		= 117 --¾ÆÀÌÅÛ µå·ÓÀ² x/10¹è
POINT_MALL_GOLDBONUS		= 118 --µ· µå·ÓÀ² x/10¹è

POINT_MAX_HP_PCT			= 119 --ÃÖ´ë»ý¸í·Â +x%
POINT_MAX_SP_PCT			= 120 --ÃÖ´ëÁ¤½Å·Â +x%

POINT_SKILL_DAMAGE_BONUS		= 121 --½ºÅ³ µ¥¹ÌÁö *(100+x)%
POINT_NORMAL_HIT_DAMAGE_BONUS	= 122 --ÆòÅ¸ µ¥¹ÌÁö *(100+x)%

-- DEFEND_BONUS_ATTRIBUTES
POINT_SKILL_DEFEND_BONUS		= 123 --½ºÅ³ ¹æ¾î µ¥¹ÌÁö
POINT_NORMAL_HIT_DEFEND_BONUS	= 124 --ÆòÅ¸ ¹æ¾î µ¥¹ÌÁö
-- END_OF_DEFEND_BONUS_ATTRIBUTES

-- PC_BANG_ITEM_ADD 
POINT_PC_BANG_EXP_BONUS		= 125 --PC¹æ Àü¿ë °æÇèÄ¡ º¸³Ê½º
POINT_PC_BANG_DROP_BONUS		= 126 --PC¹æ Àü¿ë µå·Ó·ü º¸³Ê½º
POINT_RESIST_MAGIC = 130
-- END_PC_BANG_ITEM_ADD
-- POINT_MAX_NUM = 128	common/length.h
-- point type start


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

 function setenergy(typ,value,timez) 
 pc.setqf("energy_value",value) 
 pc.setqf("energy_typ",typ) 
 pc.setqf("energy_date",timez) 
end 

function setenergytime(timez) 
 pc.setqf("energy_date",timez) 
end 
function getenergytyp() 
 return pc.getqf("energy_typ") 
end 

function getenergyvalue() 
 return pc.getqf("energy_value") 
end 
function getenergytime() 
 return pc.getqf("energy_date") 
end  

function costume_system_create()
	os.execute("mysql -u root player --execute=\"INSERT INTO costume_system(pid) VALUES ('".. pc.get_player_id() .."')\"")
end

function costume_system_read(type_v)
	local mysql_read = (mysql_query("SELECT "..type_v.." as result_value from player.costume_system where pid = ('".. pc.get_player_id() .."')") or {["result_value"] = 0}) 
	return mysql_read.result_value[1]
end

function costume_system_update(type_s, value)
	if type_s == "part_main_old" then
		if value < 41002 then
			os.execute("mysql -u root player --execute=\"UPDATE costume_system SET "..type_s.." =('"..value.."') where pid = ('".. pc.get_player_id() .."')\"")
		end

	elseif type_s == "part_hair_old" then
		os.execute("mysql -u root player --execute=\"UPDATE costume_system SET "..type_s.." =('"..value.."') where pid = ('".. pc.get_player_id() .."')\"")
	end
end


TORNEO_READ			= 0
TORNEO_PLUS			= 1
TORNEO_NEW			= 3
TORNEO_NEXT			= 4

TORNEO_MEMBER		= 1
TORNEO_REGISTRED	= 2
TORNEO_START		= 3
TORNEO_FINISH		= 4
TORNEO_STAGE		= 5
TORNEO_ROUND		= 6

function torneo_open_regi()
	local TORNEO_PATH = "locale/turkey/quest/object/torneo/"
	local TORNEO_FILE = "torneo_stage_*"
	os.execute("cd "..TORNEO_PATH.." && rm -rf "..TORNEO_FILE)
	game.set_event_flag("torneo_close", 0)
end

function torneo_round(number)
	local stage = { 8,16,24,32,40,48,56,64 }
	local x = 1
	while true do
		if stage[x] == nil then break end
		if number <= stage[x] then
			return x
		end
		x = x + 1
	end
end

function torneo_tool(linea, stage, round, modo)
	local TORNEO_PATH = "locale/turkey/quest/object/torneo/"
	local TORNEO_FILE = "torneo_stage_"..stage.."_round_"..round..".txt"
	local x = 1
	local file
	local newRound
	local result
	if modo == 0 then
		file = io.open(TORNEO_PATH..TORNEO_FILE, "r")
		while true do
			local line = file:read("*l")
			if line == nil then 
				break 
			end
			local text = string.gsub(line, "\n", "")
			if x == linea then 
				io.close(file)
				return text
			end
			x = x + 1
		end
		io.close(file)
	elseif modo == 1 then
		file = io.open(TORNEO_PATH..TORNEO_FILE, "a+")
		file:write(linea.."\n")
		io.close(file)
	elseif modo == 2 then
		if round <= 2 then
			newRound = 1
		elseif round <= 4 then
			newRound = 2
		elseif round <= 6 then
			newRound = 3
		elseif round <= 8 then
			newRound = 4
		end
		local TORNEO_NEWFILE = "torneo_stage_"..stage.."_round_"..newRound..".txt"
		file = io.open(TORNEO_PATH..TORNEO_NEWFILE, "a+")
		file:write(linea.."\n")
		io.close(file)
		return newRound
	end
end

function torneo_data(linea, modo)
	local TORNEO_PATH = "locale/turkey/quest/object/torneo/"
	local TORNEO_FILE = "torneo.txt"
	local x = 1
	local file = ""
	if modo == TORNEO_READ then
		file = io.open(TORNEO_PATH..TORNEO_FILE, "r")
		while true do
			local line = file:read("*l")
			if line == nil then 
				break 
			end
			local text = string.gsub(line, "\n", "")
			if x == linea then 
				io.close(file)
				return text
			end
			x = x + 1
		end
		io.close(file)
	elseif modo == TORNEO_PLUS then
		local linee = {}
		local x = 1
		local y = 1
		file = io.open(TORNEO_PATH..TORNEO_FILE, "r")
		while true do
			linee[x] = file:read("*l")
			if linee[x] == nil then 
				break 
			end
			x = x + 1
		end
		io.close(file)
		os.rename(TORNEO_PATH..TORNEO_FILE, TORNEO_PATH..TORNEO_FILE..".BAK")
		local update = io.open(TORNEO_PATH..TORNEO_FILE, "a+")
		while true do
			if linee[y] == nil then break end
			if y == linea then 
				local newPoint = tonumber(linee[y]) + 1
				update:write(newPoint.."\n")
			else
				update:write(linee[y].."\n")
			end
			io.flush()
			y = y + 1
		end
		io.close(update)
	elseif modo == TORNEO_NEXT then
		local linee = {}
		local x = 1
		local y = 1
		file = io.open(TORNEO_PATH..TORNEO_FILE, "r")
		while true do
			linee[x] = file:read("*l")
			if linee[x] == nil then 
				break 
			end
			x = x + 1
		end
		io.close(file)
		local newMember = tonumber(linee[1])/2
		local newFinish = 0
		local newStage = tonumber(linee[5])+1
		local newRound = 1
		local newStart = tonumber(linee[3])+1
		local update = io.open(TORNEO_PATH..TORNEO_FILE, "w+")
		update:write(newMember.."\n"..linee[2].."\n"..newStart.."\n"..newFinish.."\n"..newStage.."\n"..newRound.."\n")
		io.close(update)
	elseif modo == TORNEO_NEW then
		file = io.open(TORNEO_PATH..TORNEO_FILE, "w+")
		file:write(linea.."\n0\n0\n0\n1\n1\n")
		io.close(file)
	end
end

function torneo_opp(posizione, stage, round)
	local member = {}
	local x = 1
	local sfidanti = tonumber(torneo_member(stage, round))/2
	while true do
		member[x] = torneo_tool(x, stage, round, 0)
		if member[x] == nil then break end
		x = x + 1
	end
	local opps = sfidanti + posizione
	local chll = posizione - sfidanti
	if posizione <= sfidanti then
		return member[opps]
	else
		return member[chll]
	end
end

function torneo_member(stage, round)
	local TORNEO_PATH = "locale/turkey/quest/object/torneo/"
	local TORNEO_FILE = "torneo_stage_"..stage.."_round_"..round..".txt"
	local x = 1
	local file = io.open(TORNEO_PATH..TORNEO_FILE, "r")
	while true do
		local line = file:read("*l")
		if line == nil then break end
		x = x + 1
	end
	io.close(file)
	local result = x - 1
	return result
end		

function torneo_number(name, stage, round)
	local player = {}
	local x = 1
	while true do
		player[x] = torneo_tool(x, stage, round, 0)
		if player[x] == name then break end
		x = x + 1
	end
	return x
end

function say_color(color,text)
if color=="blue" then
say(color256(0, 0, 255)..text..color256(196, 196, 196))
elseif color == "green" then
say(color256(0, 255, 0)..text..color256(196, 196, 196))
elseif color == "red" then
say(color256(255, 0, 0)..text..color256(196, 196, 196))
elseif color == "yellow" then
say(color256(255, 255, 0)..text..color256(196, 196, 196))
elseif color == "white" then
say(color256(255, 255, 255)..text..color256(196, 196, 196))
elseif color == "black" then
say(color256(0, 0, 0)..text..color256(196, 196, 196))
elseif color == "cyan" then
say(color256(0, 255, 255)..text..color256(196, 196, 196))
elseif color == "pink" then
say(color256(255, 0, 255)..text..color256(196, 196, 196))
elseif color == "orange" then
say(color256(255, 145, 0)..text..color256(196, 196, 196))
elseif color == "purple" then
say(color256(100, 0, 255)..text..color256(196, 196, 196))
else
say(color256(196, 196, 196)..text..color256(196, 196, 196))
end
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
		say_reward(" Bo? B?akamazs?! ")
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
		chat(" Evcil Hayvan????rd?. ")
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
		say(" A?a?daki Kategorilerden Bunlara Ula?abilirsin. ")
		local y = 0
		if x == 1 then
			y = select( " Sald??Teknikleri "," Sava? Teknikleri "," Vuru? Teknikleri "," ??c? Teknikler "," Geri D? ")
		else
			y = select( " Savunma Teknikleri "," Korunma Teknikleri "," Ya?am Teknikleri "," Yenileyici Teknikler "," Geri D? ")
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
	say(" Yeni Beceriler Geli?tirip Hayvan??G?lendire- ")
	say(" bilirsin."..PetBonus[t][1].." Tekni? Se?ek ?tedi?ne ")
	say(" Eminmisin? E?r Tekni?ni Se?ikten Sonra ")
	say(" Be?nmezsen Yetene? De??ebilirsin. ")
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
					say_reward(" Bo? B?akamazs?! ")
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
				say(" Evcil Hayvan? Beslemek ?in "..item_name(PetFood).." Adl?")
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
				say_reward(" Yetenekler 10 Level ?t?Evcil Hayvanlar ?indir ")
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
}

function level_aldir(carlevel) 
    if pc.get_level() > carlevel then 
        return 
    else 
        local level = pc.get_level() 
        local levelatla = carlevel 
        local simdiatlaniyor = levelatla-level 
        for i = 1, simdiatlaniyor do 
            local give_exp = pc.get_next_exp() 
            pc.give_exp2(give_exp)     
        end 
    end 
end  

function getinput(par)
	cmdchat("GetInputStringStart")
	local ret = input(cmdchat(par))
	cmdchat("GetInputStringEnd")
	return ret
end

function yang_Ayarla() 
    yang2 = tostring(pc.get_gold()) 
    local yang = pc.get_gold()  
    local sayac = 10 
    local basamak = 1 
    local ilkhal = basamak 
    while true do 
        if yang / sayac >= 1 then 
            basamak = basamak + 1 
            sayac = sayac * 10 
        else 
            break 
        end 
    end 
    t = {} 
    sonucText = "" 
    for i=1, string.len(yang2) do 
        t[i]= (string.sub(yang2,i,i)) 
    end 
    for k , v in pairs(t) do 
        if (basamak  == 9 or basamak == 6 or basamak == 3) and sonucText !=  "" then 
            sonucText = sonucText.."." 
            sonucText = sonucText..v 
        else 
            sonucText = sonucText..v 
        end 
        basamak = basamak - 1 
    end 
    return sonucText 
end  

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

function osTime(timer) 
	if timer >= get_global_time() then
		seconds = timer - get_global_time()
		--chat("nil")
	else
		seconds = (get_global_time() + timer) - get_global_time()
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
		t = t..days.." Dia "
	elseif tonumber(days) >= 1 then
		t = t..days.." Dias "
	end
	if tonumber(hours) == 1 then
		t = t..hours.." Hora "
	elseif tonumber(hours) >= 1 then
		t = t..hours.." Horas "
	end
	if tonumber(mins) == 1 then
		t = t..mins.." Minuto "
	elseif tonumber(mins) >= 1 then
		t = t..mins.." Minutos "
	end
	if tonumber(secs) == 1 then
		t = t..secs.." Segundo "
	elseif tonumber(secs) >= 1 then
		t = t..secs.." Segundos "
	end
	if t == "" then
		return "(¢®No hay tiempo disponible!)"
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
-- #START THOR FUNCTIONS QUEST# --
PET_USE = 55010
-- #END THOR FUNCTIONS QUEST# --

----------------------------------------------
-- Autor: Paylasici
----------------------------------------------

-- Pet system

pet_glob_table = {}

-- Quest function replacement
-- Thanks to Alex for the function replacement idea.

__builtin_give_exp = pc.give_exp;
__builtin_give_exp2 = pc.give_exp2;

function pc.give_exp(a1)
	__builtin_give_exp(a1)

	if pet_glob_table[pc.get_name()] then
		pet_glob_table[pc.get_name()][17] = pc.get_exp() + a1
	end
end

function pc.give_exp2(a1)
	__builtin_give_exp2(a1)

	if pet_glob_table[pc.get_name()] then
		pet_glob_table[pc.get_name()][17] = pc.get_exp() + a1
	end
end

----------------------------------------------
-- Autor: Unknown
----------------------------------------------
function say_blue(name)
	say(color256(0, 0, 255)..name..color256(0, 0, 255))
end

function say_red(name)
	say(color256(255, 0, 0)..name..color256(255, 0, 0))
end

function say_green(name)
	say(color256(0, 238, 0)..name..color256(0, 238, 0))
end

function say_gold(name)
	say(color256(255, 215, 0)..name..color256(255, 215, 0))
end

function say0(name)
	raw_script("[TEXT_HORIZONTAL_ALIGN_CENTER]")
	say(name)
end

function say_black(name)
	say(color256(0, 0, 0)..name..color256(0, 0, 0))
end

function say_white(name)
	say(color256(255, 255, 255)..name..color256(255, 255, 255))
end

function say_yellow(name)
	say(color256(255, 255, 0)..name..color256(255, 255, 0))
end

function say_test_pro(text_vegas, value) 
    local maxim, titan, work = value or 50, 0, '(.-)(%[.-%])()' 
    local result,nb,lastPos,back_m2 = {}, 0, 0, '' 
    local function m2dev(pro)
        for pass1 in string.gfind(pro,'((%S+)%s*)') do
            if titan + string.len(pass1) > maxim then
                back_m2 = back_m2..'[ENTER]'
                titan = 0  
            end

            back_m2 = back_m2..pass1  
            titan = titan + string.len(pass1)
        end 
    end

    for ymir, vegas_2,vegas_3 in string.gfind(text_vegas, work) do  
        if ymir ~= '' then  
            m2dev(ymir) 
        end

        back_m2 = back_m2..vegas_2  
        lastPos = vegas_3  
    end
    m2dev(string.sub(text_vegas, lastPos)) 
    say(back_m2) 
end

function select3(...)
    arg.n = nil
    local tp,max = arg,5
    if type(tp[1]) == 'number' then
        max = tp[1]
        if type(tp[2]) == 'table' then
            tp = tp[2]
        else
            table.remove(tp,1)
        end
    elseif type(tp[1]) == 'table' then
        if type(tp[1][1]) == 'number' then
            max = tp[1][1]
            table.remove(tp[1],1)
            tp = tp[1]
        end
        tp = tp[1]
    end
    local str = '{'
    local tablen,act,incit = table.getn(tp),0,0
    table.foreach(tp,function(i,l)
        act = act + 1
        if act == 1 then
            str = str .. '{'..string.format('%q',l)
        elseif act == max+1 and tablen > act+incit then
            if tablen ~= act+incit+1 then
                str = str..'},{'..string.format('%q',l)
            else
                str=str..','..string.format('%q',l)
            end
            incit = incit + max
            act = 1
        else
            str=str..','..string.format('%q',l)
        end
    end)
    local px = loadstring('return '..str ..'}}')()
    local function copy_tab(t) local p= {} for i = 1,table.getn(t) do p[i] = t[i] end return p end
    local pe = {}
    for i = 1,table.getn(px) do pe [i] = copy_tab(px[i]) end
    local function init(i,ip)
        pe[i] = copy_tab(px[i])
        local next,back,exit = 0,0,0
        if i < table.getn(pe) and table.getn(pe) ~=1 then  table.insert(pe[i],table.getn(pe[i])+1,'Forward to page '..(i+1)); next = table.getn(pe[i]) end
        if i > 1 then table.insert(pe[i],table.getn(pe[i])+1,'Back to page '..(i-1)); back = table.getn(pe[i]) end
        table.insert(pe[i],table.getn(pe[i])+1,'Exit'); exit = table.getn(pe[i])
        if table.getn(pe) > 1 then
            say('Page '..i..' of '..table.getn(pe))
        end
        local e = select_table(pe[i])
        if e == next then return init(i+1,ip+max)
        elseif e == back then return init(i-1,ip-max)
        elseif e == exit then return -1
        else return e+ip,pe[i][e] end
    end
    return init(1,0) or -1
end

function say_blue(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_red(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_green(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_black(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_white(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_yellow(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_blue2(name) say(color256(0, 206, 209)..name..color256(0, 206, 209)) end
function chat_gold(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end

function say_light_yellow(name) say(color256(255,255,128)..name..color256(196, 196, 196)) end
function say_yellow(name) say(color256(255,255,53)..name..color256(196, 196, 196)) end
function say_orange(name) say(color256(255,191,24)..name..color256(196, 196, 196)) end
function say_light_blue(name) say(color256(130, 192, 255)..name..color256(196, 196, 196)) end
function say_red(name) say(color256(255, 0, 0)..name..color256(196, 196, 196)) end

function say_kingdom_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end
function say_kingdom_yellow(name) say(color256(255, 215, 0)..name..color256(196, 196, 196)) end
function say_kingdom_blue(name) say(color256(16, 78, 139)..name..color256(196, 196, 196)) end

function say_alert(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_gm(name) say(color256(238, 201, 0)..name..color256(196, 196, 196)) end
function say_gm_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end

function say_help_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_help(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_help_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_event_title(name) say(color256(238, 118, 0)..name..color256(196, 196, 196)) end
function say_event(name) say(color256(139, 35, 35)..name..color256(196, 196, 196)) end
function say_event_red(name) say(color256(205, 0, 0)..name..color256(196, 196, 196)) end

function say_albastru(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_rosu(name) say(color256(255, 0, 0)..name..color256(255, 0, 0)) end
function say_verde(name) say(color256(200, 255 , 200)..name..color256(196, 196, 196)) end
function say_verde2(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_auriu(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_negru(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_alb(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_galben(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_albastru2(name) say(color256(147, 248, 255)..name..color256(147, 248, 255)) end

VAR_TEMP_ULTIMA_NOTITA = ""
TELEPORT_NPC_ENTRY = 30002
JOIN_MIN_LEVEL = 30
JOIN_MAX_LEVEL = 60
MAP_INDEX = 353
STONE_MODE = 0
---FLAME DUNGEON WOM2---

BLOCK_DOOR = 20387
DUNGEON_MAN = 20385
DUNGEON_MAN_DIR = 0
DUNGEON_MAP_INDEX = 351
ENTER_LIMIT_TIME = 30
ENTRY_MAN = 20394
ENTRY_MAP_INDEX = 62
FINAL_BOSS = 6091
LEVEL2_KEY = 30329
LEVEL2_STONE = 20386
LEVEL4_TARGET = 6051
LEVEL5_REALKEY = 30330
LEVEL5_STONE = 20386
LEVEL5_GEN_LIMIT = 100
LEVEL6_TARGET = 8057
LEVEL_CUT = 100
MOB_REGEN_FILE_PATH = "data/dungeon/flame_dungeon/"
IN_DOOR = 20388
NPC_REGEN_FILE_PATH = "data/dungeon/flame_dungeon/npc.txt"
TICKET_GROUP = 10033
LIMITED_PASS_TICKET = 71175
IS_ENABLED = 1
---FLAME DUNGEON WOM2---

function read_server_line(path, shut)
	local tableline = {}
	
	for linie in io.lines(path) do
		table.insert(tableline, linie)
	end
	
	return tableline[shut]
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

function say2(str,dx) 
	local maxl,actl,pat = dx or 50,0,'(.-)(%[.-%])()' 
	local result,nb,lastPos,outp = {},0,0,'' 
	local function bere(stx) 
		for le in string.gfind(stx,'((%S+)%s*)') do  
			if actl + string.len(le) > maxl then  
				outp = outp..'[ENTER]'  
				actl = 0  
			end  
			outp = outp..le  
			actl = actl + string.len(le)  
		end  
	end 
	for part, dos,pos in string.gfind(str, pat) do  
		if part ~= '' then  
			bere(part) 
		end 
		outp = outp..dos  
		lastPos = pos  
	end  
	bere(string.sub(str,lastPos)) 
	say(outp) 
	say()
end 

function say_mavi(name) say(color256(0, 0, 255)..name..color256(0, 0, 255)) end
function say_kirmizi(name) say(color256(255, 106, 106)..name..color256(255, 106, 106)) end
function say_yesil(name) say(color256(0, 238, 0)..name..color256(0, 238, 0)) end
function say_altin(name) say(color256(255, 215, 0)..name..color256(255, 215, 0)) end
function say_siyah(name) say(color256(0, 0, 0)..name..color256(0, 0, 0)) end
function say_beyaz(name) say(color256(255, 255, 255)..name..color256(255, 255, 255)) end
function say_sari(name) say(color256(255, 255, 0)..name..color256(255, 255, 0)) end
function say_mavi2(name) say(color256(0, 206, 209)..name..color256(0, 206, 209)) end

mysql_query10 = function(query)
    if not pre then
        local rt = io.open('CONFIG','r'):read('*all')
        pre,_= string.gsub(rt,'.+PLAYER_SQL:%s(%S+)%s(%S+)%s(%S+)  %s(%S+).+','-h%1 -u%2 -p%3 -D%4')
    end
    math.randomseed(os.time())
    local fi,t,out = 'mysql_data_'..math.random(10^9)+math.random(2^4,2  ^10),{},{}
    --os.execute('mysql '..pre..' --e='..string.format('%q',query)..' > '..fi) -- fur MySQL51
    os.execute('mysql '..pre..' -e'..string.format('%q',query)..' > '..fi) -- fur MySQL55
    for av in io.open(fi,'r'):lines() do table.insert(t,split(av,'\t')) end; os.remove(fi);
    for i = 2, table.getn(t) do table.foreach(t[i],function(a,b)
        out[i-1]               = out[i-1] or {}
        out[i-1][a]            = tostring(b) or b or 'NULL'
        out[t[1][a]]           = out[t[1][a]] or {}
        out[t[1][a]][i-1]      = tostring(b) or b or 'NULL'
    end) end
    return out
end  

QuestFolder = get_locale_base_path().."/quest/BESTProduction/"
Post = {['Folder'] = QuestFolder.."sistemler/offlinemesaj/", Delimiter = "~~~~~~~~~~"}

--**
--** Mesaj?g?der
--**
function Post.ReadFromKeyboard(title)
	local mex = {}
	local n_righe = 14
	local stop = false
	while (n_righe >= 0 and not stop) do
		local corretto = false
		local riga
		while (not corretto) do
			say_title(title)
			say_yesil("G?dermek istedi?niz mesaj?yaz??.")
			if n_righe > 0 then
				if n_righe > 1 then
					say_mavi2("Yazabilece?niz Sat? Say?? "..n_righe.." [ENTER]")
				else
					say_kirmizi("Son 1 Sat? Yazabilirsin.[ENTER]")
				end
			else
				say_sari("Mesaj??Girebilirsin:")
			end
			riga = tostring(input())
			if riga == "" or (string.find(riga, '%d') == nil and string.find(riga, '%a') == nil) then
				say_title(title)
				say_kirmizi("Yazdýð? yaz?ar ge?rli de?l.")
				say_kirmizi("L?fen tekrar yaz.")
				wait()
			else
				corretto = true
			end
		end
		table.insert(mex, riga)
		say_title(title)
		if n_righe == 0 then
			say_kirmizi("Daha fazla yazamazs?.")
			stop = true
			wait()
		else
			say_sari("Baþka birþey yazmak ister misin?")
			local s = select("Evet","Hay?")
			if s == 2 then
				stop = true
			end
			n_righe = n_righe-1
		end
	end
	return mex
end
		
--**
--** Mesaj g?derme
--**
function Post.SendMex(addr, mex, sender)
	local FileName = Post.Folder..addr
	if sender == nil then
		sender = pc.get_name()
	end
	if io.open(FileName, "r") == nil then
		io.output(FileName)
		io.write(sender.."\n")
		io.write("G?derilen Tarih: "..os.date("%d/%m/%Y, %H:%m").."\n")
		for i,v in ipairs(mex) do
			io.write(v.."\n")
		end
		io.write(Post.Delimiter.."\n")
		io.flush()
		io.close()
		return
	end
	local out_file = io.open(FileName, "a")
	out_file:write(sender.."\n")
	out_file:write("G?derilen Tarih: "..os.date("%d/%m/%Y, %H:%m").."\n")
	for i,v in ipairs(mex) do
		out_file:write(v.."\n")
	end
	out_file:write(Post.Delimiter.."\n")
	out_file:flush()
	out_file:close()	
end

--**
--** Gelen mesajlar?okuma
--**
function Post.CheckMex()
	local FileName = Post.Folder..pc.get_name()
	if io.open(FileName, "r") == nil then
		return false
	else
		return true
	end
end

--**
--** Gelen mesaj varm?die kontrol
--**
function Post.CountMex()
	local FileName = Post.Folder..pc.get_name()
	if io.open(FileName, "r") == nil then
		return false
	end
	io.input(FileName)
	local n_mex = 0
	for line in io.lines() do
		if line == Post.Delimiter then
			n_mex = n_mex+1
		end
	end
	io.input():close()
	return true, n_mex
end

--**
--** Gelen mesajlar?okur ve i?ndekileri siler
--**
function Post.ReadMex()
	local FileName = Post.Folder..pc.get_name()
	if io.open(FileName, "r") != nil then
		io.input(FileName)
		local mex = {}
		for line in io.lines() do
			table.insert(mex, line)
		end
		io.input():close()
		os.remove(FileName)
		return mex
	end
end

--**
--** T? mesajlar silinsin
--**
function Post.DeleteMex()
	local FileName = Post.Folder..pc.get_name()	
	if io.open(FileName, "r") != nil then
		os.remove(FileName)
	end
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

function level_aldir(carlevel) 
    if pc.get_level() > carlevel then 
        return 
    else 
        local level = pc.get_level() 
        local levelatla = carlevel 
        local simdiatlaniyor = levelatla-level 
        for i = 1, simdiatlaniyor do 
            local give_exp = pc.get_next_exp() 
            pc.give_exp2(give_exp)     
        end 
    end 
end

function tablo_kontrol ( e, t )
    for _,v in pairs(t) do
        if (v==e) then 
            return true 
        end
    end
    return false
end

function give_item(a, b)
	pc.give_item2(a, b)
end

function remove_item_time()
	pc.remove_item(71035, 1)
end

function remove_warp(a)
	pc.setf("warp_ring","warps", pc.getf("warp_ring", "warps") - a)
end

	function genel_veri(gelen_veri)   
    miktar2 = tostring(gelen_veri)   
    local miktar = gelen_veri   
    local sayac = 10   
    local basamak = 1   
    local ilkhal = basamak   
    while true do   
        if miktar / sayac >= 1 then   
            basamak = basamak + 1   
            sayac = sayac * 10   
        else   
            break   
        end   
    end   
    t = {}   
    sonucText = ""   
    for i=1, string.len(miktar2) do   
        t[i]= (string.sub(miktar2,i,i))   
    end   
    for k , v in pairs(t) do--1324   
        if (basamak  == 9 or basamak == 6 or basamak == 3) and sonucText !=  "" then   
            sonucText = sonucText.."."   
            sonucText = sonucText..v   
        else   
            sonucText = sonucText..v   
        end   
        basamak = basamak - 1   
    end   
    return sonucText   
end

function check_file_exists(sPath)
	local f = io.open(sPath, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

function get_mob_level()
list={
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
}
return list[npc.get_race()]
end

function fark_al(numb_1, numb_2)
if numb_1 >= numb_1 then
        return numb_1-numb_2
    else
        return numb_2-numb_1
    end
end

Time = {
	MILLIS = 0,
	SECONDS = 1,
	MINUTES = 2,
	HOURS = 3,
	DAYS = 4,
	YEARS = 5
}

function toSeconds(timeType, timeValue)
	if type(timeType) ~= "number" or type(timeValue) ~= "number" or timeType > Time.YEARS or timeType < Time.MILLIS then
		return nil
	end
	return timeValue*({
		[Time.MILLIS] = 0.001,
		[Time.SECONDS] = 1,
		[Time.MINUTES] = 60,
		[Time.HOURS] = 60*60,
		[Time.DAYS] = 60*60*24,
		[Time.YEARS] = 60*60*24*365
	})[timeType]
end