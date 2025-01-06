-- call rares to general chat or targets to focus if they are a player.
function ZigiTargetCaller(target)
	if UnitRace("target") then SendChatMessage("Kill my target NOW! ->> %t the "..(UnitRace("target").." "..UnitClass("target")).." ", IsInGroup(2) and "instance_chat" or IsInRaid() and "raid" or IsInGroup() and "party" or "say")
	elseif target == nil then 
		return 
	else
		a=target
		b=C_Map
		c='player'
		d=b.GetBestMapForUnit(c)
		e=b.GetPlayerMapPosition(d,c)
		b.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(d,e.x,e.y))
		SendChatMessage(a..' at '..b.GetUserWaypointHyperlink(),'CHANNEL',c,1)
		b.ClearUserWaypoint()
	end
end