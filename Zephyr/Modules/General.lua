local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local minimapZoomButtons = ZPR:NewModule("minimapZoomButtons", "AceEvent-3.0")
local castBarTimer = ZPR:NewModule("castBarTimer", "AceEvent-3.0")
local playerCastBarIcon = ZPR:NewModule("playerCastBarIcon", "AceEvent-3.0")

function minimapZoomButtons:OnEnable()
	Minimap.ZoomIn:SetAlpha(0)
	Minimap.ZoomOut:SetAlpha(0)

	if Minimap.ZoomIn:IsShown() then
		Minimap.ZoomIn:Hide()
	end

	if Minimap.ZoomOut:IsShown() then
		Minimap.ZoomOut:Hide()
	end
end

function castBarTimer:OnEnable()

	local castBarTimersInitialized = false

	local function timerFrame(parent, xOffset, yOffset)
		local timerFrame = CreateFrame("Frame", "castBarTimer" .. parent:GetName(), parent)
		timerFrame:SetWidth(1)
		timerFrame:SetHeight(1)
		timerFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", xOffset, yOffset)
		timerFrame.text = timerFrame:CreateFontString(nil, "ARTWORK")
		timerFrame.text:SetFontObject(SystemFont_Shadow_Small)
		timerFrame.text:SetPoint("CENTER", 0, 0)
	end

	local function realignSpellNameText()
		TargetFrameSpellBar.Text:SetJustifyH("LEFT")
		FocusFrameSpellBar.Text:SetJustifyH("LEFT")
		PlayerCastingBarFrame.Text:SetJustifyH("LEFT")

		PlayerCastingBarFrame.Text:SetPoint("TOPLEFT", PlayerCastingBarFrame, "TOPLEFT", 5, -10)
		PlayerCastingBarFrame.Text:SetPoint("TOPRIGHT", PlayerCastingBarFrame, "TOPRIGHT", -30, -10)
		TargetFrameSpellBar.Text:SetPoint("TOPLEFT", TargetFrameSpellBar, "TOPLEFT", 5, -8)
		TargetFrameSpellBar.Text:SetPoint("TOPRIGHT", TargetFrameSpellBar, "TOPRIGHT", -25, -8)
		FocusFrameSpellBar.Text:SetPoint("TOPLEFT", FocusFrameSpellBar, "TOPLEFT", 5, -8)
		FocusFrameSpellBar.Text:SetPoint("TOPRIGHT", FocusFrameSpellBar, "TOPRIGHT", -25, -8)
	end

	local function setTimerText(castBarFrame, timerTextFrame)
		local timeLeft = nil;
		if (castBarFrame.casting) then
			timeLeft = castBarFrame.maxValue - castBarFrame:GetValue();
		elseif (castBarFrame.channeling) then
			timeLeft = castBarFrame:GetValue()
		end
		if (timeLeft) then
			timeLeft = (timeLeft < 0.1) and 0.01 or timeLeft;
			timerTextFrame.text:SetText(string.format("%.1f", timeLeft))
		end
	end

	local function handlePlayerCastBar_OnUpdate(self, ...)
		setTimerText(self, _G["castBarTimerPlayerCastingBarFrame"])
	end

	local function handleTargetSpellBar_OnUpdate(self, ...)
		setTimerText(self, _G["castBarTimerTargetFrameSpellBar"])
	end

	local function handleFocusSpellBar_OnUpdate(self, ...)
		setTimerText(self, _G["castBarTimerFocusFrameSpellBar"])
	end

	if not castBarTimersInitialized then
		timerFrame(PlayerCastingBarFrame, -14, -17)
		PlayerCastingBarFrame:HookScript("OnUpdate", handlePlayerCastBar_OnUpdate)

		timerFrame(TargetFrameSpellBar, -12, -16)
		TargetFrameSpellBar:HookScript("OnUpdate", handleTargetSpellBar_OnUpdate)

		timerFrame(FocusFrameSpellBar, -12, -16)
		FocusFrameSpellBar:HookScript("OnUpdate", handleFocusSpellBar_OnUpdate)

		castBarTimersInitialized = true
	end

	-- Prevent the text from flowing into the castbar timer
	realignSpellNameText()

	_G["castBarTimerPlayerCastingBarFrame"]:Show()
	_G["castBarTimerTargetFrameSpellBar"]:Show()
	_G["castBarTimerFocusFrameSpellBar"]:Show()
end

function playerCastBarIcon:OnEnable()
	local point, relativeTo, relativePoint = PlayerCastingBarFrame.Icon:GetPoint()
	PlayerCastingBarFrame.Icon:SetSize(22, 22)
	PlayerCastingBarFrame.Icon:SetPoint(point, relativeTo, relativePoint, -2, -6)
	PlayerCastingBarFrame.Icon:Show()
end
