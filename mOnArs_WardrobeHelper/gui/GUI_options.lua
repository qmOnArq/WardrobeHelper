local o = mOnWardrobe

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

o.resetSettings = function()
	mOnWDSave = nil
	o.fixSettings()
	o.GUIfixOptions()
end

o.GUIfixOptions = function()
	o.GUIshowTabOptions(1)
	mOnWD_OptionsFrame.hideList:SetChecked(mOnWDSave.hideList)
	mOnWD_OptionsFrame.disableProgress:SetChecked(mOnWDSave.disableProgress)
	mOnWD_OptionsFrame.hideMinimap:SetChecked(mOnWDSave.minimap.hide)
end

o.GUIshowOptions = function()
  mOnWD_MainFrame:Hide()
  mOnWD_MainFrame.ItemFrame:Hide()
	o.GUIfixOptions()
  mOnWD_OptionsFrame:Show()
end

o.GUIshowTabOptions = function(number)
	for i=1,#mOnWD_OptionsFrame.tabItems do
		local tab = mOnWD_OptionsFrame.tabItems[i]
		for j=1,#tab do
			tab[j]:Hide()
		end
	end
	local tab = mOnWD_OptionsFrame.tabItems[number]
	for i=1,#tab do
		tab[i]:Show()
	end
	for i=1,#mOnWD_OptionsFrame.tabOptions do
		mOnWD_OptionsFrame.tabOptions[i].text:SetTextColor(1,1,1,1)
	end
	mOnWD_OptionsFrame.tabOptions[number].text:SetTextColor(1,0.8,0,1)
end

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

local function CreateTableRow(parent, rowHeight, N, text)
	local row = CreateFrame("Button", nil, parent)
	row.id = N
	row:SetHeight(rowHeight)
	row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row:SetPoint("LEFT")
	row:SetPoint("RIGHT")
	row:SetPoint("TOP", parent, "TOP", 0, -5 - (rowHeight + 2) * (N - 1))
	row:SetScript("OnClick", function()
		o.GUIshowTabOptions(N)
	end)

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	c:SetHeight(rowHeight)
	c:SetJustifyH("LEFT")
	c:SetPoint("LEFT", row, "LEFT", 7, 0)
	c:SetText(text)
	--c:SetFont("Fonts\\FRIZQT__.TTF",12,"")
	row.text = c

	return row
end

local fr = CreateFrame("Frame", "mOnWD_OptionsFrame")
fr.tabItems = {}
fr.tabOptions = {}
fr.tabItems[1] = {}
fr.tabItems[2] = {}
fr:Hide()
tinsert(UISpecialFrames, fr:GetName())
fr:SetWidth(500)
fr:SetHeight(400)
fr:SetScale(0.8)
fr:SetPoint("CENTER",UIParent,"CENTER",0,0)
fr:SetFrameStrata("DIALOG")
local h = fr:CreateTexture(nil, "ARTWORK")
h:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
h:SetWidth(500)
h:SetHeight(68)
h:ClearAllPoints()
h:SetPoint("TOP", 0, 15)
fr.HeaderTexture = h
fr.title = fr:CreateFontString(nil, "ARTWORK", "GameFontNormal")
fr.title:SetPoint("TOP", h, "TOP", 0, -15)
fr.title:SetText("mOnAr's Wardrobe Helper (v" .. o.version .. ")")
fr:SetBackdrop(
	{
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left=11, right=12, top=12, bottom=11 }
	})
fr:SetScript("OnShow", function()
	PlaySound("igCharacterInfoOpen")
end)
fr:SetScript("OnHide", function()
	PlaySound("igCharacterInfoClose")
end)
fr:SetMovable(true)
fr:EnableMouse(true)
fr:RegisterForDrag("LeftButton")
fr:SetScript("OnDragStart", fr.StartMoving)
fr:SetScript("OnDragStop", fr.StopMovingOrSizing)

local b = CreateFrame("BUTTON", "mOnWD_OptionsFrame_Close", fr, "UIPanelButtonTemplate")
fr.bClose = b
b:SetText(o.strings["Close"])
b:SetHeight(25)
b:SetWidth(100)
b:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", -10, 10)
b:SetScript("OnClick", function()
	fr:Hide()
end)

local b = CreateFrame("BUTTON", "mOnWD_OptionsFrame_Def", fr, "UIPanelButtonTemplate")
fr.bDef = b
b:SetText(o.strings["Defaults"])
b:SetHeight(25)
b:SetWidth(100)
b:SetPoint("BOTTOMLEFT", fr, "BOTTOMLEFT", 10, 10)
b:SetScript("OnClick", function()
	o.resetSettings()
end)

local panel = CreateFrame("Frame", "mOnWD_OptionsFrame_Panel", fr)
fr.panel = panel
fr.panel:SetPoint("TOPLEFT", fr, "TOPLEFT", 110, -10)
fr.panel:SetPoint("BOTTOMRIGHT", fr, "BOTTOMRIGHT", -15, 39)

local border = CreateFrame("Frame", nil, panel)
border:SetPoint("TOPLEFT", 1, -27)
border:SetPoint("BOTTOMRIGHT", -1, 3)
border:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
})
border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
border:SetBackdropBorderColor(0.4, 0.4, 0.4)
fr.panel.border = border

local panel = CreateFrame("Frame", "mOnWD_OptionsFrame_Panel2", fr)
fr.panelSelect = panel
fr.panelSelect:SetPoint("TOPLEFT", fr, "TOPLEFT", 15, -10)
fr.panelSelect:SetPoint("BOTTOMRIGHT", fr.panel, "BOTTOMLEFT", -1, 0)

local border = CreateFrame("Frame", nil, panel)
border:SetPoint("TOPLEFT", 1, -27)
border:SetPoint("BOTTOMRIGHT", -1, 3)
border:SetBackdrop({
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
})
border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
border:SetBackdropBorderColor(0.4, 0.4, 0.4)

fr.tabOptions[1] = CreateTableRow(border, 14, 1, o.strings["General"])
fr.tabOptions[2] = CreateTableRow(border, 14, 2, o.strings["Debug"])

local n = CreateFrame("CheckButton", "mOnWD_OptionsFrame_HideList", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.hideList = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
mOnWD_OptionsFrame_HideListText:SetText(o.strings["Hide List Option"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			mOnWDSave.hideList = true
		else
			mOnWDSave.hideList = false
		end
	end);

local n = CreateFrame("CheckButton", "mOnWD_OptionsFrame_DisableProgress", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.disableProgress = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -60)
mOnWD_OptionsFrame_DisableProgressText:SetText(o.strings["Disable Progress"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			mOnWDSave.disableProgress = true
		else
			mOnWDSave.disableProgress = false
		end
	end);

local fs = fr.panel:CreateFontString("mOnWD_OptionsFrame_DisableProgress_Info","OVERLAY","GameFontNormalSmall");
fr.disableProgressInfo = fs;
fs:SetWidth(300);
fs:SetHeight(0);
fs:SetJustifyH("LEFT");
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 30, -80)
fs:SetText(o.strings["Disable Progress Info"])
table.insert(fr.tabItems[1], fs)

local n = CreateFrame("CheckButton", "mOnWD_OptionsFrame_DisableMinimapButton", fr.panel.border, "ChatConfigCheckButtonTemplate")
fr.hideMinimap = n
table.insert(fr.tabItems[1], n)
n:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -95)
mOnWD_OptionsFrame_DisableMinimapButtonText:SetText(o.strings["Hide Minimap"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			mOnWDSave.minimap.hide = true
		else
			mOnWDSave.minimap.hide = false
		end
		if mOnWDSave.minimap.hide then
			o.LDBI:Hide("Wardrobe Helper")
		else
			o.LDBI:Show("Wardrobe Helper")
		end
	end);

local fs = fr.panel:CreateFontString("mOnWD_OptionsFrame_Debug_Info","OVERLAY","GameFontNormalSmall");
fr.disableProgressInfo = fs;
fs:SetWidth(300);
fs:SetHeight(0);
fs:SetJustifyH("LEFT");
fs:SetPoint("TOPLEFT", fr.panel, "TOPLEFT", 10, -35)
fs:SetText(o.strings["Debug Info"])
table.insert(fr.tabItems[2], fs)
