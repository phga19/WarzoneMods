function Client_SaveConfigureUI(alert)
	print("Client_SaveConfigureUI")
	Mod.Settings.TargetMe = getIsChecked(win .. "MeCheckBox")
	Mod.Settings.TargetAllies = getIsChecked(win .. "AlliesCheckBox")
	Mod.Settings.TargetEnnemies = getIsChecked(win .. "EnnemiesCheckBox")
	Mod.Settings.Advanced = getIsChecked(win .. "AdvancedCheckBox")
	if Mod.Settings.TargetMe then
		Mod.Settings.A = getValue(win .. "InputA");
		Mod.Settings.B = getValue(win .. "InputB");
	else
		Mod.Settings.A = 0;
		Mod.Settings.B = 0;
	end
	if Mod.Settings.TargetAllies then
		Mod.Settings.C = getValue(win .. "InputC");
	else
		Mod.Settings.C = 0;
	end
	if Mod.Settings.TargetEnnemies then
		Mod.Settings.D = getValue(win .. "InputD");
	else
		Mod.Settings.D = 0;
	end
	if Mod.Settings.Advanced then
		Mod.Settings.E = getValue(win .. "InputE");
		Mod.Settings.F = getValue(win .. "InputF");
		Mod.Settings.G = getValue(win .. "InputG");
		Mod.Settings.H = getValue(win .. "InputH");
		Mod.Settings.I = getValue(win .. "InputI");
		Mod.Settings.J = getValue(win .. "InputJ");
		Mod.Settings.K = getValue(win .. "InputK");
		Mod.Settings.L = getValue(win .. "InputL");
		Mod.Settings.M = getValue(win .. "InputM");
		Mod.Settings.N = getValue(win .. "InputN");
	else
		Mod.Settings.E = 0;
		Mod.Settings.F = 0;
		Mod.Settings.G = 0;
		Mod.Settings.H = 0;
		Mod.Settings.I = 0;
		Mod.Settings.J = 0;
		Mod.Settings.K = 0;
		Mod.Settings.L = 0;
		Mod.Settings.M = 0;
		Mod.Settings.N = 0;
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