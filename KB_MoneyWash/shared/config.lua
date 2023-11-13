Config = {}

Config.Menu = 'NativeUI'  -- ox_lib or NativeUI

Config.Coords = {
    {710.92, 4185.36, 41.08},
    {634.87, 2774.97, 42.01}
}

Config.Fee = 0.1 -- 10% fee

Config.Language = 'en' -- You can choose between 'en' and 'de'.

-- WeebHook --

Config.Webhook = ""

Config.DateFormat = '%x %H:%M' -- Here you can find the various options for formatting time: https://www.lua.org/pil/22.1.html

Config.Name = 'Money Wash'

Config.Color = 16711680 -- You can find the required number under "Decimal value" on this website: https://www.spycolor.com

-- Translations --

Config.Translation = {

    ['de'] = {
        ['notEnoughMoney'] = 'Du hast nicht genug Schwarzgeld',
        ['showInfoBar'] = 'Drücke ~g~E~s~, um auf die Geldwäsche zuzugreifen',
        ['moneyWash'] = 'Geldwäsche',
        ['howMuch'] = 'Wie viel?',
        ['moneyLaundering'] = 'Geldwaschen',
        ['launderYourMoney'] = 'Dein Geld waschen',
        ['howMuchMoney'] = 'Wie viel Geld willst du waschen?',
        ['youHaveLaundered'] = 'Du hast gewaschen: ~g~'
    },

    ['en'] = {
        ['notEnoughMoney'] = 'You do not have enough blackmoney',
        ['showInfoBar'] =  'Press ~g~E~s~, to access money laundering',
        ['moneyWash'] = 'Money Wash',
        ['howMuch'] = 'How much?',
        ['moneyLaundering'] = 'Money laundering',
        ['launderYourMoney'] = 'Launder your money',
        ['howMuchMoney'] = 'How much money do you want to launder?',
        ['youHaveLaundered'] =  'You have laundered: ~g~'
    }
}
