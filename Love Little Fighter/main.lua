--Base include
require("library/lua_enhance")
require("global_var")





function love.load()
	x = 0
	love.window.setMode(setting_width_default, setting_height_default, nil)
	love.graphics.setBackgroundColor(1, 0, 0, 1)
	require("system_loading")
	Loading:StartLoading()
	--Required Files

	require("base_character")
	
	Loading:EndLoading()
end

function love.draw(d)
	if Loading:IsLoading() then
		Loading:Draw(d)
		return
	end
	Character:Kernel_DrawAllCharacters()
	
end

function love.update(d)
	if Loading:IsLoading() then
		--Loading:Draw(d)
		return
	end
end

function love.keypressed(key)

end

function love.keyreleased(key)

	print("Key:", key)
end