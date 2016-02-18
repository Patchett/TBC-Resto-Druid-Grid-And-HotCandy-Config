-- -------------------------------------------------------------------------- --
-- GridIndicatorCornerIcons by kunda                                          --
-- -------------------------------------------------------------------------- --
local L = AceLibrary("AceLocale-2.2"):new("GridIndicatorCornerIcons")
local AceOO = AceLibrary("AceOO-2.0")

GridIndicatorCornerIcons = GridStatus:NewModule("GridIndicatorCornerIcons")
GridIndicatorCornerIcons.defaultDB = {
	iconSizeTopLeftCorner = 10,
	iconSizeTopRightCorner = 10,
	iconSizeBottomLeftCorner = 10,
	iconSizeBottomRightCorner = 10,
	xoffset = -2,
	yoffset = 4,
	}

local indicators = GridFrame.frameClass.prototype.indicators
table.insert(indicators, { type = "iconTLcornerleft",  order = 7.21, name = L["Top Left Corner Icon (Left)"] })
table.insert(indicators, { type = "iconTLcornerright", order = 7.22, name = L["Top Left Corner Icon (Right)"] })
table.insert(indicators, { type = "iconTRcornerleft",  order = 7.23, name = L["Top Right Corner Icon (Left)"] })
table.insert(indicators, { type = "iconTRcornerright", order = 7.24, name = L["Top Right Corner Icon (Right)"] })
table.insert(indicators, { type = "iconBLcornerleft",  order = 7.25, name = L["Bottom Left Corner Icon (Left)"] })
table.insert(indicators, { type = "iconBLcornerright", order = 7.26, name = L["Bottom Left Corner Icon (Right)"] })
table.insert(indicators, { type = "iconBRcornerleft",  order = 7.27, name = L["Bottom Right Corner Icon (Left)"] })
table.insert(indicators, { type = "iconBRcornerright", order = 7.28, name = L["Bottom Right Corner Icon (Right)"] })

local statusmap = GridFrame.db.profile.statusmap
if not statusmap["iconTLcornerleft"] then
	statusmap["iconTLcornerleft"] = {}
	statusmap["iconTLcornerright"] = {}
	statusmap["iconTRcornerleft"] = {}
	statusmap["iconTRcornerright"] = {}
	statusmap["iconBLcornerleft"] = {}
	statusmap["iconBLcornerright"] = {}
	statusmap["iconBRcornerleft"] = {}
	statusmap["iconBRcornerright"] = {}
end

local GridIndicatorCornerIconsFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if not _frameClass then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = GridIndicatorCornerIconsFrameClass
end

function GridIndicatorCornerIcons:OnEnable()
	self:CleanOptionsMenu() -- hack for better indicator menu

	GridFrame.options.args.advanced.args["cornericons"] = {
		type = "group",
		name = L["Icon (Corners)"],
		desc = L["Options for Icon (Corners) indicators."],
		order = 107,
		args = {
			["iconsizetopleftcorner"] = {
				type = "range",
				name = L["Icon Size Top Left Corner"],
				desc = L["Adjust the size of the 2 Top Left Corner Icons."],
				order = 107.1,
				min = 5,
				max = 50,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			},
			["iconsizetoprightcorner"] = {
				type = "range",
				name = L["Icon Size Top Right Corner"],
				desc = L["Adjust the size of the 2 Top Right Corner Icons."],
				order = 107.2,
				min = 5,
				max = 50,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			},
			["iconsizebottomleftcorner"] = {
				type = "range",
				name = L["Icon Size Bottom Left Corner"],
				desc = L["Adjust the size of the 2 Bottom Left Corner Icons."],
				order = 107.3,
				min = 5,
				max = 50,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			},
			["iconsizebottomrightcorner"] = {
				type = "range",
				name = L["Icon Size Bottom Right Corner"],
				desc = L["Adjust the size of the 2 Bottom Right Corner Icons."],
				order = 107.4,
				min = 5,
				max = 50,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			},
			["xoffset"] = {
				type = "range",
				name = L["Offset X-axis"],
				desc = L["Adjust the offset of the X-axis."],
				order = 107.5,
				min = -10,
				max = 10,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.xoffset
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.xoffset = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			},
			["yoffset"] = {
				type = "range",
				name = L["Offset Y-axis"],
				desc = L["Adjust the offset of the Y-axis."],
				order = 107.6,
				min = -10,
				max = 10,
				step = 1,
				get = function ()
					return GridIndicatorCornerIcons.db.profile.yoffset
				end,
				set = function (v)
					GridIndicatorCornerIcons.db.profile.yoffset = v
					GridFrame:WithAllFrames(function (f) f:SetIconSize(v) end)
				end,
			}
		}
	}
	hooksecurefunc(GridFrame, "UpdateOptionsMenu", GridIndicatorCornerIcons.CleanOptionsMenu) -- hack for better indicator menu
end

function GridIndicatorCornerIcons:CleanOptionsMenu()
	GridFrame.options.args["cornericons"] = {
		type = "group",
		icon = "Interface\\QuestFrame\\UI-Quest-BulletPoint",
		name = L["Icon (Corners)"],
		desc = L["Options for Icon (Corners) indicators."],
		order = 57.2,
		args = {
			["iconTLcornerleft"]  = GridFrame.options.args.iconTLcornerleft,
			["iconTLcornerright"] = GridFrame.options.args.iconTLcornerright,
			["iconTRcornerleft"]  = GridFrame.options.args.iconTRcornerleft,
			["iconTRcornerright"] = GridFrame.options.args.iconTRcornerright,
			["iconBLcornerleft"]  = GridFrame.options.args.iconBLcornerleft,
			["iconBLcornerright"] = GridFrame.options.args.iconBLcornerright,
			["iconBRcornerleft"]  = GridFrame.options.args.iconBRcornerleft,
			["iconBRcornerright"] = GridFrame.options.args.iconBRcornerright
		}
	}
	GridFrame.options.args.iconTLcornerleft = nil
	GridFrame.options.args.iconTLcornerright = nil
	GridFrame.options.args.iconTRcornerleft = nil
	GridFrame.options.args.iconTRcornerright = nil
	GridFrame.options.args.iconBLcornerleft = nil
	GridFrame.options.args.iconBLcornerright = nil
	GridFrame.options.args.iconBRcornerleft = nil
	GridFrame.options.args.iconBRcornerright = nil
end

function GridIndicatorCornerIconsFrameClass.prototype:CreateIndicator(indicator)
	GridIndicatorCornerIconsFrameClass.super.prototype.CreateIndicator(self, indicator)
	local f = self.frame
	local xoffset = GridIndicatorCornerIcons.db.profile.xoffset
	local yoffset = GridIndicatorCornerIcons.db.profile.yoffset
	if indicator == "iconTLcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		f.iconTLcornerleft = f.Bar:CreateTexture("IconTopLeftCorner1", "OVERLAY")
		f.iconTLcornerleft:SetWidth(wh)
		f.iconTLcornerleft:SetHeight(wh)
		f.iconTLcornerleft:SetPoint("TOPLEFT", f, "TOPLEFT", xoffset, yoffset)
		f.iconTLcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTLcornerleft:SetTexture(1,1,1,0)
	elseif indicator == "iconTLcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		f.iconTLcornerright = f.Bar:CreateTexture("IconTopLeftCorner2", "OVERLAY")
		f.iconTLcornerright:SetWidth(wh)
		f.iconTLcornerright:SetHeight(wh)
		f.iconTLcornerright:SetPoint("TOPLEFT", f, "TOPLEFT", (wh+xoffset), yoffset)
		f.iconTLcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTLcornerright:SetTexture(1,1,1,0)
	elseif indicator == "iconTRcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		f.iconTRcornerleft = f.Bar:CreateTexture("IconTopRightCorner1", "OVERLAY")
		f.iconTRcornerleft:SetWidth(wh)
		f.iconTRcornerleft:SetHeight(wh)
		f.iconTRcornerleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", ((wh*-1)+(xoffset*-1)), yoffset)
		f.iconTRcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTRcornerleft:SetTexture(1,1,1,0)
	elseif indicator == "iconTRcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		f.iconTRcornerright = f.Bar:CreateTexture("IconTopRightCorner2", "OVERLAY")
		f.iconTRcornerright:SetWidth(wh)
		f.iconTRcornerright:SetHeight(wh)
		f.iconTRcornerright:SetPoint("TOPRIGHT", f, "TOPRIGHT", (xoffset*-1), yoffset)
		f.iconTRcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconTRcornerright:SetTexture(1,1,1,0)
	elseif indicator == "iconBLcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		f.iconBLcornerleft = f.Bar:CreateTexture("IconBottomLeftCorner1", "OVERLAY")
		f.iconBLcornerleft:SetWidth(wh)
		f.iconBLcornerleft:SetHeight(wh)
		f.iconBLcornerleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", xoffset, (yoffset*-1))
		f.iconBLcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBLcornerleft:SetTexture(1,1,1,0)
	elseif indicator == "iconBLcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		f.iconBLcornerright = f.Bar:CreateTexture("IconBottomLeftCorner2", "OVERLAY")
		f.iconBLcornerright:SetWidth(wh)
		f.iconBLcornerright:SetHeight(wh)
		f.iconBLcornerright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (wh+xoffset), (yoffset*-1))
		f.iconBLcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBLcornerright:SetTexture(1,1,1,0)
	elseif indicator == "iconBRcornerleft" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		f.iconBRcornerleft = f.Bar:CreateTexture("IconBottomRightCorner1", "OVERLAY")
		f.iconBRcornerleft:SetWidth(wh)
		f.iconBRcornerleft:SetHeight(wh)
		f.iconBRcornerleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", ((wh*-1)+(xoffset*-1)), (yoffset*-1))
		f.iconBRcornerleft:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBRcornerleft:SetTexture(1,1,1,0)
	elseif indicator == "iconBRcornerright" then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		f.iconBRcornerright = f.Bar:CreateTexture("IconBottomRightCorner2", "OVERLAY")
		f.iconBRcornerright:SetWidth(wh)
		f.iconBRcornerright:SetHeight(wh)
		f.iconBRcornerright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", (xoffset*-1), (yoffset*-1))
		f.iconBRcornerright:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		f.iconBRcornerright:SetTexture(1,1,1,0)
	end
end

function GridIndicatorCornerIconsFrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack)
	GridIndicatorCornerIconsFrameClass.super.prototype.SetIndicator(self, indicator, color, text, value, maxValue, texture, start, duration, stack)
	if indicator == "iconTLcornerleft"
	or indicator == "iconTLcornerright"
	or indicator == "iconTRcornerleft"
	or indicator == "iconTRcornerright"
	or indicator == "iconBLcornerleft"
	or indicator == "iconBLcornerright"
	or indicator == "iconBRcornerleft"
	or indicator == "iconBRcornerright"
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

function GridIndicatorCornerIconsFrameClass.prototype:ClearIndicator(indicator)
	GridIndicatorCornerIconsFrameClass.super.prototype.ClearIndicator(self, indicator)
	if indicator == "iconTLcornerleft"
	or indicator == "iconTLcornerright"
	or indicator == "iconTRcornerleft"
	or indicator == "iconTRcornerright"
	or indicator == "iconBLcornerleft"
	or indicator == "iconBLcornerright"
	or indicator == "iconBRcornerleft"
	or indicator == "iconBRcornerright"
	then
		if self.frame[indicator] then
			self.frame[indicator]:SetTexture(1,1,1,0)
			self.frame[indicator]:Hide()
		end
	end
end

function GridIndicatorCornerIconsFrameClass.prototype:SetIconSize(size)
	GridIndicatorCornerIconsFrameClass.super.prototype.SetIconSize(self, GridFrame.db.profile.iconSize)
	local f = self.frame
	local xoffset = GridIndicatorCornerIcons.db.profile.xoffset
	local yoffset = GridIndicatorCornerIcons.db.profile.yoffset
	if f.iconTLcornerleft then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		f.iconTLcornerleft:SetPoint("TOPLEFT", f, "TOPLEFT", xoffset, yoffset)
		f.iconTLcornerleft:SetWidth(wh)
		f.iconTLcornerleft:SetHeight(wh)
	end
	if f.iconTLcornerright then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopLeftCorner
		f.iconTLcornerright:SetPoint("TOPLEFT", f, "TOPLEFT", (wh+xoffset), yoffset)
		f.iconTLcornerright:SetWidth(wh)
		f.iconTLcornerright:SetHeight(wh)
	end
	if f.iconTRcornerleft then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		f.iconTRcornerleft:SetPoint("TOPRIGHT", f, "TOPRIGHT", ((wh*-1)+(xoffset*-1)), yoffset)
		f.iconTRcornerleft:SetWidth(wh)
		f.iconTRcornerleft:SetHeight(wh)
	end
	if f.iconTRcornerright then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeTopRightCorner
		f.iconTRcornerright:SetPoint("TOPRIGHT", f, "TOPRIGHT", (xoffset*-1), yoffset)
		f.iconTRcornerright:SetWidth(wh)
		f.iconTRcornerright:SetHeight(wh)
	end
	if f.iconBLcornerleft then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		f.iconBLcornerleft:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", xoffset, (yoffset*-1))
		f.iconBLcornerleft:SetWidth(wh)
		f.iconBLcornerleft:SetHeight(wh)
	end
	if f.iconBLcornerright then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomLeftCorner
		f.iconBLcornerright:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (wh+xoffset), (yoffset*-1))
		f.iconBLcornerright:SetWidth(wh)
		f.iconBLcornerright:SetHeight(wh)
	end
	if f.iconBRcornerleft then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		f.iconBRcornerleft:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", ((wh*-1)+(xoffset*-1)), (yoffset*-1))
		f.iconBRcornerleft:SetWidth(wh)
		f.iconBRcornerleft:SetHeight(wh)
	end
	if f.iconBRcornerright then
		local wh = GridIndicatorCornerIcons.db.profile.iconSizeBottomRightCorner
		f.iconBRcornerright:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", (xoffset*-1), (yoffset*-1))
		f.iconBRcornerright:SetWidth(wh)
		f.iconBRcornerright:SetHeight(wh)
	end
end