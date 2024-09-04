require "ISUI/ISPlayerData"
require "ISUI/ISInventoryPane"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISInventoryTransferAction"

local KEY_TRANSFER = {
	name = "Transfer item(s) to backpack",
	key = Keyboard.KEY_BACKSLASH,
}

if ModOptions and ModOptions.AddKeyBinding then
	ModOptions:AddKeyBinding("[Player Control]", KEY_TRANSFER)
end

--- Extract InventoryItem from Lua table containers
local function getSingleItem(item)
    if (item["items"] ~= nil) then
        return getSingleItem(item["items"])
    elseif (type(item) == "table") then
        return getSingleItem(item[1])
    else
        return item
    end
end

local function KeyUp(keynum)
	if keynum == KEY_TRANSFER.key then
		local player = getSpecificPlayer(0)
		local primary = player:getPrimaryHandItem();
        local secondary = player:getSecondaryHandItem();
		local selected = getPlayerInventory(0).inventoryPane.selected
		local back = player:getClothingItem_Back():getItemContainer()
		for _, inventoryItem in pairs(selected) do
            local item = getSingleItem(inventoryItem)
            -- ignore favorite and equipped items
            if (not item:isFavorite() and not player:isEquipped(item)) then
                -- create "timed action" to transfer items (game api)
                ISTimedActionQueue.add(ISInventoryTransferAction:new(player, item, item:getContainer(), back))
            end
        end
	end
end
Events.OnKeyPressed.Add(KeyUp);
