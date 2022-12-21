local addonName, ns = ...

ZPR = LibStub("AceAddon-3.0"):NewAddon("Zephyr", "AceEvent-3.0", "AceConsole-3.0")

local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local ADB = LibStub("AceDB-3.0")

function ZPR:OnInitialize()
	self.db = ADB:New("ZephyrDB", self.defaults, true)

	AC:RegisterOptionsTable("Zephyr_Options", self.options)
	ACD:SetDefaultSize("Zephyr_Options", 570, 650)
	self.optionsFrame = ACD:AddToBlizOptions("Zephyr_Options", "Zephyr")

	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	AC:RegisterOptionsTable("Zephyr_Profiles", profiles)
	ACD:AddToBlizOptions("Zephyr_Profiles", "Profiles", "Zephyr")

	self:RegisterChatCommand("zp", "SlashCommand")
	self:RegisterChatCommand("Zephyr", "SlashCommand")
end

function ZPR:OnEnable()
	self:Print("Zephyr has been enabled.")
	self:ToggleModules()
end

function ZPR:OnDisable()
	self:Print("Zephyr has been disabled.")
	self:ToggleModules()
end

function ZPR:Print(message)
	print("|cFF33FF99Zephyr:|r " .. message)
end

function ZPR:ToggleModules()
	for name, module in self:IterateModules() do
		if self.db.profile.modules[name] then
			module:Enable()
		else
			module:Disable()
		end
	end
end

function ZPR:SlashCommand(input)
	if input == "reset" then
		self.db:ResetProfile()
		self:Print("Profile has been reset.")
	elseif ACD.OpenFrames["Zephyr Options"] then
		ACD:Close("Zephyr_Options")
	else
		ACD:Open("Zephyr_Options")
	end
end
