
GridDB = {
	["namespaces"] = {
		["GridStatusRaidIcons"] = {
			["profiles"] = {
				["Default"] = {
					["alert_raidicons_player"] = {
						["priority"] = 99,
					},
					["debug"] = true,
				},
			},
		},
		["GridStatusKalecgos"] = {
			["profiles"] = {
				["Default"] = {
					["alert_kalecgos"] = {
						["color2"] = {
							["g"] = 0.03137254901960784,
							["b"] = 0.792156862745098,
						},
						["timer"] = 13,
						["priority"] = 99,
					},
				},
			},
		},
		["GridMBFrame"] = {
			["profiles"] = {
				["Default"] = {
					["side"] = "Bottom",
					["size"] = 0.1,
				},
			},
		},
		["GridStatusLineOfSight"] = {
			["profiles"] = {
				["Default"] = {
					["lineofsight"] = {
						["priority"] = 89,
					},
				},
			},
		},
		["GridIndicatorCornerIcons"] = {
			["profiles"] = {
				["Default"] = {
					["iconSizeBottomRightCorner"] = 11,
				},
			},
		},
		["GridStatusRange"] = {
			["profiles"] = {
				["Default"] = {
					["alert_range_10"] = {
						["color"] = {
							["a"] = 0.8181818181818181,
							["b"] = 0.3,
							["g"] = 0.2,
							["r"] = 0.1,
						},
						["priority"] = 81,
						["enable"] = false,
						["text"] = "10 yards",
						["range"] = false,
						["desc"] = "More than 10 yards away",
					},
					["alert_range_30"] = {
						["color"] = {
							["a"] = 0.4545454545454546,
							["b"] = 0.9,
							["g"] = 0.6,
							["r"] = 0.3,
						},
						["priority"] = 83,
						["enable"] = false,
						["text"] = "30 yards",
						["range"] = false,
						["desc"] = "More than 30 yards away",
					},
					["alert_range_28"] = {
						["color"] = {
							["a"] = 0.490909090909091,
							["b"] = 0.84,
							["g"] = 0.5600000000000001,
							["r"] = 0.28,
						},
						["priority"] = 83,
						["enable"] = false,
						["text"] = "28 yards",
						["range"] = false,
						["desc"] = "More than 28 yards away",
					},
					["alert_range_38"] = {
						["color"] = {
							["a"] = 0.3090909090909091,
							["b"] = 0.14,
							["g"] = 0.76,
							["r"] = 0.38,
						},
						["priority"] = 84,
						["enable"] = false,
						["text"] = "38 yards",
						["range"] = false,
						["desc"] = "More than 38 yards away",
					},
					["alert_range_40"] = {
						["color"] = {
							["a"] = 0.2727272727272727,
							["b"] = 0.2,
							["g"] = 0.8,
							["r"] = 0.4,
						},
						["priority"] = 84,
						["enable"] = true,
						["text"] = "40 yards",
						["range"] = false,
						["desc"] = "More than 40 yards away",
					},
					["alert_range_100"] = {
						["color"] = {
							["a"] = 0.1090909090909091,
							["b"] = 0,
							["g"] = 0,
							["r"] = 0,
						},
						["priority"] = 90,
						["enable"] = false,
						["text"] = "100 yards",
						["range"] = false,
						["desc"] = "More than 100 yards away",
					},
				},
			},
		},
		["GridStatus"] = {
			["profiles"] = {
				["Default"] = {
					["colors"] = {
						["HUNTER"] = {
							["b"] = 0.45,
							["g"] = 0.83,
							["r"] = 0.67,
						},
						["WARRIOR"] = {
							["b"] = 0.43,
							["g"] = 0.61,
							["r"] = 0.78,
						},
						["PALADIN"] = {
							["b"] = 0.73,
							["g"] = 0.55,
							["r"] = 0.96,
						},
						["MAGE"] = {
							["b"] = 0.94,
							["g"] = 0.8,
							["r"] = 0.41,
						},
						["ROGUE"] = {
							["b"] = 0.41,
							["g"] = 0.96,
							["r"] = 1,
						},
						["PRIEST"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["WARLOCK"] = {
							["b"] = 0.79,
							["g"] = 0.51,
							["r"] = 0.58,
						},
						["DRUID"] = {
							["b"] = 0.04,
							["g"] = 0.49,
							["r"] = 1,
						},
						["SHAMAN"] = {
							["b"] = 1,
							["g"] = 0.35,
							["r"] = 0.14,
						},
					},
				},
			},
		},
		["GridStatusHots"] = {
			["profiles"] = {
				["Default"] = {
					["debug"] = false,
					["alert_rejuv"] = {
						["threshold2"] = 5,
						["color"] = {
							["g"] = 1,
							["b"] = 0.1137254901960784,
						},
						["threshold3"] = 3,
					},
					["alert_lifebl"] = {
						["threshold2"] = 5,
						["color"] = {
							["b"] = 0.04313725490196078,
							["g"] = 1,
							["r"] = 0.05490196078431373,
						},
						["color3"] = {
							["b"] = 0.07450980392156863,
						},
						["threshold3"] = 3,
					},
					["alert_regrow"] = {
						["threshold2"] = 8,
						["color"] = {
							["r"] = 0,
							["b"] = 0.07058823529411765,
						},
						["threshold3"] = 4,
						["enable"] = false,
					},
					["alert_tothots"] = {
						["enable"] = false,
					},
				},
			},
		},
		["GridStatusReadyCheck"] = {
			["profiles"] = {
				["Default"] = {
					["readycheck"] = {
						["priority"] = 90,
					},
				},
			},
		},
		["GridStatusLifebloom"] = {
			["profiles"] = {
				["Default"] = {
					["alert_LifebloomDuration"] = {
						["color2"] = {
							["a"] = 0,
							["b"] = 0.7686274509803921,
							["g"] = 0.2235294117647059,
							["r"] = 1,
						},
						["color"] = {
							["a"] = 0,
						},
					},
					["alert_LifebloomStack"] = {
						["color2"] = {
							["r"] = 0.9529411764705882,
							["b"] = 0.2078431372549019,
						},
						["color3"] = {
							["r"] = 0.1098039215686275,
							["b"] = 0.1215686274509804,
						},
						["color"] = {
							["b"] = 1,
							["g"] = 0,
							["r"] = 0.792156862745098,
						},
					},
				},
			},
		},
		["GridLayout"] = {
			["profiles"] = {
				["Default"] = {
					["anchorRel"] = "BOTTOMLEFT",
					["BorderB"] = 0.5019607843137255,
					["BackgroundR"] = 0.1019607843137255,
					["ScaleSize"] = 0.9,
					["FrameLock"] = true,
					["BorderA"] = 0,
					["BorderR"] = 0.5019607843137255,
					["borderTexture"] = "None",
					["anchor"] = "BOTTOMLEFT",
					["BackgroundG"] = 0.1019607843137255,
					["groupAnchor"] = "BOTTOMLEFT",
					["showPartyPets"] = true,
					["PosY"] = 0,
					["Spacing"] = 0,
					["BackgroundA"] = 0,
					["Padding"] = 0,
					["BorderG"] = 0.5019607843137255,
					["BackgroundB"] = 0.1019607843137255,
					["horizontal"] = true,
					["PosX"] = 870.6274426883465,
					["ClickThrough"] = true,
				},
			},
		},
		["GridFrame"] = {
			["profiles"] = {
				["Default"] = {
					["fontSize"] = 10,
					["healingBar_intensity"] = 0.4,
					["iconBorderSize"] = 0,
					["iconSize"] = 16,
					["textlength"] = 10,
					["texture"] = "Minimalist",
					["frameHeight"] = 30,
					["enableText2"] = true,
					["invertBarColor"] = true,
					["cornerSize"] = 9,
					["orientation"] = "HORIZONTAL",
					["font"] = "Arial Narrow",
					["frameWidth"] = 58,
					["statusmap"] = {
						["corner2"] = {
							["alert_LifebloomDuration"] = false,
							["buff_Rejuvenation"] = false,
							["lineofsight"] = false,
							["alert_lifebl"] = false,
							["buff_Regrowth"] = false,
							["alert_rejuv"] = false,
							["buff_PowerWord:Shield"] = false,
							["readycheck"] = false,
							["alert_regrow"] = true,
							["alert_LifebloomStack"] = false,
						},
						["healingBar"] = {
							["lineofsight"] = false,
							["unit_health"] = false,
							["unit_healthDeficit"] = false,
							["alert_lowHealth"] = false,
							["alert_lowMana"] = false,
							["unit_mana"] = false,
						},
						["icontop"] = {
							["alert_LifebloomDuration"] = false,
							["alert_range_40"] = false,
							["alert_raidicons_playertarget"] = false,
							["alert_LifebloomStack"] = false,
							["lineofsight"] = false,
							["alert_raidicons_player"] = true,
							["player_target"] = false,
							["buff_Regrowth"] = false,
							["buff_Rejuvenation"] = false,
						},
						["text3"] = {
							["debuff_Ghost"] = true,
							["alert_offline"] = true,
							["unit_health"] = false,
							["buff_Rejuvenation"] = false,
							["alert_heals"] = true,
							["unit_name"] = true,
							["unit_mana"] = false,
							["alert_LifebloomStack"] = false,
							["player_target"] = false,
							["buff_Regrowth"] = false,
							["unit_healthDeficit"] = false,
							["alert_lifebl"] = false,
							["alert_feignDeath"] = true,
							["alert_death"] = true,
							["alert_LifebloomDuration"] = false,
						},
						["border"] = {
							["alert_tothots"] = false,
							["buff_Rejuvenation"] = false,
							["alert_lowHealth"] = false,
							["alert_range_40"] = false,
							["buff_Regrowth"] = false,
							["alert_kalecgos"] = true,
							["alert_lowMana"] = false,
							["alert_aggro"] = true,
						},
						["iconBLcornerleft"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
						},
						["iconbottom"] = {
							["buffGroup_MarkoftheWild"] = true,
						},
						["iconBRcornerleft"] = {
							["buff_PowerWord:Shield"] = false,
							["buff_Rejuvenation"] = false,
							["alert_rejuv"] = false,
						},
						["iconTRcornerright"] = {
							["alert_LifebloomStack"] = true,
						},
						["icon"] = {
							["alert_LifebloomDuration"] = false,
							["buff_Renew"] = false,
							["unit_name"] = false,
							["alert_LifebloomStack"] = false,
							["alert_rejuv"] = false,
							["alert_lifebl"] = false,
							["readycheck"] = true,
							["alert_aggro"] = false,
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["debuff_disease"] = false,
							["buff_Rejuvenation"] = false,
							["unit_mana"] = false,
							["buffGroup_MarkoftheWild"] = false,
							["alert_range_10"] = false,
							["buff_Regrowth"] = false,
							["lineofsight"] = false,
							["alert_raidicons_player"] = false,
							["unit_health"] = false,
							["alert_regrow"] = false,
							["debuff_magic"] = false,
						},
						["iconTRcornerleft"] = {
							["alert_LifebloomStack"] = true,
						},
						["text2"] = {
							["debuff_Ghost"] = false,
							["alert_tothots"] = false,
							["alert_LifebloomDuration"] = false,
							["buff_Regrowth"] = false,
							["alert_regrow"] = false,
							["alert_feignDeath"] = false,
							["alert_LifebloomStack"] = false,
							["alert_rejuv"] = true,
							["alert_lifebl"] = false,
							["alert_offline"] = false,
							["alert_death"] = false,
							["buff_Rejuvenation"] = false,
						},
						["iconleft"] = {
							["alert_raidicons_player"] = false,
							["alert_raidicons_playertarget"] = false,
						},
						["iconBRcornerright"] = {
							["alert_LifebloomStack"] = false,
							["alert_rejuv"] = false,
							["buff_Rejuvenation"] = false,
							["alert_regrow"] = false,
							["alert_LifebloomDuration"] = false,
						},
						["manabar"] = {
							["unit_mana"] = true,
						},
						["text"] = {
							["debuff_Ghost"] = false,
							["alert_LifebloomDuration"] = true,
							["alert_heals"] = false,
							["alert_feignDeath"] = false,
							["unit_name"] = false,
							["alert_LifebloomStack"] = false,
							["unit_healthDeficit"] = false,
							["alert_raidicons_player"] = false,
							["alert_offline"] = false,
							["alert_death"] = false,
							["alert_lifebl"] = true,
						},
						["iconTLcornerright"] = {
						},
						["corner4"] = {
							["alert_aggro"] = false,
							["debuff_poison"] = true,
							["alert_LifebloomStack"] = false,
							["lineofsight"] = false,
						},
						["iconright"] = {
							["lineofsight"] = true,
							["alert_heals"] = false,
							["buff_Regrowth"] = false,
							["alert_rejuv"] = false,
							["buff_Rejuvenation"] = false,
							["readycheck"] = false,
							["alert_LifebloomDuration"] = false,
							["alert_LifebloomStack"] = false,
						},
						["iconTLcornerleft"] = {
							["alert_LifebloomStack"] = false,
							["debuff_poison"] = false,
						},
						["corner1"] = {
							["debuff_curse"] = true,
							["alert_tothots"] = false,
							["lineofsight"] = false,
							["alert_LifebloomStack"] = false,
							["alert_heals"] = false,
							["buff_Regrowth"] = false,
							["alert_aggro"] = false,
						},
						["iconBLcornerright"] = {
							["debuff_curse"] = false,
						},
						["corner3"] = {
							["debuff_curse"] = false,
							["debuff_poison"] = false,
							["alert_tothots"] = false,
							["debuff_disease"] = false,
							["alert_LifebloomDuration"] = false,
							["alert_lowHealth"] = false,
							["alert_LifebloomStack"] = true,
							["alert_rejuv"] = false,
							["alert_lifebl"] = false,
							["alert_regrow"] = false,
							["debuff_magic"] = false,
						},
					},
				},
			},
		},
		["GridIndicatorSideIcons"] = {
			["profiles"] = {
				["Default"] = {
					["iconSizeBottom"] = 11,
				},
			},
		},
	},
	["profiles"] = {
		["Default"] = {
			["minimapPosition"] = 317.6636510825839,
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
		},
	},
}
