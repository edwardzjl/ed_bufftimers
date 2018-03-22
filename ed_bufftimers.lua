
local addonName, addon = ...
local cfg = addon.cfg
----------------------------------------------------------------------------------------------------
--[[initialization]]
local type_tbl = {
	Buff = UnitBuff,
	Debuff = UnitDebuff
}
local size_tbl = {
	PlayerBuff = cfg.PlayerBuffIconSize,
	PlayerDebuff = cfg.PlayerDebuffIconSize,
	TargetBuff = cfg.TargetBuffIconSize,
	FocusBuff = cfg.FocusBuffIconSize,
	PetBuff = cfg.PetBuffIconSize
}

local function createIcon(spell_id, icon_size)
	local _, _, icon = GetSpellInfo(spell_id)
	local frame = CreateFrame("Frame")
	frame:SetSize(icon_size, icon_size)
	frame.t = frame:CreateTexture(nil, "BORDER")
	frame.t:SetAllPoints(true)
	frame.t:SetTexture(icon)
	frame.f = frame:CreateFontString(nil, "BORDER")	-- number font
	frame.f:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
	frame.f:SetPoint("BOTTOMRIGHT", 0, 0)
	frame.c = frame:CreateFontString(nil, "BORDER")	-- cooldown font
	frame.c:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
	frame.c:SetPoint("BOTTOM", 0, -10)
	return frame;
end

local function createList(unit, _type)
	for i, spell_id in ipairs(cfg.list_tbl[unit.._type]) do
		_G[unit.._type.."Icon"..i] = _G[unit.._type.."Icon"..i] or createIcon(spell_id, size_tbl[unit.._type])
		_G[unit.._type.."Icon"..i]:Hide()
	end
end
----------------------------------------------------------------------------------------------------
icon_setting_tbl = {
  PlayerBuff = function ()
  	return cfg.PlayerBuffIconOffsetX, cfg.PlayerBuffIconOffsetY, cfg.PlayerBuffIconSize, UIParent, "CENTER", "CENTER"
  end,
  PlayerDebuff = function ()
  	return cfg.PlayerDebuffIconOffsetX, cfg.PlayerDebuffIconOffsetY, cfg.PlayerDebuffIconSize, UIParent, "CENTER", "CENTER"
  end,
  TargetBuff = function ()
  	return cfg.TargetBuffIconOffsetX, cfg.TargetBuffIconOffsetY, cfg.TargetBuffIconSize, TargetFrame, "LEFT", "RIGHT"
  end,
  FocusBuff = function ()
  	return cfg.FocusBuffIconOffsetX, cfg.FocusBuffIconOffsetY, cfg.FocusBuffIconSize, FocusFrame, "LEFT", "RIGHT"
  end,
  PetBuff = function ()
  	return cfg.PetBuffIconOffsetX, cfg.PetBuffIconOffsetY, cfg.PetBuffIconSize, PlayerFrame, "LEFT", "RIGHT"
  end
}
local function showIcon(unit, _type, spell_id, Icons, i, row)
	local offsetX, offsetY, icon_size, iconParent, anchor, targetAnchor
	= icon_setting_tbl[unit.._type]()
	local name, _, _, count = type_tbl[_type](unit, GetSpellInfo(spell_id))
	if name then
		_G[Icons..i]:Show()
		_G[Icons..i]:SetPoint(anchor, iconParent, targetAnchor, offsetX + (icon_size + 4) * (row - 1), offsetY)
		if(count > 1)then
			_G[Icons..i].f:SetText(count)
		else
			_G[Icons..i].f:SetText("")
		end
		row = row + 1;
	else
		_G[Icons..i]:Hide()
	end
	return row;
end

local function setIcons(unit, _type)
	local Icons = unit.._type.."Icon"
	local row = 1;
	for i, spell_id in ipairs(cfg.list_tbl[unit.._type])do
		_G[Icons..i]:Hide()
		row = showIcon(unit, _type, spell_id, Icons, i, row)
	end
end
----------------------------------------------------------------------------------------------------
--[[set the cooldown timer of buff icons]]
local function setTimer(unit, _type)
	for i, spell_id in ipairs(cfg.list_tbl[unit.._type])do
		local name, _, _, _, _, _, expires = type_tbl[_type](unit, GetSpellInfo(spell_id))
		if name then
			local vt = math.floor(expires - GetTime() + 1)
			if (vt >= 60)then
				vt = math.ceil(vt / 60)
				_G[unit.._type.."Icon"..i].c:SetText(vt.."m")
			elseif vt >= 0 then
				_G[unit.._type.."Icon"..i].c:SetText(vt.."s")
			end
		end
	end
end
----------------------------------------------------------------------------------------------------

local BuffFrame = CreateFrame("Frame")
BuffFrame:RegisterEvent("PLAYER_LOGIN")
BuffFrame:RegisterEvent("UNIT_AURA")
BuffFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
BuffFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
BuffFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		createList("Player", "Buff")
		createList("Player", "Debuff")
		createList("Target", "Buff")
		createList("Focus", "Buff")
		if cfg.class == "HUNTER" then
			createList("Pet", "Buff")
		end
	elseif event == "UNIT_AURA" then
		setIcons("Player", "Buff")
		setIcons("Player", "Debuff")
		setIcons("Target", "Buff")
		setIcons("Focus", "Buff")
		if cfg.class == "HUNTER" then
			setIcons("Pet", "Buff")
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		setIcons("Target", "Buff")
	elseif event == "PLAYER_FOCUS_CHANGED" then
		setIcons("Focus", "Buff")
    end
end)
BuffFrame:SetScript("OnUpdate", function()
	setTimer("Player", "Buff")
	setTimer("Player", "Debuff")
	setTimer("Target", "Buff")
	setTimer("Focus", "Buff")
	if cfg.class == "HUNTER" then
		setTimer("Pet", "Buff")
	end
end)
