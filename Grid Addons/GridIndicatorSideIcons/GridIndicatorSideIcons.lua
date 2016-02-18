-- ----------------------------------------------------------------------------
-- GridIndicatorSideIcons by kunda
-- ----------------------------------------------------------------------------
local L = AceLibrary("AceLocale-2.2"):new("GridIndicatorSideIcons")
local AceOO = AceLibrary("AceOO-2.0")

GridIndicatorSideIcons = GridStatus:NewModule("GridIndicatorSideIcons")
GridIndicatorSideIcons.menuName = L["GridIndicatorSideIcons"]
GridIndicatorSideIcons.options = false
GridIndicatorSideIcons.defaultDB = {
	iconSizeTop = 6,
	iconSizeBottom = 6,
	iconSizeLeft = 6,
	iconSizeRight = 6,
}

local indicators = GridFrame.frameClass.prototype.indicators
table.insert(indicators, { type = "icontop",		order = 6.1, name = L["Top Icon"] })
table.insert(indicators, { type = "iconbottom",	order = 6.2, name = L["Bottom Icon"] })
table.insert(indicators, { type = "iconleft",		order = 6.3, name = L["Left Icon"] })
table.insert(indicators, { type = "iconright",	order = 6.4, name = L["Right Icon"] })

local statusmap = GridFrame.defaultDB.statusmap
if not statusmap["icontop"] then statusmap["icontop"] = {}; end
if not statusmap["iconbottom"] then statusmap["iconbottom"] = {}; end
if not statusmap["iconleft"] then statusmap["iconleft"] = {}; end
if not statusmap["iconright"] then statusmap["iconright"] = {}; end

if(GridFrame and GridFrame.db and GridFrame.db.profile) then
	statusmap = GridFrame.db.profile.statusmap
	if not statusmap["icontop"] then statusmap["icontop"] = {}; end
	if not statusmap["iconbottom"] then statusmap["iconbottom"] = {}; end
	if not statusmap["iconleft"] then statusmap["iconleft"] = {}; end
	if not statusmap["iconright"] then statusmap["iconright"] = {}; end
end

local GridIndicatorSideIconsFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if not _frameClass then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = GridIndicatorSideIconsFrameClass
end

function GridIndicatorSideIcons:OnEnable()
	local opt = GridFrame.options.args.advanced.args
	opt["iconsizetop"] = {
		type = "range",
		name = L["Icon Size Top"],
		desc = L["Adjust the size of the top icon."],
		order = 101,
		min = 5,
		max = 50,
		step = 1,
		get = function ()
			return GridIndicatorSideIcons.db.profile.iconSizeTop
		end,
		set = function (v)
			GridIndicatorSideIcons.db.profile.iconSizeTop = v
			GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
		end,
	}
	opt["iconsizebottom"] = {
		type = "range",
		name = L["Icon Size Bottom"],
		desc = L["Adjust the size of the bottom icon."],
		order = 102,
		min = 5,
		max = 50,
		step = 1,
		get = function ()
			return GridIndicatorSideIcons.db.profile.iconSizeBottom
		end,
		set = function (v)
			GridIndicatorSideIcons.db.profile.iconSizeBottom = v
			GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
		end,
	}
	opt["iconsizeleft"] = {
		type = "range",
		name = L["Icon Size Left"],
		desc = L["Adjust the size of the left icon."],
		order = 103,
		min = 5,
		max = 50,
		step = 1,
		get = function ()
			return GridIndicatorSideIcons.db.profile.iconSizeLeft
		end,
		set = function (v)
			GridIndicatorSideIcons.db.profile.iconSizeLeft = v
			GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
		end,
	}
	opt["iconsizeright"] = {
		type = "range",
		name = L["Icon Size Right"],
		desc = L["Adjust the size of the right icon."],
		order = 104,
		min = 5,
		max = 50,
		step = 1,
		get = function ()
			return GridIndicatorSideIcons.db.profile.iconSizeRight
		end,
		set = function (v)
			GridIndicatorSideIcons.db.profile.iconSizeRight = v
			GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
		end,
	}
end

function GridIndicatorSideIconsFrameClass.prototype:CreateIndicator(indicator)
	GridIndicatorSideIconsFrameClass.super.prototype.CreateIndicator(self, indicator)
	local f = self.frame
	if indicator == "icontop" then
		f.icontop = f.Bar:CreateTexture("IconTop", "OVERLAY")
		f.icontop:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeTop)
		f.icontop:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeTop)
		f.icontop:SetPoint("TOP", f, "TOP")
		f.icontop:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.icontop:SetTexture(1,1,1,0)
	elseif indicator == "iconbottom" then
		f.iconbottom = f.Bar:CreateTexture("IconBottom", "OVERLAY")
		f.iconbottom:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeBottom)
		f.iconbottom:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeBottom)
		f.iconbottom:SetPoint("BOTTOM", f, "BOTTOM")
		f.iconbottom:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconbottom:SetTexture(1,1,1,0)
	elseif indicator == "iconleft" then
		f.iconleft = f.Bar:CreateTexture("IconLeft", "OVERLAY")
		f.iconleft:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeLeft)
		f.iconleft:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeLeft)
		f.iconleft:SetPoint("LEFT", f, "LEFT")
		f.iconleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconleft:SetTexture(1,1,1,0)
	elseif indicator == "iconright" then
		f.iconright = f.Bar:CreateTexture("IconRight", "OVERLAY")
		f.iconright:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeRight)
		f.iconright:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeRight)
		f.iconright:SetPoint("RIGHT", f, "RIGHT")
		f.iconright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconright:SetTexture(1,1,1,0)
	end
end

function GridIndicatorSideIconsFrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture)
	GridIndicatorSideIconsFrameClass.super.prototype.SetIndicator(self, indicator, color, text, value, maxValue, texture)
	if indicator == "icontop"
	or indicator == "iconbottom"
	or indicator == "iconleft"
	or indicator == "iconright"
	then
		if not self.frame[indicator] then
			self:CreateIndicator(indicator)
		end
		if texture then
			self.frame[indicator]:SetTexture(texture)
			self.frame[indicator]:SetAlpha(1)
			self.frame[indicator]:Show()
			if type(color) == "table" then
				self.frame[indicator]:SetAlpha(color.a)
			end
		else
			self.frame[indicator]:Hide()
		end
	end
end

function GridIndicatorSideIconsFrameClass.prototype:ClearIndicator(indicator)
	GridIndicatorSideIconsFrameClass.super.prototype.ClearIndicator(self, indicator)
	if indicator == "icontop"
	or indicator == "iconbottom"
	or indicator == "iconleft"
	or indicator == "iconright"
	then
		if self.frame[indicator] then
			self.frame[indicator]:SetTexture(1,1,1,0)
			self.frame[indicator]:Hide()
		end
	end
end

function GridIndicatorSideIconsFrameClass.prototype:SetIconSize(size)
	GridIndicatorSideIconsFrameClass.super.prototype.SetIconSize(self, GridFrame.db.profile.iconSize)
	local f = self.frame
	if f.icontop then
		f.icontop:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeTop)
		f.icontop:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeTop)
	end
	if f.iconbottom then
		f.iconbottom:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeBottom)
		f.iconbottom:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeBottom)
	end
	if f.iconleft then
		f.iconleft:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeLeft)
		f.iconleft:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeLeft)
	end
	if f.iconright then
		f.iconright:SetWidth(GridIndicatorSideIcons.db.profile.iconSizeRight)
		f.iconright:SetHeight(GridIndicatorSideIcons.db.profile.iconSizeRight)
	end
end