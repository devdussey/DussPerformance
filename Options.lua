-- Options Panel for DussPerformance

DussPerformance.Options = {}

function DussPerformance.Options:CreatePanel()
    local panel = CreateFrame("Frame", "DussPerformanceOptionsPanel", InterfaceOptionsFramePanelContainer)
    panel.name = "Duss Performance"
    panel:SetSize(600, 500)

    -- Title
    local title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 20, -20)
    title:SetText("Duss Performance Options")

    -- Enable/Disable Addon
    local enableCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    enableCheck:SetPoint("TOPLEFT", 40, -60)
    enableCheck:SetChecked(DussPerformance.Config.enabled)
    enableCheck.label = enableCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    enableCheck.label:SetPoint("LEFT", enableCheck, "RIGHT", 5, 0)
    enableCheck.label:SetText("Enable DussPerformance")
    enableCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.enabled = self:GetChecked()
        if DussPerformance.Config.enabled then
            DussPerformance.EffectFilter:ApplyAllFilters()
            print("DussPerformance: Enabled")
        else
            DussPerformance.EffectFilter:ResetFilters()
            print("DussPerformance: Disabled")
        end
        DussPerformance.Utils:SaveSettings()
    end)

    -- Performance Mode Section
    local modeTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    modeTitle:SetPoint("TOPLEFT", 20, -100)
    modeTitle:SetText("Performance Mode")

    -- Balanced Button
    local balancedBtn = CreateFrame("Button", nil, panel, "GameMenuButtonTemplate")
    balancedBtn:SetPoint("TOPLEFT", 40, -130)
    balancedBtn:SetSize(120, 25)
    balancedBtn:SetText("Balanced")
    balancedBtn:SetScript("OnClick", function()
        DussPerformance.Utils:ApplyPreset("balanced")
        DussPerformance.EffectFilter:ApplyAllFilters()
        DussPerformance.Options:RefreshPanel()
    end)

    -- Aggressive Button
    local aggressiveBtn = CreateFrame("Button", nil, panel, "GameMenuButtonTemplate")
    aggressiveBtn:SetPoint("TOPLEFT", 170, -130)
    aggressiveBtn:SetSize(120, 25)
    aggressiveBtn:SetText("Aggressive")
    aggressiveBtn:SetScript("OnClick", function()
        DussPerformance.Utils:ApplyPreset("aggressive")
        DussPerformance.EffectFilter:ApplyAllFilters()
        DussPerformance.Options:RefreshPanel()
    end)

    -- Raid Button
    local raidBtn = CreateFrame("Button", nil, panel, "GameMenuButtonTemplate")
    raidBtn:SetPoint("TOPLEFT", 300, -130)
    raidBtn:SetSize(120, 25)
    raidBtn:SetText("Raid")
    raidBtn:SetScript("OnClick", function()
        DussPerformance.Utils:ApplyPreset("raid")
        DussPerformance.EffectFilter:ApplyAllFilters()
        DussPerformance.Options:RefreshPanel()
    end)

    -- Filters Section
    local filterTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    filterTitle:SetPoint("TOPLEFT", 20, -175)
    filterTitle:SetText("Effect Filters")

    -- Other Player Spells
    local otherSpellsCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    otherSpellsCheck:SetPoint("TOPLEFT", 40, -205)
    otherSpellsCheck:SetChecked(DussPerformance.Config.filters.otherPlayerSpells)
    otherSpellsCheck.label = otherSpellsCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    otherSpellsCheck.label:SetPoint("LEFT", otherSpellsCheck, "RIGHT", 5, 0)
    otherSpellsCheck.label:SetText("Hide Other Players' Spells")
    otherSpellsCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.filters.otherPlayerSpells = self:GetChecked()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Weather Effects
    local weatherCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    weatherCheck:SetPoint("TOPLEFT", 40, -235)
    weatherCheck:SetChecked(DussPerformance.Config.filters.weatherEffects)
    weatherCheck.label = weatherCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    weatherCheck.label:SetPoint("LEFT", weatherCheck, "RIGHT", 5, 0)
    weatherCheck.label:SetText("Hide Weather Effects")
    weatherCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.filters.weatherEffects = self:GetChecked()
        DussPerformance.EffectFilter:HideWeather()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Environment Particles
    local envCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    envCheck:SetPoint("TOPLEFT", 40, -265)
    envCheck:SetChecked(DussPerformance.Config.filters.environmentParticles)
    envCheck.label = envCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    envCheck.label:SetPoint("LEFT", envCheck, "RIGHT", 5, 0)
    envCheck.label:SetText("Hide Environment Particles")
    envCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.filters.environmentParticles = self:GetChecked()
        DussPerformance.EffectFilter:ReduceParticles()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Ground Effects
    local groundCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    groundCheck:SetPoint("TOPLEFT", 40, -295)
    groundCheck:SetChecked(DussPerformance.Config.filters.groundEffects)
    groundCheck.label = groundCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    groundCheck.label:SetPoint("LEFT", groundCheck, "RIGHT", 5, 0)
    groundCheck.label:SetText("Hide Ground Effects")
    groundCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.filters.groundEffects = self:GetChecked()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Buff/Debuff Visuals
    local buffCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    buffCheck:SetPoint("TOPLEFT", 40, -325)
    buffCheck:SetChecked(DussPerformance.Config.filters.buffDebuffVisuals)
    buffCheck.label = buffCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    buffCheck.label:SetPoint("LEFT", buffCheck, "RIGHT", 5, 0)
    buffCheck.label:SetText("Hide Buff/Debuff Visuals")
    buffCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.filters.buffDebuffVisuals = self:GetChecked()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Exceptions Section
    local excepTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    excepTitle:SetPoint("TOPLEFT", 20, -365)
    excepTitle:SetText("Always Show")

    -- Boss Spells (always on)
    local bossCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    bossCheck:SetPoint("TOPLEFT", 40, -395)
    bossCheck:SetChecked(DussPerformance.Config.exceptions.bossSpells)
    bossCheck:Disable()
    bossCheck.label = bossCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bossCheck.label:SetPoint("LEFT", bossCheck, "RIGHT", 5, 0)
    bossCheck.label:SetText("Boss Spells (Always)")
    bossCheck.label:SetTextColor(0.5, 0.5, 0.5)

    -- Your Spells (always on)
    local yourCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    yourCheck:SetPoint("TOPLEFT", 40, -425)
    yourCheck:SetChecked(DussPerformance.Config.exceptions.yourSpells)
    yourCheck:Disable()
    yourCheck.label = yourCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    yourCheck.label:SetPoint("LEFT", yourCheck, "RIGHT", 5, 0)
    yourCheck.label:SetText("Your Spells (Always)")
    yourCheck.label:SetTextColor(0.5, 0.5, 0.5)

    -- Party Spells
    local partyCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    partyCheck:SetPoint("TOPLEFT", 280, -395)
    partyCheck:SetChecked(DussPerformance.Config.exceptions.partySpells)
    partyCheck.label = partyCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    partyCheck.label:SetPoint("LEFT", partyCheck, "RIGHT", 5, 0)
    partyCheck.label:SetText("Party Member Spells")
    partyCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.exceptions.partySpells = self:GetChecked()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Raid Spells
    local raidCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    raidCheck:SetPoint("TOPLEFT", 280, -425)
    raidCheck:SetChecked(DussPerformance.Config.exceptions.raidSpells)
    raidCheck.label = raidCheck:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    raidCheck.label:SetPoint("LEFT", raidCheck, "RIGHT", 5, 0)
    raidCheck.label:SetText("Raid Member Spells")
    raidCheck:SetScript("OnClick", function(self)
        DussPerformance.Config.exceptions.raidSpells = self:GetChecked()
        DussPerformance.Utils:SaveSettings()
    end)

    -- Reset Button
    local resetBtn = CreateFrame("Button", nil, panel, "GameMenuButtonTemplate")
    resetBtn:SetPoint("TOPLEFT", 40, -470)
    resetBtn:SetSize(100, 25)
    resetBtn:SetText("Reset All")
    resetBtn:SetScript("OnClick", function()
        DussPerformance.EffectFilter:ResetFilters()
        DussPerformance.Utils:LoadSettings()
        DussPerformance.Options:RefreshPanel()
    end)

    return panel
end

function DussPerformance.Options:RefreshPanel()
    -- Panel will be refreshed on next open
end

function DussPerformance.Options:Init()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, addonName)
        if addonName == "DussPerformance" then
            local panel = DussPerformance.Options:CreatePanel()
            if InterfaceOptions_AddCategory then
                InterfaceOptions_AddCategory(panel)
            end
            self:UnregisterEvent("ADDON_LOADED")
        end
    end)
end

print("DussPerformance: Options loaded")
