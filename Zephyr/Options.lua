local _, ns = ...

ZPR.defaults = {
	profile = {
		modules = {
			classColors = true,
		}
	}
}

ZPR.options = {
	type = "group",
	args = {
		modules = {
			type = "group",
			name = "Modules",
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
				}
			}
		}
	}
}
