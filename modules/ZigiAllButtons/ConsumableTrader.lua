function ConsumableTrader(tradable)
	local c=C_Container 
	for i=0,4 do 
		for x=1,c.GetContainerNumSlots(i)do 
			y=c.GetContainerItemLink(i,x)
			if y and GetItemInfo(y)== tradable then 
				c.PickupContainerItem(i,x)DropItemOnUnit("target")
				return TradeFrameTradeButton:Click() 
			end 
		end 
	end
end
