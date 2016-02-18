local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")

L:RegisterTranslations("enUS", function() return {
	["Size"] = true,
	["Percentage of frame for mana bar"] = true,
	["Side"] = true,
	["Side of frame manabar attaches to"] = true,
    
	["Hide Non-Mana"] = true, --deprecated
    ["Ignore Non-Mana"] = true,
    
	["Hide power bars for non-mana users"] = true, --deprecated
	["Don't track power for non-mana users"] = true,

	["PowerBar Colours"] = true, --deprecated
    ["Colours"] = true,
    
	["Colours of the various power bars"] = true, --deprecated
    ["Colours for the various powers"] = true,
    
	["Manabar color"] = true, --deprecated
    ["Mana color"] = true,
    
	["Color of mana bars"] = true, --deprecated
    ["Color for mana"] = true,
    
	["Energybar color"] = true, --deprecated
    ["Energy color"] = true,
    
	["Color of energy bars"] = true, --deprecated
    ["Color for energy"] = true,
    
	["Ragebar color"] = true, --deprecated
    ["Rage color"] = true,
    
	["Color of rage bars"] = true, --deprecated
    ["Color for rage"] = true,

	["Hide Pet-Bars"] = true, --deprecated
    ["Ignore Pets"] = true,
    
	["Hide power bars for pets"] = true, --deprecated
    ["Don't track power for pets"] = true,

	["Mana Bar"] = true,
    ["Mana"] = true,
    ["Mana Bar options."] = true,

	["Left"] = true,
	["Top"] = true,
	["Right"] = true,
	["Bottom"] = true,
} end)
