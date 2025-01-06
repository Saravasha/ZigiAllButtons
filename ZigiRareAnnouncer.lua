local frame = CreateFrame("FRAME", "ZigiRareAnnouncer")


-- call rares to general chat
function ZigiRareAnnouncer(target)
	if target == nil then 
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