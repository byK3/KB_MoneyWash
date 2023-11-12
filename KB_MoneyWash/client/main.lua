ESX = exports['es_extended']:getSharedObject()

local Translation = Config.Translation
local Language = Config.Language

_menuPool = NativeUI.CreatePool()
local isNearMoneyWash = false

Citizen.CreateThread(function ()
    while true do

        for k, v in pairs(Config.Coords) do
            DrawMarker(27, v[1], v[2], v[3] -0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 50, 60, 100, false, true, 2, false, false, false, false)
        end

        Wait(1)
    end
end)

if Config.Menu == 'ox_lib' then
    Citizen.CreateThread(function()
        while true do
    
            local sleep = 350
    
            local playerCoords =GetEntityCoords(PlayerPedId())
            isNearMoneyWash = false
    
            for k, v in pairs(Config.Coords) do
                local dist = Vdist(playerCoords, v[1], v[2], v[3])
                if dist < 1.5 then
                    sleep = 1
                    showInfobar(Translation[Language]['showInfoBar'])
                    
                    if IsControlJustReleased(0, 38) then
                        moneWashMenu()
                    end
    
                end
            end
            Citizen.Wait(sleep)
        end
    end)
    
    RegisterNetEvent('KBMoneyWash:input')
    AddEventHandler('KBMoneyWash:input', function ()
        amount = lib.inputDialog(Translation[Language]['moneyWash'], {
            {type = 'input', label = Translation[Language]['howMuch']}
        })
    
        TriggerServerEvent('KBMoneyWash:wash', tonumber(amount[1]))
    
    end)
    
    function moneWashMenu()
        
        lib.registerContext({
            id = 'moneyWash',
            title = Translation[Language]['moneyWash'],
            options = {
                {title = Translation[Language]['moneyLaundering'], event = 'KBMoneyWash:input'}
            }
        })
    
        lib.showContext('moneyWash')
    end
elseif Config.Menu == 'NativeUI' then
    Citizen.CreateThread(function()
        while true do
    
            local playerCoords =GetEntityCoords(PlayerPedId())
            isNearMoneyWash = false
    
            for k, v in pairs(Config.Coords) do
                local dist = Vdist(playerCoords, v[1], v[2], v[3])
                if dist < 1.5 then
                    isNearMoneyWash = true
                end
            end
            Citizen.Wait(350)
        end
    end)
    
    Citizen.CreateThread(function()
        while true do
    
            _menuPool:ProcessMenus()
    
            if isNearMoneyWash then
                showInfobar(Translation[Language]['showInfoBar'])
                if IsControlJustReleased(0, 38) then
                     --- open menu
                    openMoneyWash()
                end
            elseif _menuPool:IsAnyMenuOpen() then
                _menuPool:CloseAllMenus()
            end
            
            Citizen.Wait(1)
        end
    end)
    
    function openMoneyWash()
    
        local moneyMenu = NativeUI.CreateMenu(Translation[Language]['moneyWash'])
        _menuPool:Add(moneyMenu)
    
        local washItem = NativeUI.CreateItem(Translation[Language]['launderYourMoney'], '')
        moneyMenu:AddItem(washItem)
    
        washItem.Activated = function(sender, index)
            local input = CreateDialog(Translation[Language]['howMuchMoney'])
            input = tonumber(input)
            if input ~= nil and input > 0 then
                TriggerServerEvent('KBMoneyWash:wash', input)
            end
        end
    
    
    
    
        moneyMenu:Visible(true)
        _menuPool:MouseEdgeEnabled(false)
    end
end





function showInfobar(msg)

    CurrentActionMsg  = msg
    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end


function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
    AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
    DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local displayResult = GetOnscreenKeyboardResult()
        return displayResult
    end
end