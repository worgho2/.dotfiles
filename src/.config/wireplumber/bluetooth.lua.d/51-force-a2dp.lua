-- This rule forces all Bluetooth devices to default to the A2DP Sink profile
-- for high-quality audio, without disabling the HSP/HFP (microphone) profile.
--
-- References:
-- * Wireplumber Official Documentation:
--     https://pipewire.pages.freedesktop.org/wireplumber/
--
-- * Wireplumber Default System Examples:
--     /usr/share/wireplumber/policy.lua.d/
--
-- * Restarting Wireplumber to apply the rule:
--     systemctl --user restart wireplumber
--
-- * Start wireplumber in debug mode to see what is happening:
--     WIREPLUMBER_DEBUG=I wireplumber

rule = {
    matches = {
        {
            { "device.bus", "equals", "bluetooth" },
        },
    },
    apply_properties = {
        ["bluez5.default.profile"] = "a2dp-sink",
    },
}
  
table.insert(bluez_monitor.rules, rule)