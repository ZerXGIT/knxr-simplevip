if not ESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

ESX.RegisterCommand("vip", "admin", function(xPlayer, args, showError)
    local target = args.id

    if not target then 
        showError("Invalid target")
        return
    end
    
    local onOrOff = tostring(args.bool)

    if not onOrOff then 
        showError("Invalid VIP boolean: true/false")
        return
    end

    -- return if onOrOff is not a "true" or "false" string
    if onOrOff ~= "true" and onOrOff ~= "false" then
        showError("Invalid VIP boolean: true/false")
        return
    end

    if onOrOff == "true" then
        onOrOff = 1
    else
        onOrOff = 0
    end

    local identifier = target.getIdentifier()

    updatePlayerVip(identifier, onOrOff, xPlayer)

end, true, {help = "Toggle Troll Protection", arguments = {
    {name = "id", help = "Player ID", type = "player"},
    {name = "bool", help = "VIP status", type = "string"}
}})

function updatePlayerVip(identifier, onOrOff, xPlayer)
    -- Update the table if you whish
    CreateThread(function()
        local affectedRows = MySQL.update.await("UPDATE users SET vip = @onOrOff WHERE identifier = @identifier", {
            ["@identifier"] = identifier,
            ["@onOrOff"] = onOrOff
        })
        local realstate

        if onOrOff == 1 then
            realstate = "true"
        else
            realstate = "false"
        end


        if affectedRows == 0 then
            xPlayer.showNotification("Failed to update VIP status. Maybe the player already has that status?")
        else
            xPlayer.showNotification("You have set " .. identifier .. " to VIP: " .. realstate)
        end
    end)
end