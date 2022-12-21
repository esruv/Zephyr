local addonName, ns = ...
local addonTitle = GetAddOnInfo(addonName)
local exclamation = "|TInterface\\Cursor\\Quest:12:12:1:0:64:64:9:60:9:60|t"

ZPR.defaults = {
	profile = {
		modules = {
			classColors = true,
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
					args = {}
				},
				actionBars = {
					type = "group",
					name = "Action Bars",
					desc = "Configure options for the Action Bars module.",
					args = {}
				},
				unitFrames = {
					type = "group",
					name = "Unit Frames",
					desc = "Configure options for the Unit Frames module.",
					args = {
						classColors = {
							type = "toggle",
							name = "Class Colors",
							desc = "Enable or disable class colors for unit frames.",
							set = function(info, value)
								ZPR.db.profile.modules.classColors = value
								ZPR:ToggleModules()
							end,
							get = function(info)
								return ZPR.db.profile.modules.classColors
							end
						}
					}
				},
				misc = {
					type = "group",
					name = "Misc",
					desc = "Configure options for the Misc module.",
					args = {}
				},
			}
		}
	}
}
