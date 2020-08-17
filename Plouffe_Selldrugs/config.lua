SellDrugs = {}

TriggerEvent('Bckekw:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent('Bckekw:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

SellDrugs.Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

SellDrugs.txt ={
    ["not_decor"] = 'Ta du stock a vendre ?',
    ["has_decor"] = "Pour un pochon je t'offre ",
    ["refused"] = "Vous aviez l'air louche la personne a changer d'idée",
    ["alreadysold"] = "Vous avez deja vendu a cette personne",
    ["policealert"] = "Une vente de drogue a été déclaré par un civil zone: ",
    ["notenough"] = "Vous n'avez pas asser de produits.",
    ["sold"] = "Vous avez vendu vos produits pour: "
}

SellDrugs.DrugsArray = {
    {["Zone"] = "Vinewood Hills",["Name"] = "Coke",  ["itemName"] = "pooch_coke",  ["minMultiplier"] = 1, ["maxMultiplier"] = 8, ["minPrice"] = 95, ["maxPrice"] = 160,["zone"] = vector3(138.55, 217.9, 108.82)   , ["range"] = 300}, --Hollywood Boulevard
    {["Zone"] = "Vesspucci",["Name"] = "Heroine",  ["itemName"] = "pooch_heroine",  ["minMultiplier"] = 1, ["maxMultiplier"] = 7, ["minPrice"] = 80, ["maxPrice"] = 150,  ["zone"] = vector3(-803.02, -925.73, 18.51)  , ["range"] = 250}, --Depaneur de vespucci
    {["Zone"] = "Mirror Park",["Name"] = "Meth",  ["itemName"] = "pooch_meth",  ["minMultiplier"] = 1, ["maxMultiplier"] = 6, ["minPrice"] = 70, ["maxPrice"] = 140, ["zone"] = vector3(1159.89, -592.21, 64.05)  , ["range"] = 300}, -- Cartier ou il y a le lac a droite
    {["Zone"] = "Terrain de camping",["Name"] = "Opium", ["itemName"] = "pooch_opium", ["minMultiplier"] = 1, ["maxMultiplier"] = 6, ["minPrice"] = 65, ["maxPrice"] = 110, ["zone"] = vector3(-1125.97, 4923.27, 219.04), ["range"] = 120}, ---Cartier des tout nue
    {["Zone"] = "Grapeseed",["Name"] = "Mdma", ["itemName"] = "pooch_mdma", ["minMultiplier"] = 3, ["maxMultiplier"] = 6, ["minPrice"] = 40, ["maxPrice"] = 95, ["zone"] = vector3(1682.06,4829.6,42.13), ["range"] = 200}, ---Grapeseed
    {["Zone"] = "Sandy Shore",["Name"] = "Lsd", ["itemName"] = "pooch_lsd", ["minMultiplier"] = 1, ["maxMultiplier"] = 6, ["minPrice"] = 70, ["maxPrice"] = 105, ["zone"] = vector3(1774.02,3690.6,34.67), ["range"] = 300}, ---Sandy
    {["Zone"] = "Sud de la ville",["Name"] = "Weed", ["itemName"] = "weedjoint", ["minMultiplier"] = 1, ["maxMultiplier"] = 6, ["minPrice"] = 90, ["maxPrice"] = 160, ["zone"] = vector3(1068.32, -2382.61, 30.72), ["range"] = 300} ---Ancien impoort
}

SellDrugs.PriceDecor = "DRUG_OFFER"
SellDrugs.CallPercent = 10
SellDrugs.PedReject = 8
SellDrugs.PedSetUp = 1