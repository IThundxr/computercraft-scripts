local DiscordHook = require("DiscordHook")

args = { ... }
local success, hook = DiscordHook.createWebhook(tostring(args[1]))
if not success then
    error("Webhook connection failed! Reason: " .. hook)
end

local detector = peripheral.find("playerDetector")
if detector == nil then error("playerDetector not found") end

local whitelist = {
    ["IThundxr"] = true,
    ["IThundxrwastaken"] = true,
    ["IceChief2862"] = true,
    ["Bl1tz_Gam1ng"] = true
}

local pinged = false
while true do
    data = detector.getPlayersInRange(200)
    for i = #data, 1, -1 do
        local removed = false
        if whitelist[data[i]] then
            table.remove(data, i)
            removed = true
        end

        if not removed then
            local pos = detector.getPlayerPos(data[i])
            data[i] = string.format("%s : %d, %d, %d", data[i], pos.x, pos.y, pos.z)
        end
    end
    if #data > 0 then
        playersraw = textutils.serialize(data)
        players = table.concat(data, "\n")

        if not pinged then
            hook.sendEmbed("@everyone", "Intruder Detected!",
                "Unauthorized Personal Detected: User(s): **```" ..
                "\n" .. players .. "```**\nTime: <t:" .. math.floor(os.epoch "utc" / 1000 + 0.5) .. ":R>", nil,
                0xFF0000)
        end
        pinged = true
    else
        pinged = false
    end
    sleep(5)
end
