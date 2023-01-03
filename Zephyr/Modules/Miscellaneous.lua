local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local mouseoverMicroMenu = ZPR:NewModule("mouseoverMicroMenu", "AceEvent-3.0")
local mouseoverRaidManager = ZPR:NewModule("mouseoverRaidManager", "AceEvent-3.0")
local buffFrameCollapseExpand = ZPR:NewModule("buffFrameCollapseExpand", "AceEvent-3.0")
local talkingHead = ZPR:NewModule("talkingHead", "AceEvent-3.0")
local nameplateHPPercent = ZPR:NewModule("nameplateHPPercent", "AceEvent-3.0")
local nameplateArenaNumbers = ZPR:NewModule("nameplateArenaNumbers", "AceEvent-3.0")
local partyFrameTitle = ZPR:NewModule("partyFrameTitle", "AceEvent-3.0")
local partyFrameRealmName = ZPR:NewModule("partyFrameRealmName", "AceEvent-3.0")
local partyFramePlayerName = ZPR:NewModule("partyFramePlayerName", "AceEvent-3.0")
local partyFrameRoleIcon = ZPR:NewModule("partyFrameRoleIcon", "AceEvent-3.0")
local customHPFormat = ZPR:NewModule("customHPFormat", "AceEvent-3.0")

function mouseoverMicroMenu:OnEnable()

	local BAG_BUTTONS = {
		MainMenuBarBackpackButton,
		CharacterBag0Slot,
		CharacterBag1Slot,
		CharacterBag2Slot,
		CharacterBag3Slot,
		CharacterReagentBag0Slot,
		BagBarExpandToggle,
	}

	for i = 1, #BAG_BUTTONS do
		BAG_BUTTONS[i]:Hide()
	end

	local microMenu = MicroButtonAndBagsBar
	microMenu:SetAlpha(0)
	local function FindParent(frame, target)
		if frame == target then
			return true
		elseif frame then
			return FindParent(frame:GetParent(), target)
		end
	end

	microMenu:HookScript("OnEnter", function(self)
		self:SetAlpha(1)
	end)

	microMenu:HookScript("OnLeave", function(self)
		if not FindParent(GetMouseFocus(), self) then
			self:SetAlpha(0)
		end
	end)
end

function mouseoverRaidManager:OnEnable()
	local raidManager = CompactRaidFrameManager
	raidManager:SetAlpha(0)
	local function FindParent(frame, target)
		if frame == target then
			return true
		elseif frame then
			return FindParent(frame:GetParent(), target)
		end
	end

	raidManager:HookScript("OnEnter", function(self)
		self:SetAlpha(1)
	end)

	raidManager:HookScript("OnLeave", function(self)
		if raidManager.collapsed and not FindParent(GetMouseFocus(), self) then
			self:SetAlpha(0)
		end
	end)

	raidManager.toggleButton:HookScript("OnClick", function()
		if raidManager.collapsed then
			raidManager:SetAlpha(0)
		end
	end)

	raidManager.container:SetIgnoreParentAlpha(true)
end

function buffFrameCollapseExpand:OnEnable()
	if BuffFrame:IsShown() then
		BuffFrame.CollapseAndExpandButton:EnableMouse(false)
		BuffFrame.CollapseAndExpandButton:SetAlpha(0)
	end
end

function talkingHead:OnEnable()
	hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
		self:Hide()
	end)
end

function nameplateHPPercent:OnEnable()
	if IsAddOnLoaded('Plater') or IsAddOnLoaded('TidyPlates_ThreatPlates') or IsAddOnLoaded('TidyPlates') or
		IsAddOnLoaded('Kui_Nameplates') then return end

	if GetCVar("nameplateShowOnlyNames") == "1" then
		return
	end

	local function nameplateHealthText(unit, healthBar)
		if not healthBar.text then
			healthBar.text = healthBar:CreateFontString(nil, "ARTWORK", nil)
			healthBar.text:SetPoint("CENTER")
			healthBar.text:SetFont(STANDARD_TEXT_FONT, 8, 'OUTLINE')
		else
			local _, maxHealth = healthBar:GetMinMaxValues()
			local currentHealth = healthBar:GetValue()
			healthBar.text:SetText(string.format(math.floor((currentHealth / maxHealth) * 100)) .. "%")
		end
	end

	local function nameplateHealthTextFrame(self)
		local inInstance, instanceType = IsInInstance()
		if inInstance and not (instanceType == 'arena' or instanceType == 'pvp') then
			if self:IsForbidden() then return end
		end

		if self.unit and self.unit:find('nameplate%d') then
			if self.healthBar and self.unit then
				if UnitName("player") ~= UnitName(self.unit) then
					local unit = self.unit
					local healthBar = self.healthBar
					nameplateHealthText(unit, healthBar)
				end
			end
		end
	end

	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", nameplateHealthTextFrame)
	hooksecurefunc("CompactUnitFrame_UpdateHealth", nameplateHealthTextFrame)
	hooksecurefunc("CompactUnitFrame_UpdateStatusText", nameplateHealthTextFrame)
end

function nameplateArenaNumbers:OnEnable()

	if IsAddOnLoaded('Plater') or IsAddOnLoaded('TidyPlates_ThreatPlates') or IsAddOnLoaded('TidyPlates') or
		IsAddOnLoaded('Kui_Nameplates') then return end

	if GetCVar("nameplateShowOnlyNames") == "1" then
		return
	end

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	frame:HookScript("OnEvent", function()

		local U = UnitIsUnit
		hooksecurefunc(
			"CompactUnitFrame_UpdateName",
			function(F)
				if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
					for i = 1, 5 do
						if U(F.unit, "arena" .. i) then
							F.name:SetText(i)
							F.name:SetTextColor(1, 1, 0)
							break
						end
					end
				end
			end)
	end)
end

function partyFrameTitle:OnEnable()
	CompactPartyFrameTitle:SetAlpha(0)
end

function partyFrameRealmName:OnEnable()
	hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
		if frame and not frame:IsForbidden() then
			local frame_name = frame:GetName()
			if frame_name and frame_name:match("^CompactRaidFrame%d") or ("^CompactRaidGroup%dMember%d") or
				("^CompactPartyFrameMember%d") and frame.unit and frame.name then
				local unit_name = GetUnitName(frame.unit, true)
				if unit_name then
					frame.name:SetText(unit_name:match("[^-]+"))
				end
			end
		end
	end)
end

function partyFramePlayerName:OnEnable()
	DefaultCompactUnitFrameOptions.displayName = false
end

function partyFrameRoleIcon:OnEnable()
	DefaultCompactUnitFrameOptions.displayRoleIcon = false
end

function customHPFormat:OnEnable()
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(f, t, v, _, x)
		-- f == PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar or
		-- f == PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar or
		-- f == FocusFrame.TargetFrameContent.TargetFrameContentMain.HealthBar then
		if f == TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBar then
			local F, V, z = format, v, 1000
			Z = z * z
			v = (v > Z and F("%.2fM", v / Z)) or (v > (z * 10) and F("%.0fk", v / z)) or v
			if V or x then
				t:SetText(F("%s", v))
				if UnitIsDeadOrGhost("target") then t:SetText(F(""))
				end
			end
		end
	end)
end
