local o = mOnWardrobe
local f = mOnWD_MainFrame

---------------------------------------------------------------
-- Initialization
---------------------------------------------------------------

local first = nil

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

local function createItemSlot(par, N)
	local but = CreateFrame("BUTTON", "$parentItem"..N, par)
	but:SetWidth(37);
	but:SetHeight(37);
	but.id = N;
	but.ItemID = nil;

	local t = but:CreateTexture(nil, "ARTWORK")
	t:SetAllPoints(but);
	t:SetTexture(1,1,1,0.25)
	but.texture = t;

	but:SetNormalTexture(t);
	but:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	but:SetScript("OnEnter", function()
			GameTooltip_SetDefaultAnchor(GameTooltip, but)
			GameTooltip:ClearLines()
			GameTooltip:SetItemByID(but.ItemID);
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOMLEFT", but, "TOPLEFT")
			GameTooltip:Show();
		end);

	but:SetScript("OnClick", function(self, button)
			local name, itemLink = GetItemInfo(self.ItemID)
			if (itemLink and button == "LeftButton" and IsModifiedClick("CHATLINK")) then
				ChatEdit_InsertLink(itemLink)
				return
			end

			if(itemLink and button == "LeftButton" and IsModifiedClick("DRESSUP") and DressUpFrame) then
				DressUpItemLink(itemLink)
				return
			end
		end)

	but:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);

	return but
end

local function setDifficulty(difficulty)
	local scrollbar = mOnWD_MainFrame.ItemFrame.scrollbar
	local iframe = mOnWD_MainFrame.ItemFrame.contentFrame
	local bosses = o.instances[mOnWD_MainFrame.ItemFrame.selected][difficulty]

	iframe.difficulty = difficulty

	for i = 1,#iframe.Bosses do
		if iframe.Bosses[i] then
			iframe.Bosses[i]:Hide()
		end
	end

	for i = 1,#iframe.Items do
		if iframe.Items[i] then
			iframe.Items[i]:Hide()
		end
	end

	local i = 1
	local top = 0

	local ordered_keys = {}

	if bosses == nil then
		return
	end

	for k in pairs(bosses) do
	    table.insert(ordered_keys, k)
	end
	table.sort(ordered_keys)


	local item = 1
	for i=1,#ordered_keys do
		if #bosses[ordered_keys[i]] > 0 then
			if iframe.Bosses[i] == nil then
				iframe.Bosses[i] = iframe:CreateFontString("mOnWD_ItemFrame_Boss" .. i,"OVERLAY","GameFontNormalLarge");
				iframe.Bosses[i]:SetWidth(400);
				iframe.Bosses[i]:SetHeight(0);
				iframe.Bosses[i]:SetJustifyH("LEFT");
			end
			iframe.Bosses[i]:SetText(ordered_keys[i])
			iframe.Bosses[i]:Show()
			iframe.Bosses[i]:SetPoint("TOPLEFT", iframe, "TOPLEFT", 25, top)
			top = top - 30

			local left = 0
			for j = 1,#bosses[ordered_keys[i]] do
				if left >= 12 then
					left = 0
					top = top - 40
				end
				local v = bosses[ordered_keys[i]][j]
				if iframe.Items[item] == nil then
					iframe.Items[item] = createItemSlot(iframe, item)
				end
				iframe.Items[item]:SetPoint("TOPLEFT", iframe, "TOPLEFT", 25 + left * 40, top)
				GetItemInfo(v.id)
				iframe.Items[item].texture:SetTexture(GetItemIcon(v.id))
				iframe.Items[item].ItemID = v.id;
				iframe.Items[item]:Show()
				left = left + 1
				item = item + 1
			end
			top = top - 40
		end
	end

	scrollbar:SetMinMaxValues(1, math.max(-top - mOnWD_MainFrame.ItemFrame:GetHeight() + 200, 2))
	scrollbar:SetValue(0)
end

local function clickDropdown(self)
	UIDropDownMenu_SetSelectedID(mOnWD_ItemFrame_DropDown, self:GetID())
	setDifficulty(self.value)
end

local function initDropdown(self, level)
	local i = 1
	for k, v in orderedPairs(o.instances[mOnWD_MainFrame.ItemFrame.selected]) do
		if string.sub(k, 1, 1) ~= '#' then
			if first == nil then
				first = k
			end
			local info = UIDropDownMenu_CreateInfo()
			info.text = k
			info.value = k
			info.func = clickDropdown
			mOnWD_MainFrame.ItemFrame.difficultyID[k] = i
			UIDropDownMenu_AddButton(info, level)
			i = i + 1
		end
	end
end

o.GUIshowItems = function(instance)
	if mOnWDSave.hideList then
		mOnWD_MainFrame.ItemFrame:SetParent(UIParent)
		mOnWD_MainFrame:Hide()
	else
		mOnWD_MainFrame.ItemFrame:SetParent(mOnWD_MainFrame)
		mOnWD_MainFrame.ItemFrame:ClearAllPoints()
		mOnWD_MainFrame.ItemFrame:SetPoint("LEFT", mOnWD_MainFrame, "RIGHT", 5, 0)
	end


	first = nil
	mOnWD_MainFrame.ItemFrame:Show()
	mOnWD_MainFrame.ItemFrame.title:SetText(instance)
	mOnWD_MainFrame.ItemFrame.selected = instance
	mOnWD_MainFrame.ItemFrame.difficultyID = {}
	UIDropDownMenu_Initialize(mOnWD_ItemFrame_DropDown, initDropdown)
	UIDropDownMenu_SetWidth(mOnWD_ItemFrame_DropDown, 100)
	UIDropDownMenu_SetButtonWidth(mOnWD_ItemFrame_DropDown, 124)
	UIDropDownMenu_SetSelectedID(mOnWD_ItemFrame_DropDown, 1)
	UIDropDownMenu_JustifyText(mOnWD_ItemFrame_DropDown, "LEFT")
	setDifficulty(first)
end

o.GUIcurrentInstance = function()
	local name, type, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, mapID = GetInstanceInfo()
	mOnWD_MainFrame.ItemFrame:Hide()
	local namesToTry = o.createInstanceNames(name)

	for i = 1,#namesToTry do
		local name = namesToTry[i]
		if o.instances[name] then
			o.GUIshowItems(name)
			if o.instances[name][difficultyName] then
				setDifficulty(difficultyName)
				UIDropDownMenu_SetSelectedID(mOnWD_ItemFrame_DropDown, mOnWD_MainFrame.ItemFrame.difficultyID[difficultyName])
			end
			return
		end
	end
end

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

local ff = CreateFrame("Frame", nil, f)
f.ItemFrame = ff;
ff:Hide()
ff:SetWidth(532)
ff:SetHeight(512)
ff:SetPoint("LEFT", f, "RIGHT", 5, 0)
local h = ff:CreateTexture(nil, "ARTWORK")
h:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
h:SetWidth(400)
h:SetHeight(68)
h:SetPoint("TOP", 0, 12)
ff:SetMovable(true);
ff:EnableMouse(true);
ff:SetClampedToScreen(true);
ff:RegisterForDrag("LeftButton");
ff:SetScript("OnDragStart", ff.StartMoving)
ff:SetScript("OnDragStop", ff.StopMovingOrSizing)
ff.HeaderTexture = h;
ff.title = ff:CreateFontString(nil, "ARTWORK", "GameFontNormal")
ff.title:SetPoint("TOP", h, "TOP", 0, -15)
ff.title:SetText("");
ff:SetBackdrop(
	{
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left=11, right=12, top=12, bottom=11 }
	})

local b = CreateFrame("BUTTON");
ff.bHide = b;
b:SetParent(ff);
b:SetWidth(32);
b:SetHeight(32);
b:SetFrameStrata("DIALOG")
b:SetPoint("BOTTOMLEFT",ff, "BOTTOMLEFT", 10, 10);
b:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up.bpl");
b:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down.bpl");
b:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled.bpl");
b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight.bpl","ADD");
b:SetScript("OnClick", function()
			ff:Hide()
			mOnWD_MainFrame:Show()
	end);

local fd = CreateFrame("Button", "mOnWD_ItemFrame_DropDown", ff, "UIDropDownMenuTemplate")
fd:ClearAllPoints()
fd:SetPoint("TOPLEFT", ff, "TOPLEFT", 10, 5)
fd:Show()


local scrollframe = CreateFrame("ScrollFrame", nil, ff)
scrollframe:SetPoint("TOPLEFT", 10, -40)
scrollframe:SetPoint("BOTTOMRIGHT", -10, 40)
ff.scrollframe = scrollframe

local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
scrollbar:SetPoint("TOPLEFT", ff, "TOPRIGHT", -30, -25)
scrollbar:SetPoint("BOTTOMLEFT", ff, "BOTTOMRIGHT", -30, 25)
scrollbar:SetMinMaxValues(1, 10000)
scrollbar:SetValueStep(1)
scrollbar.scrollStep = 1
scrollbar:SetValue(0)
scrollbar:SetWidth(16)
scrollbar:SetScript("OnValueChanged",
function(self, value)
	self:GetParent():SetVerticalScroll(value)
end)
ff.scrollbar = scrollbar

local content = CreateFrame("Frame", nil, scrollframe)
content:SetSize(128, 128)
scrollframe.content = content

ff.contentFrame = content

scrollframe:SetScrollChild(content)
ff.contentFrame.Bosses = {};
ff.contentFrame.Items = {};

ff:EnableMouseWheel(true)
ff:SetScript("OnMouseWheel", function(self, delta)
	scrollbar:SetValue(scrollbar:GetValue() - delta * 20)
end)

local b = CreateFrame("BUTTON","mOnWD_ItemFrame_bRefresh",ff,"UIPanelButtonTemplate");
ff.bRefresh = b;
b:SetPoint("TOPRIGHT", ff, "TOPRIGHT", -35, 5)
b:SetText(o.strings["Refresh Instance"])
b:SetHeight(25);
b:SetWidth(120);
b:SetScript("OnClick", function()
		o.refreshInstance(mOnWD_MainFrame.ItemFrame.selected)
		setDifficulty(mOnWD_MainFrame.ItemFrame.contentFrame.difficulty)
	end)
