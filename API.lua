-- API OF PROYECT --
API = {};
API.version=17
API.stability="STABLE"
--1 WHITE 2 BLACK
API.theme = 1


function API.SetLenguage(sav_set)
if sav_set == "load" then
API.lang = INIFile.GetValue(_SourceFolder.."\\AutoPlay\\Docs\\AllConfig.ini", "Conf", "Lenguage");
if API.lang == "" then API.lang = "ES" end
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
	API.UploadCore(Fileg[1])
	end
end

function API.UploadCore(archivo_ruta)
			category = string.lower(Dialog.Input(l.categoryf, l.category, l.functions, MB_ICONQUESTION))
			if category ~= "CANCEL" then
				FileInformatin = String.SplitPath(archivo_ruta);
				jj=host.."AMSHub/caches/uploads/"..FileInformatin.Filename..FileInformatin.Extension
				state=HTTP.Submit(host.."AMSHub/caches/ini.php", {category=category.."-CACHE",filename=FileInformatin.Filename,url=jj,size=File.GetSize(archivo_ruta)}, SUBMITWEB_POST, 20, 80, nil, nil);
				API.ShowPopup(state);	
				if "Esto ya esta subido." ~= state and "Esta categoria no existe." ~= state then
				DLL.CallFunction("AutoPlay\\Docs\\WebUploadPabloko.dll", "UploadFile", "\""..host.."AMSHub/caches/archivo.php\",\""..archivo_ruta.."\"", DLL_RETURN_TYPE_INTEGER, DLL_CALL_STDCALL);			
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
	tblImageProps = {ResizeBottom = true,ResizeRight = true,ImageFile = "AutoPlay\\Images\\gris.png",Height = cuadrant.Height,Width = cuadrant.Width,Y = 0+36,X = 0,Opacity=10};
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

