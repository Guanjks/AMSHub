
function EventControllers(Event, Object, Theme, Back)
	if (Event == "OnClick") then
		if (Object == "btn-close") then
			Window.Close(Application.GetWndHandle(), CLOSEWND_TERMINATE);
		elseif (Object == "btn-maximize") then
			local Path = String.SplitPath(Image.GetFilename(Object));
			if (ESize == false) then			
				Image.Load(Object, Path.Drive.."\\"..Path.Folder.."\\btn-restore.png");
				Window.Maximize(Application.GetWndHandle());
				ESize = true;
			else
				Image.Load(Object, Path.Drive.."\\"..Path.Folder.."\\btn-maximize.png");
				Window.Restore(Application.GetWndHandle());
				ESize = false;
			end
		elseif (Object == "btn-minimize") then
			Window.Minimize(Application.GetWndHandle());
		end
	elseif (Event == "OnEnter") then
		if (Object == "btn-close") then
		Paragraph.SetProperties(Back, {BGColor=Math.HexColorToNumber("E53935"),BGStyle=BG_SOLID});
			
		else
		
		Paragraph.SetProperties(Back, {BGColor=Math.HexColorToNumber("f0f0f0"),BGStyle=BG_SOLID});

		end
	elseif (Event == "OnLeave") then
			Paragraph.SetProperties(Back, {BGColor=Math.HexColorToNumber("FFFFFF"),BGStyle=BG_SOLID});
	end
end

cuadrant = Window.GetSize(Application.GetWndHandle());
Theme = {Icons="black",TextColor="000000",HubColor= "FFFFFF",BackgroundColor= "FFFFFF",BackgroundColorList = "fcfcfc" ,scroll= true,scrollsize=7,menusize=200};

CreateUI()