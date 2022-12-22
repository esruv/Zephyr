local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local spellBarHookSet = false

local classColors = ZPR:NewModule("classColors", "AceEvent-3.0")
local pvpIcon = ZPR:NewModule("pvpIcon", "AceEvent-3.0")
local feedbackText = ZPR:NewModule("feedbackText", "AceEvent-3.0")
local groupIndicator = ZPR:NewModule("groupIndicator", "AceEvent-3.0")
local restIndicator = ZPR:NewModule("restIndicator", "AceEvent-3.0")
local repColor = ZPR:NewModule("repColor", "AceEvent-3.0")
local combatIndicator = ZPR:NewModule("combatIndicator", "AceEvent-3.0")
local targetCastBarOnTop = ZPR:NewModule("targetCastBarOnTop", "AceEvent-3.0")
local focusCastBarOnTop = ZPR:NewModule("focusCastBarOnTop", "AceEvent-3.0")

local playerFrameMain = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain
local targetFrameMain = TargetFrame.TargetFrameContent.TargetFrameContentMain
local focusFrameMain = FocusFrame.TargetFrameContent.TargetFrameContentMain

local playerFrameContextual = PlayerFrame_GetPlayerFrameContentContextual()
local targetFrameContextual = TargetFrame.TargetFrameContent.TargetFrameContentContextual
local focusFrameContextual = FocusFrame.TargetFrameContent.TargetFrameContentContextual

function classColors:OnEnable()
	local function handleUnitFramePortraitUpdate(self)
		local healthBar = self.HealthBar

		if self.unit == "player" then
			-- if player is in a vehicle color the pet frame instead
			if UnitInVehicle(self.unit) then
				healthBar = PetFrameHealthBar
			else
				healthBar = playerFrameMain.HealthBarArea.HealthBar
			end

		elseif self.unit == "pet" then
			healthBar = PetFrameHealthBar
		elseif self.unit == "target" then
			healthBar = targetFrameMain.HealthBar
		elseif self.unit == "focus" then
			healthBar = focusFrameMain.HealthBar
		elseif self.unit == "vehicle" then
			healthBar = playerFrameMain.HealthBarArea.HealthBar
		end

		if not healthBar then
			return
		end

		if UnitIsPlayer(self.unit) and UnitIsConnected(self.unit) and classColors:IsEnabled() then
			local _, const_class = UnitClass(self.unit);
			local r, g, b = GetClassColor(const_class)
			healthBar:SetStatusBarDesaturated(true)
			healthBar:SetStatusBarColor(r, g, b)
		elseif UnitIsPlayer(self.unit) and not UnitIsConnected(self.unit) then
			healthBar:SetStatusBarDesaturated(true)
			healthBar:SetStatusBarColor(1, 1, 1)
		end
	end

	hooksecurefunc("UnitFramePortrait_Update", handleUnitFramePortraitUpdate)
end

function repColor:OnEnable()
	targetFrameMain.ReputationColor:Hide()
	focusFrameMain.ReputationColor:Hide()
end

function pvpIcon:OnEnable()
	playerFrameContextual.PVPIcon:SetAlpha(0)
	playerFrameContextual.PrestigePortrait:SetAlpha(0)
	playerFrameContextual.PrestigeBadge:SetAlpha(0)

	targetFrameContextual.PvpIcon:SetAlpha(0)
	targetFrameContextual.PrestigePortrait:SetAlpha(0)
	targetFrameContextual.PrestigeBadge:SetAlpha(0)

	focusFrameContextual.PvpIcon:SetAlpha(0)
	focusFrameContextual.PrestigePortrait:SetAlpha(0)
	focusFrameContextual.PrestigeBadge:SetAlpha(0)
end

function feedbackText:OnEnable()
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end
end

function groupIndicator:OnEnable()
	playerFrameContextual.GroupIndicator:SetAlpha(0)
end

function restIndicator:OnEnable()
	playerFrameContextual.PlayerRestLoop:SetAlpha(0)
end

local function handleTargetFrameSpellBar_OnUpdate(self, arg1, ...)
	if targetCastBarOnTop:IsEnabled() then
		self:SetPoint("TOPLEFT", TargetFrame, "TOPLEFT", 45, 15)
	end
end

local function handleFocusFrameSpellBar_OnUpdate(self, arg1, ...)
	if focusCastBarOnTop:IsEnabled() then
		if FocusFrame.smallSize then
			self:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 38, 15)
		else
			self:SetPoint("TOPLEFT", FocusFrame, "TOPLEFT", 45, 15)
		end
	end
end

function targetCastBarOnTop:OnEnable()
	TargetFrameSpellBar:HookScript("OnUpdate", handleTargetFrameSpellBar_OnUpdate)
end

function focusCastBarOnTop:OnEnable()

	FocusFrameSpellBar:HookScript("OnUpdate", handleFocusFrameSpellBar_OnUpdate)
end

function combatIndicator:OnEnable()
	CTT = CreateFrame("Frame")
	CTT:SetPoint("CENTER", TargetFrame, "RIGHT", 3, 0)
	CTT:SetSize(25, 25)
	CTT.t = CTT:CreateTexture(nil, BORDER)
	CTT.t:SetAllPoints()
	CTT.t:SetTexture("Interface\\Icons\\ABILITY_DUALWIELD")
	CTT:Hide()

	local function FrameOnUpdate(self)
		if UnitAffectingCombat("target") then
			self:Show()
		else
			self:Hide()
		end
	end

	local CI = CreateFrame("Frame")
	CI:SetScript("OnUpdate", function(self)
		FrameOnUpdate(CTT)
	end)
	CFT = CreateFrame("Frame")
	CFT:SetPoint("CENTER", FocusFrame, "RIGHT", 3, 0)
	CFT:SetSize(25, 25)
	CFT.t = CFT:CreateTexture(nil, BORDER)
	CFT.t:SetAllPoints()
	CFT.t:SetTexture("Interface\\Icons\\ABILITY_DUALWIELD")
	CFT:Hide()

	local function FrameOnUpdate(self)
		if UnitAffectingCombat("focus") then
			self:Show()
		else
			self:Hide()
		end
	end

	local CI = CreateFrame("Frame")
	CI:SetScript("OnUpdate", function(self)
		FrameOnUpdate(CFT)
	end)
end
