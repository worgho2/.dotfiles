-- Override default policy to disable auto-switching to headset profile
-- specifically for media-role applications (like Google Meet communication streams).
-- This lets A2DP stay active for high-quality audio.
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

if not bluetooth_policy then bluetooth_policy = {} end
if not bluetooth_policy.policy then bluetooth_policy.policy = {} end

bluetooth_policy.policy["media-role.use-headset-profile"] = false   