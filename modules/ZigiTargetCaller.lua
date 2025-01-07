-- call rares to general chat or targets to focus if they are a player.
function ZigiTargetCaller(target)
	if UnitRace("target") then SendChatMessage("Kill my target NOW! ->> %t the "..(UnitRace("target").." "..UnitClass("target")).." ", IsInGroup(2) and "instance_chat" or IsInRaid() and "raid" or IsInGroup() and "party" or "say")
	elseif target == nil then 
		return 
	else
		local a=target
		local b=C_Map
		local c="player"
		local d=b.GetBestMapForUnit(c)
		local e=b.GetPlayerMapPosition(d,c)
		local f= "("..format("%.1f",(UnitHealth("target")/UnitHealthMax("target")*100)).."%)"
		if f == "0.0" then
			f = "is dead"
			SendChatMessage(a.. " " ..f,"CHANNEL",c,1)
		else
			b.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(d,e.x,e.y))
			if b.GetUserWaypointHyperlink() ~= nil then
				SendChatMessage(a.. " "..f.." at "..b.GetUserWaypointHyperlink() or "","CHANNEL",c,1)
			end
			b.ClearUserWaypoint()
		end
	end
end