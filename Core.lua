--Esto hace que las updates pesen 100kb jajjaja

	
SCR = {};

tmr=
[[
if e_ID == 221 then
if chaton and name ~= nil then
Chat.Create()
end
end

if e_ID == 227 then
API.CheckConection()
end


if e_ID == 21 then
if ESize == false then
Paragraph.SetEnabled("Paragraph2", false);
else
Paragraph.SetEnabled("Paragraph2", true);
end
end     
if e_ID == 10 then
	Page.StopTimer(10)
	arrastrarysoltar ()
	Page.StartTimer(200, 10)
end


   ]]
Application.SetPageScript("Page1", "On Timer", tmr);




function SCR.On_Show()
Application.LoadActionPlugin("AutoPlay\\Docs\\dragdrop.lmd")
DragAndDrop.SetDataFormat(DataFormat.FileDrop)
DragAndDrop.Start(Application.GetWndHandle())
Page.StartTimer(200, 10)

function arrastrarysoltar ()
	if dataFormat then
		if DragAndDrop.GetEventType () == "DragOver" then
		Paragraph.SetText("home_upload","\n\n\n\SUELTALO!");
		Image.Load("home_blured", "AutoPlay\\Images\\blurred_green.jpg")
		else
		Paragraph.SetText("home_upload",gtp);
		Image.Load("home_blured", "AutoPlay\\Images\\blurred_colors.jpg")
		end
		
		data = DragAndDrop.GetDataObject();
		
		if (dataFormat == "FileDrop") then
		for i, v in pairs(data) do
		archivo = String.SplitPath(v)
     	archivo_ruta = archivo.Drive..archivo.Folder..archivo.Filename..archivo.Extension

			if archivo.Extension == ".apz" or archivo.Extension == ".zip" or archivo.Extension == ".lua" then

	
			API.UploadCore(archivo_ruta)
			

			if index then
				Page.StopTimer(10)
				DragAndDrop.Stop (Application.GetWndHandle())
				Application.ExitScript()
			end
			
			end
		break
	end
	end
end
end










dofile(_SourceFolder.."\\AutoPlay\\Scripts\\API.lua")
dofile(_SourceFolder.."\\AutoPlay\\Scripts\\ui-ams\\Interfacer.lua")

UIAMS.CreateControllers()
API.CheckConection()
dofile(_SourceFolder.."\\AutoPlay\\Scripts\\Core-UP.lua")

UP.CheckUpdates()
Page.StartTimer(10000, 227);

dofile(_SourceFolder.."\\AutoPlay\\Scripts\\Home.lua")
Page.StartTimer(500, 21);






dofile(_SourceFolder.."\\AutoPlay\\Scripts\\Chat-UI.lua")
dofile(_SourceFolder.."\\AutoPlay\\Scripts\\Hub.lua")

dofile(_SourceFolder.."\\AutoPlay\\Scripts\\Menu.lua")


end

function SCR.Functions()
http = require("socket.http")


function load(fileName)
	assert(type(fileName) == 'string');
	local file = assert(io.open(fileName, 'r'));
	local data = {};
	local section;
	for line in file:lines() do
		local tempSection = line:match('^%[([^%[%]]+)%]$');
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection;
			data[section] = data[section] or {};
		end
		local param, value = line:match('^([%w|_]+)%s-=%s-(.+)$');
		if(param and value ~= nil)then
			if(tonumber(value))then
				value = tonumber(value);
			elseif(value == 'true')then
				value = true;
			elseif(value == 'false')then
				value = false;
			end
			if(tonumber(param))then
				param = tonumber(param);
			end
			data[section][param] = value;
		end
	end
	file:close();
	return data;
end



tbObjectType = {}
tbObjectType[OBJECT_BUTTON] = Button;
tbObjectType[OBJECT_PARAGRAPH] = Paragraph;
tbObjectType[OBJECT_IMAGE] = Image;
tbObjectType[OBJECT_INPUT] = Input;


vOPA_CORTINA, X, Y = 0, 219, 74
B_USER_FOCUS, B_PASSWORD_FOCUS, vIMGOPACIDAD, AVATAR = true, true, 0, 1
end

function SCR.OnClose()

end
function SCR.MouseButton()

end
function SCR.MouseMove()

end

function SCR.Global()
require("SliderEx")

function IMGOPACIDAD ()
while vIMGOPACIDAD < 100 do

vIMGOPACIDAD = vIMGOPACIDAD + 10
Image.SetOpacity(IMG, vIMGOPACIDAD)
Application.Sleep(20);
end
if ONEL then
do return end
else
while vIMGOPACIDAD > vMINOPACIDAD do
vIMGOPACIDAD = vIMGOPACIDAD - 10
Image.SetOpacity(IMG, vIMGOPACIDAD)
Application.Sleep(30);
end
end
end
function lua_dostring(sLua,errors)
	local Return, Error = pcall(function(s)
		return loadstring(s)();
	end, sLua);
	if Error ~= nil and errors then
	--ERROR
	do return end
	end
	
	if Error ~= nil and errors == false then
	return true
	else
	return false
	end
end

end

function SCR.Preload()

end




function SCR.On_Close()
end