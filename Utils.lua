-- Utility functions for DussPerformance

DussPerformance.Utils = {}

-- Save settings to SavedVariables
function DussPerformance.Utils:SaveSettings()
    if not DussPerformanceSavedVars then
        DussPerformanceSavedVars = {}
    end
    DussPerformanceSavedVars.filters = DussPerformance.Config.filters
    DussPerformanceSavedVars.exceptions = DussPerformance.Config.exceptions
    DussPerformanceSavedVars.enabled = DussPerformance.Config.enabled
    DussPerformanceSavedVars.performanceMode = DussPerformance.Config.performanceMode
end

-- Load settings from SavedVariables
function DussPerformance.Utils:LoadSettings()
    if not DussPerformanceSavedVars then
        DussPerformanceSavedVars = DussPerformance.DefaultVars
    else
        -- Merge with defaults
        for key, value in pairs(DussPerformance.DefaultVars) do
            if DussPerformanceSavedVars[key] == nil then
                DussPerformanceSavedVars[key] = value
            end
        end
    end

    DussPerformance.Config.filters = DussPerformanceSavedVars.filters
    DussPerformance.Config.exceptions = DussPerformanceSavedVars.exceptions
    DussPerformance.Config.enabled = DussPerformanceSavedVars.enabled
    DussPerformance.Config.performanceMode = DussPerformanceSavedVars.performanceMode
end

-- Apply performance preset
function DussPerformance.Utils:ApplyPreset(preset)
    if preset == "aggressive" then
        DussPerformance.Config.filters.otherPlayerSpells = true
        DussPerformance.Config.filters.weatherEffects = true
        DussPerformance.Config.filters.environmentParticles = true
        DussPerformance.Config.filters.groundEffects = true
        DussPerformance.Config.filters.buffDebuffVisuals = true
        DussPerformance.Config.exceptions.partySpells = false
        DussPerformance.Config.exceptions.raidSpells = false
        print("DussPerformance: Aggressive mode enabled (maximum FPS)")
    elseif preset == "balanced" then
        DussPerformance.Config.filters.otherPlayerSpells = true
        DussPerformance.Config.filters.weatherEffects = true
        DussPerformance.Config.filters.environmentParticles = true
        DussPerformance.Config.filters.groundEffects = false
        DussPerformance.Config.filters.buffDebuffVisuals = false
        DussPerformance.Config.exceptions.partySpells = true
        DussPerformance.Config.exceptions.raidSpells = false
        print("DussPerformance: Balanced mode enabled")
    elseif preset == "raid" then
        DussPerformance.Config.filters.otherPlayerSpells = true
        DussPerformance.Config.filters.weatherEffects = false
        DussPerformance.Config.filters.environmentParticles = true
        DussPerformance.Config.filters.groundEffects = false
        DussPerformance.Config.filters.buffDebuffVisuals = false
        DussPerformance.Config.exceptions.partySpells = true
        DussPerformance.Config.exceptions.raidSpells = true
        print("DussPerformance: Raid mode enabled")
    end
    DussPerformance.Config.performanceMode = preset
    DussPerformance.Utils:SaveSettings()
end

-- Toggle a specific filter
function DussPerformance.Utils:ToggleFilter(filterName)
    if DussPerformance.Config.filters[filterName] ~= nil then
        DussPerformance.Config.filters[filterName] = not DussPerformance.Config.filters[filterName]
        local status = DussPerformance.Config.filters[filterName] and "enabled" or "disabled"
        print("DussPerformance: " .. filterName .. " " .. status)
        DussPerformance.Utils:SaveSettings()
        return true
    end
    return false
end

-- Toggle a specific exception
function DussPerformance.Utils:ToggleException(exceptionName)
    if DussPerformance.Config.exceptions[exceptionName] ~= nil then
        DussPerformance.Config.exceptions[exceptionName] = not DussPerformance.Config.exceptions[exceptionName]
        local status = DussPerformance.Config.exceptions[exceptionName] and "enabled" or "disabled"
        print("DussPerformance: " .. exceptionName .. " " .. status)
        DussPerformance.Utils:SaveSettings()
        return true
    end
    return false
end

-- Check if unit is boss
function DussPerformance.Utils:IsBoss(unit)
    local classification = UnitClassification(unit)
    return classification == "boss" or classification == "rareelite" or classification == "elite"
end

-- Check if unit is in party/raid
function DussPerformance.Utils:IsGroupMember(unit)
    return UnitInParty(unit) or UnitInRaid(unit)
end

print("DussPerformance: Utils loaded")
