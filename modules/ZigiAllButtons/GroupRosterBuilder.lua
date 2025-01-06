function groupRosterBuilder(role)
	if role == "tank" then
		role = "help,nodead" 
		for i = 1, 5 do 
			if UnitGroupRolesAssigned("party"..i) == "TANK" then 
				role = "@".."party"..i 
				-- print("Role Tank found at: ",role)
				return role or ""
			else
				-- print("Tank not found!")
				return role or ""
			end 
		end
	elseif role == "healer" then
		role = "help,nodead"
		for i = 1, 5 do  
			if UnitGroupRolesAssigned("party"..i) == "HEALER" then 
				role = "@".."party"..i 
				-- print("Role Healer found at: ",role)
				return role or ""
			else
				-- print("Healer not found!")
				return role or ""
			end  
		end
	end
end