--Base include
require("library/lua_enhance")
require("global_var")
require("gameplay")
require("base_character")





function love.load()
	love.window.setMode(setting_width_default, setting_height_default, nil)
	love.graphics.setBackgroundColor(1, 0, 0, 1)
	local a = Character:New(0, {x = 400, y = 300})
	Character:SetPlayer(a, 1)
	Character:Spawn(a, 22)
end

function love.draw()
	--[[if Loading:IsLoading() then
		Loading:Draw()
		return
	end]]
	Character:Kernel_DrawAllCharacters()
end

function love.update(d)
	--[[if Loading:IsLoading() then
		--Loading:Draw(d)
		return
	end]]
	GamePlay:Update(d)
end

function love.keypressed(key)

end

function love.keyreleased(key)

	--print("Key:", key)
end