Chat = {};
SIZEeHeight=35
function Chat.Create()
	if con then
	captionold=Paragraph.GetText("Paragraph8");
	if captionold ~= caption then
	caption=string.gsub(caption, name.."]", l.you.."]")
	Paragraph.SetText("Paragraph8", caption.."\n\n\n");
	Paragraph.SetScrollPos("Paragraph8", 9000, true);
	end
	end
end

function Chat.RefreshChat()
caption=http.request(host.."/AMSHub/chat/CHAT")
Chat.Create()
end


function Chat.CreateUI()
if name == nil then
name = Dialog.Input(l.name, l.namep, l.tstname, MB_ICONQUESTION)
end

	btnProps = {};
	btnProps.Width = 90
	btnProps.Height = SIZEeHeight;	
	btnProps.X = tblCon.Width-btnProps.Width+tblCon.X;
	btnProps.Y = tblCon.Y+tblCon.Height-SIZEeHeight;
	btnProps.Alignment = ALIGN_CENTER;
	btnProps.ButtonFile = "AutoPlay\\Buttons\\menu.btn";
	btnProps.FontName = "Segoe Ui";
	btnProps.FontSize = 10;
	btnProps.ColorNormal = Math.HexColorToNumber("000000");
	btnProps.ColorHighlight = Math.HexColorToNumber("000000");
	btnProps.ColorDown = Math.HexColorToNumber("000000");
	btnProps.Text = l.send;
	btnProps.ResizeRight = true
	btnProps.ResizeLeft = true
	btnProps.ResizeTop = true
	btnProps.ResizeBottom = true
	Page.CreateObject(OBJECT_BUTTON, "cha_buton", btnProps);


tblInputProps = {Text = Text,FontName = "Segoe UI",ResizeBottom = true,ResizeTop = true,ResizeRight = true,FontSize = 9,Border = BORDER_NONE,BackgroundColor = Math.HexColorToNumber("FFFFFF"),Height = SIZEeHeight,Width=tblCon.Width- btnProps.Width,X = tblCon.X,Y = tblCon.Y+tblCon.Height-SIZEeHeight};
Page.CreateObject(OBJECT_INPUT, "cha_input", tblInputProps);

Page.SetObjectScript("cha_buton", "On Click", "Chat.SendMessage(Input.GetText('cha_input'))");
Page.SetObjectScript("cha_input", "On Key", [[if e_Key == 13 then Page.ClickObject("cha_buton") end]]);




end

function Chat.SendMessage(text)
HTTP.Submit(host.."AMSHub/chat/chat.php", {name=name,text=text}, SUBMITWEB_POST, 20, 80, nil, nil);
Chat.RefreshChat()
end


function Chat.Sesion(t,send)
if t then
chaton=true
API.LoadList("Slider_",true)
Chat.CreateUI()
Chat.RefreshChat()
else
if send == nil then
Chat.SendMessage(name.." Salio")
end
chaton=nil
API.DeleteAllObjects("cha_")
end
end

