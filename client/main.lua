RegisterCommand('editor', function(source)
    SendNUIMessage({
        eventName = 'openEditor',
        language = _G[Config.languale]
    })
    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(
        true
    )

    while IsNuiFocusKeepingInput() do
        Wait(0)
        DisableControlAction(0, 24, true)  -- disable attack
        DisableControlAction(0, 25, true)  -- disable aim
        DisableControlAction(0, 47, true)  -- disable weapon
        DisableControlAction(0, 58, true)  -- disable weapon
        DisableControlAction(0, 63, true)  -- veh turn left
        DisableControlAction(0, 64, true)  -- veh turn right
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 289, true) -- disable inventory
        DisableControlAction(0, 166, true) -- F5 menu
        DisableControlAction(0, 157, true) -- 1
        DisableControlAction(0, 158, true) -- 2
        DisableControlAction(0, 160, true) -- 3
        DisableControlAction(0, 164, true) -- 4
        DisableControlAction(0, 165, true) -- 5
        DisableControlAction(0, 45, true)  -- reload


        DisableControlAction(0, 246, true) -- disable exit vehicle
        DisableControlAction(0, 75, true)  -- disable exit vehicle
        DisableControlAction(27, 75, true) -- disable exit vehicle
        DisableControlAction(0, 80, true)  -- vehicle camera mode
        DisableControlAction(0, 85, true)  -- radio
        DisableControlAction(0, 0, true)   -- camera mode

        --  numpad
        DisableControlAction(0, 117, true)
        DisableControlAction(0, 118, true)
        DisableControlAction(0, 107, true)
        DisableControlAction(0, 108, true)
        DisableControlAction(0, 110, true)

        -- scroll
        DisableControlAction(0, 81, true)
        DisableControlAction(0, 82, true)
        DisableControlAction(0, 1, true)
        DisableControlAction(0, 2, true)
    end
end, false)


RegisterNUICallback('buttonClick', function(data, cb)
    local button = data.button

    if button == 'record' then
        SetNuiFocus(false, false)
        StartRecording(1)
        cb({ action = 'recording', actionData = { close = true, record = true } })
    elseif button == 'save' then
        StartRecording(0)
        StopRecordingAndSaveClip()
        cb({ action = 'saved', actionData = { type = 'clip', record = false } })
    elseif button == 'delete' then
        StartRecording(0)
        StopRecordingAndDiscardClip()
        cb({ action = 'deleted', actionData = { record = false } })
    elseif button == 'photo' then
        BeginTakeHighQualityPhoto()
        SaveHighQualityPhoto(-1)
        FreeMemoryForHighQualityPhoto()
        cb({ action = 'saved', actionData = { type = 'photo' } })
    elseif button == 'open' then
        cb({ action = 'opening' })
    elseif button == 'close' then
        SetNuiFocus(false, false)
        cb({ action = 'close', actionData = { close = true } })
    end
end)

RegisterNUICallback('openEditor', function(data, cb)
    SetNuiFocus(false, false)
    ActivateRockstarEditor()
    cb({ action = 'close', actionData = { close = true } })
end)
