--Default Settings:
setting_width_default = 800
setting_height_default = 600

__KeyboardUse = {}

--Required Files
require("base_character")


function love.load()
	love.window.setMode(setting_width_default, setting_height_default, nil)
	x = 0
	y = setting_height_default * 0.5
	direct = 1
end

function love.draw(d)
	--love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
	--[[love.graphics.draw(__CharacterInfo[0].avatar, 0, 0)
	love.graphics.draw(__CharacterInfo[0].ui_avatar, 400, 300)]]
	love.graphics.draw(__CharacterInfo[0].ui_avatar, x, y, nil, -1, 1)
end

function love.update(d)
	if __KeyboardUse["space"] then
		x = x + d * __CharacterInfo[0].info.walkSpeed
	end
end

function love.keypressed(key)
	__KeyboardUse[key] = true
end

function love.keyreleased(key)
	__KeyboardUse[key] = false
	print("Key:", key)
end