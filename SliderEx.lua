HORIZONTAL = 0;
VERTICAL = 1;
_cSliderElementsList = nil;
_cSliderAliasList = nil;
_cActiveSliderName = nil;
_lEnter = false;
_cEnterName=nil;
_lClickSliderBtn = false;
_nMouseOffset = 0;

local function _SliderElementExist(cName)
	lExist = false;
	if (_cSliderElementsList and cName) then
		if string.find(_cSliderElementsList, cName..",", 1) ~= nil then	lExist = true; end
	end
	return lExist
end

local function _SliderAliasExist(cName)
	lExist = false;
	if (_cSliderAliasList and cName) then
		if string.find(_cSliderAliasList, cName..",", 1) ~= nil then lExist = true; end
	end
	return lExist
end

function _SliderList()
	_cSliderElementsList = "";
	_cSliderAliasList = "";
	local tObjects = Page.EnumerateObjects();
	if (tObjects) then
		for n, cObjectName in pairs(tObjects) do
			local lSliderElement = true;
			if (string.sub(cObjectName, 0,10) == "Slider_Bar" and Page.GetObjectType(cObjectName) == OBJECT_BUTTON) then
				_cSliderElementsList = _cSliderElementsList..cObjectName..",";
			elseif (string.sub(cObjectName, 0,10) == "Slider_Btn" and Page.GetObjectType(cObjectName) == OBJECT_BUTTON) then
				_cSliderElementsList = _cSliderElementsList..cObjectName..",";
			elseif (string.sub(cObjectName, 0,10) == "Slider_Prg" and Page.GetObjectType(cObjectName) == OBJECT_IMAGE) then
				_cSliderElementsList = _cSliderElementsList..cObjectName..",";
			else
				lSliderElement = false;
			end
			if (lSliderElement) then
				local cAlias = string.sub(cObjectName, 0,6)..String.Right(cObjectName, string.len(cObjectName) - 10);
				if (not _SliderAliasExist(cAlias)) then
					_cSliderAliasList = _cSliderAliasList..cAlias..",";
				end
			end
		end
		if (_cSliderElementsList == "") then _cSliderElementsList = nil; end
		if (_cSliderAliasList == "") then _cSliderAliasList = nil; end
	else
		_cSliderElementsList = nil;
		_cSliderAliasList = nil;
	end
end

local function MouseOnSlider(cSliderName)
	tMouseOnSlider = {Bar = nil, Btn = nil};
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;
		local tPrpsSliderBar = Button.GetProperties(cSliderBarName);
		local tPrpsSliderBtn = Button.GetProperties(cSliderBtnName);
		local nXBar0 = tPrpsSliderBar.X;
		local nXBar1 = tPrpsSliderBar.X + tPrpsSliderBar.Width;
		local nYBar0 = tPrpsSliderBar.Y;
		local nYBar1 = tPrpsSliderBar.Y + tPrpsSliderBar.Height;
		local nXBtn0 = tPrpsSliderBtn.X;
		local nXBtn1 = tPrpsSliderBtn.X + tPrpsSliderBtn.Width;
		local nYBtn0 = tPrpsSliderBtn.Y;
		local nYBtn1 = tPrpsSliderBtn.Y + tPrpsSliderBtn.Height;
		local m_pos = System.GetMousePosition(true);
		if (m_pos.X >= nXBtn0 and m_pos.X <= nXBtn1 and m_pos.Y >= nYBtn0 and m_pos.Y <= nYBtn1) then
			tMouseOnSlider.Bar = false;
			tMouseOnSlider.Btn = true;
		else
			if (m_pos.X >= nXBar0 and m_pos.X <= nXBar1 and m_pos.Y >= nYBar0 and m_pos.Y <= nYBar1) then
				tMouseOnSlider.Bar = true;
				tMouseOnSlider.Btn = false;
			end
		end
	end
	return tMouseOnSlider
end


local function SliderGetActiveAlias()
	cActiveAlias = "";
	if (_cActiveSliderName) then
		cActiveAlias = _cActiveSliderName;
	end
	return cActiveAlias
end


local function SliderGetAlias(cElementName)
	cAlias = "";
	if (_SliderAliasExist(cElementName)) then
		cAlias = cElementName;
	else
		if (_SliderElementExist(cElementName)) then
			cAlias = string.sub(cElementName, 0,6)..String.Right(cElementName, string.len(cElementName) - 10);
		else
			cAlias = "";
		end
	end
	return cAlias
end


local function SliderGetElementsName(cAlias)
	tElenents = {Bar = "", Btn = "", Prg = ""};
	local cElementName = "";
	if (_SliderElementExist(cAlias)) then
		cAlias = string.sub(cAlias, 0,6)..String.Right(cAlias, string.len(cAlias) - 10);
	end
	if (_SliderAliasExist(cAlias)) then
		local cPre = string.sub(cAlias, 0,6);
		local cSuf = String.Right(cAlias, string.len(cAlias)-6);
		cElementName = cPre.."_Bar"..cSuf;
		if (not _SliderElementExist(cElementName)) then
			tElenents = nil;
		else
			tElenents.Bar = cElementName;
			cElementName = cPre.."_Btn"..cSuf;
			if (not _SliderElementExist(cElementName)) then
				tElenents = nil;
			else
				tElenents.Btn = cElementName;
				cElementName = cPre.."_Prg"..cSuf;
				if (not _SliderElementExist(cElementName)) then
					tElenents.Prg = "";
				else
					tElenents.Prg = cElementName;
				end
			end
		end
	else
		tElenents = nil;
	end
	return tElenents
end


local function SliderGetLength(cSliderName)
	nLength = nil;
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local tPrpsSliderBar = Button.GetSize(cSliderBarName);
		local nOrientation = SliderEx.GetOrientation(cSliderName);
		if (nOrientation == HORIZONTAL) then
			nLength = tPrpsSliderBar.Width;
		else
			nLength = tPrpsSliderBar.Height;
		end
	else
		nLength = nil;
	end
	return nLength
end


local function SliderGetPos(cSliderName)
	tPos = nil;
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		tPos = Button.GetPos(cSliderBarName);
	else
		tPos = nil;
	end
	return tPos
end


local function SliderGetRange(cSliderName)
	tRange = {Start = 0, End = 0}
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local tProp = Button.GetProperties(cSliderBarName);
		local nOrientation = SliderEx.GetOrientation(cSliderName);
		if (nOrientation == HORIZONTAL) then
			tRange.Start = tProp.XOffset;
			tRange.End = tProp.YOffset;
		else
			tRange.Start = tProp.YOffset;
			tRange.End = tProp.XOffset;
		end
		if (tRange.Start ==	 tRange.End) then
			tRange.Start = 0;
			tRange.End = 100;
		end
	else
		tRange = nil;
	end
	return tRange
end


local function SliderGetSliderPos(cSliderName)
	nSliderPos = nil;
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;	
		local tPrpsSliderBar = Button.GetProperties(cSliderBarName);
		local tPrpsSliderBtn = Button.GetProperties(cSliderBtnName);
		local tRange = SliderEx.GetRange(cSliderName);
		local nOrientation = SliderEx.GetOrientation(cSliderName);
		if (nOrientation == HORIZONTAL) then
			local nOffset = tPrpsSliderBtn.X - tPrpsSliderBar.X;
			nOffsetRange = nOffset * (tRange.End - tRange.Start) / (tPrpsSliderBar.Width - tPrpsSliderBtn.Width);
		else
			local nOffset = tPrpsSliderBar.Y + tPrpsSliderBar.Height - tPrpsSliderBtn.Y - tPrpsSliderBtn.Height;
			nOffsetRange = nOffset * (tRange.End - tRange.Start) / (tPrpsSliderBar.Height - tPrpsSliderBtn.Height);
		end
		nSliderPos = tRange.Start + nOffsetRange;
	else
		nSliderPos = nil;
	end
	return math.floor(nSliderPos)
end


local function SliderGetSize(cSliderName)
	tSize = nil;
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		tSize = Button.GetSize(cSliderBarName);
	else
		tSize = nil;
	end
	return tSize
end


local function SliderGetOrientation(cSliderName)
	nOrientation = nil;
	local tSize = SliderEx.GetSize(cSliderName);
	if (tSize) then
		if (tSize.Width >= tSize.Height) then
			nOrientation = HORIZONTAL;
		else
			nOrientation = VERTICAL;
		end
	end
	return nOrientation
end





local function SliderSetPos(cSliderName, X, Y)

	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;
		local cSliderPrgName = tElementsName.Prg;
		local tPos = Button.GetPos(cSliderBarName);
		local nXOffset = X - tPos.X;
		local nYOffset = Y - tPos.Y;
		tPos = Button.GetPos(cSliderBtnName);
		Button.SetPos(cSliderBarName, X, Y);
		Button.SetPos(cSliderBtnName, tPos.X + nXOffset, tPos.Y + nYOffset);
		if (cSliderPrgName ~= "") then
			tPos = Image.GetPos(cSliderPrgName);
			Image.SetPos(cSliderPrgName, tPos.X + nXOffset, tPos.Y + nYOffset);
		end
		Page.ClickObject(cSliderBtnName);
	end
end

local function SliderSetRange(cSliderName, Start, End)
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;
		local nOrientation = SliderEx.GetOrientation(cSliderName);
		if (Start ==  End) then
			Start = 0;
			End = 100;
		end
		if (nOrientation == HORIZONTAL) then
			tProp = {XOffset = Start, YOffset = End}
		else
			tProp = {XOffset = End, YOffset = Start}
		end
		Button.SetProperties(cSliderBarName, tProp);
		Page.ClickObject(cSliderBtnName);
	end
end

local function SliderSetSliderPos(cSliderName, Position)
if DialogEx.GetWndHandle() == -1 then
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;
		local cSliderPrgName = tElementsName.Prg;

		local tRange = SliderEx.GetRange(cSliderName);
		local tPrpsSliderBar = Button.GetProperties(cSliderBarName);
		local tPrpsSliderBtn = Button.GetProperties(cSliderBtnName);	
		local nOrientation = SliderEx.GetOrientation(cSliderName);
		if (tRange.Start == tRange.End) then
			if (tRange.End == 0) then
				SliderEx.SetRange(cSliderName, 0, 100);
			else
				SliderEx.SetRange(cSliderName, 0, tRange.End);
			end
			tRange = SliderEx.GetRange(cSliderName);
		end
		if (tRange.Start < tRange.End) then
			if (Position < tRange.Start) then Position = tRange.Start; end
			if (Position > tRange.End) then Position = tRange.End; end
		elseif (tRange.Start > tRange.End) then
			if (Position > tRange.Start) then Position = tRange.Start; end
			if (Position < tRange.End) then Position = tRange.End; end
		end
		local nOffsetRange = Position - tRange.Start;

		
		
		if (nOrientation == HORIZONTAL) then
			if (tPrpsSliderBar.Width > tPrpsSliderBtn.Width) then
				local nX = tPrpsSliderBar.X + (nOffsetRange * (tPrpsSliderBar.Width - tPrpsSliderBtn.Width) / (tRange.End - tRange.Start));	-- ????? ???????
				Button.SetPos(cSliderBtnName, Math.Round(nX, 0), tPrpsSliderBtn.Y);
			end
		else
			if (tPrpsSliderBar.Height > tPrpsSliderBtn.Height) then
				local nY = tPrpsSliderBar.Y + tPrpsSliderBar.Height - tPrpsSliderBtn.Height - ((nOffsetRange * (tPrpsSliderBar.Height - tPrpsSliderBtn.Height) / (tRange.End - tRange.Start)));	-- ????? ???????
				Button.SetPos(cSliderBtnName, tPrpsSliderBtn.X, Math.Round(nY, 0));
			end
		end
		Page.ClickObject(cSliderBtnName);
	end
	end
end



SliderEx = {
	GetActiveAlias	= SliderGetActiveAlias,
	GetAlias		= SliderGetAlias,
	GetElementsName	= SliderGetElementsName,
	GetLength		= SliderGetLength,
	GetOrientation	= SliderGetOrientation,
	GetPos			= SliderGetPos,
	GetRange		= SliderGetRange,
	GetSliderPos	= SliderGetSliderPos,
	GetSize			= SliderGetSize,
	IsEnabled		= SliderIsEnabled,
	IsVisible		= SliderIsVisible,
	SetEnabled		= SliderSetEnabled,
	SetLength		= SliderSetLength,
	SetPos			= SliderSetPos,
	SetRange		= SliderSetRange,
	SetSliderPos	= SliderSetSliderPos,
	SetVisible		= SliderSetVisible
}

function MouseButton(m_Type, m_X, m_Y)
	if (System.IsKeyDown(1) and not _cActiveSliderName) then
		if (_lEnter and _cEnterName) then
			local tElementsName = SliderEx.GetElementsName(_cEnterName);
			if (tElementsName) then
				local cSliderBarName = tElementsName.Bar;
				local cSliderBtnName = tElementsName.Btn;
				local cSliderPrgName = tElementsName.Prg;
				local tPrpsSliderBar = Button.GetProperties(cSliderBarName);
				local tPrpsSliderBtn = Button.GetProperties(cSliderBtnName);	
				local m_pos = System.GetMousePosition(true);
				local tMouseOnSlider = MouseOnSlider(_cEnterName);
			
			tImgPrps=Image.GetProperties(cSliderPrgName);
			if (nOrientation == HORIZONTAL) then
				Image.SetSize(cSliderPrgName, tPrpsSliderBtn.X - tImgPrps.X + tPrpsSliderBtn.Width/2, tImgPrps.Height);
			else
				Image.SetSize(cSliderPrgName, tImgPrps.Width, tPrpsSliderBtn.Y - tImgPrps.Y + tPrpsSliderBtn.Height/2);
			end
				
				if (tMouseOnSlider.Btn) then
					_lClickSliderBtn = true;
					_cActiveSliderName = _cEnterName;
					local nOrientation = SliderEx.GetOrientation(_cActiveSliderName);
					if (nOrientation == HORIZONTAL) then
						_nMouseOffset = m_X - tPrpsSliderBtn.X;
					else
						_nMouseOffset = m_Y - tPrpsSliderBtn.Y;
					end
					Page.ClickObject(cSliderBtnName);
				elseif (tMouseOnSlider.Bar) then
					_cActiveSliderName = _cEnterName;
					local nOrientation = SliderEx.GetOrientation(_cActiveSliderName);
					if (nOrientation == HORIZONTAL) then
						if (tPrpsSliderBar.Width > tPrpsSliderBtn.Width) then
							local nX = m_pos.X - tPrpsSliderBtn.Width / 2;
							if (nX < tPrpsSliderBar.X) then
								nX = tPrpsSliderBar.X;
							elseif (nX > tPrpsSliderBar.X + tPrpsSliderBar.Width - tPrpsSliderBtn.Width) then
								nX = tPrpsSliderBar.X + tPrpsSliderBar.Width - tPrpsSliderBtn.Width;
							end
							Button.SetPos(cSliderBtnName, nX, tPrpsSliderBtn.Y);
						end
					else
						if (tPrpsSliderBar.Height > tPrpsSliderBtn.Height) then
							local nY = m_pos.Y - tPrpsSliderBtn.Height / 2;
							if (nY < tPrpsSliderBar.Y) then
								nY = tPrpsSliderBar.Y;
							elseif (nY > tPrpsSliderBar.Y + tPrpsSliderBar.Height - tPrpsSliderBtn.Height) then
								nY = tPrpsSliderBar.Y + tPrpsSliderBar.Height - tPrpsSliderBtn.Height;
							end
							Button.SetPos(cSliderBtnName, tPrpsSliderBtn.X, nY);
						end
					end
					Page.ClickObject(cSliderBtnName);
				end
			end
		end
	else
		_lClickSliderBtn = false;
		_cActiveSliderName = nil;
	end
end

function MouseMove(m_X, m_Y)
	if _lClickSliderBtn and _cActiveSliderName and System.IsKeyDown(1) then
		local tElementsName = SliderEx.GetElementsName(_cActiveSliderName);
		if (tElementsName) then
			local cSliderBtnName = tElementsName.Btn;
			local cSliderBarName = tElementsName.Bar;
			local cSliderPrgName = tElementsName.Prg;
			local tPos = SliderEx.GetPos(_cActiveSliderName);
			local tPrpsSliderBar = Button.GetProperties(cSliderBarName);
			local tPrpsSliderBtn = Button.GetProperties(cSliderBtnName);
			local nLen = SliderEx.GetLength(_cActiveSliderName);
			local nOrientation = SliderEx.GetOrientation(_cActiveSliderName);
			tImgPrps=Image.GetProperties(cSliderPrgName);

			
			if (nOrientation == HORIZONTAL) then
			Image.SetSize(cSliderPrgName, tPrpsSliderBtn.X - tImgPrps.X + tPrpsSliderBtn.Width/2, tImgPrps.Height);
				if (tPrpsSliderBar.Width > tPrpsSliderBtn.Width) then
					local nStart = tPos.X;
					local nEnd = tPos.X + nLen - tPrpsSliderBtn.Width;
					if (m_X - _nMouseOffset <= nStart) then
						Button.SetPos(cSliderBtnName, nStart , tPrpsSliderBtn.Y);
					elseif (m_X - _nMouseOffset >= nEnd) then
						Button.SetPos(cSliderBtnName, nEnd , tPrpsSliderBtn.Y);
					else
						Button.SetPos(cSliderBtnName, m_X - _nMouseOffset, tPrpsSliderBtn.Y);
					end
				end
			else
			Image.SetSize(cSliderPrgName, tImgPrps.Width, tPrpsSliderBtn.Y - tImgPrps.Y + tPrpsSliderBtn.Height/2);
				if (tPrpsSliderBar.Height > tPrpsSliderBtn.Height) then
					local nStart = tPos.Y;
					local nEnd = tPos.Y + nLen - tPrpsSliderBtn.Height;
					if (m_Y - _nMouseOffset <= nStart) then
						Button.SetPos(cSliderBtnName, tPrpsSliderBtn.X, nStart);
					elseif (m_Y - _nMouseOffset >= nEnd) then
						Button.SetPos(cSliderBtnName, tPrpsSliderBtn.X, nEnd);
					else
						Button.SetPos(cSliderBtnName, tPrpsSliderBtn.X, m_Y - _nMouseOffset);
					end
				end
			end
			Page.ClickObject(cSliderBtnName);
		end
	else
		_lClickSliderBtn = false;
		_cActiveSliderName = nil;
	end
end

function OnEnter(cSliderName)
	_lEnter = true;
	_cEnterName=SliderEx.GetAlias(cSliderName);
end

function OnLeave(cSliderName)
	local tMouseOnSlider = MouseOnSlider(_cEnterName);
	if (tMouseOnSlider.Bar or tMouseOnSlider.Btn) then
		_lEnter = true;
		_cEnterName = SliderEx.GetAlias(cSliderName);
	else
		_lEnter = false;
		_cEnterName = nil;
	end
end

function OnClick(cSliderName)
	local tElementsName = SliderEx.GetElementsName(cSliderName);
	if (tElementsName) then
		local cSliderBarName = tElementsName.Bar;
		local cSliderBtnName = tElementsName.Btn;
		local cSliderPrgName = tElementsName.Prg;
		if (cSliderPrgName ~= "") then
			local tImgPrps = Image.GetProperties(cSliderPrgName);
			local tBarPrps = Button.GetProperties(cSliderBarName);
			local tBtnPrps = Button.GetProperties(cSliderBtnName);
			local nOrientation = SliderEx.GetOrientation(cSliderName);
			if (nOrientation == HORIZONTAL) then
				Image.SetSize(cSliderPrgName, tBtnPrps.X - tImgPrps.X + tBtnPrps.Width/2, tImgPrps.Height);
			else
				Image.SetSize(cSliderPrgName, tImgPrps.Width, tBtnPrps.Y - tImgPrps.Y + tBtnPrps.Height/2);
			end
		end
	end
	e_Pos = SliderEx.GetSliderPos(cSliderName);
	return e_Pos
end

function SliderEvents()
	local tObjects = Page.EnumerateObjects();
	if (tObjects) then
		for n, cObjectName in pairs(tObjects) do
			if (string.sub(cObjectName, 0,10) == "Slider_Btn") or (string.sub(cObjectName, 0,10) == "Slider_Prg") or (string.sub(cObjectName, 0,10) == "Slider_Bar") then
					local Script = Page.GetObjectScript(cObjectName, "On Enter");
					Script = "OnEnter(this);\r\n"..Script;
					Page.SetObjectScript(cObjectName, "On Enter", Script);

					local Script = Page.GetObjectScript(cObjectName, "On Leave");
					Script = "OnLeave(this);\r\n"..Script;
					Page.SetObjectScript(cObjectName, "On Leave", Script);

					local Script = Page.GetObjectScript(cObjectName, "On Click");
					Script = "OnClick(this);\r\n"..Script;
					Page.SetObjectScript(cObjectName, "On Click", Script);
			end
		end
	end
end

function PageEvents()
	tPagesName = Application.GetPages();
	for n, cPageName in pairs(tPagesName) do
		local Scriptg = Application.GetPageScript(cPageName, "On Preload");
		Scriptfg = "SliderEvents();\r\n_SliderList();\r\n"..Scriptg;
		Application.SetPageScript(cPageName, "On Preload", Scriptfg);
		Script = Application.GetPageScript(cPageName, "On Mouse Button");
		Script = "MouseButton(e_Type, e_X, e_Y);\r\n"..Script;
		Application.SetPageScript(cPageName, "On Mouse Button", Script);
		Script = Application.GetPageScript(cPageName, "On Mouse Move");
		Script = "MouseMove(e_X, e_Y);\r\n"..Script;
		Application.SetPageScript(cPageName, "On Mouse Move", Script);
	end
end

PageEvents();
