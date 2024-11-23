function AdjustIncome(game, playerID, income, team, standing, teamsUnspentGold, sumTeamsUnspentGold)
	local money = {};
	local turn = game.ServerGame.Game.TurnNumber;
	local teamUnspentGold = teamsUnspentGold[team]
	-- print("AdjustIncome teamUnspentGold AAAAAA" .. teamUnspentGold)

    local unspentGold = standing.NumResources(playerID, WL.ResourceType.Gold);
    local totalAlliesUnspentGold = 0;
    local totalEnnemiesUnspentGold = 0;
	if team == 0 then
		print("team0" .. team)
		totalAlliesUnspentGold = 0;
		-- print("unspentGold" .. unspentGold)
		-- print("sumTeamsUnspentGold" .. sumTeamsUnspentGold)
		totalEnnemiesUnspentGold = sumTeamsUnspentGold - unspentGold;
    else
		print("team!" .. team)
		print("unspentGold" .. unspentGold)
		print("teamUnspentGold" .. teamUnspentGold)
		-- print("sumTeamsUnspentGold" .. sumTeamsUnspentGold)
		totalAlliesUnspentGold = teamUnspentGold - unspentGold;
		-- print("sumTeamsUnspentGold BBBBBBB team " .. team .. "  ABCABC " .. teamUnspentGold .. " CCCC " .. sumTeamsUnspentGold)
		totalEnnemiesUnspentGold = sumTeamsUnspentGold - teamUnspentGold;
	end
    local todo = 0;
	-- print("Me" .. Mod.Settings.Me)
	-- print("unspentGold" .. unspentGold)
	local tMe = Mod.Settings.Me * unspentGold;
	-- print("untConstspentGold" .. Mod.Settings.Const)
	local tConst = Mod.Settings.Const;
	print("totalAlliesUnspentGold" .. totalAlliesUnspentGold)
	print("Ally" .. Mod.Settings.Ally)
	local tAlly = Mod.Settings.Ally * totalAlliesUnspentGold;
	print("tAlly" .. tAlly)
	-- print("totalEnnemiesUnspentGold" .. totalEnnemiesUnspentGold)
	-- print("Ennemy" .. Mod.Settings.Ennemy)
	local tEnnemy = Mod.Settings.Ennemy * totalEnnemiesUnspentGold;
	-- print("income" .. income)
	-- print("Income" .. Mod.Settings.Income)
	local tIncome = Mod.Settings.Income * income;
	-- print("turn" .. turn)
	-- print("Turn" .. Mod.Settings.Turn)
	local tTurn = Mod.Settings.Turn * turn;
	local tG = Mod.Settings.G * todo;
	local tH = Mod.Settings.H * todo;
	--TODO add option to sum all at once into money. Better readability, but less information available
	--TODO add option to not showing bonuses worth 0. Better readability, but less information available
	if Mod.Settings.Me ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tMe, "Your unspent gold")); --TODO delete after tests
	end
	if Mod.Settings.Const ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tConst, "1 or more unspent gold constant")); --TODO delete after tests
	end
	-- if Mod.Settings.Me ~= 0 or Mod.Settings.Const ~= 0 then
		--table.insert(money, WL.IncomeMod.Create(playerID, tMe + tConst, "Your unspent gold")); --TODO add after tests
	-- end
	if Mod.Settings.Ally ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tAlly, "Your allies unspent gold"));
	end
	if Mod.Settings.Ennemy ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tEnnemy, "Your ennemies unspent gold"));
	end
	if Mod.Settings.Income ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tIncome, "Your income"));
	end
	if Mod.Settings.Turn ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tTurn, "Turn number"));
	end
	if Mod.Settings.G ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tG, "TODO"));
	end
	if Mod.Settings.H ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tH, "TODO"));
	end
	if Mod.Settings.TerritoryCapture ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tTerritoryCaptured[playerID], "Territories captured"));
	end
	if Mod.Settings.BonusCaptured ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tBonusCaptured[playerID], "Bonus captured"));
	end
	if Mod.Settings.DefendingKills ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tDefendingKills[playerID], "Defenders killed"));
	end
	if Mod.Settings.AttackingKills ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tAttackingKills[playerID], "Attackers killed"));
	end
	if Mod.Settings.DefendingSpeKills ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tDefendingSpeKills[playerID], "Special Defenders killed"));
	end
	if Mod.Settings.AttackingSpeKills ~= 0 then
		table.insert(money, WL.IncomeMod.Create(playerID, tAttackingSpeKills[playerID], "Special Attackers killed"));
	end
    -- extraIncomeReceived = tMe + tConst + tAlly + tEnnemy + tIncome + tTurn + tG + tH +...
	-- print("AdjustIncome playerID " .. playerID .. " TOTAL " .. extraIncomeReceived)
	return money;
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

function isIn(value, list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set[value] or false
end

function Round(n)
	return math.floor(n + 0.5);
end

-- function CreateHorizontalArray(size)
--     local arr = {}
--     for i=0, size-1 do
--         arr[i] = getNewHorz(vert)
--     end
--     return arr
-- end