--Base include
require ("global_var")

--Required Files
require("library/lua_enhance")
require("base_character")


function love.load()
	x = 0
	love.window.setMode(setting_width_default, setting_height_default, nil)
	love.graphics.setBackgroundColor(1, 0, 0, 1)
end

function love.draw(d)

end

function love.update(d)

end

function love.keypressed(key)

end

function love.keyreleased(key)

	print("Key:", key)
end