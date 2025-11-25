-- Default configuration for DussPerformance

DussPerformance.Config = {
    -- Toggle switches
    enabled = true,

    -- Effect filtering
    filters = {
        otherPlayerSpells = true,      -- Hide spell effects from other players
        weatherEffects = true,          -- Hide weather (rain, snow, fog)
        environmentParticles = true,    -- Hide floating particles/dust
        groundEffects = true,           -- Hide ground-based visual effects
        buffDebuffVisuals = true,       -- Hide buff/debuff visuals on other players
    },

    -- Exceptions (always show these)
    exceptions = {
        bossSpells = true,              -- Always show boss ability effects
        yourSpells = true,              -- Always show your own spell effects
        partySpells = false,            -- Show party member spells
        raidSpells = false,             -- Show raid member spells
    },

    -- Performance levels
    performanceMode = "balanced",       -- "balanced", "aggressive", "custom"
}

-- Default saved variables
DussPerformance.DefaultVars = {
    enabled = true,
    filters = {
        otherPlayerSpells = true,
        weatherEffects = true,
        environmentParticles = true,
        groundEffects = true,
        buffDebuffVisuals = true,
    },
    exceptions = {
        bossSpells = true,
        yourSpells = true,
        partySpells = false,
        raidSpells = false,
    },
    performanceMode = "balanced",
}

print("DussPerformance: Config loaded")
