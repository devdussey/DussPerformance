-- Effect filtering logic for DussPerformance

DussPerformance.EffectFilter = {}

-- Hide weather effects
function DussPerformance.EffectFilter:HideWeather()
    if DussPerformance.Config.filters.weatherEffects then
        SetCVar("weatherDensity", 0)
        SetCVar("environmentDetail", 0)
        SetCVar("groundClutter", 0)
    else
        SetCVar("weatherDensity", 1)
        SetCVar("environmentDetail", 1)
        SetCVar("groundClutter", 1)
    end
end

-- Reduce particle effects
function DussPerformance.EffectFilter:ReduceParticles()
    if DussPerformance.Config.filters.environmentParticles then
        SetCVar("particleDensity", 0.3)
    else
        SetCVar("particleDensity", 1)
    end
end

-- Handle spell cast filtering
function DussPerformance.EffectFilter:FilterSpellCast(unit)
    if not DussPerformance.Config.enabled then
        return false
    end

    -- Always show boss spells
    if DussPerformance.Config.exceptions.bossSpells and DussPerformance.Utils:IsBoss(unit) then
        return false
    end

    -- Always show your own spells
    if DussPerformance.Config.exceptions.yourSpells and unit == "player" then
        return false
    end

    -- Show party/raid member spells if enabled
    if DussPerformance.Utils:IsGroupMember(unit) then
        if unit ~= "player" and UnitInParty(unit) and DussPerformance.Config.exceptions.partySpells then
            return false
        end
        if unit ~= "player" and UnitInRaid(unit) and DussPerformance.Config.exceptions.raidSpells then
            return false
        end
    end

    -- Hide other player spells
    if DussPerformance.Config.filters.otherPlayerSpells and not DussPerformance.Utils:IsBoss(unit) then
        return true
    end

    return false
end

-- Apply all filters
function DussPerformance.EffectFilter:ApplyAllFilters()
    if not DussPerformance.Config.enabled then
        return
    end

    DussPerformance.EffectFilter:HideWeather()
    DussPerformance.EffectFilter:ReduceParticles()
end

-- Reset all filters to defaults
function DussPerformance.EffectFilter:ResetFilters()
    SetCVar("weatherDensity", 1)
    SetCVar("environmentDetail", 1)
    SetCVar("groundClutter", 1)
    SetCVar("particleDensity", 1)
    print("DussPerformance: All filters reset to default")
end

-- Initialize filters on addon load
function DussPerformance.EffectFilter:Init()
    DussPerformance.EffectFilter:ApplyAllFilters()
    print("DussPerformance: Effect filters initialized")
end

print("DussPerformance: EffectFilter loaded")
