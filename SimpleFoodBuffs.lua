local ADDON_NAME = "SimpleFoodBuffs"

local function AddCustomTooltipText(tooltip)
    if not tooltip or not tooltip.GetItem then
        return
    end

    local _, itemLink = tooltip:GetItem()
    if not itemLink then return end

    local replenishment
    local replenishment_text = "Use:%s*(.-)%s*Must remain seated"
    local buff
    local buff_text = "gain%s+(.-)%s+for%s+"
    local experience
    local xp_text = "increased by%s+(%d+%%)"
    local color_gold = "|cffffd700"
    local color_green = "|cff00ff00"

    for i = 1, tooltip:NumLines() do
        local line = _G[tooltip:GetName() .. "TextLeft" .. i]

        if line then
            local text = line:GetText()

            if text then
            	replenishment = text:match(replenishment_text) or replenishment	
                buff = text:match(buff_text) or buff
                experience = text:match(xp_text) or experience
            end
        end
    end

    if replenishment or buff or experience then
        tooltip:AddLine(" ")
        tooltip:AddLine(color_gold.."SimpleFoodBuffs:|r")
        
        if replenishment then
            tooltip:AddLine(color_green .. replenishment .. "|r")
        end

        if buff then
            tooltip:AddLine(color_green .. buff .. "|r")
        end

        if experience then
            tooltip:AddLine(color_green .. experience .. " XP|r")
        end

        tooltip:Show()
    end
end

TooltipDataProcessor.AddTooltipPostCall(
    Enum.TooltipDataType.Item,
    function(tooltip)
        AddCustomTooltipText(tooltip)
    end
)
