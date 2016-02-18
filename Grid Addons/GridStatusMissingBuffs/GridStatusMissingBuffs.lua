-- This was written by North101, msl etc.  Toadkiller added it to wowace so it can be kept up to date.
-- http://www.wowace.com/wiki/GridStatusMissingBuffs

-- Updated toc for 2.2 & classified it as a Unit Frame addon

local L = AceLibrary("AceLocale-2.2"):new("GridStatusMissingBuffs")
local Aura = AceLibrary("SpecialEvents-Aura-2.0")
local BabbleSpell = LibStub:GetLibrary("LibBabble-Spell-3.0")
local BS = BabbleSpell:GetLookupTable()
local BC = AceLibrary("Babble-Class-2.2")
local RL = AceLibrary("Roster-2.1")

L:RegisterTranslations("enUS", function()
	return {
		["Missing Buffs"] = true,
		["Buff Group: "] = true,
		["[^%a]"] = true,
		["Show on %s."] = true,

		["Add Buff"] = true,
		["Adds a new buff to the buff group"] = true,
		["<buff name>"] = true,
		["Delete Buff"] = true,
		["Deletes an existing buff from the buff group"] = true,
		["Buff Icon"] = true,
		["The icon to appear when no buffs in the buff group are active."] = true,
		["Show"] = true,
		["Configure when to show the buff group"] = true,
			["When Dead"] = true,
			["Show missing buff group for dead players"] = true,
			["When Offline"] = true,
			["Show missing buff group for offline players"] = true,
			["When in Combat"] = true,
			["Show missing buff group when in combat"] = true,
			["On party"] = true,
			["Show missing buff group on party"] = true,
			["On raid"] = true,
			["Show missing buff group on raid"] = true,
			["On self"] = true,
			["Show missing buff group on self"] = true,
		["Class Filter"] = true,
		["Show status for the selected classes."] = true,

		["Add Buff Group"] = true,
		["Adds a new buff group to the status module"] = true,
		["Delete Buff Group"] = true,
		["Deletes an existing buff group from the status module"] = true,
		["Remove %s from the menu"] = true,
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["Missing Buffs"] = "Fehlende Buffs",
		["Buff Group: "] = "Buffgruppe: ",
		["[^%a]"] = "[^%a]",
		["Show on %s."] = "Zeigen bei %s.",

		["Add Buff"] = "Buff hinzufügen",
		["Adds a new buff to the buff group"] = "Neuen Buff zu Buffgruppe hinzufügen.",
		["<buff name>"] = "<Buffname>",
		["Delete Buff"] = "Buff löschen",
		["Deletes an existing buff from the buff group"] = "Buff von Buffgruppe löschen.",
		["Buff Icon"] = "Bufficon",
		["The icon to appear when no buffs in the buff group are active."] = "Icon das erscheinen soll, wenn kein Buff der Buffgruppe aktiv ist.",
		["Show"] = "Zeige",
		["Configure when to show the buff group"] = "Einstellen, wann die Buffgruppe angezeigt werden soll.",
			["When Dead"] = "Wenn Tot",
			["Show missing buff group for dead players"] = "Zeige fehlende Buffgruppe für tote Spieler.",
			["When Offline"] = "Wenn Offline",
			["Show missing buff group for offline players"] = "Zeige fehlende Buffgruppe für Spieler die Offline sind.",
			["When in Combat"] = "Wenn im Kampf",
			["Show missing buff group when in combat"] = "Zeige fehlende Buffgruppe im Kampf.",
			["On party"] = "Gruppe",
			["Show missing buff group on party"] = "Zeige fehlende Buffgruppe für Gruppe.",
			["On raid"] = "Schlachtzug",
			["Show missing buff group on raid"] = "Zeige fehlende Buffgruppe für Schlachtzug.",
			["On self"] = "Bei sich selbst",
			["Show missing buff group on self"] = "Zeige fehlende Buffgruppe bei sich selbst.",
		["Class Filter"] = "Klassenfilter",
		["Show status for the selected classes."] = "Zeige Status für die ausgewählten Klassen.",

		["Add Buff Group"] = "Neue Buffgruppe hinzufügen",
		["Adds a new buff group to the status module"] = "Eine neue Buffgruppe dem Statusmodul hinzufügen.",
		["Delete Buff Group"] = "Buffgruppe löschen",
		["Deletes an existing buff group from the status module"] = "Eine Buffgruppe vom Statusmodul entfernen.",
		["Remove %s from the menu"] = "%s vom Menü entfernen.",
	}
end)

L:RegisterTranslations("koKR", function()
	return {
		["Missing Buffs"] = "버프 사라짐",
		["Buff Group: "] = "그룹 버프: ",
		["[^%a]"] = "[^%S]",
		["Show on %s."] = "%s 표시",

		["Add Buff"] = "버프 추가",
		["Adds a new buff to the buff group"] = "그룹 버프에 새로운 버프를 추가합니다.",
		["<buff name>"] = "<버프 이름>",
		["Delete Buff"] = "버프 삭제",
		["Deletes an existing buff from the buff group"] = "그룹 버프에 버프를 삭제합니다." ,
		["Buff Icon"] = "버프 아이콘",
		["The icon to appear when no buffs in the buff group are active."] = "그룹 버프의 버프가 없을때 아이콘을 표시합니다.",
		["Show"] = "표시",
		["Configure when to show the buff group"] = "그룹 버프 표시 설정을 합니다.",
			["When Dead"] = "죽었을때",
			["Show missing buff group for dead players"] = "죽은 플레이어를 위해 그룹 버프가 없을때 표시합니다.",
			["When Offline"] = "오프라인일때",
			["Show missing buff group for offline players"] = "오프라인 플레이어를 위해 그룹 버프가 없을때 표시합니다.",
			["When in Combat"] = "전투상태일때",
			["Show missing buff group when in combat"] = "전투중 그룹 버프가 없을때 표시합니다.",
			["On party"] = "파티시",
			["Show missing buff group on party"] = "파티시 그룹 버프가 없을때 표시합니다.",
			["On raid"] = "공격대시",
			["Show missing buff group on raid"] = "공격대시 그룹 버프가 없을때 표시합니다.",
			["On self"] = "솔로잉시",
			["Show missing buff group on self"] = "솔로잉시 그룹 버프가 없을때 표시합니다.",
		["Class Filter"] = "직업 필터",
		["Show status for the selected classes."] = "선택된 직업의 상태만을 표시합니다.",

		["Add Buff Group"] = "그룹 버프 추가",
		["Adds a new buff group to the status module"] = "상태 모듈에 새로운 그룹 버프를 추가합니다.",
		["Delete Buff Group"] = "그룹 버프 삭제",
		["Deletes an existing buff group from the status module"] = "상태 모듈의 기존 그룹 버프를 삭제합니다.",
		["Remove %s from the menu"] = "메뉴에서 %s|1을;를; 제거합니다.",
	}
end)

L:RegisterTranslations("zhTW", function()
	return {
		["Missing Buffs"] = "缺少增益",
		["Buff Group: "] = "增益組合: ",
		["[^%a]"] = "[^%S]",
		["Show on %s."] = "當是%s時顯示。",

		["Add Buff"] = "增加增益",
		["Adds a new buff to the buff group"] = "增加一個新的增益至增益組合中",
		["<buff name>"] = "<增益名稱>",
		["Delete Buff"] = "刪除增益",
		["Deletes an existing buff from the buff group"] = "刪除增益組合內已有的增益",
		["Buff Icon"] = "增益圖示",
		["The icon to appear when no buffs in the buff group are active."] = "當缺少增益組合內的全部增益時顯示的圖示。",
		["Show"] = "顯示",
		["Configure when to show the buff group"] = "什麼時顯示增益組合",
			["When Dead"] = "死亡",
			["Show missing buff group for dead players"] = "死亡玩家顯示增益組合",
			["When Offline"] = "離線",
			["Show missing buff group for offline players"] = "離線玩家顯示增益組合",
			["When in Combat"] = "戰鬥中",
			["Show missing buff group when in combat"] = "當戰鬥中時顯示增益組合",
			["On party"] = "隊伍",
			["Show missing buff group on party"] = "顯示小隊缺少的增益組合",
			["On raid"] = "團隊",
			["Show missing buff group on raid"] = "顯示團隊缺少的增益組合",
			["On self"] = "自己",
			["Show missing buff group on self"] = "顯示自己缺少的增益組合",
		["Class Filter"] = "職業過濾",
		["Show status for the selected classes."] = "顯示選定職業的狀態。",

		["Add Buff Group"] = "增加增益組合",
		["Adds a new buff group to the status module"] = "增加一個新的增益組合至狀態模組中",
		["Delete Buff Group"] = "刪除增益組合",
		["Deletes an existing buff group from the status module"] = "刪除狀態模組內已有的增益組合",
		["Remove %s from the menu"] = "從選單移除%s",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Missing Buffs"] = "缺失BUFF",
		["Buff Group: "] = "缺失BUFF：",
		["[^%a]"] = "[^%S]",
		["Show on %s."] = "当%s时显示。",

		["Add Buff"] = "添加BUFF",
		["Adds a new buff to the buff group"] = "增加一个新的BUFF至缺失BUFF组中",
		["<buff name>"] = "<BUFF名>",
		["Delete Buff"] = "删除BUFF",
		["Deletes an existing buff from the buff group"] = "删除组中已有的BUFF",
		["Buff Icon"] = "BUFF图标",
		["The icon to appear when no buffs in the buff group are active."] = "当缺少组内的全部BUFF,状态栏显示的图标。",
		["Show"] = "显示",
		["Configure when to show the buff group"] = "何时显示缺失BUFF",
			["When Dead"] = "死亡时",
			["Show missing buff group for dead players"] = "死亡玩家显示缺失BUFF",
			["When Offline"] = "离线时",
			["Show missing buff group for offline players"] = "离线玩家显示缺失BUFF",
			["When in Combat"] = "战斗中",
			["Show missing buff group when in combat"] = "战斗时也显示缺失BUFF",
			["On party"] = "小队成员",
			["Show missing buff group on party"] = "显示小队的缺失BUFF",
			["On raid"] = "团队成员",
			["Show missing buff group on raid"] = "显示所有团员的缺失BUFF",
			["On self"] = "自己",
			["Show missing buff group on self"] = "显示自己的缺失BUFF",
		["Class Filter"] = "职业过滤",
		["Show status for the selected classes."] = "仅显示所选职业的缺失BUFF。",

		["Add Buff Group"] = "添加缺失BUFF组",
		["Adds a new buff group to the status module"] = "增加一个新的缺失BUFF组",
		["Delete Buff Group"] = "删除缺失BUFF组",
		["Deletes an existing buff group from the status module"] = "删除一个已有的缺失BUFF组",
		["Remove %s from the menu"] = "从菜单中移除%s",
	}
end)

GridStatusMissingBuffs = GridStatus:NewModule("GridStatusMissingBuffs")
GridStatusMissingBuffs.menuName = L["Missing Buffs"]

local function compactSpellName(spell)
	return string.gsub(spell, L["[^%a]"], "")
end

local function statusForSpell(spell)
	return "buffGroup_"..compactSpellName(spell)
end

GridStatusMissingBuffs.defaultDB = {
	debug = false,
	buffGroup_MarkoftheWild = {
		text = BS["Mark of the Wild"],
		desc = L["Buff Group: "]..BS["Mark of the Wild"],
		icon = "MarkoftheWild",
		buffs = {
			MarkoftheWild = BS["Mark of the Wild"],
			GiftoftheWild = BS["Gift of the Wild"],
		},
		classFilter = {},
		combat = false,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		enable = true,
		color = { r = 1, g = 0, b = 1, a = 0.5 },
		priority = 80,
		range = false,
	},
	buffGroup_Fortitude = {
		text = BS["Power Word: Fortitude"],
		desc = L["Buff Group: "]..BS["Power Word: Fortitude"],
		icon = "PrayerofForitude",
		buffs = {
			PowerWordForitude = BS["Power Word: Fortitude"],
			PrayerofForitude = BS["Prayer of Fortitude"],
		},
		classFilter = {},
		combat = true,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		onself = true,
		onparty = true,
		onraid = true,
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 0.5 },
		priority = 99,
		range = false,
	},
	buffGroup_DivineSpirit = {
		text = BS["Divine Spirit"],
		desc = L["Buff Group: "]..BS["Divine Spirit"],
		icon = "DivineSpirit",
		buffs = {
			DivineSpirit = BS["Divine Spirit"],
			PrayerofSpirit = BS["Prayer of Spirit"],
		},
		classFilter = {
			WARRIOR = false,
			ROGUE = false,
		},
		combat = false,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		onself = true,
		onparty = true,
		onraid = true,
		enable = true,
		color = { r = 0, g = 1, b = 1, a = 0.5 },
		priority = 80,
		range = false,
	},
	buffGroup_ShadowProtection = {
		text = BS["Shadow Protection"],
		desc = L["Buff Group: "]..BS["Shadow Protection"],
		icon = "Shadow Protection",
		buffs = {
			ShadowProtection = BS["Shadow Protection"],
			PrayerofShadowProt = BS["Prayer of Shadow Protection"],
		},
		classFilter = {},
		combat = false,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		onself = true,
		onparty = true,
		onraid = true,
		enable = true,
		color = { r = 0, g = 1, b = 1, a = 0.5 },
		priority = 80,
		range = false,
	},
	buffGroup_ArcaneIntellect = {
		text = BS["Arcane Intellect"],
		desc = L["Buff Group: "]..BS["Arcane Intellect"],
		icon = "ArcaneBrilliance",
		buffs = {
			ArcaneIntellect = BS["Arcane Intellect"],
			ArcaneBrilliance = BS["Arcane Brilliance"],
		},
		classFilter = {
			WARRIOR = false,
			ROGUE = false,
		},
		combat = false,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		enable = true,
		color = { r = 0, g = 0, b = 1, a = 0.5 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofKings = {
		text = BS["Blessing of Kings"],
		desc = L["Buff Group: "]..BS["Blessing of Kings"],
		icon = "BlessingofKings",
		buffs = {
			BlessingofKings = BS["Blessing of Kings"],
			GreaterBlessingofKings = BS["Greater Blessing of Kings"],
		},
		classFilter = {},
		combat = true,
		dead = false,
		offline = false,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofMight = {
		text = BS["Blessing of Might"],
		desc = L["Buff Group: "]..BS["Blessing of Might"],
		icon = "BlessingofMight",
		buffs = {
			BlessingofMight = BS["Blessing of Might"],
			GreaterBlessingofMight = BS["Greater Blessing of Might"],
		},
		classFilter = {
			DRUID = false,
			PRIEST = false,
			SHAMAN = false,
			MAGE = false,
			WARLOCK = false,
			PALADIN = false,
		},
		combat = false,
		dead = false,
		onself = true,
		onparty = true,
		onraid = true,
		offline = false,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofSalvation = {
		text = BS["Blessing of Salvation"],
		desc = L["Buff Group: "]..BS["Blessing of Salvation"],
		icon = "BlessingofSalvation",
		buffs = {
			BlessingofSalvation = BS["Blessing of Salvation"],
			GreaterBlessingofSalvation = BS["Greater Blessing of Salvation"],
		},
		classFilter = {
			WARRIOR = false,
		},
		combat = true,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		onself = true,
		onparty = true,
		onraid = true,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofWisdom = {
		text = BS["Blessing of Wisdom"],
		desc = L["Buff Group: "]..BS["Blessing of Wisdom"],
		icon = "BlessingofWisdom",
		buffs = {
			BlessingofWisdom = BS["Blessing of Wisdom"],
			GreaterBlessingofWisdom = BS["Greater Blessing of Wisdom"],
		},
		classFilter = {
			WARRIOR = false,
			ROGUE = false,
		},
		combat = false,
		dead = false,
		offline = false,
		onself = true,
		onparty = true,
		onraid = true,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofLight = {
		text = BS["Blessing of Light"],
		desc = L["Buff Group: "]..BS["Blessing of Light"],
		icon = "BlessingofLight",
		buffs = {
			BlessingofLight = BS["Blessing of Light"],
			GreaterBlessingofLight = BS["Greater Blessing of Light"],
		},
		classFilter = {},
		combat = false,
		dead = false,
		offline = false,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
	buffGroup_BlessingofSanctuary = {
		text = BS["Blessing of Sanctuary"],
		desc = L["Buff Group: "]..BS["Blessing of Sanctuary"],
		icon = "BlessingofSanctuary",
		buffs = {
			BlessingofSanctuary = BS["Blessing of Sanctuary"],
			GreaterBlessingofSanctuary = BS["Greater Blessing of Sanctuary"],
		},
		classFilter = {},
		combat = false,
		dead = false,
		offline = false,
		enable = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		priority = 80,
		range = false,
	},
}

function GridStatusMissingBuffs:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatuses()
end

function GridStatusMissingBuffs:OnEnable()
	self.debugging = self.db.profile.debug
	self:CreateAddRemoveOptions()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateAllUnits")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "UpdateAllUnits")
	self:RegisterEvent("PLAYER_ALIVE", "UpdateAllUnits")
	self:RegisterEvent("PLAYER_DEAD", "UpdateAllUnits")
	self:RegisterEvent("PLAYER_UNGHOST", "UpdateAllUnits")
	self:RegisterEvent("SpecialEvents_UnitBuffGained", "UpdateUnit")
	self:RegisterEvent("SpecialEvents_UnitBuffLost", "UpdateUnit")
	self:RegisterEvent("Grid_UnitJoined")
	self:CreateAddRemoveOptions()
	self:UpdateAllUnits()
end

function GridStatusMissingBuffs:PLAYER_LEAVING_WORLD()
	self:UnregisterEvent("SpecialEvents_UnitBuffGained")
	self:UnregisterEvent("SpecialEvents_UnitBuffLost")
end

function GridStatusMissingBuffs:PLAYER_ENTERING_WORLD()
	self:UpdateAllUnits()
	self:RegisterEvent("SpecialEvents_UnitBuffGained", "UpdateUnit")
	self:RegisterEvent("SpecialEvents_UnitBuffLost", "UpdateUnit")
end

function GridStatusMissingBuffs:Grid_UnitJoined(name, unitid)
	self:Debug("Joined",name)
	self:UpdateUnit(unitid)
end

function GridStatusMissingBuffs:RegisterStatuses()
	local status, settings, desc

	for status, settings in self:ConfiguredStatusIterator() do
		desc = settings.desc or settings.text or ""
		if not settings.classFilter then
			self.db.profile[status].classFilter = {}
		end
		self:Debug("registering", status, desc)
		self:RegisterStatus(status, desc, self:GetBuffGroupOptions(status))
	end
end

function GridStatusMissingBuffs:UnregisterStatuses()
	local status, moduleName, desc
	for status, moduleName, desc in self.core:RegisteredStatusIterator() do
		if moduleName == self.name then
			self:Debug("unregistering", status, desc)
			self:UnregisterStatus(status)
			self.options.args[status] = nil
		end
	end
end

function GridStatusMissingBuffs:ConfiguredStatusIterator()
	local profile = self.db.profile
	local status

	return function ()
		status = next(profile, status)

		-- skip any non-table entries
		while status ~= nil and type(profile[status]) ~= "table" do
			status = next(profile, status)
		end

		if status == nil then
			return nil
		end

		return status, profile[status]
	end
end

function GridStatusMissingBuffs:GetBuffGroupOptions(status)
	local classFilterArgs = {}

	local classes = {
		WARRIOR = BC["Warrior"],
		PRIEST = BC["Priest"],
		DRUID = BC["Druid"],
		PALADIN = BC["Paladin"],
		SHAMAN = BC["Shaman"],
		MAGE = BC["Mage"],
		WARLOCK = BC["Warlock"],
		HUNTER = BC["Hunter"],
		ROGUE = BC["Rogue"],
	}

	for class,name in pairs(classes) do
		local class,name = class,name
		classFilterArgs[class] = {
			type = "toggle",
			name = name,
			desc = string.format(L["Show on %s."], name),
			get = function ()
				return self.db.profile[status].classFilter[class] ~= false
			end,
			set = function (v)
				 self.db.profile[status].classFilter[class] = v
			end,
		}
	end

	return {
		add_buff = {
			type = "text",
			name = L["Add Buff"],
			desc = L["Adds a new buff to the buff group"],
			get = false,
			usage = L["<buff name>"],
			set = function(v) self:AddBuff(status, v) end,
			order = 110.8
		},
		delete_buff = {
			type = "group",
			name = L["Delete Buff"],
			desc = L["Deletes an existing buff from the buff group"],
			disable = function() return next(self.db.profile[status].buffs) == nil end,
			args = {},
			order = 110.9
		},
		buff_icon = {
			type = 'text',
			name = L["Buff Icon"],
			desc = L["The icon to appear when no buffs in the buff group are active."],
			validate = self.db.profile[status].buffs,
			disable = function() return next(self.db.profile[status].buffs) == nil end,
			get = function()
				return self.db.profile[status].icon
			end,
			set = function(v)
				self.db.profile[status].icon = v
			end,
		},
		show = {
			type = "group",
			name =  L["Show"],
			desc =  L["Configure when to show the buff group"],
			args = {
				dead = {
					type = "toggle",
					name =  L["When Dead"],
					desc =  L["Show missing buff group for dead players"],
					get = function()
						return self.db.profile[status].dead
					end,
					set = function(v)
						self.db.profile[status].dead = not self.db.profile[status].dead
					end,
				},
				offline = {
					type = "toggle",
					name =  L["When Offline"],
					desc =  L["Show missing buff group for offline players"],
					get = function()
						return self.db.profile[status].offline
					end,
					set = function(v)
						self.db.profile[status].offline = not self.db.profile[status].offline
					end,
				},
				combat = {
					type = "toggle",
					name =  L["When in Combat"],
					desc =  L["Show missing buff group when in combat"],
					get = function()
						return self.db.profile[status].combat
					end,
					set = function()
						self.db.profile[status].combat = not self.db.profile[status].combat
					end,
				},
				onself = {
					type = "toggle",
					name =  L["On self"],
					desc =  L["Show missing buff group on self"],
					get = function()
						return self.db.profile[status].onself
					end,
					set = function()
						self.db.profile[status].onself = not self.db.profile[status].onself
					end,
				},
				onparty = {
					type = "toggle",
					name =  L["On party"],
					desc =  L["Show missing buff group on party"],
					get = function()
						return self.db.profile[status].onparty
					end,
					set = function()
						self.db.profile[status].onparty = not self.db.profile[status].onparty
					end,
				},
				onraid = {
					type = "toggle",
					name =  L["On raid"],
					desc =  L["Show missing buff group on raid"],
					get = function()
						return self.db.profile[status].onraid
					end,
					set = function()
						self.db.profile[status].onraid = not self.db.profile[status].onraid
					end,
				},
			}
		},
		classFilter = {
			type = "group",
			name =  L["Class Filter"],
			desc =  L["Show status for the selected classes."],
			args = classFilterArgs,
			order = 111
		},
	}
end

function GridStatusMissingBuffs:Reset()
	self.super.Reset(self)

	self:UnregisterStatuses()
	self:RegisterStatuses()
	self:CreateAddRemoveOptions()
	self:UpdateAllUnits()
end

function GridStatusMissingBuffs:CreateAddRemoveOptions()
	local status, settings

	self.options.args["add_buff_group"] = {
		type = "text",
		name =  L["Add Buff Group"],
		desc =  L["Adds a new buff group to the status module"],
		get = false,
		usage =  L["<buff name>"],
		set = function(v) self:AddBuffGroup(v) end,
		order = 201
	}
	self.options.args["delete_buff_group"] = {
		type = "group",
		name =  L["Delete Buff Group"],
		desc =  L["Deletes an existing buff group from the status module"],
		disable = function() return next(self.db.profile[status]) == nil end,
		args = {},
		order = 202
	}

	for status, settings in self:ConfiguredStatusIterator() do
		local status, settings = status, settings
		local buffName = (settings.desc or settings.text or "")
		self.options.args["delete_buff_group"].args[status] = {
			type = "execute",
			name = buffName,
			desc = string.format(L["Remove %s from the menu"], buffName),
			func = function() return self:DeleteBuffGroup(status) end
		}

		self.options.args["delete_buff_group"].args[status] = {
			type = "execute",
			name = buffName,
			desc = string.format(L["Remove %s from the menu"], buffName),
			func = function() return self:DeleteBuffGroup(status) end
		}
		local buffId, buffName
		for buffId, buffName in pairs(settings.buffs) do
			local buffId, buffName = buffId, buffName
			self.options.args[status].args["delete_buff"].args[buffId] = {
				type = "execute",
				name = buffName,
				desc = string.format(L["Remove %s from the menu"], buffName),
				func = function() return self:DeleteBuff(status, buffId) end
			}
		end
	end
end

function GridStatusMissingBuffs:AddBuffGroup(name)
	local status = statusForSpell(name)
	local desc = "Buff Group: "..name
	local buff = BS:HasReverseTranslation(name) and name
	local compactName = compactSpellName(name)

	self.db.profile[status] = {
		text = name,
		desc = desc,
		enable = true,
		buffs = {
			[compactName] = buff,
		},
		icon = compactName,
		priority = 90,
		range = false,
		color = { r = 0, g = 0, b = 1, a = 1 },
		classFilter = {},
		combat = false,
		dead = false,
		offline = false,
	}

	self:RegisterStatus(status, desc, self:GetBuffGroupOptions(status))
	self:CreateAddRemoveOptions()
end

function GridStatusMissingBuffs:DeleteBuffGroup(status)
	self:UnregisterStatus(status)
	self.options.args[status] = nil
	self.options.args["delete_buff_group"].args[status] = nil
	self.db.profile[status] = nil
	self:CreateAddRemoveOptions()
end

function GridStatusMissingBuffs:AddBuff(status, name)
	local buffId = statusForSpell(name)

	self.db.profile[status].buffs[buffId] = name
end

function GridStatusMissingBuffs:DeleteBuff(status, buffId)
	self.options.args[status].args["delete_buff"].args[buffId] = nil
	self.db.profile[status].buffs[buffId] = nil
end

function GridStatusMissingBuffs:UpdateAllUnits()
	self:Debug("updating all units")
	for u in RL:IterateRoster() do
		self:UpdateUnit(u.unitid)
	end
end

function GridStatusMissingBuffs:UpdateUnit(unitid)
	self:Debug("Updating Unit",UnitName(unitid))

	for status in self:ConfiguredStatusIterator() do
		self:ShowMissingBuffs(unitid, status)
	end
end

function GridStatusMissingBuffs:ShowMissingBuffs(unit, status)
	local name = UnitName(unit)
	local settings = self.db.profile[status]

	if not settings.enable or
	   (not settings.combat and (UnitAffectingCombat("player") or UnitAffectingCombat(unit))) or
	   (not settings.dead and UnitIsDeadOrGhost(unit)) or
	   (not settings.offline and not UnitIsConnected(unit)) or
	   (not settings.onself and (unit == "player")) or
	   (not settings.onparty and not (unit == "player") and UnitInParty(unit)) or
	   (not settings.onraid and not (unit == "player") and not UnitInParty(unit) and UnitInRaid(unit))
	then
		return self.core:SendStatusLost(name, status)
	end

	local _, class = UnitClass(unit)
	if settings.classFilter[class or ""] == false then
		return self.core:SendStatusLost(name, status)
	end

	for buffId, buff in pairs(settings.buffs) do
		if Aura:UnitHasBuff(unit, buff) then
			return self.core:SendStatusLost(name, status)
		end
	end

	local tex = BabbleSpell:GetSpellIcon(settings.buffs[settings.icon or ""] or "")

	self:Debug("gained",status)
	self.core:SendStatusGained(
		name,
		status,
		settings.priority,
		(settings.range and 40),
		settings.color,
		settings.text,
		nil,
		nil,
		tex)
end