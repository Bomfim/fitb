local KEY_SIT = {
	name = "Transfer item(s) to backpack",
	key = Keyboard.KEY_BACKSLASH,
}

if ModOptions and ModOptions.AddKeyBinding then
	ModOptions:AddKeyBinding("[Hotkeys]",KEY_SIT)
end

local function KeyUp(keynum)
	local specificPlayer = getSpecificPlayer(0)
	if specificPlayer ~= nil then
		if keynum == KEY_SIT.key then -- Num_0
			ISWorldObjectContextMenu.onSitOnGround(0)
	end
end
Events.OnKeyPressed.Add(KeyUp);