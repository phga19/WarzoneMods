require("UI");
require("util");
function Client_PresentSettingsUI(rootParent)
	-- init(rootParent);
	print("Client_PresentSettingsUI")
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText("Client_PresentSettingsUI" .. tostring(Mod.Settings.Me)).SetColor("#DDDDDD");
	-- UI.CreateLabel(vert).SetText("Client_PresentSettingsUI" .. Mod.Settings.Income).SetColor("#DDDDDD");
end