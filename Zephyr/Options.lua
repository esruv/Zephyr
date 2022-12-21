local addonName, ns = ...
local addonTitle = GetAddOnInfo(addonName, "addonName")
local exclamation = "|TInterface\\Cursor\\Quest:12:12:1:0:64:64:9:60:9:60|t"

ZPR.defaults = {
	profile = {
		modules = {
			-- General

			-- Action Bars

			-- Unit Frames
			pvpIcon = true,
			feedbackText = true,
			classColors = true,
			combatIndicator = true,

			-- Miscellaneous

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
					args = {}
				},
				actionBars = {
					type = "group",
					name = "Action Bars",
					desc = "Configure options for the Action Bars module.",
					order = 2,
					args = {}
				},
				unitFrames = {
					type = "group",
					name = "Unit Frames",
					desc = "Configure options for the Unit Frames module.",
					order = 3,
					args = {
						header_visibility = {
							type = "header",
							name = "Visibility",
							width = "full",
							order = 1
						},
						spacer3 = {
							name = "",
							type = "description",
							order = 2
						},
						pvpIcon = {
							type = "toggle",
							name = "PvP Icon",
							desc = "Enable or disable the PvP icon for unit frames.",
							width = "half",
							order = 3,
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
							order = 4,
							set = function(info, value)
								ZPR.db.profile.modules.feedbackText = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.feedbackText
							end
						},
						header_General = {
							type = "header",
							name = "General Unit Frame Customization",
							width = "full",
							order = 5
						},
						classColors = {
							type = "toggle",
							name = "Class Colors",
							desc = "Enable or disable class colors for unit frames.",
							order = 6,
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
							desc = "Disable or enable reputation colors for unit frames.",
							width = "half",
							order = 7,
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
							order = 8

						},
						combatIndicator = {
							type = "toggle",
							name = "Combat Indicator",
							desc = "Enable or disable a icon to the right of target/focus frames to indicate combat status.",
							order = 9,
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
				misc = {
					type = "group",
					name = "Misc",
					desc = "Configure options for the Misc module.",
					order = 5,
					args = {}
				},
			}
		}
	}
}
