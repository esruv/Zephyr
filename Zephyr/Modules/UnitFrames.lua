local ZPR = LibStub("AceAddon-3.0"):GetAddon("Zephyr")
local classColors = ZPR:NewModule("classColors", "AceEvent-3.0")

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
