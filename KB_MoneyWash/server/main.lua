print("----------------------------------------------------------")
print("")
print("        KK    KK     BBBBBB")
print("        KK  KK       BB    BB")
print("        KKKK         BBBBBB")
print("        KK  KK       BB    BB")
print("        KK    KK     BBBBBB")
print("")
print("             MoneyWash")
print("----------------------------------------------------------")




ESX = exports['es_extended']:getSharedObject()

local Translation = Config.Translation
local Language = Config.Language

RegisterServerEvent('KBMoneyWash:wash')
AddEventHandler('KBMoneyWash:wash', function (amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyback = amount * 0.8 

    if xPlayer.getAccount('black_money').money >= amount then
        xPlayer.removeAccountMoney('black_money', amount)
        xPlayer.addAccountMoney('money', moneyback)
        xPlayer.showNotification(Translation[Language]['youHaveLaundered'] .. amount)
        MoneWashLogs(amount)
    else
        xPlayer.showNotification(Translation[Language]['notEnoughMoney'])
    end

end)

function MoneWashLogs(amount)

    local identifiers = GetPlayerIdentifiers(source)
    
    local discordID, fivemIdentifier
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "discord:") then
            discordID = string.sub(identifier, 9)
        elseif string.find(identifier, "license:") then
            fivemIdentifier = string.sub(identifier, 9)
        end
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    local playerid = xPlayer.source
    local name = xPlayer.getName(xPlayer)
    local money = xPlayer.getAccount('money').money
    local blackMoney = xPlayer.getAccount('black_money').money
    local bank = xPlayer.getAccount('bank').money

    url = Config.Webhook

    local embeds = {
        {
            ["title"] = "Money Wash",
            ["type"] = "rich",
            ["color"] = Config.Color,
            ["description"] = '**Amount:** '..amount..'\n'..'\n'..'\n**User:** '..name..'\n**ID:** '..playerid..'\n**Money:** '..money..'\n**Bank:** '..bank..'\n**Black Money:** '..blackMoney..'\n**identifier: **'..'||**'..fivemIdentifier..'**||**'..'\n**DiscordID: **'..'||'..discordID..'||**',
            ["footer"] = {
				["text"] = os.date(Config.DateFormat),
			}
        }
    }
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = Config.Name, embeds = embeds}), { ['Content-Type'] = 'application/json'})
end