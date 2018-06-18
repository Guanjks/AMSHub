Home = {};
Home.description = "UI HOME";
Home.version = "0.1";



wit=Page.GetSize().Width

function HomeUI()
tblParaProps = {ColorDisabled = Math.HexColorToNumber(Theme.TextColor),ColorNormal = Math.HexColorToNumber(Theme.TextColor),ColorHighlight =Math.HexColorToNumber(Theme.TextColor),ColorDown=Math.HexColorToNumber(Theme.TextColor),ResizeBottom = true,Enabled = false,ResizeRight = true,FontName = "Segoe Ui",FontSize=12,Text = "AMSHub",X = 0,Y = 0,Alignment =ALIGN_CENTER,Width=cuadrant.Width,Height=cuadrant.Height,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColor)};
Page.CreateObject(OBJECT_PARAGRAPH, "Paragraph2", tblParaProps);

if API.stability == "UNSTABLE" then
tblParaProps = {Enabled = false,ColorNormal = Math.HexColorToNumber("FF0000"),FontName = "Segoe Ui",FontSize=8,Text = l.st,X =10,Y = 5,Width=200,Height=32,ScrollVertical = SCROLL_OFF,ScrollHorizontal = SCROLL_OFF};
Page.CreateObject(OBJECT_PARAGRAPH, "stability", tblParaProps);
end
if Theme.scroll then plus=7 else plus=0 end
tblCon= {ResizeBottom = true,Enabled = true,ResizeRight = true,FontName = "Segoe Ui",FontSize=9,Text = "",X = conmenu.Width,Y = 36,Alignment =ALIGN_CENTER,Width=wit-conmenu.Width,Height=577,ScrollVertical = SCROLL_ON,ScrollHorizontal = SCROLL_OFF,BGStyle=BG_SOLID,BGColor=Math.HexColorToNumber(Theme.BackgroundColorList)};
Page.CreateObject(OBJECT_PARAGRAPH, "Paragraph8", tblCon);



end
