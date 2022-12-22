local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local keybindText = ZPR:NewModule("keybindText", "AceEvent-3.0")
local macroText = ZPR:NewModule("macroText", "AceEvent-3.0")
local shortKeybindText = ZPR:NewModule("shortKeybindText", "AceEvent-3.0")

local map = {
	["Middle Mouse"] = "M3",
	["Mouse Wheel Down"] = "WD",
	["Mouse Wheel Up"] = "WU",
	["Home"] = "Hm",
	["Insert"] = "Ins",
	["Delete"] = "Del",
	["Page Down"] = "PD",
	["Page Up"] = "PU",
	["Spacebar"] = "_",
}

local patterns = {
	["Mouse Button "] = "M", -- M4, M5
	["Num Pad "] = "N",
	["a%-"] = "A", -- alt
	["c%-"] = "C", -- ctrl
	["s%-"] = "S", -- shift
}

local bars = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
	"MultiBarRightButton",
	"MultiBar5Button",
	"MultiBar6Button",
	"MultiBar7Button",
}

local function UpdateHotkey(self)
	local hotkey = self.HotKey
	local text = hotkey:GetText()
	for k, v in pairs(patterns) do
		text = text:gsub(k, v)
	end
	hotkey:SetText(map[text] or text)
end

local function hideKeybindText(self)
	local hotkey = self.HotKey
	hotkey:SetText("")
end

local function hideMacroText(self)
	local macro = self.Name
	macro:SetText("")
end

function keybindText:OnEnable()
	for _, bar in pairs(bars) do
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			hooksecurefunc(_G[bar .. i], "Update", hideKeybindText)
		end
	end
end

function macroText:OnEnable() -- hide macro text on Action Bars
	for _, bar in pairs(bars) do
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			hooksecurefunc(_G[bar .. i], "Update", hideMacroText)
		end
	end
end

function shortKeybindText:OnEnable()
	for _, bar in pairs(bars) do
		for i = 1, NUM_ACTIONBAR_BUTTONS do
			hooksecurefunc(_G[bar .. i], "Update", UpdateHotkey)
		end
	end
end
