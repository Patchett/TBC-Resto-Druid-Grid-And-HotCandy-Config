local RL = AceLibrary("Roster-2.1")
local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")

GridMBStatus = GridStatus:NewModule("GridMBStatus")

GridMBStatus.menuName = "ManaBar"

GridMBStatus.defaultDB = {
	debug = false,
	hiderage = false,
	hidepetbars = true,
	color = { r = 0, g = 0.5, b = 1.0, a = 1.0 },
	ecolor = { r = 1, g = 1, b = 0, a = 1.0 },
	rcolor = { r = 1, g = 0, b = 0, a = 1.0 },
	unit_mana = {
		color = { r=1, g=1, b=1, a=1 },
		text = "ManaBar",
		enable = true,
		priority = 30,
		range = false
	}
}

GridMBStatus.options = false

local manabar_options = {
	
	["Ignore Non-Mana"] = {
		type = "toggle",
		name = L["Ignore Non-Mana"],
		desc = L["Don't track power for non-mana users"],
		get = function()
			return GridMBStatus.db.profile.hiderage
		end,
		set = function(v)
			GridMBStatus.db.profile.hiderage = v
            GridMBStatus:UpdateAllUnits()
		end,
	},
	["Colours"] = {
		type = "group",
		name = L["Colours"],
		desc = L["Colours for the various powers"],
		args = {
		["Mana color"] = {
			type = "color",
			name = L["Mana color"],
			desc = L["Color for mana"],
			hasAlpha = true,
			get = function()
				local s = GridMBStatus.db.profile.color
				return s.r, s.g, s.b, s.a
			end,
			set = function(r,g,b,a)
				local s = GridMBStatus.db.profile.color
				s.r, s.g, s.b, s.a = r, g, b, a
                GridMBStatus:UpdateAllUnits()
			end
			},
		["Energy color"] = {
			type = "color",
			name = L["Energy color"],
			desc = L["Color for energy"],
			hasAlpha = true,
			get = function()
				local s = GridMBStatus.db.profile.ecolor
				return s.r, s.g, s.b, s.a
			end,
			set = function(r,g,b,a)
				local s = GridMBStatus.db.profile.ecolor
				s.r, s.g, s.b, s.a = r, g, b, a
                GridMBStatus:UpdateAllUnits()
			end
			},
		["Rage color"] = {
			type = "color",
			name = L["Rage color"],
			desc = L["Color for rage"],
			hasAlpha = true,
			get = function()
				local s = GridMBStatus.db.profile.rcolor
				return s.r, s.g, s.b, s.a
			end,
			set = function(r,g,b,a)
				local s = GridMBStatus.db.profile.rcolor
				s.r, s.g, s.b, s.a = r, g, b, a
                GridMBStatus:UpdateAllUnits()
			end
			},

		}
	},
	["Ignore Pets"] = {
		type = "toggle",
		name = L["Ignore Pets"],
		desc = L["Don't track power for pets"],
		get = function()
			return GridMBStatus.db.profile.hidepetbars
		end,
		set = function(v)
			GridMBStatus.db.profile.hidepetbars=v
            GridMBStatus:UpdateAllUnits()
		end,
	}
}

local playerName = UnitName("player")
local ignoreUnitsPower = {}

function GridMBStatus:OnInitialize()
	self.super.OnInitialize(self)
    
	self:RegisterStatus('unit_mana',L["Mana"], manabar_options, true)
	GridStatus.options.args['unit_mana'].args['color'] = nil
end

function GridMBStatus:OnEnable()
    self:RegisterEvent("Grid_UnitLeft")
	self:RegisterEvent("Grid_LeftParty")
    
	self:RegisterEvent("Grid_UnitJoined", "UpdateUnitPowerType")
    self:RegisterEvent("UNIT_DISPLAYPOWER")
    
    
	self:RegisterEvent("UNIT_MANA","UpdateUnit")
    self:RegisterEvent("UNIT_MAXMANA","UpdateUnit")
    
	self:RegisterEvent("UNIT_RAGE","UpdateUnit")
    self:RegisterEvent("UNIT_MAXRAGE","UpdateUnit")
    
	self:RegisterEvent("UNIT_ENERGY","UpdateUnit")
    self:RegisterEvent("UNIT_MAXENERGY","UpdateUnit")
	
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
end



--[[free the leaving units entry in ignoreUnitsPower-table]]
function GridMBStatus:Grid_UnitLeft(name)
	--this doesn't work in battlegrounds because I currently can't find
	--an easy way of getting the realm of the leaving unit because it isn't
	--in the raid anymore
	ignoreUnitsPower[name] = nil
end

--[[wipe own-heals-table clean]]
function GridMBStatus:Grid_LeftParty()
	ignoreUnitsPower = {}
    self:UpdateUnitPowerType(playerName)
end

function GridMBStatus:UNIT_DISPLAYPOWER(unitid)
    local name = UnitName(unitid)
    if not name then return end
    
    self:UpdateUnitPowerType(name)
end

function GridMBStatus:UpdateUnit(unitid)
    local name = UnitName(unitid)
    --DEFAULT_CHAT_FRAME:AddMessage("UU("..unitid..")")
    if not name then return end
    --DEFAULT_CHAT_FRAME:AddMessage("UU("..name..")")
    
    if ignoreUnitsPower[name] == false then
        self:UpdateUnitPower(name)
    end
end

function GridMBStatus:UpdateAllUnits()
    --DEFAULT_CHAT_FRAME:AddMessage("MB:UpdateAllUnits()")
    for u in RL:IterateRoster() do
        self:UpdateUnitPowerType(u.name)
    end
end


function GridMBStatus:UpdateUnitPowerType(name)
    --DEFAULT_CHAT_FRAME:AddMessage("MB:UpdateUnitPowerType("..name..")")
        
    local ignoreUnit = false
    
    if petbars and GridMBStatus.db.profile.hidepetbars and (not UnitIsPlayer(name)) then
        ignoreUnit = true
	elseif GridMBStatus.db.profile.hiderage then
		local powerType = UnitPowerType(name)
        
		if powerType == 1 or powerType == 3 then
			ignoreUnit = true
		end
	end
    
    ignoreUnitsPower[name] = ignoreUnit
    
    if ignoreUnit then
        self.core:SendStatusLost(name, "unit_mana")
    else
        self:UpdateUnitPower(name)
    end
end

function GridMBStatus:UpdateUnitPower(name)
	
	local cur, max = UnitMana(name), UnitManaMax(name)
	local priority = 70

	if cur==max then
		priority=1
	end
    
	local powerType = UnitPowerType(name)
	local col = nil

	if powerType == 3 then
		col = GridMBStatus.db.profile.ecolor
	elseif powerType == 1 then
		col = GridMBStatus.db.profile.rcolor
	else
		col = GridMBStatus.db.profile.color
	end

--DEFAULT_CHAT_FRAME:AddMessage("UU("..unitid..")")

	self.core:SendStatusGained(
        name, "unit_mana", 
        priority, 
        nil,
		col,
        nil,
        cur,max,
        nil
    )
end

