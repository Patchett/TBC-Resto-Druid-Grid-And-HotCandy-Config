-- GridStatusLineOfSight.lua
--
-- Created By : Pachelbel

-- Libraries
local RL = AceLibrary("Roster-2.1")
local L = AceLibrary("AceLocale-2.2"):new("GridStatusLineOfSight")

-- Module
GridStatusLineOfSight = GridStatus:NewModule("GridStatusLineOfSight", "AceHook-2.1")

local GridStatusLineOfSight = GridStatusLineOfSight
GridStatusLineOfSight.menuName = L["Line Of Sight"]
GridStatusLineOfSight.options = false

GridStatusLineOfSight.defaultDB = {
    debug = false,
    enable = true,
    version = "0.1",

    lineofsight = {
        text = L["LoS"],
        enable = true,
        color = { r = 0.0, g = 0.0, b = 1.0, a = 1.0 },
        priority = 50,
        duration = 8.0,  -- how long they should get the LoS indicator for
        range = false,
    },
}

local lineofsightOptions = {
    ["duration"] = {
        type = 'range',
        name = L["LoS duration"],
        desc = L["Seconds LoS error indicator should remain on"],
        get = function() 
            return GridStatusLineOfSight.db.profile.lineofsight.duration 
        end,
        set = function(v)
            GridStatusLineOfSight.db.profile.lineofsight.duration = v
        end,
        min = 1.0,
        max = 10.0,
        step = 0.5,
        isPercent = false,
    },
}

-- variables for "transactioning" spell casts
local savedSpellName = ""
local savedSpellRank = ""
local savedTargetName = ""

function GridStatusLineOfSight:OnInitialize()
    self.super.OnInitialize(self)
    self:RegisterStatus("lineofsight", L["Line Of Sight"], lineofsightOptions, true)

    -- init saved variables used for spell cast "transactioning"
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetName = ""

    --!!! once enable is fixed remove below
    self:RegisterEvent("UNIT_SPELLCAST_START", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_SENT", "UNIT_SPELLCAST_SENT")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UI_ERROR_MESSAGE")

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:OnInitialize")
end

function GridStatusLineOfSight:OnEnable()
    self:UnregisterAllEvents()
    
    self:RegisterEvent("UNIT_SPELLCAST_START", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_SENT", "UNIT_SPELLCAST_SENT")
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_FAILED", "UNIT_SPELLCAST_clear")
    self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "UNIT_SPELLCAST_clear")
    --self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "UNIT_SPELLCAST_clear")

    self:RegisterEvent("UI_ERROR_MESSAGE")

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:OnEnable")
end

function GridStatusLineOfSight:OnDisable()
    self:UnregisterAllEvents()

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:OnDisable")
end

-- Converts the full name (which is the name of the unit together with 
-- its realm) to the grid name ("Roster-2.1" name actually) which is 
-- simply the name of the unit
function GridStatusLineOfSight:GetGridName(fullName)
    return fullName:match("(.+)%-") or fullName
end

function GridStatusLineOfSight:LoseStatus(name, settings)
    local gridName = self:GetGridName(name) -- strip realm if present

    -- cancel any previous events to clear LoS indicator
    if (self:CancelScheduledEvent("ClearLineOfSight_".. name)) then
        -- if event canceled, set status as lost
        self.core:SendStatusLost(gridName, "lineofsight")
    end

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:LoseStatus " .. name)
end

function GridStatusLineOfSight:GainStatus(name, settings)
    local gridName = self:GetGridName(name) -- strip realm if present

    -- cancel any previous events to clear LoS indicator
    self:CancelScheduledEvent("ClearLineOfSight_".. name)

    self.core:SendStatusGained(gridName,
                                "lineofsight",
                                settings.priority,
                                nil,
                                settings.color,
                                settings.text,
                                nil,
                                nil,
                                nil)

    -- add event to remove LoS indicator in duration seconds
    self:ScheduleEvent("ClearLineOfSight_"..name, self.LoseStatus, settings.duration, self, name, settings)

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:GainStatus " .. name)
end

function GridStatusLineOfSight:UI_ERROR_MESSAGE(message, r, g, b)
    local settings = self.db.profile.lineofsight
    
    if (not settings.enable) then return end  -- only run if enabled

    -- if LoS was cause of error...
    if (message == SPELL_FAILED_LINE_OF_SIGHT) then

        -- if we have a saved target from spell cast sent event...
        if (savedTargetName ~= "") then
            -- gain status for target
            self:GainStatus(savedTargetName, settings)
        end
        
        -- clear saved variables
        savedSpellName = ""
        savedSpellRank = ""
        savedTargetName = ""

        -- trace out event
        --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UI_ERROR_MESSAGE " .. ":" .. message)
    end

end

function GridStatusLineOfSight:UNIT_SPELLCAST_clear(unit)
    local settings = self.db.profile.lineofsight

    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts

    -- clear saved variables (target will be gotten in sent event)
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetName = ""

    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_clear " .. unit)
end

function GridStatusLineOfSight:UNIT_SPELLCAST_SENT(unit, spellName, spellRank, targetName)
    local settings = self.db.profile.lineofsight

    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts

    -- save spellName, spellRank, and targetName for "transactioning" of 
    -- spell cast succeed, interrupt and failed events
    savedSpellName = spellName;
    savedSpellRank = spellRank;
    savedTargetName = targetName;
    
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_SENT " .. unit .. ":" .. spellName .. ":" .. savedTargetName)
end

function GridStatusLineOfSight:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank)
    local settings = self.db.profile.lineofsight

    if (not settings.enable) then return end  -- only run if enabled
    if (unit ~= 'player') then return end  -- look for our own casts

    -- if same spell name and rank, assume same target
    if ((spellName == savedSpellName) and (spellRank == savedSpellRank)) then
        -- if spell cast succeeded, then must be in LoS, so lose status (if they had it)
        self:LoseStatus(savedTargetName, settings)
    end
    
    -- clear saved variables (even if not match)
    savedSpellName = ""
    savedSpellRank = ""
    savedTargetName = ""
    
    -- trace out event
    --DEFAULT_CHAT_FRAME:AddMessage("GridStatusLineOfSight:UNIT_SPELLCAST_SUCCEEDED " .. unit .. ":" .. spellName)
end

