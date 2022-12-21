local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")

local partyFrameTitle = ZPR:NewModule("partyFrameText", "AceEvent-3.0")
local mouseoverRaidManager = ZPR:NewModule("mouseoverRaidManager", "AceEvent-3.0")
local buffFrameCollapseExpand = ZPR:NewModule("buffFrameCollapseExpand", "AceEvent-3.0")
local talkingHead = ZPR:NewModule("talkingHead", "AceEvent-3.0")

function partyFrameTitle:OnEnable()
	if CompactPartyFrame:IsShown() then
		CompactPartyFrameTitle:SetAlpha(0)
	end
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
