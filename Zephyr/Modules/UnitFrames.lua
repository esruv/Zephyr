local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local classColors = ZPR:NewModule("classColors", "AceEvent-3.0")
local pvpIcon = ZPR:NewModule("pvpIcon", "AceEvent-3.0")
local feedbackText = ZPR:NewModule("feedbackText", "AceEvent-3.0")
local combatIndicator = ZPR:NewModule("combatIndicator", "AceEvent-3.0")
local repColor = ZPR:NewModule("repColor", "AceEvent-3.0")

local playerFrameContentMain = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain
local targetFrameContentMain = TargetFrame.TargetFrameContent.TargetFrameContentMain
local focusFrameContentMain = FocusFrame.TargetFrameContent.TargetFrameContentMain

local playerFrameTargetContextual = PlayerFrame_GetPlayerFrameContentContextual()
local targetFrameContextual = TargetFrame.TargetFrameContent.TargetFrameContentContextual
local focusFrameContextual = FocusFrame.TargetFrameContent.TargetFrameContentContextual

function classColors:OnEnable()

	local function SetClassColors(self)
		if UnitIsPlayer(self.unit) and UnitIsConnected(self.unit) then
			local _, class = UnitClass(self.unit)
			local color = RAID_CLASS_COLORS[class]
			if color then
				self:SetStatusBarColor(color.r, color.g, color.b)
				self:SetStatusBarDesaturated(true)
			elseif UnitIsTapped(self.unit) and not UnitIsTappedByPlayer(self.unit) then
				self:SetStatusBarColor(0.5, 0.5, 0.5)
				self:SetStatusBarDesaturated(true)
			else
				self:SetStatusBarColor(0.0, 1.0, 0.0)
				self:SetStatusBarDesaturated(true)
			end
		elseif UnitIsPlayer(self.unit) then
			self:SetStatusBarColor(0.5, 0.5, 0.5)
			self:SetStatusBarDesaturated(true)
		else
			self:SetStatusBarColor(0.0, 1.0, 0.0)
			self:SetStatusBarDesaturated(true)
		end
	end

	hooksecurefunc("HealthBar_OnValueChanged", SetClassColors)
	hooksecurefunc("UnitFrameHealthBar_Update", SetClassColors)

end

function repColor:OnEnable()
	targetFrameContentMain.ReputationColor:Hide()
	focusFrameContentMain.ReputationColor:Hide()
end

function pvpIcon:OnEnable()
	playerFrameTargetContextual.PVPIcon:SetAlpha(0)
	playerFrameTargetContextual.PrestigePortrait:SetAlpha(0)
	playerFrameTargetContextual.PrestigeBadge:SetAlpha(0)

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

	local g = CreateFrame("Frame")
	g:SetScript("OnUpdate", function(self)
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

	local g = CreateFrame("Frame")
	g:SetScript("OnUpdate", function(self)
		FrameOnUpdate(CFT)
	end)
end
