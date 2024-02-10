local NearBank, ShowingInteraction = false, false

-- [ Code ] --

-- [ Functions ] --

function InitZones()
    Citizen.CreateThread(function()
        for k, v in pairs(Config.BankLocations) do
            exports['quantum-polyzone']:CreateBox({
                center = v['Coords'], 
                length = v['Data']['Length'], 
                width = v['Data']['Width'],
            }, {
                name = 'banking'..k,
                minZ = v['Data']['MinZ'],
                maxZ = v['Data']['MaxZ'],
                heading = v['Heading'],
                hasMultipleZones = false,
                debugPoly = false,
            }, function() end, function() end)
        end
        --[[
        exports['quantum-ui']:AddEyeEntry(GetHashKey("prop_fleeca_atm"), {
            Type = 'Model',
            Model = 'prop_fleeca_atm',
            SpriteDistance = 2.0,
            Options = {
                {
                    Name = 'open_atm',
                    Icon = 'fas fa-dollar-sign',
                    Label = 'Atm',
                    EventType = 'Client',
                    EventName = 'quantum-financials/client/open-banking',
                    EventParams = false,
                    Enabled = function(Entity)
                        return true
                    end,
                },
            }
        })]]
        exports['quantum-ui']:AddUseEntry(GetHashKey("prop_fleeca_atm"), {
            Type = 'Model',
            Model = 'prop_fleeca_atm',
            SpriteDistance = 2.8,
            Distance = 2.0,
            EventType = 'Client',
            EventName = 'quantum-financials/client/open-banking',
            EventParams = false,
            Enabled = function(Entity)
                return true
            end
        })
        for i = 1, 3 do
            --[[
            exports['quantum-ui']:AddEyeEntry(GetHashKey("prop_atm_0"..i), {
                Type = 'Model',
                Model = 'prop_atm_0'..i,
                SpriteDistance = 2.0,
                Options = {
                    {
                        Name = 'open_atm',
                        Icon = 'fas fa-dollar-sign',
                        Label = 'Atm',
                        EventType = 'Client',
                        EventName = 'quantum-financials/client/open-banking',
                        EventParams = false,
                        Enabled = function(Entity)
                            return true
                        end,
                    },
                }
            })]]
            exports['quantum-ui']:AddUseEntry(GetHashKey("prop_atm_0"..i), {
                Type = 'Model',
                Model = 'prop_atm_0'..i,
                SpriteDistance = 2.0,
                Distance = 2.0,
                EventType = 'Client',
                EventName = 'quantum-financials/client/open-banking',
                EventParams = false,
                Enabled = function(Entity)
                    return true
                end
            })
        end
        
    end)
end

exports['quantum-ui']:AddUseEntry("test_ped", {
    Type = 'Entity',
    EntityType = 'Ped',
    SpriteDistance = 10.0,
    Distance = 5.0,
    Position = vector4(150.07, -1035.61, 28.34, 325.05),
    Model = 's_m_y_chef_01',
    EventType = 'Client',
    EventName = 'test/test/test',
    EventParams = {},
    Enabled = function(Entity)
        return true
    end
})

-- [ Events ] --

RegisterNetEvent('quantum-polyzone/client/enter-polyzone', function(PolyData, Coords)
    local PolyName = string.sub(PolyData.name, 1, 7)
    if PolyName == 'banking' then
        if not NearBank then
            NearBank = true

            if not ShowingInteraction then
                ShowingInteraction = true
                exports['quantum-ui']:SetInteraction('[E] Bank', 'primary')
            end
            Citizen.CreateThread(function()
                while NearBank do
                    Citizen.Wait(4)
                    if IsControlJustReleased(0, 38) then
                        exports['quantum-ui']:HideInteraction()
                        TriggerEvent('quantum-financials/client/open-banking', true)
                    end
                end
            end)

        end
    end
end)

RegisterNetEvent('quantum-polyzone/client/leave-polyzone', function(PolyData, Coords)
    local PolyName = string.sub(PolyData.name, 1, 7)
    if PolyName == 'banking' then
        if NearBank then
            NearBank = false
            if ShowingInteraction then
                ShowingInteraction = false
                exports['quantum-ui']:HideInteraction()
            end
        end
    end
end)