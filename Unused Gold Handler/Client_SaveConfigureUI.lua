require("UI");
function Client_SaveConfigureUI(alert)
	print("Client_SaveConfigureUI")
	Mod.Settings.TargetMe = getIsChecked(win .. "MeCheckBox");
	Mod.Settings.TargetAllies = getIsChecked(win .. "AlliesCheckBox")
	Mod.Settings.TargetEnnemies = getIsChecked(win .. "EnnemiesCheckBox")
	Mod.Settings.Advanced = getIsChecked(win .. "AdvancedCheckBox")
	local suffix = "I"
	local TextToSorF =
	{
		["Success only"] = "S",
		["Failure only"] = "F",
		["Success and Failure"] = "SF",
	}
	if Mod.Settings.TargetMe then
		Mod.Settings.Me = getValue(getUIName(suffix, "Me"));
		Mod.Settings.Const = getValue(getUIName(suffix, "Const"));
	else
		Mod.Settings.Me = 0;
		Mod.Settings.Const = 0;
	end
	if Mod.Settings.TargetAllies then
		Mod.Settings.Ally = getValue(getUIName(suffix, "Ally"));
	else
		Mod.Settings.Ally = 0;
	end
	if Mod.Settings.TargetEnnemies then
		Mod.Settings.Ennemy = getValue(getUIName(suffix, "Ennemy"));
	else
		Mod.Settings.Ennemy = 0;
	end
	if Mod.Settings.Advanced then
		Mod.Settings.Income = getValue(getUIName(suffix, "Income"));
		Mod.Settings.Turn = getValue(getUIName(suffix, "Turn"));
		Mod.Settings.G = getValue(getUIName(suffix, "G"));
		Mod.Settings.H = getValue(getUIName(suffix, "H"));
		Mod.Settings.TerritoryCapture = getValue(getUIName(suffix, "TerritoryCapture"));
		Mod.Settings.BonusCaptured = getValue(getUIName(suffix, "BonusCaptured"));
		Mod.Settings.DefendingKills = getValue(getUIName(suffix, "DefendingKills"));
		Mod.Settings.DefendingKillSorF = TextToSorF[getText(win .. "DefendingKillsSorFButton2")];
		Mod.Settings.AttackingKills = getValue(getUIName(suffix, "AttackingKills"));
		Mod.Settings.AttackingKillSorF = TextToSorF[getText(win .. "AttackingKillsSorFButton2")];
		Mod.Settings.DefendingSpeKills = getValue(getUIName(suffix, "DefendingSpeKills"));
		Mod.Settings.DefendingSpeKillSorF = TextToSorF[getText(win .. "DefendingSpeKillsSorFButton2")];
		Mod.Settings.AttackingSpeKills = getValue(getUIName(suffix, "AttackingSpeKills"));
		Mod.Settings.AttackingSpeKillSorF = TextToSorF[getText(win .. "AttackingSpeKillsSorFButton2")];
	else
		Mod.Settings.Income = 0;
		Mod.Settings.Turn = 0;
		Mod.Settings.G = 0;
		Mod.Settings.H = 0;
		Mod.Settings.TerritoryCapture = 0;
		Mod.Settings.BonusCaptured = 0;
		Mod.Settings.DefendingKills = 0;
		Mod.Settings.DefendingKillSorF = "SF";
		Mod.Settings.AttackingKills = 0;
		Mod.Settings.AttackingKillSorF = "SF";
		Mod.Settings.DefendingSpeKills = 0;
		Mod.Settings.DefendingSpeKillSorF = "SF";
		Mod.Settings.AttackingSpeKills = 0;
		Mod.Settings.AttackingSpeKillSorF = "SF";
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