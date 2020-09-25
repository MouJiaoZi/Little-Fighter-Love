--Default Settings:
setting_width_default = 800
setting_height_default = 600

--Key Bind
--enum
KEY_UP = 1
KEY_DOWN = 2
KEY_LEFT = 4
KEY_RIGHT = 8
KEY_ATTACK = 16
KEY_JUMP = 32
KEY_DEFEND = 64

__PLAYER_KEY_SETTINGS = {}
for i=1,4 do __PLAYER_KEY_SETTINGS[i] = {} end

__PLAYER_KEY_SETTINGS[1][KEY_UP] = "w"
__PLAYER_KEY_SETTINGS[1][KEY_DOWN] = "s"
__PLAYER_KEY_SETTINGS[1][KEY_LEFT] = "a"
__PLAYER_KEY_SETTINGS[1][KEY_RIGHT] = "d"
__PLAYER_KEY_SETTINGS[1][KEY_ATTACK] = "j"
__PLAYER_KEY_SETTINGS[1][KEY_JUMP] = "k"
__PLAYER_KEY_SETTINGS[1][KEY_DEFEND] = "l"