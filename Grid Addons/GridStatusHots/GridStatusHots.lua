--{{{ Libraries

local RL = AceLibrary("Roster-2.1")
local Aura = AceLibrary("SpecialEvents-Aura-2.0")
local L = AceLibrary("AceLocale-2.2"):new("GridStatusHots")

--}}}
--

local playerClass, englishClass = UnitClass("player")

GridStatusHots = GridStatus:NewModule("GridStatusHots")
GridStatusHots.menuName = L["My HoTs"]

--{{{ AceDB defaults
--
GridStatusHots.defaultDB = {
	alert_renew = {
		text = L["Buff: My Renew"],
		desc = L["Buff: My Renew"],
		enable = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_rejuv = {
		text = L["Buff: My Rejuvenation"],
		desc = L["Buff: My Rejuvenation"],
		enable = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 0, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_regrow = {
		text = L["Buff: My Regrowth"],
		desc = L["Buff: My Regrowth"],
		enable = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 1, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_lifebl = {
		text = L["Buff: My Lifebloom"],
		desc = L["Buff: My Lifebloom"],
		enable = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_tothots = {
		text = L["Buff: Hot Count"],
		desc = L["Buff: Hot Count"],
		enable = true,
		priority = 97,
		range = false,
		color = { r = 0, g = 1, b = 0, a = 1 },
	},
}


local renew_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_renew.threshold2
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_renew.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_renew.threshold3
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_renew.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local rejuv_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_rejuv.threshold2
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_rejuv.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_rejuv.threshold3
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_rejuv.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local regrow_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_regrow.threshold2
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_regrow.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_regrow.threshold3
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_regrow.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local lifebl_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_lifebl.threshold2
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_lifebl.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_lifebl.threshold3
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_lifebl.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}


--}}}


function GridStatusHots:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus("alert_tothots", L["Buff: Hot Count"], alert_tothots)
	if englishClass == "PRIEST" then
		self:RegisterStatus("alert_renew", L["Buff: My Renew"], renew_hotcolors)
	end
	if englishClass == "DRUID" then
		self:RegisterStatus("alert_rejuv", L["Buff: My Rejuvenation"], rejuv_hotcolors)
		self:RegisterStatus("alert_regrow", L["Buff: My Regrowth"], regrow_hotcolors)
		self:RegisterStatus("alert_lifebl", L["Buff: My Lifebloom"], lifebl_hotcolors)
	end
end

function GridStatusHots:OnEnable()
	local f = function()
		GridStatusHots:UpdateAll()
	end
	self:ScheduleRepeatingEvent("GHS_Refresh", f,.5)
end

function GridStatusHots:Reset()
	self.super.Reset(self)
end

function GridStatusHots:UpdateAll()
	for u in RL:IterateRoster(true) do
		local name = UnitName(u.unitid) or ""
		local recnt,rgcnt,rjcnt,lbcnt = 0,0,0,0
		local retime,rjtime,rgtime,lbtime,hcnttxt = nil,nil,nil,nil,nil

		-- Find number of hots pr unit
		for i=1,40 do -- this is not raid numbers, its possible buffs/debuffs to scan per member,
			local bname,brank,btexture,bcount,bdur, btime = UnitBuff(u.unitid, i)
			if not bname then break end
			if bname and bname == L["Renew"] then
				recnt = recnt + 1
				if btime then retime = btime+1 end
			end
			if bname and bname == L["Regrowth"] then
				rgcnt = rgcnt + 1
				if btime then rgtime = btime+1 end
			end
			if bname and bname == L["Rejuvenation"] then
				rjcnt = rjcnt + 1
				if btime then rjtime = btime+1 end
			end
			if bname and bname == L["Lifebloom"] then
				lbcnt = lbcnt + bcount
				if btime then lbtime = btime+1 end
			end
		end
		-- Set number of hots currently running on all units
		if recnt > 0 or rjcnt > 0 or rgcnt > 0 or lbcnt > 0 then
			hcnttxt = tostring(lbcnt)
			local settings = self.db.profile.alert_tothots
			self.core:SendStatusGained(name, "alert_tothots",
				settings.priority,
				(settings.range and 40),
				settings.color,
				tostring(hcnttxt)
			)
		else
			if self.core:GetCachedStatus(name, "alert_tothots") then self.core:SendStatusLost(name, "alert_tothots") end
		end

		if retime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_renew
			local hotcolor = settings.color
			if retime <= settings.threshold2 then hotcolor = settings.color2 end
			if retime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(name, "alert_renew",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(retime))
			)
		else
			if self.core:GetCachedStatus(name, "alert_renew") then self.core:SendStatusLost(name, "alert_renew") end
		end
		if rgtime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_regrow
			local hotcolor = settings.color
			if rgtime <= settings.threshold2 then hotcolor = settings.color2 end
			if rgtime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(name, "alert_regrow",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rgtime))
			)
		else
			if self.core:GetCachedStatus(name, "alert_regrow") then self.core:SendStatusLost(name, "alert_regrow") end
		end
		if rjtime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_rejuv
			local hotcolor = settings.color
			if rjtime <= settings.threshold2 then hotcolor = settings.color2 end
			if rjtime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(name, "alert_rejuv",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rjtime))
			)
		else
			if self.core:GetCachedStatus(name, "alert_rejuv") then self.core:SendStatusLost(name, "alert_rejuv") end
		end
		if lbtime then
			-- Add self thrown countdown and status
			local settings = self.db.profile.alert_lifebl
			local hotcolor = settings.color
			if lbtime <= settings.threshold2 then hotcolor = settings.color2 end
			if lbtime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(name, "alert_lifebl",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(lbtime))
			)
		else
			if self.core:GetCachedStatus(name, "alert_lifebl") then self.core:SendStatusLost(name, "alert_lifebl") end
		end

	end
end
