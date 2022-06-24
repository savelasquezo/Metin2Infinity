quest AutoMSM begin
	state start begin
		when login begin
			timer("timer1", 300)
		end
		when timer1.timer begin
			timer("timer2", 1800)
			notice("<Inf> Enterate de todas las Novedades.")
			notice("<Inf> WEB: https://www.metin2lamda.com/ ")
		end
		when timer2.timer begin
			timer("timer3", 1800)
			notice("<Inf> Recordamos que no Debes Incumplir Ninguna Regla.")
			notice("<Inf> Evita Sanciones. ")
		end
		when timer3.timer begin
			timer("timer4", 1800)
			notice("<Inf> Problemas/Sugerencias Reportalos en Nuestro Discord")
			notice("<Inf> https://discord.gg/33Ygcjs4 ")
		end
		when timer4.timer begin
			timer("timer5", 1800)
			notice("<Inf> Nuevas Opcion de Compra de MDs Paypal via Discord!!")
			notice("<Inf> https://discord.gg/33Ygcjs4 ")
		end
		when timer5.timer begin
			timer("timer1", 1800)
			notice("<Inf> Donaciones Disponibles por Nuestra WEB!! Aplican Promociones")
			notice("<Inf> https://www.metin2lamda.com ")
		end
	end
end
