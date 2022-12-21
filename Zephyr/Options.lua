local addonName, ns = ...
local addonTitle = GetAddOnInfo(addonName, "addonName")
local exclamation = "|TInterface\\Cursor\\Quest:12:12:1:0:64:64:9:60:9:60|t"

ZPR.defaults = {
	profile = {
		modules = {
			-- General
			minimapZoomButtons = false,
			castBarTimer = true,
			playerCastBarIcon = true,
			-- Action Bars
			keybindText = false,
			macroText = true,
			shortKeybindText = true,
			-- Unit Frames
			pvpIcon = true,
			feedbackText = true,
			groupIndicator = true,
			restIndicator = true,
			classColors = true,
			repColor = true,
			combatIndicator = true,
			-- Miscellaneous
			talkingHead = true,
			partyFrameText = true,
			buffFrameCollapseExpand = true,
		}
	}
}

ZPR.options = {
	name = "Zephyr",
	type = "group",
	args = {
		title = {
			name = addonTitle .. " v" .. GetAddOnMetadata(addonName, "Version"),
			type = "description",
			fontSize = "large",
			order = 1
		},
		description = {
			name = "Lightweight modifications to the default Blizzard Interface to improve gameplay.",
			type = "description",
			fontSize = "medium",
			order = 2
		},
		spacer1 = {
			name = "",
			type = "header",
			order = 3
		},
		reloadReminder = {
			name = exclamation .. "UI must be reloaded for changes to take affect fully.",
			type = "description",
			fontSize = "medium",
			order = 4
		},
		spacer2 = {
			name = "",
			type = "header",
			order = 5
		},
		reloadButton = {
			name = "Reload UI",
			type = "execute",
			func = ReloadUI,
			order = 6,
			width = 0.6
		},
		modules = {
			name = "Modules",
			type = "group",
			desc = "Configure individual modules.",
			args = {
				general = {
					type = "group",
					name = "General",
					desc = "Configure options for the General module.",
					order = 1,
					args = {
						header_Visibility = {
							type = "header",
							name = "Visibility",
							order = 1
						},
						minimapZoomButtons = {
							type = "toggle",
							name = "Minimap Buttons",
							desc = "Disable or enable the Minimap Zoom In/Out buttons.",
							order = 2,
							set = function(info, value)
								ZPR.db.profile.modules.minimapZoomButtons = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.minimapZoomButtons
							end
						},
						header_General = {
							type = "header",
							name = "General",
							order = 3
						},
						castBarTimer = {
							type = "toggle",
							name = "Cast Bar Timer",
							desc = "Enable or disable the cast bar timer.",
							order = 4,
							set = function(info, value)
								ZPR.db.profile.modules.castBarTimer = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.castBarTimer
							end
						},
						playerCastBarIcon = {
							type = "toggle",
							name = "Player Cast Bar Icon",
							desc = "Enable or disable the player cast bar icon.",
							order = 5,
							set = function(info, value)
								ZPR.db.profile.modules.playerCastBarIcon = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.playerCastBarIcon
							end
						},
					}
				},
				actionBars = {
					type = "group",
					name = "Action Bars",
					desc = "Configure options for the Action Bars module.",
					order = 2,
					args = {
						header_Visibility = {
							type = "header",
							name = "Visibility",
							width = "full",
							order = 1
						},
						keybindText = {
							type = "toggle",
							name = "Keybind Text",
							desc = "Disable or enable the keybind text on Action Bars.",
							width = "0.285",
							order = 2,
							set = function(info, value)
								ZPR.db.profile.modules.keybindText = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.keybindText
							end
						},
						macroText = {
							type = "toggle",
							name = "Macro Text",
							desc = "Disable or enable the macro text on Action Bars.",
							order = 3,
							set = function(info, value)
								ZPR.db.profile.modules.macroText = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.macroText
							end
						},
						header_General = {
							type = "header",
							name = "General Action Bars Customization",
							width = "full",
							order = 4
						},
						shortKeybindText = {
							type = "toggle",
							name = "Short Keybind Text",
							desc = "Enable or disable short keybind text on Action Bars.",
							width = "0.285",
							order = 5,
							set = function(info, value)
								ZPR.db.profile.modules.shortKeybindText = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.shortKeybindText
							end
						},
					}
				},
				unitFrames = {
					type = "group",
					name = "Unit Frames",
					desc = "Configure options for the Unit Frames module.",
					order = 3,
					args = {
						header_Visibility = {
							type = "header",
							name = "Visibility",
							width = "full",
							order = 1
						},
						pvpIcon = {
							type = "toggle",
							name = "PvP Icon",
							desc = "Disable or enable the PvP icon for Unit Frames.",
							width = "0.285",
							order = 2,
							set = function(info, value)
								ZPR.db.profile.modules.pvpIcon = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.pvpIcon
							end
						},
						feedbackText = {
							type = "toggle",
							name = "Feedback Text",
							desc = "Disable or enable feedback text for the Player & Pet Portraits.",
							order = 3,
							set = function(info, value)
								ZPR.db.profile.modules.feedbackText = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.feedbackText
							end
						},
						groupIndicator = {
							type = "toggle",
							name = "Group Indicator",
							desc = "Disable or enable the group indicator for Unit Frames.",
							width = "0.285",
							order = 4,
							set = function(info, value)
								ZPR.db.profile.modules.groupIndicator = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.groupIndicator
							end
						},
						restIndicator = {
							type = "toggle",
							name = "Rest Indicator",
							desc = "Disable or enable the rest indicator for Unit Frames.",
							order = 5,
							set = function(info, value)
								ZPR.db.profile.modules.restIndicator = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.restIndicator
							end
						},
						header_General = {
							type = "header",
							name = "General Unit Frame Customization",
							width = "full",
							order = 6
						},
						classColors = {
							type = "toggle",
							name = "Class Colors",
							desc = "Enable or disable class colors for Unit Frames.",
							width = "0.285",
							order = 7,
							set = function(info, value)
								ZPR.db.profile.modules.classColors = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.classColors
							end
						},
						repColor = {
							type = "toggle",
							name = "Rep Colors",
							desc = "Disable or enable reputation colors for Unit Frames.",
							order = 8,
							set = function(info, value)
								ZPR.db.profile.modules.repColor = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.repColor
							end
						},
						header_Misc = {
							type = "header",
							name = "Miscellaneous Unit Frame Customization",
							width = "full",
							order = 9

						},
						combatIndicator = {
							type = "toggle",
							name = "Combat Indicator",
							desc = "Enable or disable a icon to the right of target/focus frames to indicate combat status.",
							width = "0.285",
							order = 10,
							set = function(info, value)
								ZPR.db.profile.modules.combatIndicator = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.combatIndicator
							end
						},
					},
				},
				miscellaneous = {
					type = "group",
					name = "Miscellaneous",
					desc = "Configure options for the Miscellaneous module.",
					order = 4,
					args = {
						header = {
							type = "header",
							name = "Visibility",
							width = "full",
							order = 1
						},
						partyFrameTitle = {
							type = "toggle",
							name = "Party Frame Title",
							desc = "Disable or enable the 'Party' text on the Party Frames Header.",
							width = "0.285",
							order = 2,
							set = function(info, value)
								ZPR.db.profile.modules.partyFrameTitle = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.partyFrameTitle
							end
						},
						mouseoverRaidManager = {
							type = "toggle",
							name = "Raid Manager",
							desc = "Enable or disable the Raid Manager to only show when moused over.",
							order = 3,
							set = function(info, value)
								ZPR.db.profile.modules.mouseoverRaidManager = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.mouseoverRaidManager
							end
						},
						buffFrameCollapseExpand = {
							type = "toggle",
							name = "Buff Frame Toggle",
							desc = "Disable or enable the Buff Frame Collapse/Expand Button.",
							width = "0.285",
							order = 4,
							set = function(info, value)
								ZPR.db.profile.modules.buffFrameCollapseExpand = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.buffFrameCollapseExpand
							end
						},
						talkingHead = {
							type = "toggle",
							name = "Talking Head",
							desc = "Disable or enable the talking head frame.",
							order = 5,
							set = function(info, value)
								ZPR.db.profile.modules.talkingHead = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.talkingHead
							end
						}
					}
				},
			}
		}
	}
}
