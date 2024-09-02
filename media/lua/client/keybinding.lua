local KEY_SIT = {
	name = "Transfer item(s) to backpack",
	key = Keyboard.KEY_BACKSLASH,
}

if ModOptions and ModOptions.AddKeyBinding then
	ModOptions:AddKeyBinding("[Player Control]",KEY_SIT)
end

local function KeyUp(keynum)
    print ("KeyUp")
	local specificPlayer = getSpecificPlayer(0)
	if specificPlayer ~= nil then
		if keynum == KEY_SIT.key then
			ISWorldObjectContextMenu.onSitOnGround(0)
            print ("KEYBACKSLASH")
	end
end
Events.OnKeyPressed.Add(KeyUp);