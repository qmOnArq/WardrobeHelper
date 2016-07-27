local o = mOnWardrobe

---------------------------------------------------------------
--  Initialization
---------------------------------------------------------------

o.CURRENT_PAGE = 1

---------------------------------------------------------------
--  Create UI
---------------------------------------------------------------

mOnWD_MainFrame = CreateFrame("FRAME","mOnWD_MainFrame",UIParent,"ButtonFrameTemplate");
mOnWD_MainFrameTitleText:SetText("mOnAr's Wardrobe Helper (v" .. o.version .. ")");
local f = mOnWD_MainFrame;
f:SetHeight(512);
f:SetWidth(384);
f:Hide();
tinsert(UISpecialFrames,"mOnWD_MainFrame");
f:SetFrameStrata("high");
f:SetPoint("CENTER",0,0);
f:SetMovable(true);
f:EnableMouse(true);
f:SetClampedToScreen(true);
f:RegisterForDrag("LeftButton");
f:SetScript("OnDragStart", f.StartMoving)
f:SetScript("OnDragStop", f.StopMovingOrSizing)
SetPortraitToTexture(mOnWD_MainFramePortrait, "Interface\\FriendsFrame\\FriendsFrameScrollIcon");

local f=CreateFrame("FRAME",nil,mOnWD_MainFrame);
mOnWD_MainFrame.ListFrame = f;
f:SetHeight(512);
f:SetWidth(384);
f:EnableMouse(false);
f:SetAllPoints(mOnWD_MainFrame);

local b = CreateFrame("BUTTON","mOnWD_MainFrame_bRefresh",f,"UIPanelButtonTemplate");
f.bRefresh = b;
b:SetPoint("TOPRIGHT",-10,-35);
b:SetText(o.strings["Refresh Items"])
b:SetHeight(25);
b:SetWidth(120);
b:SetScript("OnClick", function()
	StaticPopup_Show ("MONWD_CONFIRMATION")
	end)

local b = CreateFrame("BUTTON","mOnWD_MainFrame_bCurrentInstance",f,"UIPanelButtonTemplate");
f.bInstance = b;
b:SetPoint("RIGHT", mOnWD_MainFrame_bRefresh, "LEFT", -10, 0);
b:SetText(o.strings["Current Instance"])
b:SetHeight(25);
b:SetWidth(120);
b:SetScript("OnClick", function()
		o.GUIcurrentInstance()
	end)

local b = CreateFrame("BUTTON","mOnWD_MainFrame_bOptions",f,"UIPanelButtonTemplate");
	f.bOptions = b;
	b:SetPoint("RIGHT", mOnWD_MainFrame_bCurrentInstance, "LEFT", -10, 0);
	b:SetText(o.strings["Options"])
	b:SetHeight(25);
	b:SetWidth(60);
	b:SetScript("OnClick", function()
			o.GUIshowOptions()
		end)

local ff = CreateFrame("FRAME",nil,f);
ff:Show();
f.RowFrame = ff;
ff:SetPoint("TOPLEFT",8,-94);
ff:SetWidth(367);
ff:SetHeight(390);

local st = ff:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
st:SetHeight(380)
st:SetWidth(300)
st:SetJustifyH("CENTER")
st:SetPoint("TOP", ff, "TOP", 0, -10)
st:SetText(string.format(o.strings["Click Refresh Info"], o.strings["Refresh Items"]));
st:Hide();
local filename, fontHeight, flags = st:GetFont()
st:SetFont(filename, 20, "")
f.info = st;

local t = ff:CreateTexture(nil, "BACKGROUND");
ff.BG = t;
t:SetColorTexture(0,0,0,0.4);
t:SetAllPoints(ff);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColL1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("TOPLEFT",6,-70);
t:SetTexCoord(0,0.078125,0,0.75);
t:SetWidth(5);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColM1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColL1,"RIGHT");
t:SetTexCoord(0.078125,0.90625,0,0.75);
t:SetWidth(120);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColR1 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColM1,"RIGHT");
t:SetTexCoord(0.90625,0.96875,0,0.75);
t:SetWidth(4);
t:SetHeight(24);

local fs = f:CreateFontString(nil, "ARTWORK","GameFontNormalSmall");
f.ColT1 = fs;
fs:SetText(o.strings["Progress"]);
fs:SetPoint("LEFT",f.ColL1, 10, 0);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColL2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("Left",f.ColR1,10,0);
t:SetTexCoord(0,0.078125,0,0.75);
t:SetWidth(5);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColM2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColL2,"RIGHT");
t:SetTexCoord(0.078125,0.90625,0,0.75);
t:SetWidth(220);
t:SetHeight(24);

local t = f:CreateTexture(nil, "ARTWORK");
f.ColR2 = t;
t:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
t:SetPoint("LEFT",f.ColM2,"RIGHT");
t:SetTexCoord(0.90625,0.96875,0,0.75);
t:SetWidth(4);
t:SetHeight(24);

local fs = f:CreateFontString(nil, "ARTWORK","GameFontNormalSmall");
f.ColT2 = fs;
fs:SetText(o.strings["Instance"]);
fs:SetPoint("LEFT",f.ColL2, 10, 0);

local function CreateTableRow(parent, rowHeight, N)
  local row = CreateFrame("Button", nil, parent)
  row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
	row.id = N;
  row:SetHeight(rowHeight)
  row:SetPoint("LEFT")
  row:SetPoint("RIGHT", parent, "RIGHT", -16, 0)
	row:SetScript("OnClick", function()
			o.GUIselect(row.text2:GetText())
		end);

	local c = CreateFrame("StatusBar", nil, row)
	c:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	c:GetStatusBarTexture():SetHorizTile(false)
	c:SetMinMaxValues(0, 100)
	c:SetValue(100)
	c:SetWidth(100)
	c:SetHeight(10)
	c:SetPoint("LEFT",row,"LEFT", 10, 0)
	c:SetStatusBarColor(0,1,0)
	row.status = c

  local c = c:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  c:SetHeight(rowHeight)
  c:SetWidth(110 - (2 * 10))
  c:SetJustifyH("LEFT")
  c:SetPoint("LEFT", row, "LEFT", 20, 0)
	c:SetText('');
	local filename, fontHeight, flags = c:GetFont()
	c:SetFont(filename, fontHeight, "OUTLINE")
	row.text1 = c;

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  c:SetHeight(rowHeight)
  c:SetWidth(220 - (2 * 10))
  c:SetJustifyH("LEFT")
  c:SetPoint("LEFT", row.text1, "RIGHT", 2 * 10, 0)
	c:SetText('');
	row.text2 = c;

	local c = row:CreateTexture(nil, "ARTWORK");
	c:SetTexture("Interface\\FriendsFrame\\StatusIcon-DnD")
	c:SetWidth(16);
	c:SetHeight(16);
	c:SetPoint("RIGHT", row.text2, "LEFT", -2,0);
	c:Hide()
	row.saved = c;

	local c = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  c:SetHeight(rowHeight)
  c:SetWidth(100)
  c:SetJustifyH("RIGHT")
  c:SetPoint("RIGHT", row, "RIGHT", -10, 0)
	c:SetText('');
	row.percent = c;

  return row
end

local fontHeight = select(2, GameFontNormalSmall:GetFont())
local rowHeight = fontHeight + 4
local numRows = math.floor(ff:GetHeight() / rowHeight)
ff.rowHeight = rowHeight
ff.numRows = numRows;
ff.rows = {}

for i=1,numRows do
	local r = CreateTableRow(ff, rowHeight, i)
	if #ff.rows == 0 then
		r:SetPoint("TOP")
	else
		r:SetPoint("TOP", ff.rows[#ff.rows], "BOTTOM")
	end
	table.insert(ff.rows, r)
end

f:EnableMouseWheel(true)
f:SetScript("OnMouseWheel", function(self, delta)
	if o.CURRENT_PAGE - delta > 0 and o.CURRENT_PAGE - delta < #o.menuItems + 1 then
		f.scrollbar:SetValue(o.CURRENT_PAGE - delta)
	end
end)

local scrollbar = CreateFrame("Slider", nil, ff, "UIPanelScrollBarTemplate")
scrollbar:SetPoint("TOPRIGHT", ff, "TOPRIGHT", 0, 10)
scrollbar:SetPoint("BOTTOMRIGHT", ff, "BOTTOMRIGHT", 0, 16)
scrollbar:SetMinMaxValues(1, 1)
scrollbar:SetValueStep(1)
scrollbar.scrollStep = 1
scrollbar:SetWidth(16)
scrollbar:SetScript("OnValueChanged", function(self, value)
	o.GUIpagingHelper(math.floor(value + 0.5))
end)
f.scrollbar = scrollbar

local c = scrollbar:CreateTexture(nil, "BACKGROUND");
c:SetColorTexture(0,0,0,0.8)
c:SetAllPoints(scrollbar);
scrollbar.background = c;

local n = CreateFrame("CheckButton", "mOnWD_hideList", mOnWD_MainFrame, "ChatConfigCheckButtonTemplate")
mOnWD_MainFrame.hideList = n
n:SetPoint("BOTTOMLEFT", mOnWD_MainFrame, 5, 2)
mOnWD_hideListText:SetText(o.strings["Hide List Option"])
n:SetScript("OnClick", function()
		if n:GetChecked() then
			mOnWDSave.hideList = true
		else
			mOnWDSave.hideList = false
		end
	end);

StaticPopupDialogs["MONWD_CONFIRMATION"] = {
  text = o.strings["Refresh Confirmation"],
  button1 = o.strings["Yes"],
  button2 = o.strings["No"],
  OnAccept = function()
		if mOnWD_MainFrame.ItemFrame then
			mOnWD_MainFrame.ItemFrame:Hide()
		end
		o.updateMissingVisuals()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,
}

---------------------------------------------------------------
--  Methods
---------------------------------------------------------------

local function everythingNeededExists(i)
	return mOnWD_MainFrame and mOnWD_MainFrame.ListFrame and mOnWD_MainFrame.ListFrame.RowFrame and mOnWD_MainFrame.ListFrame.RowFrame.rows and
		mOnWD_MainFrame.ListFrame.RowFrame.rows[i] and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1 and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2
		and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent
		and mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status
end

o.GUIpagingHelper = function(N)
	if o.loaded == false then
		mOnWD_MainFrame.ListFrame.info:Show()
	else
		mOnWD_MainFrame.ListFrame.info:Hide()
	end

	local numRows = mOnWD_MainFrame.ListFrame.RowFrame.numRows

	o.CURRENT_PAGE = N;

	o.updateSavedInstances()

	if mOnWDSave.disableProgress then
		mOnWD_MainFrame.ListFrame.ColT1:SetText(o.strings["Missing Items"])
	else
		mOnWD_MainFrame.ListFrame.ColT1:SetText(o.strings["Progress"])
	end

	local FirstN = N - 1
	for i=1,numRows do
		if everythingNeededExists(i) then
			if mOnWDSave.disableProgress then
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:Hide();
			else
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:Show();
			end
			local index = i+FirstN
			if o.menuItems[index]~=nil then
				local item = o.menuItems[index]
				if item.category then
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i]:Disable();
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetText("");
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetText("");
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetTextColor(1,0.2,0.2,1)
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved:Hide()
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status:Hide()
				else
					local total = o.instances[item.name]['#total']
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i]:Enable();
					if mOnWDSave.disableProgress then
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetText(total);
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status:SetValue(0)
					else
						local missing = o.instances[item.name]['#collected']
						local percent = math.floor((missing / total * 100) + 0.5)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetText(missing .. " / " .. total);
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetText(percent .. "%");
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status:SetValue(percent)
					end
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status:Show()
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetTextColor(1,1,1,1)
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetTextColor(1,1,1,1)
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetTextColor(1,1,1,1)
					if item.type == "Raid" then
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetTextColor(1,1,0.6,1)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetTextColor(1,1,0.6,1)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetTextColor(1,1,0.6,1)
					elseif item.type == '#done' then
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetTextColor(1,1,1,0.6)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetTextColor(1,1,1,0.6)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetTextColor(1,1,1,0.6)
						mOnWD_MainFrame.ListFrame.RowFrame.rows[i]:Disable();
					end
				end
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetText(item.name);
				if o.saves[item.name] then
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved:Show()
				else
					mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved:Hide()
				end
			else
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text1:SetText("");
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].text2:SetText("");
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].percent:SetText("");
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i]:Disable();
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].saved:Hide()
				mOnWD_MainFrame.ListFrame.RowFrame.rows[i].status:Hide()
			end
		end
	end
end

o.GUImainPage = function(N)
	local numRows = mOnWD_MainFrame.ListFrame.RowFrame.numRows
	mOnWD_MainFrame.ListFrame.scrollbar:SetMinMaxValues(1, math.max(#o.menuItems - numRows + 1, 1))
	mOnWD_MainFrame.ListFrame.scrollbar:SetValue(N)
	o.GUIpagingHelper(N)
end

o.GUIselect = function(instance)
	o.GUIshowItems(instance)
end

local function compMenuItemsDefault(a, b)
	if a.index == b.index then
		return a.name < b.name
	else
		return a.index < b.index
	end
end

o.createMenuItems = function()
	o.menuItems = {}

	for i = 1,#o.EXPS do
		local tmp = {}
		tmp.name = o.EXPS[i]
		tmp.category = true
		tmp.index = i
		table.insert(o.menuItems, tmp)
		local tmp = {}
		tmp.name = ""
		tmp.category = true
		tmp.index = i + 0.9
		table.insert(o.menuItems, tmp)
	end

	local i = #o.EXPS + 1
	local tmp = {}
	tmp.name = "Special"
	tmp.category = true
	tmp.index = i
	table.insert(o.menuItems, tmp)
	local tmp = {}
	tmp.name = ""
	tmp.category = true
	tmp.index = i + 0.9
	table.insert(o.menuItems, tmp)

	local i = #o.EXPS + 2
	local tmp = {}
	tmp.name = "Unknown"
	tmp.category = true
	tmp.index = i
	table.insert(o.menuItems, tmp)
	local tmp = {}
	tmp.name = ""
	tmp.category = true
	tmp.index = i + 0.9
	table.insert(o.menuItems, tmp)

	for k, v in orderedPairs(o.instances) do
		local tmp = {}
		local type = 1
		tmp.name = k
		if o.categorization[k] then
			tmp.type = o.PARTY[o.categorization[k][2]]
			type = o.categorization[k][2]
			if(v['#collected'] >= v['#total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = o.categorization[k][1] + (type / 10)
		elseif o.SPECIAL[k] then
			if(v['#collected'] >= v['#total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = (#o.EXPS + 1) + (type / 10)
		else
			if(v['#collected'] >= v['#total']) then
				tmp.type = "#done"
				type = 3
			end
			tmp.index = (#o.EXPS + 1) + (type / 10)
		end
		table.insert(o.menuItems, tmp)
	end

	table.sort(o.menuItems, compMenuItemsDefault)
end
