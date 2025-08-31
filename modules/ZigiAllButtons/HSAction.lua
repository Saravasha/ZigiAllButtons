-- performs action when using Healthstone keybind --> PlaySound() and DoEmote()
function HSAction()
	if (ZG.Item_Count("Healthstone") >= 1) or (ZG.Item_Count("Demonic Healthstone") >= 1) then
		PlaySound(15160)
		DoEmote("glare")
	else	
		PlaySound(15160)
		DoEmote("cry")
	end
end