quest GuildSystem2 begin
	state start begin
		when login begin
			clear_server_timer("tanit_cache")
			server_loop_timer("tanit_cache", 30)
			lonca_tanitim_tablosu = game.mysql_query2("SELECT guild.name,guild.lider,guild.level,guild.id,guild.win,guild.draw,guild.loss,guild.bayrak,guild.rc FROM player.guild ORDER BY guild.level DESC, guild.ladder_point DESC;")
		end
		when tanit_cache.server_timer begin
			lonca_tanitim_tablosu = game.mysql_query2("SELECT guild.name,guild.lider,guild.level,guild.id,guild.win,guild.draw,guild.loss,guild.bayrak,guild.rc FROM player.guild ORDER BY guild.level DESC, guild.ladder_point DESC;")
		end
	end
end
