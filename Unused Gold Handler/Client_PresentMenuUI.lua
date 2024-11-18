require("util");
function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)
	print("Client_PresentMenuUI")
-- 	for p, _q in pairs(game.ServerGame.Game.PlayingPlayers) do
-- 		local mods = {};
-- 	   local extraIncomeReceived = getExtraIncomeReceived(p, q.Income(0, game.ServerGame.DistributionStanding , true, true), game.ServerGame.Game.TurnNumber);
-- 	   print(extraIncomeReceived);
-- 	   table.insert(mods, WL.IncomeMod.Create(p, unspentGold, "Income from Unspent Gold Manager"));
-- 	   addNewOrder(WL.GameOrderEvent.Create(p, "Adjusted income (Unspent Gold Manager)", {}, {}, {}, mods));
--    end
    UI.CreateLabel(rootParent).SetText("The income bonus from your unspent gold this turn is: " .. "TODO");
end