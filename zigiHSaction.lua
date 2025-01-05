-- performs action when using Healthstone keybind --> PlaySound() and DoEmote()
function zigiHS()
	if (C_Item.GetItemCount("Healthstone", false) >= 1) or (C_Item.GetItemCount("Demonic Healthstone", false) >= 1) then
		PlaySound(15160)
		DoEmote("glare")
	else	
		PlaySound(15160)
		DoEmote("cry")
	end
end