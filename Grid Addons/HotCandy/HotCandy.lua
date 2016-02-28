--[[
Copyright (c) 2008, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

--[[ $Id: HotCandy.lua 78538 2008-07-16 11:48:25Z nevcairiel $ ]]
local HotCandy = LibStub("AceAddon-3.0"):NewAddon("HotCandy", "AceEvent-3.0", "AceBucket-3.0", "AceConsole-3.0", "LibBars-1.0")

local VERSION = tonumber(("$Revision: 78538 $"):match("%d+"))
HotCandy.revision = VERSION
HotCandy.versionstring = "1.3 |cffff8888r%d|r"
HotCandy.version = HotCandy.versionstring:format(VERSION)
HotCandy.date = ("$Date: 2008-07-16 07:48:25 -0400 (Wed, 16 Jul 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")

local pairs, next, type = pairs, next, type

local media = LibStub("LibSharedMedia-3.0")
media:Register("statusbar", "BantoBar", "Interface\\Addons\\HotCandy\\textures\\default")

local itemSets = {
	["Stormrage"] = { 16897, 16898, 16899, 16900, 16901, 16902, 16903, 16904 },
	["Nordrassil"] = { 30216, 30217, 30219, 30220, 30221 },
	["Transcendence"] = { 16919, 16920, 16921, 16922, 16923, 16924, 16925, 16926 },
	["Avatar Raiment"] = { 30150, 30151, 30152, 30153, 30154 },
}
	-- spell = duration
local durations = {
	[774] = 12, -- Rejuvenation
	[8936] = 21, -- Regrowth
	[139] = 15, -- Renew
	[2060] = 0, -- Greater Heal
	[33763] = 7, -- Lifebloom
	[28880] = 15, -- Gift of the Naaru
}

-- HoTs that we track on Casting Events
local castTrack = {
	[774] = true, -- Rejuvenation
	[139] = true, -- Renew
	[33763] = true, -- Lifebloom
	[28880] = true, -- Gift of the Naaru
}

-- HoTs that we track based on SPELL_HEAL events from the Combat Log
local cleuTrack = {
	[8936] = true, -- Regrowth
	[2060] = true, -- Greater Heal
}

-- Spell Queue for tracking the target of a cast
local spellQueue = {}
local track = {}

local defaults = {
	profile = {
		growup = false,
		texture = "BantoBar",
		width = 170,
		scale = 1,
		flash = 0,
		stackfirst = true,
		noname = false,
		locked = true,
	}
}

local lb, rejuv, regrowth = "Lifebloom", "Rejuvenation", "Regrowth"
local db

-- custom sort function to sort by time remaining
local sortFunc = function(a,b)
	if a.isTimer ~= b.isTimer then
		return a.isTimer
	end

	local av, bv = a.value, b.value
	if av == bv then
		if a.maxValue == b.maxValue then
			return a.name < b.name
		else
			return a.maxValue < b.maxValue
		end
	else
		return av < bv
	end
end

function HotCandy:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("HotCandyDB", defaults, "Default")
	db = self.db.profile

	-- Setup Options
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("HotCandy", self.CreateOptionsTable)
	local optFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("HotCandy")

	local openFunc = function()
		InterfaceOptionsFrame_OpenToFrame(optFrame)
	end
	LibStub("AceConsole-3.0"):RegisterChatCommand("hot", openFunc)
	LibStub("AceConsole-3.0"):RegisterChatCommand("hotcandy", openFunc)

	-- Setup LibBars-1.0 Group
	self.group = self:NewBarGroup("HotCandy", nil, db.width)
	self.group:SetSortFunction(sortFunc)

	-- Start in Green
	self.group:SetColorAt(1, 0, 1, 0, 1)
	-- to Yellow
	self.group:SetColorAt(0.5, 1, 1, 0, 1)
	-- and finish in Red
	self.group:SetColorAt(0.15, 1, 0, 0, 1)

	-- Load Option Settings
	self:Set("flash")
	self:Set("scale")
	self:Set("growup")
	self:Set("texture")
	self:Set("locked")
	self:LoadPosition()

	self.bars = {}
end

local first = true
function HotCandy:OnEnable()
	-- First Start, get the data from GetSpellInfo
	if first then
		lb = (GetSpellInfo(33763))
		rejuv = GetSpellInfo(774)
		regrowth = GetSpellInfo(8936)

		local newCastTrack = {}
		for k in pairs(castTrack) do
			local spellName = GetSpellInfo(k)
			newCastTrack[spellName] = true
		end
		castTrack = newCastTrack

		local newCleuTrack = {}
		for k in pairs(cleuTrack) do
			local spellName = GetSpellInfo(k)
			newCleuTrack[spellName] = true
		end
		cleuTrack = newCleuTrack

		first = nil
	end

	-- Register the events we need
	self:RegisterEvent("UNIT_SPELLCAST_SENT", "SpellCastEvent")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "SpellCastEvent")
	self:RegisterBucketEvent("UNIT_INVENTORY_CHANGED", 1, "equipChanged")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLogHandler")

	-- User moved the Anchor, save the position
	self.group.RegisterCallback(self, "AnchorMoved", "SavePosition")

	-- scan the users gear for Set Bonuses
	self:UpdateSetBonus()
end

function HotCandy:OnDisable()
	self.group.UnregisterAllCallbacks(self)
end

function HotCandy:LoadPosition()
	-- Convert old Position (its not 100% accurate due to new anchor handling - but its a start)
	if db.posx and not db.position then
		db.position = { x = db.posx, y = db.posy, point = "TOPLEFT", relPoint = "BOTTOMLEFT" }
		db.posx = nil
		db.posy = nil
	end
	if not db.position then return end
	local pos = db.position
	local x, y, s = pos.x, pos.y, self.group:GetEffectiveScale()
	local point, relPoint = pos.point, pos.relPoint
	-- x, y = x/s, y/s
	self.group:ClearAllPoints()
	self.group:SetPoint(point, UIParent, relPoint, x, y)
end

function HotCandy:SavePosition()
	if not db.position then db.position = {} end
	local pos = db.position
	local point, parent, relPoint, x, y = self.group:GetPoint()
	local s = self.group:GetEffectiveScale()
	-- x, y = x*s, y*s
	pos.x, pos.y = x, y
	pos.point, pos.relPoint = point, relPoint
end

function HotCandy:Get(key)
	return db[key]
end

function HotCandy:Set(key, value)
	if not key then return end
	if value ~= nil then
		db[key] = value
	end
	if key == "scale" then
		self.group:SetScale(db.scale)
	elseif key == "growup" then
		self.group:ReverseGrowth(db.growup)
	elseif key == "texture" then
		self.group:SetTexture(media:Fetch("statusbar", db.texture))
	elseif key == "width" then
		self.group:SetWidth(db.width)
	elseif key == "flash" then
		self.group:SetFlashTrigger(db.flash)
	elseif key == "locked" then
		if db.locked then
			self.group:HideAnchor()
		else
			self.group:ShowAnchor()
		end
	end
end

function HotCandy:CreateOptionsTable()
	self = HotCandy
	if not self.options then
		local optGet = function(info) return self:Get(info.arg or info[#info]) end
		local optSet = function(info, value) self:Set(info.arg or info[#info], value) end

		local lsmGet = function()
			local list = media:List("statusbar")
			local media = db.texture
			for i=1,#list do
				if list[i] == media then return i end
			end
			return false
		end

		local lsmSet = function(info, value)
			db.texture = media:List("statusbar")[value]
		end

		self.options = {
			name = "HotCandy",
			type = "group",
			get = optGet,
			set = optSet,
			handler = self,
			args = {
				intro = {
					cmdHidden = true,
					order = 1,
					type = "description",
					name = "You can control the behaviour and the style of HotCandy using the settings below.",
				},
				locked = {
					order = 10,
					type = "toggle",
					name = "Lock Position",
					desc = "Hide the anchor, locking the position of HotCandy.",
				},
				growup = {
					order = 15,
					name = "Grow Up",
					desc = "Toggle grow direction of the bars",
					type = "toggle",
				},
				texture = {
					order = 20,
					type = "select",
					name = "Texture",
					desc = "Set the texture for the bars.",
					values = media:List("statusbar"),
					get = lsmGet,
					set = lsmSet,
				},
				br1 = {
					cmdHidden = true,
					type = "description",
					order = 29,
					name = "",
				},
				width = {
					order = 30,
					type = "range",
					name = "Bar Width",
					desc = "Set the width of the bars.",
					min = 50, max = 500, step = 1,
				},
				scale = {
					order = 31,
					type = "range",
					name = "Bar Scale",
					desc = "Set the scale of the bars.",
					min = .1, max = 2, step = 0.01,
					isPercent = true,
				},
				br2 = {
					cmdHidden = true,
					type = "description",
					order = 34,
					name = "",
				},
				flash = {
					order = 35,
					type = "range",
					name = "Flash",
					desc = "Configure at which time-left the Bars should start flashing.",
					min = 0, max = 5, step = 0.2,
				},
				format = {
					order = 40,
					type = "group",
					name = "Text Format",
					desc = "Configure the format of the text on the timer bar.",
					dialogInline = true,
					args = {
						noname = {
							type = "toggle",
							name = "No HoT name",
							desc = "Do not show the name of the HoT.",
						},
						stackfirst = {
							type = "toggle",
							name = "Stack First",
							desc = "Show HoT stack count before the name.",
						},
					},
				},
			}
		}
	end

	return self.options
end

function HotCandy:UpdateSetBonus()
	local _, class = UnitClass("player")

	for k,v in pairs(durations) do
		local name, _, icon = GetSpellInfo(k)
		if not track[name] then
			track[name] = { icon = icon }
		end
		track[name].duration = v
	end

	if class == "DRUID" then
		if (self:getWornSetPieces("Stormrage") >= 8) then
			local key = (GetSpellInfo(774))
			track[key].duration = track[key].duration + 3
		end
		if (self:getWornSetPieces("Nordrassil") >= 2) then
			local key = (GetSpellInfo(8936))
			track[key].duration = track[key].duration + 6
		end
	elseif class == "PRIEST" then
		if (self:getWornSetPieces("Transcendence") >= 8) then
			local key = (GetSpellInfo(2060))
			track[key].duration = track[key].duration + 15
		end
		if (self:getWornSetPieces("Avatar Raiment") >= 4) then
			local key = (GetSpellInfo(139))
			track[key].duration = track[key].duration + 3
		end
	end
end

-- taken from Threat-1.0
function HotCandy:getWornSetPieces(name)
	local ct = 0
	local data = itemSets[name]
	if data then
		for _, itemID in ipairs(data) do
			if IsEquippedItem( itemID ) then
				ct = ct + 1
			end
		end
	end
	return ct
end

function HotCandy:equipChanged(units)
	if not units or not units.player or InCombatLockdown() then
		return
	end
	self:UpdateSetBonus()
end

local fmt = string.format

local function makeBarId(spell, target)
	return fmt("HotCandy%s@%s", spell, target)
end

local swiftmend = nil
-- CombatLog Event Handler
function HotCandy:CombatLogHandler(event, timestamp, clevent, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName)
	if clevent == "SPELL_HEAL" then
		if cleuTrack[spellName] and bit.band(srcFlags, COMBATLOG_FILTER_ME) == COMBATLOG_FILTER_ME then
			self:FireSpell(spellName, dstName)
		end
		if spellId == 18562 then
			swiftmend = true
		end
	-- Handler for Swiftmend
	elseif clevent == "SPELL_AURA_REMOVED" and (spellName == rejuv or spellName == regrowth) and swiftmend then
		local id = makeBarId(spellName, dstName)
		if self.bars[id] then
			local present = self:ValidateHoT(dstName, spellName)
			if not present then
				self.bars[id]:SetTimer(0)
				swiftmend = nil
			end
		end
	end
end

function HotCandy:TimerFinished(event, bar, barName)
	self.bars[barName] = nil
end


-- validate that all HoTs are still running on the current target (only used for druid swiftmend detection)
function HotCandy:ValidateHoT(name, spell)
	local i = 1
	local buff, _, _, count, duration = UnitBuff(name, i)
	while buff and duration and buff ~= spell do

		i = i + 1
		buff, _, _, count, duration = UnitBuff(name, i)
	end
	return (buff == spell)
end

-- Spell Cast Event tracks pure HoTs with no direct heal to catch
function HotCandy:SpellCastEvent(event, unit, spellName, rank, target)
	if unit ~= "player" or not castTrack[spellName] then return end
	if ( event == "UNIT_SPELLCAST_SENT" ) then
		spellQueue[spellName] = target
	elseif ( event == "UNIT_SPELLCAST_SUCCEEDED" ) then
		if spellQueue[spellName] then
			self:FireSpell(spellName, spellQueue[spellName])
		end
		spellQueue[spellName] = nil
	end
end

-- Handler for showing the Spell as a Bar
function HotCandy:FireSpell(spellName, spellTarget)
	local spell = track[spellName]
	-- Validate the Spell is supposed to be tracked
	if spell and spell.duration > 0 then
		local id = makeBarId(spellName, spellTarget)
		local stack = ""

		-- Special Lifebloom handling for detecting its stack size
		if spellName == lb then
			local i = 1
			-- Iterate over targets buffs and check for our Lifebloom
			local buff, _, _, count, duration = UnitBuff(spellTarget, i)
			while buff and duration and buff ~= spellName do
				i = i + 1
				buff, _, _, count, duration = UnitBuff(spellTarget, i)
			end
			-- Check if we found a stack of our spell
			if buff == spellName and count and count > 0 then
				count = min(count + 1, 3)
				stack = fmt("(%d) ", count)
			end
		end

		-- Create Text for the bar according to configured format
		local text
		if not db.noname then
			if db.stackfirst then
				text = stack .. spellName .. " - " .. spellTarget
			else
				text = spellName .. stack .." - " .. spellTarget
			end
		else
			text = stack .. spellTarget
		end
		-- Create the Bar
		self.bars[id] = self.group:NewTimerBar(id, text, spell.duration, nil, spell.icon)
		self.bars[id].RegisterCallback(self, "TimerFinished")
	end
end
