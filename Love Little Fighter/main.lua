--Base include
require("library/lua_enhance")
require("global_var")

require("system_loading")
--Required Files
require("base_character")



function love.load()
	x = 0
	love.window.setMode(setting_width_default, setting_height_default, nil)
	love.graphics.setBackgroundColor(1, 0, 0, 1)
	Character:New(1, {x = 300, y = 300})
	
end

function love.draw(d)
	Character:Kernel_DrawAllCharacters()
	Loading:Draw(d)
end

function love.update(d)
	
end

function love.keypressed(key)
	print(x)
	Character:Spawn(1, x)
	x = x + 1
end

function love.keyreleased(key)

	print("Key:", key)
end