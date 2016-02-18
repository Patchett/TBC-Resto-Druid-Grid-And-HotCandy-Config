local L = AceLibrary("AceLocale-2.2"):new("GridStatusLifebloom")
local BS = LibStub("LibBabble-Spell-3.0"):GetLookupTable()

local LifebloomName = BS["Lifebloom"]

GridStatusLifebloom = GridStatus:NewModule("GridStatusLifebloom")
GridStatusLifebloom.menuName = LifebloomName

L:RegisterTranslations("enUS", function()
	return {
		["Lifebloom Stack"] = true,
		["Lifebloom Duration"] = true,

		["Color 1"] = true,
		["Color 2"] = true,
		["Color 3"] = true,

		["Color when player has one stack of lifebloom."] = true,
		["Color when player has two stacks of lifebloom."] = true,
		["Color when player has three stacks of lifebloom."] = true,
		
		["Global Cooldown Mode"] = true,
		["Global Cooldown Duration"] = true,
		["Global Cooldown Delay"] = true,
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["Lifebloom Stack"] = "Blühendes Leben Anzahl",
		["Lifebloom Duration"] = "Blühendes Leben Dauer",

		["Color 1"] = "Farbe 1",
		["Color 2"] = "Farbe 2",
		["Color 3"] = "Farbe 3",

		["Color when player has one stack of lifebloom."] = "Farbe wenn Spieler einmal 'Blühendes Leben' hat.",
		["Color when player has two stacks of lifebloom."] = "Farbe wenn Spieler zweimal 'Blühendes Leben' hat.",
		["Color when player has three stacks of lifebloom."] = "Farbe wenn Spieler dreimal 'Blühendes Leben' hat.",
		
		["Global Cooldown Mode"] = "Globaler Cooldown Modus",
		["Global Cooldown Duration"] = "Globaler Cooldown Dauer",
		["Global Cooldown Delay"] = "Globaler Cooldown Verzögerung",
	}
end)

L:RegisterTranslations("koKR", function()
	return {
		["Lifebloom Stack"] = "피어나는 생명",
		["Lifebloom Duration"] = "피어나는 생명 지속시간",

		["Color 1"] = "색상 1",
		["Color 2"] = "색상 2",
		["Color 3"] = "색상 3",

		["Color when player has one stack of lifebloom."] = "피어나는 생명 1개 지속시 색상",
		["Color when player has two stacks of lifebloom."] = "피어나는 생명 2개 지속시 색상",
		["Color when player has three stacks of lifebloom."] = "피어나는 생명 3개 지속시 색상",
		
		--["Global Cooldown Mode"] = true,
		--["Global Cooldown Duration"] = true,
		--["Global Cooldown Delay"] = true,
	}
end)

L:RegisterTranslations("zhTW", function()
	return {
		["Lifebloom Stack"] = "生命之花堆疊",
		["Lifebloom Duration"] = "生命之花持續時間",

		["Color 1"] = "顏色一",
		["Color 2"] = "顏色二",
		["Color 3"] = "顏色三",

		["Color when player has one stack of lifebloom"] = "當生命之花堆疊一次的顏色",
		["Color when player has two stacks of lifebloom"] = "當生命之花堆疊二次的顏色",
		["Color when player has three stacks of lifebloom"] = "當生命之花堆疊三次的顏色",

		["Global Cooldown Mode"] = "全域冷卻時間模式",
		["Global Cooldown Duration"] = "全域持續冷卻時間",
		["Global Cooldown Delay"] = "全域延遲冷卻時間",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Lifebloom Stack"] = "生命绽放堆叠",
		["Lifebloom Duration"] = "生命绽放持续时间",

		["Color 1"] = "颜色一",
		["Color 2"] = "颜色二",
		["Color 3"] = "颜色三",

		["Color when player has one stack of lifebloom"] = "当生命绽放堆叠一次的颜色",
		["Color when player has two stacks of lifebloom"] = "当生命绽放堆叠二次的颜色",
		["Color when player has three stacks of lifebloom"] = "当生命绽放堆叠三次的颜色",
		
		--["Global Cooldown Mode"] = true,
		--["Global Cooldown Duration"] = true,
		--["Global Cooldown Delay"] = true,
	}
end)

GridStatusLifebloom.defaultDB = {
	debug = false,
	alert_LifebloomStack = {
		text = L["Lifebloom Stack"],
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		color2 = { r = 0, g = 1, b = 1, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
		gcdMode = false,
		gcdDuration = 1.5,
		gcdDelay = 0.5,
		priority = 70,
		range = false,
	},
	alert_LifebloomDuration = {
		text = L["Lifebloom Duration"],
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		color2 = { r = 0, g = 1, b = 1, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
		priority = 70,
		range = false,
	},
}

local alert_LifebloomStackOptions = {
	["color2"] = {
		type = "color",
		order = 100,
		name = L["Color 2"],
		desc = L["Color when player has two stacks of lifebloom."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusLifebloom.db.profile.alert_LifebloomStack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusLifebloom.db.profile.alert_LifebloomStack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		order = 101,
		name = L["Color 3"],
		desc = L["Color when player has three stacks of lifebloom."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusLifebloom.db.profile.alert_LifebloomStack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusLifebloom.db.profile.alert_LifebloomStack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local alert_LifebloomDurationOptions = {
	["color2"] = {
		type = "color",
		order = 100,
		name = L["Color 2"],
		desc = L["Color when player has two stacks of lifebloom."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusLifebloom.db.profile.alert_LifebloomDuration.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusLifebloom.db.profile.alert_LifebloomDuration.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		order = 101,
		name = L["Color 3"],
		desc = L["Color when player has three stacks of lifebloom."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusLifebloom.db.profile.alert_LifebloomDuration.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusLifebloom.db.profile.alert_LifebloomDuration.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["gcdMode"] = {
		type = "toggle",
		order = 102,
		name = L["Global Cooldown Mode"],
		desc = L["Global Cooldown Mode"]..".",
		get = function ()
			return GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdMode
		end,
		set = function (arg)
			GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdMode = arg
		end,
	},
	["gcdDuration"] = {
		type = "range",
		order = 103,
		name = L["Global Cooldown Duration"],
		desc = L["Global Cooldown Duration"]..".",
		min = 1.5,
		max = 2,
		step = 0.01,
		disabled = function()
			if GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdMode then
				return false
			else
				return true
			end
		end,
		get = function ()
			return GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdDuration
		end,
		set = function (arg)
			GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdDuration = arg
		end,
	},
	["gcdDelay"] = {
		type = "range",
		order = 104,
		name = L["Global Cooldown Delay"],
		desc = L["Global Cooldown Delay"]..".",
		min = 0,
		max = 1,
		step = 0.01,
		disabled = function()
			if GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdMode then
				return false
			else
				return true
			end
		end,
		get = function ()
			return GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdDelay
		end,
		set = function (arg)
			GridStatusLifebloom.db.profile.alert_LifebloomStack.gcdDelay = arg
		end,
	}
}

function GridStatusLifebloom:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_LifebloomStack", L["Lifebloom Stack"], alert_LifebloomStackOptions)
	self:RegisterStatus("alert_LifebloomDuration", L["Lifebloom Duration"], alert_LifebloomDurationOptions)
end

function GridStatusLifebloom:OnEnable()
	local f = function()
		GridStatusLifebloom:UpdateAllUnits("player")
	end
	self:RegisterEvent("SpecialEvents_UnitBuffGained")
	self:RegisterEvent("SpecialEvents_UnitBuffLost")
	self:RegisterEvent("SpecialEvents_UnitBuffCountChanged")
	self:RegisterEvent("Grid_UnitJoined")
	self:RegisterEvent("Grid_UnitDeath")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
	self:ScheduleRepeatingEvent("GridLifebloom_Refresh", f, 0.07)
end

function GridStatusLifebloom:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusLifebloom:UpdateAllUnits()
	local name, status, statusTbl

	for name, status, statusTbl in self.core:CachedStatusIterator("alert_LifebloomStack") do
		self:UpdateUnit(name,true)
	end
end

function GridStatusLifebloom:Grid_UnitJoined(name, unitid)
	if unitid then
		self:UpdateUnit(unitid)
	end
end

function GridStatusLifebloom:Grid_UnitDeath(unitname)
	local status, moduleName, desc
	for status, moduleName, desc in self.core:RegisteredStatusIterator() do
		if moduleName == self.name then
			self.core:SendStatusLost(unitname, status)
		end
	end
end

function GridStatusLifebloom:CountHOTs(unitid)
	local maxbuffs = 40
	if unitid then
		for i = 1, maxbuffs do
			buffName, rank, texture, applications, duration, timeleft = UnitBuff(unitid,i,true)
			if buffName and timeleft then
				if self:isLifebloom(buffName) then
					return applications, timeleft
				end
			end
		end
	end
	return 0,0
end

function GridStatusLifebloom:SpecialEvents_UnitBuffGained(unit, buff, index, apps, tex, rank)
	--self:UpdateUnit(unit,true)
	self:Debug("UnitBuffGained:"..buff)
	if self:isLifebloom( buff ) then
		self:UpdateUnit(unit, true)
	end
end

function GridStatusLifebloom:SpecialEvents_UnitBuffLost(unit, buff, index, apps, tex, rank)
	self:Debug("UnitBuffLost:"..buff)
	if self:isLifebloom( buff ) then
		self:UpdateUnit(unit, true)
	end
end

function GridStatusLifebloom:SpecialEvents_UnitBuffCountChanged(unit, buff, index, apps, tex, rank)
	self:Debug("UnitBuffChanged:"..buff)
	if self:isLifebloom( buff ) then
		self:UpdateUnit(unit, true)
	end
end

function GridStatusLifebloom:isLifebloom(buffName)
	return buffName == LifebloomName
end

function GridStatusLifebloom:UpdateUnit(unitid, ignoreRange)
	local name = UnitName(unitid)

	if not name then return end

	local settings = self.db.profile.alert_LifebloomStack
	local LifebloomCount,lifebloomDuration = self:CountHOTs(unitid)

	self:Debug("Count:"..LifebloomCount)
	if LifebloomCount == 0 then
		self.core:SendStatusLost(name, "alert_LifebloomStack")
		self.core:SendStatusLost(name, "alert_LifebloomDuration")
	else
		local thecolor = settings.color
		if LifebloomCount == 2 then
			thecolor = settings.color2
		elseif LifebloomCount == 3 then
			thecolor = settings.color3
		end
		local time = lifebloomDuration
		if settings.gcdMode then
			time = (lifebloomDuration - settings.gcdDelay) / settings.gcdDuration
			if time < 0 then
				time = 0
			end
		end
		self.core:SendStatusGained(name, "alert_LifebloomDuration",
			settings.priority,
			(settings.range and 40),
			thecolor,
			string.format("%.1f", time),
			lifebloomDuration,
			6 )

		self.core:SendStatusGained(name, "alert_LifebloomStack",
			settings.priority,
			(settings.range and 40),
			thecolor,
			tostring(LifebloomCount),
			LifebloomCount,
			6 )
	end
end