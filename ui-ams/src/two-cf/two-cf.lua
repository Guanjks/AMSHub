
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
		
		Paragraph.SetProperties(Back, {BGColor=Math.HexColorToNumber("00b9ff"),BGStyle=BG_SOLID});

		end
	elseif (Event == "OnLeave") then
			Paragraph.SetProperties(Back, {BGStyle=BG_TRANSPARENT});
	end
end

cuadrant = Window.GetSize(Application.GetWndHandle());
Theme = {Icons="white",TextColor="ffffff",HubColor= "262626",BackgroundColor= "262626",BackgroundColorList = "434343" ,scroll= true,scrollsize=7,menusize=200};

CreateUI()