--[[
UIAMS FRAMEWORK
--]]

--
UIAMS = {
	CreateControllers = function (Theme)
		ESize = false;
		local PageSize = Page.GetSize().Width;
		local UIAMSImage = {
			Theme = {
				"one-cf",
				"two-cf"
			},
			Position = {
				PageSize - 36,
				PageSize - (36 * 2),
				PageSize - (36 * 3)
				
			},
			Name = {
				"close",
				"maximize",
				"minimize"
			}
		}

		if (Theme == nil) then
			Theme = UIAMSImage.Theme[API.theme];			
		end
		
		local Iterator = 1;
		repeat
			ObjectProperties(Theme, UIAMSImage.Position[Iterator], UIAMSImage.Name[Iterator]);
			Iterator = Iterator + 1;
		until Iterator == 4;

	end
}

function ObjectProperties(Theme, Position, ImageName)
	require(_SourceFolder.."\\AutoPlay\\Scripts\\ui-ams\\src\\"..Theme.."\\"..Theme)
	ImageProperties = {};
	ImageProperties.X = Position;
	ImageProperties.Y = 0;
	ImageProperties.Width = 36;
	ImageProperties.Height = 36;
	ImageProperties.Enabled = false;
	ImageProperties.ResizeLeft = true;
	ImageProperties.ResizeRight = true;
	ImageProperties.ImageFile = _SourceFolder .. "\\AutoPlay\\Scripts\\ui-ams\\src\\"..Theme.."\\btn-"..ImageName..".png";
	--
	ParagraphProperties = {};
	ParagraphProperties.Text = "";
	ParagraphProperties.X = Position;
	ParagraphProperties.Y = 0;
	ParagraphProperties.Width = 36;
	ParagraphProperties.Height = 36;
	ParagraphProperties.ScrollVertical = SCROLL_OFF
	ParagraphProperties.ScrollHorizontal = SCROLL_OFF
	ParagraphProperties.ResizeLeft = true;
	ParagraphProperties.ResizeRight = true;
	ParagraphProperties.BGStyle=BG_TRANSPARENT
	
	Page.CreateObject(OBJECT_PARAGRAPH, "htsp-"..ImageName, ParagraphProperties);
	Page.CreateObject(OBJECT_IMAGE, "btn-"..ImageName, ImageProperties);
	
	
	Page.SetObjectScript("htsp-"..ImageName, "On Click", "EventControllers('OnClick', 'btn-"..ImageName.."')");
	Page.SetObjectScript("htsp-"..ImageName, "On Enter", "EventControllers('OnEnter', 'btn-"..ImageName.."', '"..Theme.."', 'htsp-"..ImageName.."')");
	Page.SetObjectScript("htsp-"..ImageName, "On Leave", "EventControllers('OnLeave', 'btn-"..ImageName.."', '"..Theme.."', 'htsp-"..ImageName.."')");
end
