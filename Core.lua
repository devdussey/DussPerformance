-- Core addon initialization for DussPerformance

DussPerformance = {
    version = "1.0",
}

-- Register slash commands
SLASH_DUSSPERFORMANCE1 = "/dussperf"
SLASH_DUSSPERFORMANCE2 = "/dp"

-- Handle slash commands
function DussPerformance:HandleSlashCommand(msg)
    msg = string.lower(msg):trim()

    if msg == "on" or msg == "enable" then
        DussPerformance.Config.enabled = true
        DussPerformance.EffectFilter:ApplyAllFilters()
        DussPerformance.Utils:SaveSettings()
        print("DussPerformance: Enabled")
    elseif msg == "off" or msg == "disable" then
        DussPerformance.Config.enabled = false
        DussPerformance.EffectFilter:ResetFilters()
        DussPerformance.Utils:SaveSettings()
        print("DussPerformance: Disabled")
    elseif msg == "toggle" or msg == "" then
        DussPerformance.Config.enabled = not DussPerformance.Config.enabled
        if DussPerformance.Config.enabled then
            DussPerformance.EffectFilter:ApplyAllFilters()
        else
            DussPerformance.EffectFilter:ResetFilters()
        end
        DussPerformance.Utils:SaveSettings()
        local status = DussPerformance.Config.enabled and "Enabled" or "Disabled"
        print("DussPerformance: " .. status)
    elseif msg == "aggressive" then
        DussPerformance.Utils:ApplyPreset("aggressive")
        DussPerformance.EffectFilter:ApplyAllFilters()
    elseif msg == "balanced" then
        DussPerformance.Utils:ApplyPreset("balanced")
        DussPerformance.EffectFilter:ApplyAllFilters()
    elseif msg == "raid" then
        DussPerformance.Utils:ApplyPreset("raid")
        DussPerformance.EffectFilter:ApplyAllFilters()
    elseif msg == "status" then
        print("DussPerformance Status:")
        print("  Enabled: " .. (DussPerformance.Config.enabled and "Yes" or "No"))
        print("  Mode: " .. DussPerformance.Config.performanceMode)
        print("  Hide Other Spells: " .. (DussPerformance.Config.filters.otherPlayerSpells and "Yes" or "No"))
        print("  Hide Weather: " .. (DussPerformance.Config.filters.weatherEffects and "Yes" or "No"))
        print("  Hide Particles: " .. (DussPerformance.Config.filters.environmentParticles and "Yes" or "No"))
        print("  Hide Ground Effects: " .. (DussPerformance.Config.filters.groundEffects and "Yes" or "No"))
        print("  Hide Buff Visuals: " .. (DussPerformance.Config.filters.buffDebuffVisuals and "Yes" or "No"))
    elseif string.find(msg, "^toggle") then
        local filterName = string.match(msg, "^toggle%s+(.+)")
        if filterName then
            DussPerformance.Utils:ToggleFilter(filterName)
            DussPerformance.EffectFilter:ApplyAllFilters()
        else
            print("DussPerformance: Usage: /dp toggle <filtername>")
        end
    else
        print("DussPerformance Commands:")
        print("  /dp or /dussperf toggle - Toggle addon on/off")
        print("  /dp on - Enable addon")
        print("  /dp off - Disable addon")
        print("  /dp aggressive - Maximum FPS mode")
        print("  /dp balanced - Balanced mode (default)")
        print("  /dp raid - Raid-friendly mode")
        print("  /dp status - Show current settings")
        print("  /dp toggle <filtername> - Toggle specific filter")
        print("  Available filters: otherPlayerSpells, weatherEffects, environmentParticles, groundEffects, buffDebuffVisuals")
    end
end

-- Register slash command handler
SlashCmdList["DUSSPERFORMANCE"] = function(msg)
    DussPerformance:HandleSlashCommand(msg)
end

-- Main addon initialization
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "DussPerformance" then
        -- Load settings
        DussPerformance.Utils:LoadSettings()

        -- Initialize effect filters
        DussPerformance.EffectFilter:Init()

        -- Initialize options menu
        DussPerformance.Options:Init()

        print("DussPerformance: Addon loaded successfully")
        print("Use /dp for commands or go to Interface > Addons > Duss Performance for options")

        self:UnregisterEvent("ADDON_LOADED")
    end
end)

print("DussPerformance: Core loaded")
