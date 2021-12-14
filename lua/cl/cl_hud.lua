-- EasyHud Инфо:
-- Название: EasyHud
-- Описание: Простенький худ для даркрп
-- Автор: Sp0k1_n0k1


print ( '[EasyHud] HUD loaded!' )

local hideHUDElements = {
	-- if you DarkRP_HUD this to true, ALL of DarkRP's HUD will be disabled. That is the health bar and stuff,
	-- but also the agenda, the voice chat icons, lockdown text, player arrested text and the names above players' heads
	["DarkRP_HUD"] = true,

	-- DarkRP_EntityDisplay is the text that is drawn above a player when you look at them.
	-- This also draws the information on doors and vehicles
	["DarkRP_EntityDisplay"] = false,

	-- This is the one you're most likely to replace first
	-- DarkRP_LocalPlayerHUD is the default HUD you see on the bottom left of the screen
	-- It shows your health, job, salary and wallet, but NOT hunger (if you have hungermod enabled)
	["DarkRP_LocalPlayerHUD"] = false,

	-- If you have hungermod enabled, you will see a hunger bar in the DarkRP_LocalPlayerHUD
	-- This does not get disabled with DarkRP_LocalPlayerHUD so you will need to disable DarkRP_Hungermod too
	["DarkRP_Hungermod"] = false,

	-- Drawing the DarkRP agenda
	["DarkRP_Agenda"] = false,

	-- Lockdown info on the HUD
	["DarkRP_LockdownHUD"] = false,

	-- Arrested HUD
	["DarkRP_ArrestedHUD"] = false,
}
 
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)
 
local function HUDHide ( myfirsthud )
    for k, v in pairs{ 'CHudHealth', 'CHudBattery', 'CHudAmmo' } do
        if myfirsthud == v then return false end
    end
end
 
hook.Add('HUDShouldDraw', 'HUDHide', HUDHide)
 
local x = 15
local y = ScrH() - 150
 
-- Шрифт
surface.CreateFont('asd123', {
    font = 'Open Sans Bold',
    size = 24,
    weight = 600,
})
 
local function MyFirstHud()
 
-- переменные
    
    local ply = LocalPlayer()
    local hp = ply:Health() or 0
    local maxhp = ply:GetMaxHealth() or 0
    local armor = ply:Armor() or 0
    local money = ply:getDarkRPVar( "money" )
    local job = ply:getDarkRPVar( "job" )
	local salary = ply:getDarkRPVar( "salary" )
	local name = ply:Nick()
 
-- Боксы
 
    draw.RoundedBox(1, x + 15, y + 20, 300, 60, Color(0,0,0,150))
	draw.RoundedBox(1, x + 15, y + -90, 300, 100, Color(0,0,0,150))
 
-- ХП
 
    draw.RoundedBox(2, x + 70, y + 27, 230, 20, Color(0,0,0,150))
 
    draw.RoundedBox(2, x + 70, y + 27, math.Clamp(hp, 0, maxhp)*2.3, 20, Color(255,0,0,255))
 
    draw.SimpleText('ХП :                 ' .. hp .. ' / ' .. maxhp , 'asd123' , x + 25, y + 25, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
 
-- Броня
 
    draw.RoundedBox(2, x + 70, y + 53, 230, 20, Color(0,0,0,150))
 
    draw.RoundedBox(2, x + 70, y + 53, math.Clamp(armor, 0, 100)*2.3, 20, Color(0,95,255,255))
 
    draw.SimpleText('AR :                 ' .. armor .. ' / ' .. '100' , 'asd123' , x + 25, y + 50, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
 
-- Работа
 
draw.SimpleText('Работа: ' .. job, 'asd123' , x + 30, y + -55, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
 
-- Деньги
 
draw.SimpleText('Деньги: ' .. money .. '$' .. ' | ' .. salary .. '$' , 'asd123' , x + 30, y + -25, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

-- Имя
draw.SimpleText('Имя: ' .. name , 'asd123' , x + 30, y + -85, Color(255,255,255,255), TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

 
end
 
hook.Add('HUDPaint', 'myfirsthud', MyFirstHud)