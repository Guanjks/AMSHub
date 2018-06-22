--BASADO EN UPDATER-NG CON NUEVO MOTOR DE ACTUALIZACION
--	http://amsspecialist.com/viewtopic.php?f=18&t=3699  --

--Configuracion
Url = "http://pastebin.com/raw/W2EsEeUb";
Temp_Folder = _TempFolder.."\\UP";
To_Folder = _SourceFolder.."\\"
	
UP = {};    
function UP.Update()
	FileInformation = String.SplitPath(urlD);
	HTTP.Download(urlD, Temp_Folder.."\\"..FileInformation.Filename..FileInformation.Extension, MODE_BINARY, 20, 80, nil, nil, UPDATER_DownloadCallback);
	UP.Apply(urlD)
end

function UP.Apply(zip)
	Paragraph.SetText("TEXT", l.uncompresing)
	Zip.Extract(Temp_Folder.."\\"..FileInformation.Filename..FileInformation.Extension, {"*.*"}, Temp_Folder.."\\unzip\\", true, true, "", ZIP_OVERWRITE_NEVER, nil);
	Paragraph.SetText("TEXT", l.restarting)
	Application.Sleep(1500);
	list=""
	for i,v in pairs(Zip.GetContents(Temp_Folder.."\\"..FileInformation.Filename..FileInformation.Extension, true)) do
	if Folder.DoesExist(String.SplitPath(v).Folder) == false then
	Folder.Create(_SourceFolder.."\\"..v);
	end
	list=list..[[move "]]..Temp_Folder..[[\unzip\"]]..v..' "'..To_Folder..v..'"\r\n'
	end
		file_write(Temp_Folder.."\\MoveUpdate.bat", [[
			Taskkill /F /IM ]].. _SourceFilename ..'\r\n'.. [[
			]]..'\r\n'.. list ..[[
			start]]..' "" "'.._SourceFolder.."\\".._SourceFilename..'"\r\n'..[[
			del ]]..'"'..Temp_Folder..'\\*" /s /q\r\n'..[[
				del "%~f0"
			]], false);
		File.Run(Temp_Folder.."\\MoveUpdate.bat", "", "", SW_HIDE, false);
end

function UP.CheckUpdates()
	if con then
		lua_dostring(http.request(Url))
		if VERHUB > API.version then
		
		bar={X=700,Y=6,W=150,H=25}
		

		
		tblParaxProps = {ResizeRight = true,ResizeLeft = true,Text = "",Enabled=true,X = bar.X,Y = bar.Y,Width = bar.W,Height = bar.H,Visible = true,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber("F5F5F5")};
		Page.CreateObject(OBJECT_PARAGRAPH, "UPDATE", tblParaxProps);

		tblParaProps = {ResizeRight = true,ResizeLeft = true,Text = "",Enabled=true,X = bar.X,Y = bar.Y,Width = 0,Height = bar.H,Visible = true,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber("c5ced6")};
		Page.CreateObject(OBJECT_PARAGRAPH, "UPDATtE", tblParaProps);
		
		tblParapProps = {ResizeRight = true,ResizeLeft = true,Text = "",Enabled=false,X = bar.X,Y = bar.Y,Alignment =ALIGN_CENTER,Width = bar.W,Height =bar.H+20,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF,Visible = true,BGStyle=TRANSPARENT};
		Page.CreateObject(OBJECT_PARAGRAPH, "TEXT", tblParapProps);
		
		
		UP.Update()
		end
	end
end

function UPDATER_DownloadCallback(BSF, TBY, TR)
	if TBY ~= 0 then
		strProgress = l.updating.." ("..round(BSF/TBY * 100) .."%)"
		Paragraph.SetSize("UPDATtE", BSF/TBY * bar.W,bar.H);
		else
		strProgress = ''
	end
	Paragraph.SetText("TEXT", strProgress);
end