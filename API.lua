-- API FOR SECURITY OF PROYECT  --
-- IF THERE IS A PROBLEM CONTACT TO Guanj --
API = {};
API.version=17
API.stability="UNSTABLE"
--1 WHITE 2 BLACK
API.theme = 2


function API.SetLenguage(sav_set)
if sav_set == "load" then
API.lang = INIFile.GetValue(_SourceFolder.."\\AutoPlay\\Docs\\AllConfig.ini", "Conf", "Lenguage");
if API.lang == nil then API.lang = "ES" end
dofile(_SourceFolder.."\\AutoPlay\\Scripts\\lang\\lang-"..API.lang..".lua")
else
INIFile.SetValue(_SourceFolder.."\\AutoPlay\\Docs\\AllConfig.ini", "Conf", "Lenguage", sav_set);
API.Reboot()
end
end
API.SetLenguage("load")

function API.UploadProyect()
Fileg = Dialog.FileBrowse(true, l.selectproyect, _DesktopFolder, l.uploadable.."|*.lua;*.apz;*.zip;|", "", "", false, true)
	if Fileg[1] ~= "CANCEL" then
	category = string.lower(Dialog.Input(l.categoryf, l.category, l.functions, MB_ICONQUESTION))
			if category ~= "" or category ~= "CANCEL" and UI.SearchInFile(menuf,category) == true then
				FileInformatin = String.SplitPath(Fileg[1]);
				jj=host.."AMSHub/apz/uploads/"..FileInformatin.Filename..FileInformatin.Extension
				state=HTTP.Submit(host.."AMSHub/caches/ini.php", {category=category.."-CACHE",filename=FileInformatin.Filename,url=jj,size=File.GetSize(Fileg[1])}, SUBMITWEB_POST, 20, 80, nil, nil);
				if "Esto ya esta subido." ~= state then
				DLL.CallFunction("AutoPlay\\Docs\\WebUploadPabloko.dll", "UploadFile", "\""..host.."AMSHub/apz/archivo.php\",\""..Fileg[1].."\"", DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL);			
				else
				API.ShowPopup(l.uploaded);	
				end
			else
			API.ShowPopup(l.enter);		
			end
end
end

function API.DeleteAllObjects(to)
	for i,v in pairs(Page.EnumerateObjects()) do
		if v:find(to, 1, false) ~= nil then
		Page.DeleteObject(v);
		end
	end
end



function API.ShowPopup(MESSAGE,salida,ID)
	cuadrant = Window.GetSize(Application.GetWndHandle());
	if ID == nil then
	ID=math.random(0,200)
	end
	tblImageProps = {ResizeBottom = true,ResizeRight = true,ImageFile = "AutoPlay\\Images\\gris.png",Height = cuadrant.Height,Width = cuadrant.Width,Y = 0+36,X = 0,Opacity=30};
	Page.CreateObject(OBJECT_IMAGE, "pop_"..ID.."_BACKGROUND", tblImageProps);
	ancho,alto=460,160
	tblParaProps = {ResizeBottom = true,ResizeRight = true,Text = MESSAGE,X = cuadrant.Width/2-ancho/2,Y = cuadrant.Height/2-alto/2,Alignment =ALIGN_CENTER,Width=ancho,Height=alto,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber("FFFFFF")};
	Page.CreateObject(OBJECT_PARAGRAPH, "pop_"..ID.."_MESSAGE", tblParaProps);
	
if salida == nil or salida then
Page.SetObjectScript("pop_"..ID.."_BACKGROUND", "On Click", "API.DeleteAllObjects('pop_')");
end
ID = nil
end

function API.LoadList(str,bolean)
	for i,v in pairs(Page.EnumerateObjects()) do
		if v:find(str, 1, false) ~= nil then
		tbObjectType[Page.GetObjectType(v)].SetVisible(v, bolean);
		end
	end
end


function API.SearchInFile(filey,tosrch)
ref=file_read(filey)
		if ref == nil or ref:find(tosrch, 1, false) ~= nil then
		return false else
		return true
		end
end



function API.Reboot()
File.Run(_SourceFilename, "", "", SW_SHOWNORMAL, false);
os.exit()
end

function API.CheckConection()
con =  HTTP.GetConnectionState().Connected
return con
end

