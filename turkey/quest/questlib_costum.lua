--[[
Server Files Author : BEST Production
Skype : best_desiqner@hotmail.com
Website : www.bestproduction-projects.com
--]]
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

mysql_query = function(query)
    if not pre then
        local rt = io.open('CONFIG', 'r'):read('*all')
        pre = string.gsub(rt, '.+PLAYER_SQL:%s(%S+)%s(%S+)%s(%S+)%s(%S+).+', '-h%1 -u%2 -p%3 -D%4')
    end

    math.randomseed(os.time())

    local fi, t, out = 'mysql_data_'..math.random(10^9)+math.random(2^4,2^10),{},{}
    os.execute('mysql '..pre..' --e='..string.format('%q', query)..' > '..fi)

    for av in io.open(fi, 'r'):lines() do table.insert(t,split(av, '\t')) end; os.remove(fi);
    for i = 2, table.getn(t) do table.foreach(t[i],function(a, b)
        out[i-1]               = out[i-1] or {}
        out[i-1][a]            = tonumber(b) or b
        out[t[1][a]]           = out[t[1][a]] or {}
        out[t[1][a]][i-1]      = tonumber(b) or b
    end) end
    return out
end

function split(str, delim, maxNb)
    if str == nil then
		return str
	end

    if string.find(str, delim) == nil then
		return { str }
	end

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

    if nb ~= maxNb then result[nb + 1] = string.sub(str, lastPos)
	end
    return result
end