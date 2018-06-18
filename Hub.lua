Hub = {};
function Hub.Refresh()
tblCon=Paragraph.GetProperties("Paragraph8")
SIZEeWidth=tblCon.Width
SIZEeHeight=35
POSMXe=tblCon.X
POSMYe=tblCon.Y
end

Hub.Refresh()
SWidthDwn=20
SHeightDwn=20
SWidthIco=31
SHeightIco=31
SWidthSize=100
SHeightSize=30




function Hub.Text(x, y, caption, b,i)
	Normal = Math.HexColorToNumber(Theme.HubColor);

	tblParaProps = {ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),Text = caption,Enabled=true,ResizeRight = true,FontName = "Segoe Ui",FontSize =9,X = x,Y = y,Alignment =ALIGN_CENTER,Width = SIZEeWidth,Height = SIZEeHeight-1,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF,Visible = true,BGStyle=BG_SOLID,BGColor=Normal};

	
	Page.CreateObject(OBJECT_PARAGRAPH, "tienda_"..b.."text", tblParaProps);
end


function Hub.Info(x, y, b, sze)
tct=string.upper(extensio)
if sze ~= nil then
tct=tct.."   "..nicesize(sze)
end	

	
	btnProps = {};
	btnProps.X = x;
	btnProps.Y = y;
	btnProps.Alignment = ALIGN_LEFT;
	btnProps.FontName = "Segoe Ui";
	btnProps.FontSize = 7;
	btnProps.Enabled = false;
	btnProps.ColorNormal = Math.HexColorToNumber("00b9ff");
	btnProps.Width = SWidthSize;
	btnProps.Height = SHeightSize;
	btnProps.Text = tct


	Page.CreateObject(OBJECT_PARAGRAPH, "tienda_"..b.."SIZE", btnProps);

end



function Hub.Download(x, y, b,url,caption)
tblImagePropsINS = {ImageFile = "AutoPlay\\Images\\download.png",Height = SHeightDwn,Width = SWidthDwn,Y = y,X = x,Visible = true,Enabled=true,Opacity=60,ResizeRight = true,ResizeLeft = true};
Page.CreateObject(OBJECT_IMAGE, "tienda_"..b.."INSTAL", tblImagePropsINS);



	Page.SetObjectScript("tienda_"..b.."INSTAL",  "On Click", [[ getbyhttp("]]..String.Replace(url, " ", "%20", true)..'","'.. [[Descargas\\]].. caption..extensio ..[[") API.ShowPopup("]]..l.dwnloadedk..extensio..l.dwnloaded..[[") ]])
	
	
	
	Page.SetObjectScript("tienda_"..b.."INSTAL",  "On Enter", [[ONEL, IMG, vMINOPACIDAD = true, this, 60
	IMGOPACIDAD ()]]);
	Page.SetObjectScript("tienda_"..b.."INSTAL",  "On Leave", [[ONEL, IMG, vMINOPACIDAD = false, this, 60
	IMGOPACIDAD ()]]);



end

	
function Hub.Create()
Hub.Refresh()

	tButtons = INIFile.GetSectionNames(SHOOP);
	if tButtons ~= nil then
	API.DeleteAllObjects("tienda_")
		ITEMS = load(SHOOP)
		for i, B in pairs(tButtons) do
		extensio=string.sub(ITEMS[B].url, -4)
		Hub.Text(POSMXe, POSMYe +SIZEeHeight*i-SIZEeHeight, ITEMS[B].caption, B,i);
		Hub.Download(POSMXe+SIZEeWidth-SWidthDwn*2, POSMYe+SIZEeHeight-SHeightDwn/2-SIZEeHeight/2 +SIZEeHeight*i-SIZEeHeight, B, ITEMS[B].url, ITEMS[B].caption);
		Hub.Info(POSMXe+10, POSMYe-SIZEeWidth+tblCon.Width+SIZEeHeight-SHeightSize/3-SIZEeHeight/2 +SIZEeHeight*i-SIZEeHeight, B,ITEMS[B].size)		
		end
	end
	
end

function Hub.SetupHub(url)
if con then
SHOOP = _SourceFolder.."\\AutoPlay\\Docs\\CACHES\\"..cacher
CheckVersionFile(SHOOP,url)
Hub.Create()
end
end

		Page.ClickObject("notBtn_Funciones");
