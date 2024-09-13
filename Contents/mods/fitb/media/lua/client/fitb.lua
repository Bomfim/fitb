require "ISUI/ISPlayerData"
require "ISUI/ISInventoryPane"
require "ISUI/ISInventoryPage"
require "TimedActions/ISTimedActionQueue"
require "TimedActions/ISInventoryTransferAction"

local KEY_TRANSFER = {
    name = "FITB",
    key = Keyboard.KEY_COMMA,
}

if ModOptions and ModOptions.AddKeyBinding then
    ModOptions:AddKeyBinding("[Hotkeys]", KEY_TRANSFER)
end

local function KeyUp(keynum)
    if keynum == KEY_TRANSFER.key then
        local playerInv = getPlayerInventory(0)
        if playerInv.isCollapsed == true then return; end

        if (table.isempty(playerInv.inventoryPane.selected)) then return; end

        local playerObj = getSpecificPlayer(0)
        if not playerObj:getClothingItem_Back() or not instanceof(playerObj:getClothingItem_Back(), "InventoryContainer") then return; end

        local selectedItems = playerInv.inventoryPane.selected
        local backpack = playerObj:getClothingItem_Back():getInventory() --getItemContainer()
        local hotBar = getPlayerHotbar(0)


        for _, item in pairs(selectedItems) do
            local itemsTable = item.items
            for _, subitem in pairs(itemsTable) do
                if backpack:contains(subitem) then return; end

                local ok = not subitem:isFavorite() and not playerObj:isEquipped(subitem) and
                subitem:getType() ~= "KeyRing" and not hotBar:isInHotbar(subitem)
                if ok then
                    ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, subitem, subitem:getContainer(),
                        backpack))
                end
            end
        end
    end
end
Events.OnKeyPressed.Add(KeyUp);
