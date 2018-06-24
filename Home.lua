Home = {};
Home.description = "UI HOME";
Home.version = "0.1";



wit=Page.GetSize().Width



function Home.UI()
DragAndDrop.Start(Application.GetWndHandle())

tbllen= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "	"..l.actuallang..":"..API.lang,X = conmenu.Width+conmenu.Y,Y = conmenu.Y*2,Width=wit/2-conmenu.Width,Height=30,Alignment =ALIGN_LEFT,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_lenguage", tbllen);




gtp="\n\n\nDrag & Drop o click\n\n"..l.uploadable
tbllendG= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeLeft = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=11,Text = gtp,X = tbllen.X+tbllen.Width+conmenu.Y,Y = conmenu.Y*2,Alignment =ALIGN_CENTER,Width=wit/2-conmenu.Width,Height=170,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_TRANSPARENT};

tblesG = {ImageFile = "AutoPlay\\Images\\blurred_colors.jpg",X = tbllendG.X,Y = tbllendG.Y,Width=wit/2-conmenu.Width,Height=170,Opacity=100,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_blured", tblesG);

tblessG = {ImageFile = "AutoPlay\\Images\\drag.png",Width=24,Height=24,X = tbllendG.X+tbllendG.Width/2-12,Y = tbllendG.Y+30,Opacity=100,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_up", tblessG);


Page.CreateObject(OBJECT_PARAGRAPH, "home_upload", tbllendG);
Page.SetObjectScript("home_upload", "On Click", 'Page.ClickObject("notBtn_Upload")');




tblleRn= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "",X = tbllen.X,Y = tbllen.Y+40,Alignment =ALIGN_CENTER,Width=wit/2-conmenu.Width,Height=130,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_infopc", tblleRn);

tbles = {ImageFile = "AutoPlay\\Images\\flags\\spain.png",Height = 16,Width = 24,Y = tbllen.Y+5,X = tbllen.X+tbllen.Width/2,Opacity=60,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_spain", tbles);
tblen = {ImageFile = "AutoPlay\\Images\\flags\\english.png",Height = 16,Width = 24,Y = tbllen.Y+5,X = tbllen.X+tbllen.Width/2+30,Opacity=60,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_english", tblen);
Page.SetObjectScript("home_english", "On Click", "API.SetLenguage('EN')");
Page.SetObjectScript("home_spain", "On Click", "API.SetLenguage('ES')");






	Page.SetObjectScript("home_spain",  "On Enter", [[ONEL, IMG, vMINOPACIDAD = true, this, 60
	IMGOPACIDAD ()]]);
	Page.SetObjectScript("home_spain",  "On Leave", [[ONEL, IMG, vMINOPACIDAD = false, this, 60
	IMGOPACIDAD ()]]);
	
	Page.SetObjectScript("home_english",  "On Enter", [[ONEL, IMG, vMINOPACIDAD = true, this, 60
	IMGOPACIDAD ()]]);
	Page.SetObjectScript("home_english",  "On Leave", [[ONEL, IMG, vMINOPACIDAD = false, this, 60
	IMGOPACIDAD ()]]);

tbllenff= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeRight = true,Enabled = true,FontName = "Segoe Ui",FontSize=9,Text = "CHANGELOG",X = conmenu.Width+conmenu.Y,Y = conmenu.Y*3+tbllendG.Height,Alignment =ALIGN_CENTER,Width=tbllendG.Width+tbllendG.Width+conmenu.Y,Height=tbllendG.Height*1.6,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_changes", tbllenff);







if System.Is64BitOS() then
Arch = "64";
else
Arch = "32"; 
end
Processor = Registry.GetValue(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0", "ProcessorNameString", true);

Usuario = System.GetUserInfo();
lua=l.pcinfo.."\n\n"..l.arch..":"..Arch.." Bits\r"..l.Proc..":"..Processor.."\n"..l.ram..": "..System.GetMemoryInfo().TotalRAM.." MB\n"..l.cred..":Guanj,Cigx"


Paragraph.SetText("home_infopc",lua);





tpt="CHANGELOG\nUI "..version_ui .." APP "..API.version.." - "..API.stability.."\n\n"..l.news.."\n"..changelog
Paragraph.SetText("home_changes", tpt);
end

function Home.Close()
DragAndDrop.Stop (Application.GetWndHandle())
API.DeleteAllObjects("home_")
end