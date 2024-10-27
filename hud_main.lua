-- hud_main.lua

-- Configurations
local HUD_CONFIG = {
    position = { x = 0.85, y = 0.8 },  -- Position of the HUD on the screen
    color = { r = 255, g = 255, b = 255, a = 200 },  -- HUD color and transparency
    fontSize = 0.5,
}

-- State variables
local showHUD = true

-- Toggle HUD display with a command
RegisterCommand("toggleHUD", function()
    showHUD = not showHUD
    if showHUD then
        TriggerEvent('chat:addMessage', { args = { "HUD is now ^2enabled" } })
    else
        TriggerEvent('chat:addMessage', { args = { "HUD is now ^1disabled" } })
    end
end, false)

-- Main HUD display logic
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  -- Every frame, if HUD is enabled and player is in a vehicle

        if showHUD and IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

            -- Retrieve stats
            local speed = GetEntitySpeed(vehicle) * 2.23694  -- Convert m/s to MPH
            local fuel = GetVehicleFuelLevel(vehicle)
            local engineHealth = GetVehicleEngineHealth(vehicle)

            -- Draw HUD
            DrawTextOnScreen(string.format("Speed: %.1f MPH", speed), HUD_CONFIG.position.x, HUD_CONFIG.position.y, HUD_CONFIG.fontSize, HUD_CONFIG.color)
            DrawTextOnScreen(string.format("Fuel: %.1f %%", fuel), HUD_CONFIG.position.x, HUD_CONFIG.position.y + 0.03, HUD_CONFIG.fontSize, HUD_CONFIG.color)
            DrawTextOnScreen(string.format("Engine Health: %.1f %%", engineHealth), HUD_CONFIG.position.x, HUD_CONFIG.position.y + 0.06, HUD_CONFIG.fontSize, HUD_CONFIG.color)
        end
    end
end)

-- Function to draw text on screen
function DrawTextOnScreen(text, x, y, scale, color)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

--[[ 
Copyright (c) 2024 WolfPack Development
This software is licensed under the MIT License.
]]
