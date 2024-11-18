require("UI");
require("util");
function Client_PresentConfigureUI(rootParent)
    init(rootParent);
	TargetMeInput = Mod.Settings.TargetMe;
	TargetAlliesInput = Mod.Settings.TargetAllies;
	TargetEnnemiesInput = Mod.Settings.TargetEnnemies;
	AdvancedInput = Mod.Settings.Advanced;
	inputA = Mod.Settings.A;
	print("Client_PresentConfigureUI 0 " .. inputA)
	inputB = Mod.Settings.B;
	inputC = Mod.Settings.C;
	inputD = Mod.Settings.D;
	inputE = Mod.Settings.E;
	inputF = Mod.Settings.F;
	inputG = Mod.Settings.G;
	inputH = Mod.Settings.H;
	inputI = Mod.Settings.I;
	inputJ = Mod.Settings.J;
	inputK = Mod.Settings.K;
	inputL = Mod.Settings.L;
	inputM = Mod.Settings.M;
	inputN = Mod.Settings.N;
	if TargetMeInput == nil then TargetMeInput = true end;
	if TargetAlliesInput == nil then TargetAlliesInput = false end;
	if TargetEnnemiesInput == nil then TargetEnnemiesInput = false end;
	if AdvancedInput == nil then AdvancedInput = false end;
	if inputA == nil then inputA = 0 end;
	print("Client_PresentConfigureUI 1 " .. Mod.Settings.A)
	print("Client_PresentConfigureUI 2 " .. inputA)
	if inputB == nil then inputB = 0 end;
	if inputC == nil then inputC = 0 end;
	if inputD == nil then inputD = 0 end;
	if inputE == nil then inputE = 0 end;
	if inputF == nil then inputF = 0 end;
	if inputG == nil then inputG = 0 end;
	if inputH == nil then inputH = 0 end;
	if inputI == nil then inputI = 0 end;
	if inputJ == nil then inputJ = 0 end;
	if inputK == nil then inputK = 0 end;
	if inputL == nil then inputL = 0 end;
	if inputM == nil then inputM = 0 end;
	if inputN == nil then inputN = 0 end;

	ShowOptions();
end

function ShowOptions()
	win = "ShowOptions";
	destroyWindow(getCurrentWindow());
	if windowExists(win) then
		resetWindow(win);
	end
	window(win);
	vert = newVerticalGroup("vert", "root");
	local line = newHorizontalGroup(win .. "line1", vert);
	newLabel(win .. "Intro", line, "Should your unspent gold grant you / your ally / your ennemies a bonus/malus?", textColor);
	local line = newHorizontalGroup(win .. "line2", vert);
	newButton(win .. "MeButton", line, "?", function() UI.Alert("Should your unspent gold grant you a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "MeCheckBox", line, "", TargetMeInput, true, IncludeExcludeTargetMe)
	newLabel(win .. "MeCheckBoxLabel", line, "Target me", mainTextColor);
	if TargetMeInput then
		ShowTargetMe()
	end
	vertAlly = newVerticalGroup("vertAlly", "root");
	local line = newHorizontalGroup(win .. "line3", vertAlly);
	newButton(win .. "AlliesButton", line, "?", function() UI.Alert("Should your unspent gold grant your allies a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "AlliesCheckBox", line, "", TargetAlliesInput, true, IncludeExcludeTargetAllies)
	newLabel(win .. "AlliesCheckBoxLabel", line, "Target allies", mainTextColor);
	if TargetAlliesInput then
		ShowTargetAllies()
	end
	vertEnnemy= newVerticalGroup("vertEnnemy", "root");
	local line = newHorizontalGroup(win .. "line4", vertEnnemy);
	newButton(win .. "EnnemiesButton", line, "?", function() UI.Alert("Should your unspent gold grant your ennemies a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "EnnemiesCheckBox", line, "", TargetEnnemiesInput, true, IncludeExcludeTargetEnnemies)
	newLabel(win .. "EnnemiesCheckBoxLabel", line, "Target ennemies", mainTextColor);
	if TargetEnnemiesInput then
		ShowTargetEnnemies()
	end
	vertAdvanced = newVerticalGroup("vertAdvanced", "root");
	local line = newHorizontalGroup(win .. "line5", vertAdvanced);
	newButton(win .. "AdvancedButton", line, "?    ", function() UI.Alert("Additional options if you feel like spicing things up.") end, buttonColor);
	newCheckbox(win .. "AdvancedCheckBox", line, "", AdvancedInput, true, IncludeExcludeAdvanced)
	newLabel(win .. "AdvancedCheckBoxLabel", line, "Advanced", mainTextColor);
	if AdvancedInput then
		ShowAdvanced()
	end
	vertSave = newVerticalGroup("vertSave", "root");
	local line = newHorizontalGroup(win .. "line6", vertSave);
	newButton(win .. "SaveInputsButton", line, "Save Settings", function() SaveInputs(); UI.Alert("Saved!") end, buttonColor2);
end

function ShowTargetMe()
	local line = newHorizontalGroup(win .. "lineMe1", vert);
	newLabel(win .. "me", line, "Unspent gold multiplier for you:", textColor);
	local line = newHorizontalGroup(win .. "lineMe2", vert);
	newButton(win .. "MeButton2", line, "?", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputA*10 .. " gold from this option.") end, buttonColor);
	iA = newNumberField(win .. "InputA", line, -10, 10, inputA, true, false);
	local line = newHorizontalGroup(win .. "lineMe3", vert);
	newLabel(win .. "me2", line, "Constant extra gold for having any unspent gold:", textColor);
	local line = newHorizontalGroup(win .. "lineMe4", vert);
	newButton(win .. "MeButton3", line, "?", function() UI.Alert("If you end your turn with 1 or more gold leftover, you will receive an additional " .. inputB .. " gold from this option.") end, buttonColor);
	iB = newNumberField(win .. "InputB", line, -10, 10, inputB, true, false);
	local line = newHorizontalGroup(win .. "lineempty1", vert);
	newLabel(win .. "empty1", line, "\n\n", mainTextColor);
end

function IncludeExcludeTargetMe()
	if TargetMeInput then
		TargetMeInput = false;
		SaveInputs();
		ShowOptions();
	else
		TargetMeInput = true;
		ShowTargetMe();
	end
end

function ShowTargetAllies()
	local line = newHorizontalGroup(win .. "lineAllies1", vertAlly);
	newLabel(win .. "allies", line, "Unspent gold multiplier for your allies:", textColor);
	local line = newHorizontalGroup(win .. "lineAllies2", vertAlly);
	newButton(win .. "AlliesButton2", line, "?", function() UI.Alert("If you end your turn with 10 gold leftover, your allies will receive an additional " .. inputC*10 .. " gold from this option.") end, buttonColor);
	iC = newNumberField(win .. "InputC", line, -10, 10, inputC, true, false);
	local line = newHorizontalGroup(win .. "lineempty2", vertAlly);
	newLabel(win .. "empty2", line, "\n\n", mainTextColor);
end

function IncludeExcludeTargetAllies()
	if TargetAlliesInput then
		TargetAlliesInput = false
		SaveInputs();
		ShowOptions()
	else
		TargetAlliesInput = true;
		ShowTargetAllies()
	end
end

function ShowTargetEnnemies()
	local line = newHorizontalGroup(win .. "lineEnnemies1", vertEnnemy);
	newLabel(win .. "ennemies", line, "Unspent gold multiplier for your ennemies:", textColor);
	local line = newHorizontalGroup(win .. "lineEnnemies2", vertEnnemy);
	newButton(win .. "EnnemiesButton2", line, "?", function() UI.Alert("If you end your turn with 10 gold leftover, your ennemies will receive an additional " .. inputD*10 .. " gold from this option.") end, buttonColor);
	iD = newNumberField(win .. "InputD", line, -10, 10, inputD, true, false);
	local line = newHorizontalGroup(win .. "lineempty3", vertEnnemy);
	newLabel(win .. "empty3", line, "\n\n", mainTextColor);
end

function IncludeExcludeTargetEnnemies()
	if TargetEnnemiesInput then
		TargetEnnemiesInput = false
		SaveInputs();
		ShowOptions()
	else
		TargetEnnemiesInput = true;
		ShowTargetEnnemies()
	end
end

function ShowAdvanced()
	local line = newHorizontalGroup(win .. "lineAdvanced1", vertAdvanced);
	newLabel(win .. "advanced", line, "TODO1:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced2", vertAdvanced);
	newButton(win .. "AdvancedButton2", line, "?   ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputE*10 .. " gold from this option.") end, buttonColor);
	iE = newNumberField(win .. "InputE", line, -10, 10, inputE, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced3", vertAdvanced);
	newLabel(win .. "advanced2", line, "TODO2:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced4", vertAdvanced);
	newButton(win .. "AdvancedButton3", line, "?   ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputF*10 .. " gold from this option.") end, buttonColor);
	iF = newNumberField(win .. "InputF", line, -10, 10, inputF, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced5", vertAdvanced);
	newLabel(win .. "advanced3", line, "TODO3:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced6", vertAdvanced);
	newButton(win .. "AdvancedButton4", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputG*10 .. " gold from this option.") end, buttonColor);
	iG = newNumberField(win .. "InputG", line, -10, 10, inputG, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced7", vertAdvanced);
	newLabel(win .. "advanced4", line, "TODO4:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced8", vertAdvanced);
	newButton(win .. "AdvancedButton5", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputH*10 .. " gold from this option.") end, buttonColor);
	iH = newNumberField(win .. "InputH", line, -10, 10, inputH, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced9", vertAdvanced);
	newLabel(win .. "advanced5", line, "TODO5:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced10", vertAdvanced);
	newButton(win .. "AdvancedButton6", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputI*10 .. " gold from this option.") end, buttonColor);
	iI = newNumberField(win .. "InputI", line, -10, 10, inputI, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced11", vertAdvanced);
	newLabel(win .. "advanced6", line, "TODO6:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced12", vertAdvanced);
	newButton(win .. "AdvancedButton7", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputJ*10 .. " gold from this option.") end, buttonColor);
	iJ = newNumberField(win .. "InputJ", line, -10, 10, inputJ, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced13", vertAdvanced);
	newLabel(win .. "advanced7", line, "TODO6:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced14", vertAdvanced);
	newButton(win .. "AdvancedButton8", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputK*10 .. " gold from this option.") end, buttonColor);
	iK = newNumberField(win .. "InputK", line, -10, 10, inputK, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced15", vertAdvanced);
	newLabel(win .. "advanced8", line, "TODO6:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced16", vertAdvanced);
	newButton(win .. "AdvancedButton9", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputL*10 .. " gold from this option.") end, buttonColor);
	iL = newNumberField(win .. "InputL", line, -10, 10, inputL, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced17", vertAdvanced);
	newLabel(win .. "advanced9", line, "TODO6:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced18", vertAdvanced);
	newButton(win .. "AdvancedButton10", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputM*10 .. " gold from this option.") end, buttonColor);
	iM = newNumberField(win .. "InputM", line, -10, 10, inputM, true, false);

	local line = newHorizontalGroup(win .. "lineAdvanced19", vertAdvanced);
	newLabel(win .. "advanced10", line, "TODO6:", textColor);
	local line = newHorizontalGroup(win .. "lineAdvanced20", vertAdvanced);
	newButton(win .. "AdvancedButton11", line, "?    ", function() UI.Alert("If you end your turn with 10 gold leftover, you will receive an additional " .. inputN*10 .. " gold from this option.") end, buttonColor);
	iN = newNumberField(win .. "InputN", line, -10, 10, inputN, true, false);

end

function IncludeExcludeAdvanced()
	if AdvancedInput then
		AdvancedInput = false
		SaveInputs();
		ShowOptions()
	else
		AdvancedInput = true;
		ShowAdvanced()
	end
end

-- Unspent: 2
-- AllyUnspentGold: 9+3+0
-- EnnemyUnspentGold: 4+0+1+12
-- Income: 10
-- TurnNumber: 5
-- TerritoryNumber: 18 
-- Units: 5
-- a.U + b + c.A + d.E + e.I + f.T + g*Terr + h.Units

function SaveInputs()
	print("BsaveInputs" .. Mod.Settings.A)
	print("BsaveInputs" .. inputA)
	inputA = getValue(iA);
	print("AsaveInputs" .. Mod.Settings.A)
	print("AsaveInputs" .. inputA)
	inputB = getValue(iB);
	inputC = getValue(iC);
	inputD = getValue(iD);
	inputE = getValue(iE);
	inputF = getValue(iF);
	inputG = getValue(iG);
	inputH = getValue(iH);
	inputI = getValue(iI);
	inputJ = getValue(iJ);
	inputK = getValue(iK);
	inputL = getValue(iL);
	inputM = getValue(iM);
	inputN = getValue(iN);
end