Home = {};
Home.description = "UI HOME";
Home.version = "0.1";



wit=Page.GetSize().Width



function Home.UI()

tbllen= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "	LENGUAGES",X = conmenu.Width+conmenu.Y,Y = conmenu.Y*2,Alignment =ALIGN_LEFT,Width=wit/2-conmenu.Width,Height=30,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_lenguage", tbllen);




tbllend= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "ESTADISTICAS",X = tbllen.X+tbllen.Width+conmenu.Y,Y = conmenu.Y*2,Alignment =ALIGN_CENTER,Width=wit/2-conmenu.Width,Height=170,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_stadistics", tbllend);


tblleRn= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "INFO PC",X = tbllen.X,Y = tbllen.Y+40,Alignment =ALIGN_CENTER,Width=wit/2-conmenu.Width,Height=130,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_infopc", tblleRn);

tbles = {ImageFile = "AutoPlay\\Images\\flags\\spain.png",Height = 16,Width = 24,Y = tbllen.Y+5,X = tbllen.X+tbllen.Width/2,Opacity=60,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_english", tbles);
tblen = {ImageFile = "AutoPlay\\Images\\flags\\english.png",Height = 16,Width = 24,Y = tbllen.Y+5,X = tbllen.X+tbllen.Width/2+30,Opacity=60,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "home_spain", tblen);



	Page.SetObjectScript("home_spain",  "On Enter", [[ONEL, IMG, vMINOPACIDAD = true, this, 60
	IMGOPACIDAD ()]]);
	Page.SetObjectScript("home_spain",  "On Leave", [[ONEL, IMG, vMINOPACIDAD = false, this, 60
	IMGOPACIDAD ()]]);
	
		Page.SetObjectScript("home_english",  "On Enter", [[ONEL, IMG, vMINOPACIDAD = true, this, 60
	IMGOPACIDAD ()]]);
	Page.SetObjectScript("home_english",  "On Leave", [[ONEL, IMG, vMINOPACIDAD = false, this, 60
	IMGOPACIDAD ()]]);

tbllenff= {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,ResizeRight = true,Enabled = true,FontName = "Segoe Ui",FontSize=9,Text = "CHANGELOG",X = conmenu.Width+conmenu.Y,Y = conmenu.Y*3+tbllend.Height,Alignment =ALIGN_CENTER,Width=tbllend.Width+tbllend.Width+conmenu.Y,Height=tbllend.Height*1.6,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "home_changes", tbllenff);







if System.Is64BitOS() then
Arch = "64";
else
Arch = "32"; 
end
Processor = Registry.GetValue(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0", "ProcessorNameString", true);

Usuario = System.GetUserInfo();

lua="INFO PC\n\nArquitectura:"..Arch.." Bits\rProccesador:"..Processor.."\n".."Memoria RAM: "..System.GetMemoryInfo().TotalRAM.." MB\nCreditos:Guanj,Cigx"


Paragraph.SetText("home_infopc",lua);







tpt="CHANGELOG\nUI "..version_ui .." APP "..API.version.." - "..API.stability.."\n\n\n"..http.request(changelog)
Paragraph.SetText("home_changes", tpt);
end

function Home.Close()
API.DeleteAllObjects("home_")
end