
main		= dofile(_SourceFolder.."\\AutoPlay\\Scripts\\ui-ams\\ui-ams.lua")
description = "Framework UI Reworked";
version_ui 	= "0.3";



wit=Page.GetSize().Width
Theme = {};
function CreateUI()
conmenu = {X = 0,Y = 36,Alignment =ALIGN_CENTER,Width=Theme.menusize,Height=548};
tblParaProps = {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,Enabled = false,ResizeRight = true,FontName = "Segoe Ui",FontSize=12,Text = "AMSHub",X = 0,Y = 0,Alignment =ALIGN_CENTER,Width=cuadrant.Width,Height=cuadrant.Height,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "Paragraph2", tblParaProps);

if API.stability == "UNSTABLE" then
tblParaProps = {Enabled = false,ColorNormal = Math.HexColorToNumber("FF0000"),FontName = "Segoe Ui",FontSize=8,Text = l.st,X =10,Y = 5,Width=200,Height=32,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF};
Page.CreateObject(OBJECT_PARAGRAPH, "stability", tblParaProps);
end
if Theme.scroll then plus=Theme.scrollsize else plus=0 end
tblCon= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,Enabled = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "",X = conmenu.Width,Y = conmenu.Y,Alignment =ALIGN_CENTER,Width=wit-conmenu.Width,Height=577,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColorList)};
Page.CreateObject(OBJECT_PARAGRAPH, "Paragraph8", tblCon);
	
	
if Theme.scroll then
	
	
	tblImBar = {};
	tblImBar.ImageFile = _SourceFolder.."\\AutoPlay\\Images\\gris.png"
	tblImBar.Height = 70
	tblImBar.Width = Theme.scrollsize
	tblImBar.Visible = false
	tblImBar.ResizeRight = true
	tblImBar.ResizeLeft = true
	tblImBar.ResizeBottom = true
	tblImBar.X = tblCon.X+tblCon.Width-tblImBar.Width
	tblImBar.Y = tblCon.Y
	
	
	barProps = {};
	barProps.ButtonFile = "AutoPlay\\Buttons\\sld-white_b.btn";
	barProps.Width = Theme.scrollsize
	barProps.Visible = false
	barProps.Height = tblCon.Height;
	barProps.X = tblCon.X+tblCon.Width-barProps.Width
	barProps.Y = tblCon.Y;
	barProps.ResizeRight = true
	barProps.ResizeLeft = true
	barProps.ResizeBottom = true

	
	BarProps = {};
	BarProps.ButtonFile = "AutoPlay\\Buttons\\dark.btn";
	BarProps.Width = Theme.scrollsize
	BarProps.Height = 80;
	BarProps.Visible = false
	BarProps.ResizeRight = true
	BarProps.ResizeLeft = true
	BarProps.ResizeBottom = true
	BarProps.X = tblCon.X+tblCon.Width-BarProps.Width
	BarProps.Y = tblCon.Y;	
	
	
	Page.CreateObject(OBJECT_BUTTON, "Slider_Bar_chat", barProps);
	Page.CreateObject(OBJECT_IMAGE, "Slider_Prg_chat", tblImBar);
	Page.CreateObject(OBJECT_BUTTON, "Slider_Btn_chat", BarProps);
	lua_dostring(Scriptfg)
	
	

	
	chaton=false
	Page.SetObjectScript("Slider_Btn_chat", "On Click", 
	[[
	if (SliderEx.GetActiveAlias() == "Slider_chat") then
	nHandPos = SliderEx.GetSliderPos("Slider_chat")

	Paragraph.SetScrollPos("Paragraph8", 100-nHandPos, true);
	
	
	end
	]]);
	
	end


end
