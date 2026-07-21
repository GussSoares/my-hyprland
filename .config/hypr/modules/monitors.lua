------------------
---- MONITORS ----
------------------

local monitor_mode = os.getenv("EXTERNAL_MONITOR")
local internal = null
local exgernal = null
-- internal monitor

if monitor_mode == "connected" then
    internal = false
    external = true
else
    internal = true
    external = false
end

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1.00",
    disabled  = internal
})
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1.00",
    disabled  = external
})

-- external monitor
-- hl.monitor({
--     output   = "HDMI-A-1",
--     mode     = "preferred",
--     position = "0x0",
--     scale    = "1.00",
-- })
