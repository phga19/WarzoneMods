require("util");
function Server_AdvanceTurn_Start(game, addNewOrder)
	print("Server_AdvanceTurn_Start")
	local playerGameData = Mod.PlayerGameData;
	tTerritoryCaptured = {};
	tBonusCaptured = {};
	tDefendingKills = {};
	tAttackingKills = {};
	tDefendingSpeKills = {};
	tAttackingSpeKills = {};
	for playerID, playerData in pairs(game.Game.PlayingPlayers) do  -- this or game.ServerGame.Game.Players?
		-- if playerID.IsAI == false then -- TODO add option to not do computation on AIs
		tTerritoryCaptured[playerID] = 0;
		tBonusCaptured[playerID] = 0;
		tDefendingKills[playerID] = 0;
		tAttackingKills[playerID] = 0;
		tDefendingSpeKills[playerID] = 0;
		tAttackingSpeKills[playerID] = 0;
	end
	
end

function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer") then
		if result.IsAttack then
			if result.IsSuccessful and order.PlayerID ~= WL.PlayerID.Neutral then
				tTerritoryCaptured[order.PlayerID] = tTerritoryCaptured[order.PlayerID] + Mod.Settings.TerritoryCapture;
				if Mod.Settings.BonusCapture ~= 0 then
					for _, bonus in pairs(game.Map.Territories[order.To].PartOfBonuses) do
						if BonusOwned(game, bonus, order.To, order.PlayerID) then
							tBonusCaptured[order.PlayerID] = tBonusCaptured[order.PlayerID] + Mod.Settings.BonusCapture;
						end
					end
				end
			end
			local territory = game.ServerGame.LatestTurnStanding.Territories[order.To];
			local owner = territory.OwnerPlayerID;
			if owner ~= order.PlayerID then
				if order.PlayerID ~= WL.PlayerID.Neutral and Mod.Settings.DefendingKills ~= 0 and
				((result.IsSuccessful and Mod.Settings.DefendingKillSorF ~= "F")  or ((not result.IsSuccessful) and Mod.Settings.DefendingKillSorF ~= "S")) then
					tDefendingKills[order.PlayerID] = tDefendingKills[order.PlayerID] + Mod.Settings.DefendingKills*result.DefendingArmiesKilled.NumArmies;
				end
				if owner ~= WL.PlayerID.Neutral and Mod.Settings.AttackingKills ~= 0 and
				((result.IsSuccessful and Mod.Settings.AttackingKillSorF ~= "F") or ((not result.IsSuccessful) and Mod.Settings.AttackingKillSorF ~= "S")) then
					tAttackingKills[order.PlayerID] = tAttackingKills[order.PlayerID] + Mod.Settings.AttackingKills*result.AttackingArmiesKilled.NumArmies;
				end
				
				if order.PlayerID ~= WL.PlayerID.Neutral and Mod.Settings.DefendingSpeKills ~= 0 and
				((result.IsSuccessful and Mod.Settings.DefendingSpeKillSorF ~= "F") or ((not result.IsSuccessful) and Mod.Settings.DefendingSpeKillSorF ~= "S")) then
					local count = 0
					for _, unit in ipairs(result.DefendingArmiesKilled.SpecialUnits) do
						count = count + 1
					end
					tDefendingSpeKills[order.PlayerID] = tDefendingSpeKills[order.PlayerID] + Mod.Settings.DefendingSpeKills*count;
				end
				if owner ~= WL.PlayerID.Neutral and Mod.Settings.AttackingSpeKills ~= 0 and
				((result.IsSuccessful and Mod.Settings.AttackingSpeKillSorF ~= "F") or ((not result.IsSuccessful) and Mod.Settings.AttackingSpeKillSorF ~= "S")) then
					local count = 0
					for _, unit in ipairs(result.AttackingArmiesKilled.SpecialUnits) do
						count = count + 1
					end
					tAttackingSpeKills[order.PlayerID] = tAttackingSpeKills[order.PlayerID] + Mod.Settings.AttackingSpeKills*count;
				end
				-- if territory.NumArmies.SpecialUnits > 0 and order.PlayerID ~= WL.PlayerID.Neutral and (result.IsSuccessful and Mod.Settings.MSuccess or not result.IsSuccessful and Mod.Settings.MFail) then
				-- 	local damageTotal = 0;
				-- 	for id_damaged, damage in pairs(result.DamageToSpecialUnits) do
				-- 		for id, specialUnit in pairs(territory.NumArmies.SpecialUnits) do
				-- 			specialUnit
				-- 			if id == id_damaged then
				-- 				break;
				-- 			end
				-- 		end
				-- 		if kills and Mod.Settings.MKill then
				-- 			damageTotal = damageTotal + damage;
				-- 		end
				-- 	end
				-- 	OrderBonus[order.PlayerID] = OrderBonus[order.PlayerID] + Mod.Settings.M*damageTotal;
				-- end
				-- if owner ~= WL.PlayerID.Neutral and (result.IsSuccessful and Mod.Settings.NSuccess or not result.IsSuccessful and Mod.Settings.NFail) then
				-- 	OrderBonus[order.PlayerID] = OrderBonus[order.PlayerID] + Mod.Settings.N*result.ActualArmies.NumArmies;
				-- end
			end
		end
	end
end

function Server_AdvanceTurn_End(game, addNewOrder)
	if game.ServerGame.Settings.CommerceGame == true then
		local players = game.ServerGame.Game.PlayingPlayers
		local standing = game.ServerGame.LatestTurnStanding;
		local teamsUnspentGold = {};
		
		for playerID, playerData in pairs(players) do
			local team = playerData.Team + 1
			-- print("playerID " .. playerID)
			-- print("team " .. team)
			-- print("teamsUnspentGold " .. (teamsUnspentGold[team] or 0))
			-- print("income " .. standing.NumResources(p, WL.ResourceType.Gold))
			-- print("total " .. standing.NumResources(p, WL.ResourceType.Gold) + (teamsUnspentGold[q.Team + 1] or 0))
			-- print("table.unpack(teamsUnspentGold)")
			-- print(teamsUnspentGold[q.Team +1])
			teamsUnspentGold[team] = standing.NumResources(playerID, WL.ResourceType.Gold) + (teamsUnspentGold[team] or 0)
			print(table.unpack(teamsUnspentGold))
		end
		local sumTeamsUnspentGold = 0;
		for teamID, teamGold in ipairs(teamsUnspentGold) do
			print("Server_AdvanceTurn_End sumTeamsUnspentGold t " .. teamID .. " income " .. teamGold)
			sumTeamsUnspentGold = sumTeamsUnspentGold + teamGold;
		end
		print("Server_AdvanceTurn_End sumTeamsUnspentGold TOTAL" .. sumTeamsUnspentGold)
		for playerID, playerData in pairs(players) do
			local income = playerData.Income(0, standing, true, true).Total
			local team = playerData.Team + 1
			local money = AdjustIncome(game, playerID, income, team, standing, teamsUnspentGold, sumTeamsUnspentGold)
			addNewOrder(WL.GameOrderEvent.Create(playerID, "Adjusted income (Unspent Gold Manager)", {}, {}, {}, money));
		end
	end
end