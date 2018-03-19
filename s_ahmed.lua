executeSQLQuery( 'CREATE TABLE IF NOT EXISTS `Bank` (playerSerial,Money) ' )
local join = createMarker(2019.32788,1007.83344,10., "arrow", 1.5,255,6,0)
local out_bank = createMarker(390.76727,173.81624,1008.,"arrow",1.5,255,6,0)
createBlip(2019.32788,1007.83344,10.,52)
setElementInterior(out_bank,3)

addEventHandler("onMarkerHit",root,
	function (player)
		if  getElementType(player) == "player"  and source == join then 
			if isPedInVehicle(player) then return end 
			setElementInterior(player,3,385.29572,173.74980,1008.38281)
			fadeCamera (player,false)
			setTimer(fadeCamera,2000, 1,player,true)
			outputChatBox("مرحبا بك في المصرف يا"..getPlayerName(player).."",player,0,255,0,true)
		elseif   source == out_bank then
			fadeCamera (player,false)
			setTimer(fadeCamera,2000,1,player,true )
			setElementInterior(player,0,2027.56958,1007.84766,10.82031)
		end 
	end 
) 

addEvent("onPlayerSaveMoney",true)
addEventHandler("onPlayerSaveMoney",root,
	function (money)
		if getPlayerMoney(source) >= tonumber(money) then 
			if  tonumber(money) then 
				local checkData = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(source) )
				if ( type ( checkData ) == 'table' and #checkData == 0 or not checkData ) then
					setElementData(source,"Bank",tonumber(money))
					takePlayerMoney(source,tonumber(money))
					executeSQLQuery( 'INSERT INTO `Bank` (playerSerial,Money) VALUES(?, ?) ',getPlayerSerial(source),getElementData(source,"Bank"))
					outputChatBox("لقد تم حفظ فلوسك في المصرف",source,0,255,0,true)
				else
					setElementData(source,"Bank",getElementData(source,"Bank")+tonumber(money))
					takePlayerMoney(source,tonumber(money))
					outputChatBox("لقد تم حفظ فلوسك في المصرف",source,0,255,0,true)
					executeSQLQuery(" UPDATE `Bank` SET playerSerial = ?,Money = ? ",getPlayerSerial(source),getElementData(source,"Bank"))
				end
			else
				outputChatBox("يجب عليك كتبت ارقام وليس احرف",source,0,255,0,true)
			end
		else
			outputChatBox("ليس لديك المال الكافي لحفظ الفلوس",source,0,255,0,true)
		end
	end 
)


addEvent("onPlayerTakeMoneyFromBank",true)
addEventHandler("onPlayerTakeMoneyFromBank",root,
	function (money2)
		local check = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(source) )
		if tonumber(money2) then 
			if ( type ( check ) == 'table' and #check == 0 or not check ) then return  outputChatBox("ليس لديك المال محفوظ في المصرف",source,0,255,0,true) end
			if getElementData(source,"Bank") >= tonumber(money2) then 
				--local s = check[1]['Money']
				setElementData(source,"Bank",getElementData(source,"Bank")-tonumber(money2))
				executeSQLQuery(" UPDATE `Bank` SET playerSerial = ?,Money = ?",getPlayerSerial(source),getElementData(source,"Bank"))
				givePlayerMoney(source,tonumber(money2))
				outputChatBox("لقد تم سحب فلوس "..money2.."",source,0,255,0,true)
				outputChatBox("فلوسك الان في المصرف "..getElementData(source,"Bank").."",source,0,255,0,true)
			else
				outputChatBox("لا يمكن سحب المال ",source,0,255,0,true)
			end 
		else
			outputChatBox("يجب عليك كتبت ارقام و ليس حروف",source,0,255,0,true)
		end 
	end 
)

addEvent("onPlayerGetData",true)
addEventHandler("onPlayerGetData",root,
	function ()
		local check2 = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(source) )
		if ( type ( check2 ) == 'table' and #check2 == 0 or not check2 ) then return   end
		local money3 = check2[1]['Money']
		setElementData(source,"Bank",money3)
	end 
) 

addEvent("onPlayerSetData",true)
addEventHandler("onPlayerSetData",root,
	function (name,money5)
		plrr = getPlayerFromName(name)
		if tonumber(money5) then 
			if plrr ~= source then 
				if plrr then 
					local check4 = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(source) )
					if ( type ( check4 ) == 'table' and #check4 == 0 or not check4 ) then return  outputChatBox("ليس لديك المال محفوظ في المصرف",source,0,255,0,true) end
					if getElementData(source,"Bank") >= tonumber(money5) then 
						setElementData(plrr,"Bank",getElementData(plrr,"Bank")+tonumber(money5))
						setElementData(source,"Bank",getElementData(source,"Bank")-tonumber(money5))
						local Data = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(plrr) )
						if ( type ( Data ) == 'table' and #Data == 0 or not Data ) then
							executeSQLQuery( 'INSERT INTO `Bank` (playerSerial,Money) VALUES(?, ?) ',getPlayerSerial(plrr),getElementData(plrr,"Bank"))
							outputChatBox(""..getPlayerName(source).." لقد ارسل لك المال",plrr,0,255,0,true)
							outputChatBox(""..money5.." وقدره",plrr,0,255,0,true)
							local Data2 = executeSQLQuery( ' SELECT * FROM `Bank` WHERE playerSerial = ? ', getPlayerSerial(source) )
							if ( type ( Data2 ) == 'table' and #Data2 == 0 or not Data2 ) then
								executeSQLQuery( 'INSERT INTO `Bank` (playerSerial,Money) VALUES(?, ?) ',getPlayerSerial(source),getElementData(source,"Bank"))
								outputChatBox("لقد تم التحويل بنجاح",source,0,255,0,true)
							else
								executeSQLQuery(" UPDATE `Bank` SET playerSerial = ?,Money = ? ",getPlayerSerial(source),getElementData(source,"Bank"))
								outputChatBox("لقد تم التحويل بنجاح",source,0,255,0,true)
							end 
						else
							executeSQLQuery(" UPDATE `Bank` SET playerSerial = ?,Money = ? ",getPlayerSerial(plrr),getElementData(plrr,"Bank"))
							outputChatBox(""..getPlayerName(source).." لقد ارسل لك المال",plrr,0,255,0,true)
							outputChatBox(""..money5.." وقدره",plrr,0,255,0,true)
						end 
					else
						outputChatBox("ليس لديك المال الكافي في المصرف",source,0,255,0,true)
					end 
				else
					outputChatBox("لا يوجد هدا الاعب في السيرفر",source,0,255,0,true)
				end
			else
				outputChatBox("لا يمكن تحويل الي نفسك المال",source,0,255,0,true)
			end
		else
			outputChatBox("يجب كتبت ارقام وليس حروف",source,0,255,0,true)
		end 
	end 
)
