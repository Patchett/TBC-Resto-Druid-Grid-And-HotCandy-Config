-- -------------------------------------------------------------------------- --
-- GridIndicatorText3 by kunda                                                --
-- -------------------------------------------------------------------------- --
local L = AceLibrary("AceLocale-2.2"):new("GridIndicatorText3")
local AceOO = AceLibrary("AceOO-2.0")
local media = LibStub("LibSharedMedia-3.0", true)

GridIndicatorText3 = GridStatus:NewModule("GridIndicatorText3")
GridIndicatorText3.defaultDB = {
	Text3fontSize = 8,
	Text3font = "Friz Quadrata TT"
	}

local indicators = GridFrame.frameClass.prototype.indicators
table.insert(indicators, { type = "text3", order = 5.5, name = L["Center Text 3 (Middle)"] })

local statusmap = GridFrame.db.profile.statusmap
if not statusmap["text3"] then
	statusmap["text3"] = {}
end

local GridIndicatorText3FrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if not _frameClass then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = GridIndicatorText3FrameClass
end

function GridIndicatorText3:OnEnable()
	self:CleanOptionsMenu() -- hack for better indicator menu
	hooksecurefunc(GridFrame, "UpdateOptionsMenu", GridIndicatorText3.CleanOptionsMenu) -- hack for better indicator menu
end

function GridIndicatorText3:CleanOptionsMenu()
	local text2check = GridFrame.db.profile.enableText2

	local opt = GridFrame.options.args.advanced.args
	opt["text3"] = {
		type = "group",
		name = L["Center Text 3 (Middle)"],
		desc = L["Options for Center Text 3 (Middle)."],
		disabled = not text2check,
		order = 110,
		args = {
			["text3fontsize"] = {
				type = "range",
				name = L["Font Size"],
				desc = L["Adjust the font size for Center Text 3 (Middle)."],
				order = 110.1,
				min = 6,
				max = 24,
				step = 1,
				get = function ()
					return GridIndicatorText3.db.profile.Text3fontSize
				end,
				set = function (v)
					GridIndicatorText3.db.profile.Text3fontSize = v
					local font = media and media:Fetch('font', GridIndicatorText3.db.profile.Text3font) or STANDARD_TEXT_FONT
					GridFrame:WithAllFrames(function (f) f:SetFrameFont(font, v, "text3") end)
				end,
			}
		}
	}
	if media then
		opt["text3"].args["text3font"] = {
			type = "text",
			name = L["Font"],
			desc = L["Adjust the font setting for Center Text 3 (Middle)."],
			order = 110.2,
			validate = media:List("font"),
			get = function ()
				return GridIndicatorText3.db.profile.Text3font
			end,
			set = function (v)
				GridIndicatorText3.db.profile.Text3font = v
				local font = media:Fetch("font", v)
				local fontsize = GridIndicatorText3.db.profile.Text3fontSize
				GridFrame:WithAllFrames(function (f) f:SetFrameFont(font, fontsize, "text3") end)
			end,
		}
	end

	-- rare Dewdrop error - mainly depends on the factor time (the Dewdrop frame is automatically closed after some seconds)
	-- hmmm needs test
	--if not text2check then
	--	GridFrame.options.args.text3 = nil
	--end

	if not text2check then
		GridFrame.options.args.text3.disabled = true
	else
		GridFrame.options.args.text3.disabled = false
	end


	GridFrame:WithAllFrames(function (f) f:PlaceIndicators() end)

end

function GridIndicatorText3FrameClass.prototype:PlaceIndicators()
	GridIndicatorText3FrameClass.super.prototype.PlaceIndicators(self)
	local f = self.frame
	local text2check = GridFrame.db.profile.enableText2
	if f.Text3 then
		if text2check then
			f.Text3:Show()
		else
			f.Text3:Hide()
		end
	end
end

function GridIndicatorText3FrameClass.prototype:CreateIndicator(indicator)
	GridIndicatorText3FrameClass.super.prototype.CreateIndicator(self, indicator)
	local f = self.frame
	if indicator == "text3" then
		local font = media and media:Fetch("font", GridIndicatorText3.db.profile.Text3font) or STANDARD_TEXT_FONT
		f.Text3 = f.Bar:CreateFontString(nil, "ARTWORK")
		f.Text3:SetFontObject(GameFontHighlightSmall)
		f.Text3:SetFont(font, GridIndicatorText3.db.profile.Text3fontSize)
		f.Text3:SetJustifyH("CENTER")
		f.Text3:SetJustifyV("CENTER")
		f.Text3:SetPoint("CENTER", f, "CENTER")
		f.Text3:Hide()
	end
end

function GridIndicatorText3FrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack)
	GridIndicatorText3FrameClass.super.prototype.SetIndicator(self, indicator, color, text, value, maxValue, texture, start, duration, stack)
	local f = self.frame
	if indicator == "text3" then
		if not f.Text3 then
			self:CreateIndicator(indicator)
		end
		local text = text:utf8sub(1, GridFrame.db.profile.textlength)
		f.Text3:SetText(text)
		if text and text ~= "" then
			f.Text3:Show()
		else
			f.Text3:Hide()
		end
		if color then
			f.Text3:SetTextColor(color.r, color.g, color.b, color.a)
		end
	end
end

function GridIndicatorText3FrameClass.prototype:ClearIndicator(indicator)
	GridIndicatorText3FrameClass.super.prototype.ClearIndicator(self, indicator)
	local f = self.frame
	if indicator == "text3" then
		if f.Text3 then
			f.Text3:Hide()
		end
	end
end

function GridIndicatorText3FrameClass.prototype:SetFrameFont(font, size, check)
	if check and check == "text3" then
		local f = self.frame
		if f.Text3 then
			f.Text3:SetFont(font, size)
		end
	else
		GridIndicatorText3FrameClass.super.prototype.SetFrameFont(self, font, size, check)
	end
end