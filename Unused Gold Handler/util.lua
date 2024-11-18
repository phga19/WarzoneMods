
function AdjustIncome(game, playerID, income, team, standing, teamsUnspentGold, sumTeamsUnspentGold)
	local money = {};
	local turn = game.ServerGame.Game.TurnNumber;
	local teamUnspentGold = teamsUnspentGold[team]
	-- print("AdjustIncome teamUnspentGold AAAAAA" .. teamUnspentGold)

    local unspentGold = standing.NumResources(playerID, WL.ResourceType.Gold);
    local totalAlliesUnspentGold = 0;
    local totalEnnemiesUnspentGold = 0;
	if team == 0 then
		totalAlliesUnspentGold = 0;
		totalEnnemiesUnspentGold = sumTeamsUnspentGold - unspentGold;
    else
		totalAlliesUnspentGold = teamUnspentGold - unspentGold;
		-- print("sumTeamsUnspentGold BBBBBBB team " .. team .. "  ABCABC " .. teamUnspentGold .. " CCCC " .. sumTeamsUnspentGold)
		totalEnnemiesUnspentGold = sumTeamsUnspentGold - teamUnspentGold;
	end
    local todo = 0;
	-- print("Mod.Settings.A " .. Mod.Settings.A .. " unspentGold " .. unspentGold .. " A_total " .. unspentGold * Mod.Settings.A)
	-- print("Mod.Settings.B " .. Mod.Settings.B)
	-- print("Mod.Settings.C " .. Mod.Settings.C .. " totalAlliesUnspentGold " .. totalAlliesUnspentGold .. " C_total " .. totalAlliesUnspentGold*Mod.Settings.C)
	-- print("Mod.Settings.D " .. Mod.Settings.D .. " totalEnnemiesUnspentGold " .. totalEnnemiesUnspentGold .. " D_total " .. totalEnnemiesUnspentGold*Mod.Settings.D)
	-- print("Mod.Settings.E " .. Mod.Settings.E .. " income " .. income .. " E_total " .. income*Mod.Settings.E)
	-- print("Mod.Settings.F " .. Mod.Settings.F .. " turn " .. turn .. " F_total " .. turn*Mod.Settings.F)
	-- print("Mod.Settings.G " .. Mod.Settings.G .. " todo " .. todo .. " G_total " .. todo*Mod.Settings.G)
	-- print("Mod.Settings.H " .. Mod.Settings.H .. " todo " .. todo .. " H_total " .. todo*Mod.Settings.H)
	local tA = Mod.Settings.A * unspentGold;
	local tB = Mod.Settings.B;
	local tC = Mod.Settings.C * totalAlliesUnspentGold;
	local tD = Mod.Settings.D * totalEnnemiesUnspentGold;
	local tE = Mod.Settings.E * income;
	local tF = Mod.Settings.F * turn;
	local tG = Mod.Settings.G * todo;
	local tH = Mod.Settings.H * todo;
	local tIJKL = OrderBonus[playerID];
	local tM = Mod.Settings.M * todo;
	local tN = Mod.Settings.N * todo;

    extraIncomeReceived = tA + tB + tC + tD + tE + tF + tG + tH + tIJKL + tM + tN;
	print("AdjustIncome playerID " .. playerID .. " TOTAL " .. extraIncomeReceived)
	return table.insert(money, WL.IncomeMod.Create(playerID, extraIncomeReceived, "Income from Unspent Gold Manager"));
end

function BonusOwned(game, bonusid, ignorterrid, playerID)
	for _, terrid in pairs(game.Map.Bonuses[bonusid].Territories)do
		if terrid ~= ignorterrid then
			if game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID ~= playerID then
				return false;
			end
		end
	end
	return true;
end

-- function CreateHorizontalArray(size)
--     local arr = {}
--     for i=0, size-1 do
--         arr[i] = getNewHorz(vert)
--     end
--     return arr
-- end