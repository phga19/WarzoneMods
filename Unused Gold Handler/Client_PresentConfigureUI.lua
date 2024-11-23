require("UI");
require("util");
function Client_PresentConfigureUI(rootParent)
    init(rootParent);
	inputTargetMe = Mod.Settings.TargetMe;
	inputTargetAllies = Mod.Settings.TargetAllies;
	inputTargetEnnemies = Mod.Settings.TargetEnnemies;
	inputAdvanced = Mod.Settings.Advanced;
	inputMe = Mod.Settings.Me;
	inputConst = Mod.Settings.Const;
	inputAlly = Mod.Settings.Ally
	inputEnnemy = Mod.Settings.Ennemy;
	inputIncome = Mod.Settings.Income;
	inputTurn = Mod.Settings.Turn;
	inputG = Mod.Settings.G;
	inputH = Mod.Settings.H;
	inputTerritoryCapture = Mod.Settings.TerritoryCapture;
	inputBonusCaptured = Mod.Settings.BonusCaptured;
	inputDefendingKills = Mod.Settings.DefendingKills;
	inputAttackingKills = Mod.Settings.AttackingKills;
	inputDefendingSpeKills = Mod.Settings.DefendingSpeKills;
	inputAttackingSpeKills = Mod.Settings.AttackingSpeKills;
	if inputTargetMe == nil then inputTargetMe = true end;
	if inputTargetAllies == nil then inputTargetAllies = false end;
	if inputTargetEnnemies == nil then inputTargetEnnemies = false end;
	if inputAdvanced == nil then inputAdvanced = false end;
	if inputMe == nil then inputMe = 0 end;
	if inputConst == nil then inputConst = 0 end;
	if inputAlly == nil then inputAlly = 0 end;
	if inputEnnemy == nil then inputEnnemy = 0 end;
	if inputIncome == nil then inputIncome = 0 end;
	if inputTurn == nil then inputTurn = 0 end;
	if inputG == nil then inputG = 0 end;
	if inputH == nil then inputH = 0 end;
	if inputTerritoryCapture == nil then inputTerritoryCapture = 0 end;
	if inputBonusCaptured == nil then inputBonusCaptured = 0 end;
	if inputDefendingKills == nil then inputDefendingKills = 0 end;
	if inputAttackingKills == nil then inputAttackingKills = 0 end;
	if inputDefendingSpeKills == nil then inputDefendingSpeKills = 0 end;
	if inputAttackingSpeKills == nil then inputAttackingSpeKills = 0 end;
	inputs = {
		Me = inputMe,
		Const = inputConst,
		Ally = inputAlly,
		Ennemy = inputEnnemy,
		Income = inputIncome,
		Turn = inputTurn,
		G = inputG,
		H = inputH,
		TerritoryCapture = inputTerritoryCapture,
		BonusCaptured = inputBonusCaptured,
		DefendingKills = inputDefendingKills,
		AttackingKills = inputAttackingKills,
		DefendingSpeKills = inputDefendingSpeKills,
		AttackingSpeKills = inputAttackingSpeKills,
	};
	local allowedSorF = {"SF", "S", "F"}
	inputDefendingKillSorF = Mod.Settings.DefendingKillSorF;
	inputAttackingKillSorF = Mod.Settings.AttackingKillSorF;
	inputDefendingSpeKillSorF = Mod.Settings.DefendingSpeKillSorF;
	inputAttackingSpeKillSorF = Mod.Settings.AttackingSpeKillSorF;
	if not isIn(inputDefendingKillSorF, allowedSorF) then inputDefendingKillSorF = "SF"; end
	if not isIn(inputAttackingKillSorF, allowedSorF) then inputAttackingKillSorF = "SF"; end
	if not isIn(inputDefendingSpeKillSorF, allowedSorF) then inputDefendingSpeKillSorF = "SF"; end
	if not isIn(inputAttackingSpeKillSorF, allowedSorF) then inputAttackingSpeKillSorF = "SF"; end
	SorFtable =
	{
		["S"] = "Success only",
		["F"] = "Failure only",
		["SF"] = "Success and Failure",
	}
	SorFNext =
	{
		["S"] = "F",
		["F"] = "SF",
		["SF"] = "S",
	}

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
	local line = newHorizontalGroup(win .. "line0", vert);
	text = "This mods offer a lot of customisation options, because giving host lots of options makes for lots of possibilites of creative templates.\n\nAll of them are compatible with each other. However it is strongly advised to use them with parcimony.\n\nIf too many different income changes are used at the same time, players will struggle to understand how their income is calculated and this will feel mystic or random to them.\n\nIt is recommanded to only use a maximum of a few of those settings at the same time, and it is even more important to respect this constraint when playing with people who are new to this mod."
	newButton(win .. "TipsButton", line, "TIPS FOR HOST", function() UI.Alert(text) end, buttonColor);
	local line = newHorizontalGroup(win .. "line1", vert);
	newLabel(win .. "Intro", line, "Should your unspent gold grant you / your ally / your ennemies a bonus/malus?", textColor);
	local line = newHorizontalGroup(win .. "line2", vert);
	newButton(win .. "MeButton", line, "?", function() UI.Alert("Should your unspent gold grant you a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "MeCheckBox", line, "", inputTargetMe, true, IncludeExcludeTargetMe)
	newLabel(win .. "MeCheckBoxLabel", line, "Target me", mainTextColor);
	if inputTargetMe then
		ShowTargetMe()
	end
	vertAlly = newVerticalGroup("vertAlly", "root");
	local line = newHorizontalGroup(win .. "line3", vertAlly);
	newButton(win .. "AlliesButton", line, "?", function() UI.Alert("Should your unspent gold grant your allies a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "AlliesCheckBox", line, "", inputTargetAllies, true, IncludeExcludeTargetAllies)
	newLabel(win .. "AlliesCheckBoxLabel", line, "Target allies", mainTextColor);
	if inputTargetAllies then
		ShowTargetAllies()
	end
	vertEnnemy= newVerticalGroup("vertEnnemy", "root");
	local line = newHorizontalGroup(win .. "line4", vertEnnemy);
	newButton(win .. "EnnemiesButton", line, "?", function() UI.Alert("Should your unspent gold grant your ennemies a bonus/malus?") end, buttonColor);
	newCheckbox(win .. "EnnemiesCheckBox", line, "", inputTargetEnnemies, true, IncludeExcludeTargetEnnemies)
	newLabel(win .. "EnnemiesCheckBoxLabel", line, "Target ennemies", mainTextColor);
	if inputTargetEnnemies then
		ShowTargetEnnemies()
	end
	vertAdvanced = newVerticalGroup("vertAdvanced", "root");
	local line = newHorizontalGroup(win .. "line5", vertAdvanced);
	newButton(win .. "AdvancedButton", line, "?    ", function() UI.Alert("Additional options if you feel like spicing things up.") end, buttonColor);
	newCheckbox(win .. "AdvancedCheckBox", line, "", inputAdvanced, true, IncludeExcludeAdvanced)
	newLabel(win .. "AdvancedCheckBoxLabel", line, "Advanced", mainTextColor);
	if inputAdvanced then
		ShowAdvanced()
	end
	-- vertSave = newVerticalGroup("vertSave", "root");
	-- local line = newHorizontalGroup(win .. "line6", vertSave);
	-- newButton(win .. "SaveInputsButton", line, "Save Settings", function() SaveInputs(); UI.Alert("Saved!") end, buttonColor2);
end

function ShowTargetMe()
	local textLabel = "Unspent gold multiplier for you:"
	local textAlertStart = alertTextButtonStart();
	local textAlertEnd = alertTextButtonEnd();
	iMe = labelButtonNumberField(vert, "Me", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Constant extra gold for having any unspent gold:" --todo option for it to only happen above X unspent gold
	textAlertStart = alertTextButtonConstStart();
	textAlertEnd = alertTextButtonEnd();
	iConst = labelButtonNumberField(vert, "Const", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	emptyLine(1, vert)
end

function IncludeExcludeTargetMe()
	if inputTargetMe then
		inputTargetMe = false;
		SaveInputs();
		ShowOptions();
	else
		inputTargetMe = true;
		ShowTargetMe();
	end
end

function ShowTargetAllies()
	local textLabel = "Unspent gold multiplier for allies:"
	local textAlertStart = alertTextButtonStart();
	local textAlertEnd = alertTextButtonEnd();
	iAlly = labelButtonNumberField(vertAlly, "Ally", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	emptyLine(2, vertAlly)
end

function IncludeExcludeTargetAllies()
	if inputTargetAllies then
		inputTargetAllies = false
		SaveInputs();
		ShowOptions()
	else
		inputTargetAllies = true;
		ShowTargetAllies()
	end
end

function IncludeExcludeDefendingKillsSuccessOnly()
	DefendingKillsSuccessOnly = not DefendingKillsSuccessOnly
end


function ShowTargetEnnemies()
	local textLabel = "Unspent gold multiplier for ennemies:"
	local textAlertStart = alertTextButtonStart();
	local textAlertEnd = alertTextButtonEnd();
	iEnnemy = labelButtonNumberField(vertEnnemy, "Ennemy", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	emptyLine(3, vertEnnemy)
end

function IncludeExcludeTargetEnnemies()
	if inputTargetEnnemies then
		inputTargetEnnemies = false
		SaveInputs();
		ShowOptions()
	else
		inputTargetEnnemies = true;
		ShowTargetEnnemies()
	end
end

function cycleDefendingKillSorF()
	SaveInputs();
	inputDefendingKillSorF = SorFNext[inputDefendingKillSorF];
	ShowOptions()
end

function cycleAttackingKillSorF()
	SaveInputs();
	inputAttackingKillSorF = SorFNext[inputAttackingKillSorF];
	ShowOptions()
end

function cycleDefendingSpeKillSorF()
	SaveInputs();
	inputDefendingSpeKillSorF = SorFNext[inputDefendingSpeKillSorF];
	ShowOptions()
end

function cycleAttackingSpeKillSorF()
	SaveInputs();
	inputAttackingSpeKillSorF = SorFNext[inputAttackingSpeKillSorF];
	ShowOptions()
end

function ShowAdvanced()
	textLabel = "Extra gold from your income:"
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iIncome = labelButtonNumberField(vertAdvanced, "Income", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from current turn number:"
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iTurn = labelButtonNumberField(vertAdvanced, "Turn", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from:"
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iG = labelButtonNumberField(vertAdvanced, "G", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from:"
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iH = labelButtonNumberField(vertAdvanced, "H", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from each captured territory:" --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iTerritoryCapture = labelButtonNumberField(vertAdvanced, "TerritoryCapture", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from captured bonuses:" --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iBonusCaptured = labelButtonNumberField(vertAdvanced, "BonusCaptured", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	textLabel = "Extra gold from defenders killed:"  --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iDefendingKills = labelButtonNumberField(vertAdvanced, "DefendingKills", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	local line = newHorizontalGroup(win .. "lineDefendingKillsSorF", vertAdvanced);
	newButton(win .. "DefendingKillsSorFButton", line, "?", function() UI.Alert("Choose between counting kills of defenders only for successful attacks, failed attacks, or both.") end, buttonColor);
	-- newLabel(win .. "DefendingKillsSorFCheckBoxLabel", line, "TODOPrevious option is only counted for: ", textColor);
	newButton(win .. "DefendingKillsSorFButton2", line, SorFtable[inputDefendingKillSorF], cycleDefendingKillSorF, buttonColor);

	textLabel = "Extra gold from attackers killed:"  --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iAttackingKills = labelButtonNumberField(vertAdvanced, "AttackingKills", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	local line = newHorizontalGroup(win .. "lineAttackingKillsSorF", vertAdvanced);
	newButton(win .. "AttackingKillsSorFButton", line, "?", function() UI.Alert("Choose between counting kills of attackers only for successful attacks, failed attacks, or both.") end, buttonColor);
	-- newLabel(win .. "AttackingKillsSorFCheckBoxLabel", line, "TODOPrevious option is only counted for: ", textColor);
	newButton(win .. "AttackingKillsSorFButton2", line, SorFtable[inputAttackingKillSorF], cycleAttackingKillSorF, buttonColor);

	textLabel = "Extra gold from defending special units killed:"  --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iDefendingSpeKills = labelButtonNumberField(vertAdvanced, "DefendingSpeKills", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	local line = newHorizontalGroup(win .. "lineDefendingKillsSorF", vertAdvanced);
	newButton(win .. "DefendingSpeKillsSorFButton", line, "?", function() UI.Alert("Choose between counting kills of defending special units only for successful attacks, failed attacks, or both.") end, buttonColor);
	-- newLabel(win .. "DefendingSpeKillsSorFCheckBoxLabel", line, "TODOPrevious option is only counted for: ", textColor);
	newButton(win .. "DefendingSpeKillsSorFButton2", line, SorFtable[inputDefendingSpeKillSorF], cycleDefendingSpeKillSorF, buttonColor);

	textLabel = "Extra gold from attacking special units killed:"  --option to add: last turn only (current and default) or all turns (todo)
	textAlertStart = alertTextButtonStart();
	textAlertEnd = alertTextButtonEnd();
	iAttackingSpeKills = labelButtonNumberField(vertAdvanced, "AttackingSpeKills", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	local line = newHorizontalGroup(win .. "lineAttackingSpeKillsSorF", vertAdvanced);
	newButton(win .. "AttackingSpeKillsSorFButton", line, "?", function() UI.Alert("Choose between counting attacking special units kills only for successful attacks, failed attacks, or both.") end, buttonColor);
	-- newLabel(win .. "AttackingSpeKillsSorFCheckBoxLabel", line, "TODOPrevious option is only counted for: ", textColor);
	newButton(win .. "AttackingSpeKillsSorFButton2", line, SorFtable[inputAttackingSpeKillSorF], cycleAttackingSpeKillSorF, buttonColor);

	-- textLabel = "Extra gold from:"
	-- textAlertStart = alertTextButtonStart();
	-- textAlertEnd = alertTextButtonEnd();
	-- iM = labelButtonNumberField(vertAdvanced, "M", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	-- textLabel = "Extra gold from:"
	-- textAlertStart = alertTextButtonStart();
	-- textAlertEnd = alertTextButtonEnd();
	-- iN = labelButtonNumberField(vertAdvanced, "N", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);

	-- textLabel = "Extra gold from:"
	-- textAlertStart = alertTextButtonStart();
	-- textAlertEnd = alertTextButtonEnd();
	-- iO = labelButtonNumberField(vertAdvanced, "TODO5", -10, 10, textLabel, inputs, textAlertStart, textAlertEnd);


end

function IncludeExcludeAdvanced()
	if inputAdvanced then
		inputAdvanced = false
		SaveInputs();
		ShowOptions()
	else
		inputAdvanced = true;
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
	inputs["Me"] = getValue(iMe);
	inputs["Const"] = getValue(iConst);
	inputs["Ally"] = getValue(iAlly);
	inputs["Ennemy"] = getValue(iEnnemy);
	inputs["Income"] = getValue(iIncome);
	inputs["Turn"] = getValue(iTurn);
	inputs["G"] = getValue(iG);
	inputs["H"] = getValue(iH);
	inputs["TerritoryCapture"] = getValue(iTerritoryCapture);
	inputs["BonusCaptured"] = getValue(iBonusCaptured);
	inputs["DefendingKills"] = getValue(iDefendingKills);
	inputs["AttackingKills"] = getValue(iAttackingKills);
	inputs["DefendingSpeKills"] = getValue(iDefendingSpeKills);
	inputs["AttackingSpeKills"] = getValue(iAttackingSpeKills);
end