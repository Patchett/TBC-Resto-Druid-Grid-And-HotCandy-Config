--[[ GridStatusBurn, by Thelein@Dragonblight-US (alts: Thelyna, Theleyn), based off the addon of
     the same name by an unknown author (I can't remember where I got this from, searching the
     major interface sites and google returns nothing. Please contact me on either wowace or
     wowinterface forums (Thelyna) if you are the original author.
     GridStatusBurn based off GridStatusKalecgos by evildead & Pastamancer.
     TODO:
     - More color configuration - DONE.
     - Configuring/debugging 'emergency' warning for people who take a late slash.
]]--

-- Setup translations
--
local L = AceLibrary("AceLocale-2.2"):new("GridStatusBurn")

--constants
local BURN_LENGTH = 60; 
local SLASH_LENGTH = 40;

--~ Prot Warrior - Sunder/Demo
--~ local BURN_LENGTH = 30; 
--~ local SLASH_LENGTH = 30;

--~ Bear Druid testing - Lacerate/Demo
--~ local BURN_LENGTH = 30; 
--~ local SLASH_LENGTH = 15;

--~ Rogue testing - Deadly/Mind-Numbing
--~ local BURN_LENGTH = 14; 
--~ local SLASH_LENGTH = 12;


L:RegisterTranslations("enUS", function()
        return {
            ["Brutallus - Burn"] = true,
            ["Color for ticks < 1k"] = true,
            ["Color for ticks > 1k < 2k"] = true,
            ["Color for ticks > 2k <= 3.2k"] = true,
            ["Color for ticks > 3.2k"] = true,
        }
    end)


-- Get spell name
--

-- Main version - the real brut spells
local spellid = {
    ["Burn"] = 46394, -- change this spellid if you want to test with another spell
    ["Meteor Slash"] = 45150,
}


-- Prot Warrior - sunder/demo
--~ local spellid = {
--~    ["Burn"] = 25203,
--~    ["Meteor Slash"] = 25225,
--~ }

--~  Bear testing - Lacerate/Demo
--~  local spellid = {
--~     ["Burn"] = 26998,
--~    ["Meteor Slash"] = 33745,
--~ }

-- Rogue testing - Deadly/Mind-Numbing
--~ local spellid = {
--~    ["Burn"] = 22054,
--~    ["Meteor Slash"] = 9186,
--~ }




local BS = {
    ["Burn"] = GetSpellInfo(spellid["Burn"]),
    ["Meteor Slash"] = GetSpellInfo(spellid["Meteor Slash"]), -- lookup table for easier testing
}

local spell_icon = {
    ["Burn"] = select(3, GetSpellInfo(spellid["Burn"])),
}

-- Make things local
local select, next, pairs = select, next, pairs
local GetTime = GetTime
local UnitName = UnitName

--- Module begins
---

GridStatusBurn = GridStatus:NewModule("GridStatusBurn")
local GridStatusBurn = GridStatusBurn
GridStatusBurn.menuName = L["Brutallus - Burn"]

GridStatusBurn.defaultDB = {
    ["debug"] = false,
    ["alert_burn"] = {
        ["desc"] = BS["Burn"],
        ["enable"] = true,
        ["priority"] = 90,
        ["range"] = false,
        ["countdown"] = true,
        ["shownexttick"] = false;
        ["showburn"] = true;
        ["showslashstacks"] = true;
        ["showslashtimer"] = true;
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
        ["color4"] = {
            r = 0,
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
        name = L["Color for ticks < 1k"],
        desc = L["Color for ticks < 1k"],
        order = 88,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBurn.db.profile["alert_burn"].color1
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBurn.db.profile["alert_burn"].color1
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["color2"] = {
        type = "color",
        name = L["Color for ticks > 1k < 2k"],
        desc = L["Color for ticks > 1k < 2k"],
        order = 89,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBurn.db.profile["alert_burn"].color2
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBurn.db.profile["alert_burn"].color2
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["color3"] = {
        type = "color",
        name = L["Color for ticks > 2k <= 3.2k"],
        desc = L["Color for ticks > 2k <= 3.2k"],
        order = 90,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBurn.db.profile["alert_burn"].color3
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBurn.db.profile["alert_burn"].color3
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["color4"] = {
        type = "color",
        name = L["Color for ticks > 3.2k"],
        desc = L["Color for ticks > 3.2k"],
        order = 91,
        hasAlpha = true,
        get = function ()
                  local color = GridStatusBurn.db.profile["alert_burn"].color4
                  return color.r, color.g, color.b, color.a
              end,
        set = function (r, g, b, a)
                  local color = GridStatusBurn.db.profile["alert_burn"].color4
                  color.r = r
                  color.g = g
                  color.b = b
                  color.a = a or 1
              end,
    },
    ["countdown"] = {
	    type = "toggle",
	    name = "Count Down",
	    desc = "Count Down to 0 as the debuff wears off",
	    get = function ()
		    return GridStatusBurn.db.profile.countdown
	    end,
	    set = function (v)
		    GridStatusBurn.db.profile.countdown = v
	    end,
    },
    ["shownexttick"] = {
	    type = "toggle",
	    name = "Show Next",
	    desc = "Show Next tick on the player frame",
	    get = function ()
		    return GridStatusBurn.db.profile.shownexttick
	    end,
	    set = function (v)
		    GridStatusBurn.db.profile.shownexttick = v
	    end,
    },
    ["showburn"] = {
	    type = "toggle",
	    name = "Show Burn",
	    desc = "Show Burn on the player frame",
	    get = function ()
		    return GridStatusBurn.db.profile.showburn
	    end,
	    set = function (v)
		    GridStatusBurn.db.profile.showburn = v
	    end,
    },
    ["showslashstacks"] = {
	    type = "toggle",
	    name = "Show Slash Stacks",
	    desc = "Show Slash Stacks on the player frame",
	    get = function ()
		    return GridStatusBurn.db.profile.showslashstacks
	    end,
	    set = function (v)
		    GridStatusBurn.db.profile.showslashstacks = v
	    end,
    },
    ["showslashtimer"] = {
	    type = "toggle",
	    name = "Show Slash Timer",
	    desc = "Show Slash Timer on the player frame",
	    get = function ()
		    return GridStatusBurn.db.profile.showslashtimer
	    end,
	    set = function (v)
		    GridStatusBurn.db.profile.showslashtimer = v
	    end,
    }

}

GridStatusBurn.options = false

function GridStatusBurn:OnInitialize()
    self.super.OnInitialize(self)
    self:RegisterStatus("alert_burn", L["Brutallus - Burn"],
                        burnOptions, true)
end

function GridStatusBurn:OnEnable()
    -- should probably use BabbleZone to look for sunwell so we're not doing
    -- anything when not in the sunwell
    self:RegisterEvent("SpecialEvents_UnitDebuffGained")
    self:RegisterEvent("SpecialEvents_UnitDebuffCountChanged")
    self:RegisterEvent("SpecialEvents_UnitDebuffLost")   
    self._timers = {}
    self._slashes = {}
end

function GridStatusBurn:OnDisable()
	if not self:IsEventRegistered("SpecialEvents_UnitDebuffGained") then
		-- if unitdebuffgained isn't registered then OnEnable hasn't been called
		-- and there's nothing to disable
		return
	end
    self:UnregisterEvent("SpecialEvents_UnitDebuffGained")
    self:UnregisterEvent("SpecialEvents_UnitDebuffCountChanged")
    self:UnregisterEvent("SpecialEvents_UnitDebuffLost")
    
    self:CancelScheduledEvent("GridStatusBurn_BurnDebuffTimer")
    self._timers = nil
    self._slashes = nil

    for name, status, statusTbl in self.core:CachedStatusIterator("alert_burn") do
        self.core:SendStatusLost(name, "alert_burn")
    end
end

function GridStatusBurn:Reset()
	self:OnDisable()
    self:OnEnable()
end

function GridStatusBurn:SpecialEvents_UnitDebuffCountChanged(unit, debuff, apps, dispelType, icon, rank, index)
	if unit == "target" or unit == "focus" then
		return
	end

  
    if debuff == BS["Meteor Slash"] then
        -- slash timer
        self._slashes[unit] = GetTime()
        
        -- fail check - future option maybe? need to make this configurable somehow
        -- self:BigTickCheck(unit)
    end    
end


-- This function isn't used at the moment because I dry-coded it - and the last two times we've done Brut no-one has taken late slashes.
function GridStatusBurn:BigTickCheck(unit)
     for units,time in pairs(self._timers) do 
        if unit == units and time < 57 then
            bigticks = 57-time -- slash duration is 40s, the 1600 ticks start 44s into burn, thus taking new slashes >3 seconds after burn is bad
            tickstotal = 1600*(1+0.75*apps)
            DEFAULT_CHAT_FRAME:AddMessage(UnitName(unit).." took a late slash, going to take "..bigticks.." of "..tickstotal" damage.")
        end
    end
end


function GridStatusBurn:SpecialEvents_UnitDebuffGained(unit, debuff, apps, type, tex, rank, index)
	if unit == "target" or unit == "focus" then
		return
	end
    
    if debuff == BS["Meteor Slash"] then
        -- slash timer
        self._slashes[unit] = GetTime()
        
        -- failtard check
        -- self:BigTickCheck(unit)
    end
    
    if debuff == BS["Burn"] then
        -- DEFAULT_CHAT_FRAME:AddMessage("Test #1")
        self:Debug("Burn Gained:", debuff)
        self:Debug("Burn Gained:", BS["Burn"])     
        self._timers[unit] = GetTime()
        self:StartOrStopTimer()
    end
end

function GridStatusBurn:SpecialEvents_UnitDebuffLost(unit, debuff, apps, type, tex, rank)
	if unit == "target" or unit == "focus" then
		return
	end

    if debuff == BS["Meteor Slash"] then
        self._slashes[unit] = nil
    end
    
    if debuff == BS["Burn"] then
        
        self._timers[unit] = nil
        self.core:SendStatusLost(UnitName(unit), "alert_burn")
        self:StartOrStopTimer()
    end
end

function GridStatusBurn:StartOrStopTimer()
    if not next(self._timers) then
        self:CancelScheduledEvent("GridStatusBurn_BurnDebuffTimer")
    elseif not self:IsEventScheduled("GridStatusBurn_BurnDebuffTimer") then
        self:ScheduleRepeatingEvent("GridStatusBurn_BurnDebuffTimer",
                                    self.DebuffTimer, 0.5, self)
    end
end


function GridStatusBurn:GetMeteorSlashCount(unit)

	for i = 1, 40 do
		local name,_,texture,count = UnitDebuff(unit,i);
		if (not texture) then 
			break;
		elseif name == (BS["Meteor Slash"]) then
			self:Debug(count);
			return(count);
		end
	end 
    return 0;
end

function GridStatusBurn:GetMeteorSlashTimer(unit,ctime)

    for slashy,time in pairs(self._slashes) do
        if slashy == unit then
            return (ctime-time)
        end
    end
end
    
function GridStatusBurn:FormatText(elapsed, count, slashelapsed,nextTick)

	--if variable is set show time left instead of time present
	if (GridStatusBurn.db.profile.countdown) then
		displaytime = BURN_LENGTH - elapsed;
        if (slashelapsed ~= nil) then
            displayslash = SLASH_LENGTH - slashelapsed;
        end
	else
		displaytime = elapsed;
        if (slashelapsed ~= nil) then
            displayslash = slashelapsed;
        end
	end
    
    local returnString = ""
    if (count ~= nil and count > 0) then
        if (GridStatusBurn.db.profile.showburn) then returnString = returnString..string.format("%d",count) end
        if (GridStatusBurn.db.profile.showslashstacks) then returnString = returnString..string.format("-%d",displayslash) end
        if (GridStatusBurn.db.profile.showslashtimer) then returnString = returnString..string.format("-%d",displaytime) end
        if (GridStatusBurn.db.profile.shownexttick) then returnString = returnString..string.format("-%d",nextTick) end
    else    
        if (GridStatusBurn.db.profile.showslashtimer) then returnString = returnString..string.format("%d",displaytime) end
        if (GridStatusBurn.db.profile.shownexttick) then returnString = returnString..string.format("-%d",nextTick) end
    end
    return returnString;
--[[
    if (GridStatusBurn.db.profile.shownexttick) then
        if (count == nil) then
            return string.format("%d-%d",displaytime,nextTick);
        else
            return string.format("%d-%d-%d-%d",count,displayslash,displaytime,nextTick); 
        end    
    else
        if (count == nil) then
            return string.format("%d",displaytime);
        else
            return string.format("%d-%d-%d",count,displayslash,displaytime); 
        end
    end
    ]]--
end

function GridStatusBurn:GetNextBurnTick(burnElapsed,slashCount,slashElapsed)
    local nextTick;
    if (burnElapsed < 10) then
        nextTick = 100;
    elseif (burnElapsed < 21) then
        nextTick = 200;
    elseif (burnElapsed < 32) then
        nextTick = 400;
    elseif (burnElapsed < 43) then
        nextTick = 800;
    elseif (burnElapsed < 54) then
        nextTick = 1600;
    elseif (burnElapsed >= 54) then
        nextTick = 3200;
    end
    if (nextTick and slashCount ~= 0) then 
        nextTick = nextTick * (1 + (0.75 * slashCount));
    end
    
    return nextTick;
end


function GridStatusBurn:DebuffTimer()
    local settings = self.db.profile["alert_burn"]

    if not settings.enable then
        return self:OnDisable()
    end

    local now = GetTime()

    for unit,time in pairs(self._timers) do

        -- get the Meteor Slash info
        local count = self:GetMeteorSlashCount(unit);

        -- elapsed is the number of seconds the unit has had the debuff
        local elapsed = now - time
        local slashelapsed = self:GetMeteorSlashTimer(unit,now);
--~         local color = settings.color1
        local tick = self:GetNextBurnTick(elapsed,count,slashelapsed);
        local color;
        if (tick < 1001) then
            color = settings.color1;
        elseif (tick < 2001) then
            color = settings.color2;
        elseif (tick < 3201) then
            color = settings.color3;
        else
            color = settings.color4;
        end
        
        -- error checking
        if (count == nil and slashelapsed ~= nil) then 
            DEFAULT_CHAT_FRAME:AddMessage("BrutBurn Error: Slash stack without timer")
        end

        
        outputText = self:FormatText(elapsed,count,slashelapsed,tick); 

	
        self.core:SendStatusGained(UnitName(unit), "alert_burn",
                    settings.priority, false,
                    color,
                    outputText,
                    displaytime, BURN_LENGTH,
                    settings.icon)
    end
end