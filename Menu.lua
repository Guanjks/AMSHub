Menu = {};
menuf=_SourceFolder.."\\AutoPlay\\Docs\\caches\\central\\MENU-CACHE"
function Menu.GetMenu()
if con then
CheckVersionFile(menuf,host.."AMSHub/caches/central/MENU-CACHE")
end
end

--SETTINGS
SIZEpWidth=conmenu.Width
SIZEpHeight=28
POSFXe=conmenu.X
POSFYe=conmenu.Y-SIZEpHeight
WidthIco=16
HeightIco=16


function Menu.CreateBtn(x, y, caption, b,enabled, submenu, functio)


	-- common properties	
	btnProps = {};
	btnProps.X = x;
	btnProps.Y = y;
	btnProps.Alignment = ALIGN_CENTER;
	btnProps.ButtonFile = "AutoPlay\\Buttons\\menu.btn";
	btnProps.FontName = "Segoe Ui";
	btnProps.FontSize = 10;
	btnProps.ColorNormal = Math.HexColorToNumber(Theme.TextColor);
	btnProps.ColorHighlight = Math.HexColorToNumber(Theme.TextColor);
	btnProps.ColorDown = Math.HexColorToNumber(Theme.TextColor);
	btnProps.ColorDisabled = Math.HexColorToNumber("008bde");
	btnProps.Width = SIZEpWidth;
	btnProps.Height = SIZEpHeight;
	if SIZEpWidth > 50 then
	btnProps.Text = caption;
	else
	btnProps.Text = " ";
	end
	
	btnProps.Visible = true;
	btnProps.Enabled = enabled;

	Page.CreateObject(OBJECT_BUTTON, "notBtn_"..b, btnProps);
	-- Set scripts
	if functio == nil then functio = "f" end 
	Page.SetObjectScript("notBtn_"..b, "On Click", "Menu.Action('" .. caption .. "','" .. functio .. "')");
end


function Menu.CreateIcon(x, y, b,icon)
	if icon ~= nil then
	tblImageProps = {ImageFile = _SourceFolder.."\\AutoPlay\\Images\\"..Theme.Icons.."\\"..icon..".png",Height = HeightIco,Width = WidthIco,Y = y,X = x,Visible = true,Enabled=false};

	Page.CreateObject(OBJECT_IMAGE, "notBtn_"..b.."ICON", tblImageProps);
	end
end

function Menu.Action(b,functio)
if b == "Chat" then
Chat.Sesion(true)
else
Chat.Sesion(false)
end

if b == "Home" then
API.DeleteAllObjects("tienda_")
Home.UI()
else
if b ~= "Upload" and name ~= "CANCEL" or functio == "f" then
Home.Close()
end
end


if b == "Upload" then
API.UploadProyect()
end
if b == "Changelog" then
API.Changelog()
end


if Image.GetProperties("notBtn_"..b.."ICON").ImageFile == _SourceFolder.."\\AutoPlay\\Images\\"..Theme.Icons.."\\folder.png" then
Image.Load("notBtn_"..b.."ICON", "AutoPlay\\Images\\"..Theme.Icons.."\\folder_open.png");
end

if functio ~= "f" and afterb == nil or afterb ~= b then
cacher=string.lower(b)
Hub.SetupHub(host.."AMSHub/caches/".. cacher.."-CACHE")
end

lastb,afterb=afterb,b
if lastb ~= nil and lastb ~= afterb and Image.GetProperties("notBtn_"..lastb.."ICON").ImageFile == _SourceFolder.."\\AutoPlay\\Images\\"..Theme.Icons.."\\folder_open.png" then
Image.Load("notBtn_"..lastb.."ICON", "AutoPlay\\Images\\"..Theme.Icons.."\\folder.png");
end

end




Menu.GetMenu()

	tButtons = INIFile.GetSectionNames(menuf);
	
			NOTS = load(menuf)
			for i, B in pairs(tButtons) do
				Menu.CreateBtn(POSFXe, POSFYe+i*SIZEpHeight, NOTS[B].caption, B,NOTS[B].enabled,NOTS[B].submenu,NOTS[B].functio);
				Menu.CreateIcon(POSFXe+WidthIco, POSFYe+i*SIZEpHeight-HeightIco/2+SIZEpHeight/2 , B,NOTS[B].icon);
			end


Page.ClickObject("notBtn_Home");



