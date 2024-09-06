require "ISUI/ISPlayerData"
require "ISUI/ISInventoryPane"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISInventoryTransferAction"

local KEY_TRANSFER = {
    name = "Transfer item(s) to backpack",
    key = Keyboard.KEY_BACKSLASH,
}

if ModOptions and ModOptions.AddKeyBinding then
    ModOptions:AddKeyBinding("[Hotkeys]", KEY_TRANSFER)
end

local function KeyUp(keynum)
    if keynum == KEY_TRANSFER.key then
        local player = getSpecificPlayer(0)
        local selectedItems = getPlayerInventory(0).inventoryPane.selected
        local back = player:getClothingItem_Back():getItemContainer() --getItemContainer()

        if selectedItems == nil then
            return
        end

        for _, item in pairs(selectedItems) do
            local itemsTable = item.items
            for _, subitem in pairs(itemsTable) do
                ISTimedActionQueue.add(ISInventoryTransferAction:new(player, subitem, subitem:getContainer(), back))
            end
        end
    end
end
Events.OnKeyPressed.Add(KeyUp);
