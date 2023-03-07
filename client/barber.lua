ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local mainMenu = RageUI.CreateMenu("Barber Shop", "MENU", 0, 0, "commonmenu", "interaction_bgd", 0, 0, 0, 0)

local barber = false
mainMenu.EnableMouse = true
mainMenu.Closed = function() 
    barber = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(0, true, 1000)
    DestroyAllCams(true) 
    DestroyCam(cam, false)
end

function Barber()
    if barber then barber = false RageUI.Visible(mainMenu, false) return else barber = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
		    while barber do
                Load()                    
                RageUI.IsVisible(mainMenu,function()
                    RageUI.List("Cheveux", rdl.List.Hair, rdl.Index.HI, nil, {}, true, {
                        onListChange = function(Index)
                            rdl.Index.HI = Index
                            TriggerEvent("skinchanger:change", "hair_1", rdl.Index.HI-1)
                        end
                    })
                    RageUI.List("Barbe", rdl.List.Beard, rdl.Index.BI, nil, {}, true, {
                        onListChange = function(Index)
                            rdl.Index.BI = Index
                            TriggerEvent("skinchanger:change", "beard_1", rdl.Index.BI-1)
                        end
                    })
                    RageUI.List("Sourcil", rdl.List.Eyebrows, rdl.Index.EI, nil, {}, true, {
                        onListChange = function(Index)
                            rdl.Index.EI = Index
                            TriggerEvent("skinchanger:change", "eyebrows_1", rdl.Index.EI-1)
                        end
                    })       
                    RageUI.List("Bouche", rdl.List.Lipstick, rdl.Index.LI, nil, {}, true, {
                        onListChange = function(Index)
                            rdl.Index.LI = Index
                            TriggerEvent("skinchanger:change", "lipstick_1", rdl.Index.LI-1)
                        end
                    })  
                    RageUI.List("Maquillage", rdl.List.Makeup, rdl.Index.MI, nil, {}, true, {
                        onListChange = function(Index)
                            rdl.Index.MI = Index
                            TriggerEvent("skinchanger:change", "makeup_1", rdl.Index.MI-1)
                        end
                    })      
                    RageUI.Button("Valider mon achat pour ~g~"..rdl.Price.."$", false, {RightLabel = "→", Color = {BackgroundColor = {0,150,0,150}}}, true, {
                        onSelected = function()
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                            FreezeEntityPosition(PlayerPedId(), false)
                            RenderScriptCams(0, true, 1000)
                            DestroyAllCams(true) 
                            DestroyCam(cam, false)
                            TriggerServerEvent("rdl:buy", rdl.Price)
                            RageUI.CloseAll()
                            barber = false
                        end
                    })
                    RageUI.ColourPanel("Couleur Cheveux", RageUI.PanelColour.HairCut, rdl.Index.CHP[1], rdl.Index.CHP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                          
                            rdl.Index.CHP[1] = MinimumIndex
                            rdl.Index.CHP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1",  rdl.Index.CHP[2]-1)
                        end
                    }, 1);
                    RageUI.ColourPanel("Nacrage Cheveux", RageUI.PanelColour.HairCut, rdl.Index.CHS[1], rdl.Index.CHS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            rdl.Index.CHS[1] = MinimumIndex
                            rdl.Index.CHS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_2", rdl.Index.CHS[2]-1)
                        end
                    }, 1);
                    RageUI.PercentagePanel(rdl.Index.BOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                          
                            rdl.Index.BOI = i
                            TriggerEvent('skinchanger:change', 'beard_2', i*10)
                        end
                    }, 2);
                    RageUI.ColourPanel("Couleur Barbe", RageUI.PanelColour.HairCut, rdl.Index.CBP[1], rdl.Index.CBP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            rdl.Index.CBP[1] = MinimumIndex
                            rdl.Index.CBP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3", rdl.Index.CBP[2]-1)
                        end
                    }, 2);
                    RageUI.ColourPanel("Nacrage Barbe", RageUI.PanelColour.HairCut, rdl.Index.CBS[1], rdl.Index.CBS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                       
                            rdl.Index.CBS[1] = MinimumIndex
                            rdl.Index.CBS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_4", rdl.Index.CBS[2]-1)
                        end
                    }, 2);
                    RageUI.PercentagePanel(rdl.Index.EOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                        
                            rdl.Index.EOI = i
                            TriggerEvent('skinchanger:change', 'eyebrows_2', i*10)
                        end
                    }, 3);
                    RageUI.ColourPanel("Couleur Sourcil", RageUI.PanelColour.HairCut, rdl.Index.CEP[1], rdl.Index.CEP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            rdl.Index.CEP[1] = MinimumIndex
                            rdl.Index.CEP[2] = CurrentIndex 
                            TriggerEvent("skinchanger:change", "eyebrows_3", rdl.Index.CEP[2]-1)                  
                        end
                    }, 3);
                    RageUI.ColourPanel("Nacrage Sourcil", RageUI.PanelColour.HairCut, rdl.Index.CES[1], rdl.Index.CES[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            rdl.Index.CES[1] = MinimumIndex
                            rdl.Index.CES[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "eyebrows_4", rdl.Index.CES[2]-1) 
                        end
                    }, 3);
                    RageUI.PercentagePanel(rdl.Index.LOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                        
                            rdl.Index.LOI = i
                            TriggerEvent('skinchanger:change', 'lipstick_2', i*10)
                        end
                    }, 4);
                    RageUI.ColourPanel("Couleur Bouche", RageUI.PanelColour.HairCut, rdl.Index.CLP[1], rdl.Index.CLP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            rdl.Index.CLP[1] = MinimumIndex
                            rdl.Index.CLP[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_3", rdl.Index.CLP[2]-1)
                        end
                    }, 4);
                    RageUI.ColourPanel("Nacrage Bouche", RageUI.PanelColour.HairCut, rdl.Index.CLS[1], rdl.Index.CLS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                        
                            rdl.Index.CLS[1] = MinimumIndex
                            rdl.Index.CLS[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_4", rdl.Index.CLS[2]-1)
                        end                           
                    }, 4);
                    RageUI.PercentagePanel(rdl.Index.MOI, 'Opacité', '0%', '100%', {
                        onProgressChange = function(i)                  
                            rdl.Index.MOI = i                            
                            TriggerEvent('skinchanger:change', 'makeup_2', i*10)
                        end
                    }, 5);
                    RageUI.ColourPanel("Couleur Maquillage", RageUI.PanelColour.HairCut, rdl.Index.CMP[1], rdl.Index.CMP[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                           
                            rdl.Index.CMP[1] = MinimumIndex
                            rdl.Index.CMP[2] = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_3', rdl.Index.CMP[2]-1)
                        end
                    }, 5);
                    RageUI.ColourPanel("Nacrage Maquillage", RageUI.PanelColour.HairCut, rdl.Index.CMS[1], rdl.Index.CMS[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)                         
                            rdl.Index.CMS[1] = MinimumIndex
                            rdl.Index.CMS[2] = CurrentIndex
                            TriggerEvent('skinchanger:change', 'makeup_4', rdl.Index.CMS[2]-1)
                        end
                    }, 5);
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(rdl.Coords) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z)
            if dist <= 2.0 then 
                wait = 0
                DrawMarker(6, v.x, v.y, v.z-1, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.5, 0.5, 0.5, 220, 120, 0, 255, false, false, p19, false) 
                if dist <= 1.5 then 
                    wait = 0 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour ouvrir le ~b~Menu Coiffeur")
                    if IsControlJustPressed(1,51) then 
                        CreateCam() 
                        Barber()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(rdl.Coords) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 71)
        SetBlipScale (blip, 0.6)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Coiffeur')
        EndTextCommandSetBlipName(blip)
    end
end)

function CreateCam()
	local coords = GetEntityCoords(GetPlayerPed(-1))
    cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', coords.x-0.8, coords.y-0.4, coords.z+0.7, 0.0, 0.0, 0.0, 40.0, true, true)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.6)
    RenderScriptCams(true, false, false, true, true)
end

function Load()
    FreezeEntityPosition(PlayerPedId(), true) 
    EnableControlAction(0, 47, true)   
    if IsDisabledControlPressed(0, 23) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-1.5)
    elseif IsDisabledControlPressed(0, 47) then
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+1.5)
    elseif IsDisabledControlPressed(0, 11) then
        SetCamFov(cam, GetCamFov(cam)+0.2)
    elseif IsDisabledControlPressed(0, 10) then
        SetCamFov(cam, GetCamFov(cam)-0.2)
    end
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 47, 0), [2] = "Tourner à Gauche"})
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 23, 0), [2] = "Tourner à Droite"}) 
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 11, 0), [2] = "Dézoom"})
    mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 10, 0), [2] = "Zoom"})
end
