-- Setup translations
--
local L = AceLibrary("AceLocale-2.2"):new("GridStatusBrutallus")
local Aura = AceLibrary("SpecialEvents-Aura-2.0")


L:RegisterTranslations("enUS", function()
        return {
            ["Brutallus Burn"] = true,
            ["Burn damage < 1k DPS"] = true,
            ["Color when burn damage does less than 1000 DPS"] = true,
            ["Burn damage < 2k DPS"] = true,
            ["Color when burn damage does more than 1000 DPS but less than 2000 DPS"] = true,
            ["Burn damage > 2k DPS"] = true,
            ["Color when burn damage exceeds 2000 DPS"] = true,
        }
    end)

L:RegisterTranslations("deDE", function()
        return {
            ["Brutallus Burn"] = "Brutallus Brand" ,
            ["Burn damage < 1k DPS"] = "Schaden < 1k DPS",
            ["Color when burn damage does less than 1000 DPS"] = "Farbe falls Brand für weniger als 1000 Schaden pro Sekunde tickt",
            ["Burn damage < 2k DPS"] = "Schaden < 2k DPS",
            ["Color when burn damage does more than 1000 DPS but less than 2000 DPS"] = "Farbe falls Brand für mehr als 1000 aber weniger als 2000 Schaden pro Sekunde tickt",
            ["Burn damage > 2k DPS"] = "Schaden > 2k DPS",
            ["Color when burn damage exceeds 2000 DPS"] = "Farbe falls Brand für mehr als 2000 Schaden pro Sekunde tickt",
        }
    end)

-- Get spell name
local spellid = {
    ["Burn"] = 46394, -- change this spellid if you want to test with another spell
    ["Meteor Slash"] = 45150,
}

local spell_icon = {
    ["Burn"] = select(3, GetSpellInfo(spellid["Burn"])),
    ["Meteor Slash"] = select(3, GetSpellInfo(spellid["Meteor Slash"])),
}

local BS = {
    ["Burn"] = GetSpellInfo(spellid["Burn"]),
    ["Meteor Slash"] = GetSpellInfo(spellid["Meteor Slash"]),
}


-- Make things local
local select, next, pairs = select, next, pairs
local GetTime = GetTime
local UnitName = UnitName

--- Module begins
---

GridStatusBrutallus = GridStatus:NewModule("GridStatusBrutallus")
local GridStatusBrutallus = GridStatusBrutallus
GridStatusBrutallus.menuName = L["Brutallus Burn"]

GridStatusBrutallus.defaultDB = {
    ["debug"] = false,
    ["alert_brutallus"] = {
        ["desc"] = BS["Burn"],
        ["enable"] = true,
        ["priority"] = 90,
        ["range"] = false,
        ["icon"] = spell_icon["Burn"],
        ["color1"] = {
            r = 0,
            g = 1,
            b = 0,
            a = 1,
        },
        ["color2"] = {
            r = 1,
            g = 1,
            b = 0,
            a = 1,
        },      
        ["color3"] = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
        },      
    },
}

local burnOptions = {
    ["color"] = false, 
    ["color1"] = {
        type = "color",
        name = L["Burn damage < 1k DPS"],
        desc = L["Color when burn damage does less than 1000 DPS"],
        order = 88,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color1
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color1
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["color2"] = {
        type = "color",
        name = L["Burn damage < 2k DPS"],
        desc = L["Color when burn damage does more than 1000 DPS but less than 2000 DPS"],
        order = 89,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color2
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color2
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["color3"] = {
        type = "color",
        name = L["Burn damage > 2k DPS"],
        desc = L["Color when burn damage exceeds 2000 DPS"],
        order = 90,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color3
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBrutallus.db.profile["alert_brutallus"].color3
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
}

GridStatusBrutallus.options = false

function GridStatusBrutallus:OnInitialize()
    self.super.OnInitialize(self)
    self:RegisterStatus("alert_brutallus", L["Brutallus Burn"],
                        burnOptions, true)
end

function GridStatusBrutallus:OnEnable()
    -- should probably use BabbleZone to look for sunwell so we're not doing
    -- anything when not in the sunwell
    self:RegisterEvent("SpecialEvents_UnitDebuffGained")
    self:RegisterEvent("SpecialEvents_UnitDebuffLost")   
    self._timers = {}
end

function GridStatusBrutallus:OnDisable()
    self:UnregisterEvent("SpecialEvents_UnitDebuffGained")
    self:UnregisterEvent("SpecialEvents_UnitDebuffLost")
    
    self:CancelScheduledEvent("GridStatusBrutallus_BrutallusDebuffTimer")
    self._timers = nil

    for name, status, statusTbl in self.core:CachedStatusIterator("alert_brutallus") do
        self.core:SendStatusLost(name, "alert_brutallus")
    end
end

function GridStatusBrutallus:Reset()
    self:OnDisable()
    self:OnEnable()
end

function GridStatusBrutallus:SpecialEvents_UnitDebuffGained(unit, debuff, apps, type, tex, rank, index)
	if unit == "target" or unit == "focus" then
		return
	end

    if debuff == BS["Burn"] then
        self:Debug("Burn Gained:", debuff)
        self:Debug("Burn Gained:", BS["Burn"])     
        self._timers[unit] = GetTime()
        self:StartOrStopTimer()
    end
end

function GridStatusBrutallus:SpecialEvents_UnitDebuffLost(unit, debuff, apps, type, tex, rank)
		if unit == "target" or unit == "focus" then
			return
		end

    if debuff == BS["Burn"] then
        self._timers[unit] = nil
        self.core:SendStatusLost(UnitName(unit), "alert_brutallus")
        self:StartOrStopTimer()
    end
end

function GridStatusBrutallus:StartOrStopTimer()
    if not next(self._timers) then
        self:CancelScheduledEvent("GridStatusBrutallus_BrutallusDebuffTimer")
    elseif not self:IsEventScheduled("GridStatusBrutallus_BrutallusDebuffTimer") then
        self:ScheduleRepeatingEvent("GridStatusBrutallus_BrutallusDebuffTimer",
                                    self.DebuffTimer, 0.5, self)
    end
end

function GridStatusBrutallus:DebuffTimer()
    local settings = self.db.profile["alert_brutallus"]

    if not settings.enable then
        return self:OnDisable()
    end

    local now = GetTime()

    for unit,time in pairs(self._timers) do
        -- elapsed is the number of seconds the unit has had the debuff
        local elapsed = now - time
        local text, apps
        local dps
        
        local idx,cnt = Aura:UnitHasDebuff(unit, BS["Meteor Slash"])
        if idx then
        	text = ("%d-%d"):format(elapsed,cnt)
        	apps = cnt
        else
        	text = ("%d"):format(elapsed)
        	apps = 0
        end

				dps = 100*2^math.floor(elapsed/11)*(1+0.75*apps)
				
        local color = settings.color1

        if dps >= 1000 then
            color = settings.color2
        end
        
        if dps >= 2000 then
            color = settings.color3
        end

        self.core:SendStatusGained(UnitName(unit), "alert_brutallus",
                                   settings.priority, false,
                                   color,
                                   text,
                                   elapsed, 60,
                                   settings.icon)
    end
end