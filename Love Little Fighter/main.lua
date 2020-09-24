--Default Settings:
setting_width_default = 800
setting_height_default = 600

__KeyboardUse = {}

--Required Files
require("library/lua_enhance")
require("base_character")


function love.load()
	x = 0
	love.window.setMode(setting_width_default, setting_height_default, nil)
	love.graphics.setBackgroundColor(1, 0, 0, 1)
	local a = Character:New(0, {x=250,y=100})
	local b = Character:New(1, {x=150,y=5,healthRegen=100000})
	local c = Character:New(0, {x=400,y=300})
	print(c, b, a)
end

function love.draw(d)
	Character:Kernel_DrawAllCharacters()
end

function love.update(d)

end

function love.keypressed(key)
	__KeyboardUse[key] = true
	if __KeyboardUse["z"] then
		Character:Spawn(1, iFrame)
	elseif __KeyboardUse["x"] then
		Character:Spawn(2, 20)
	elseif __KeyboardUse["c"] then
		Character:Spawn(3, 40)
	elseif __KeyboardUse["v"] then
		Character:Hide(1)
	elseif __KeyboardUse["b"] then
		Character:Hide(2)
	elseif __KeyboardUse["n"] then
		Character:Hide(3)
	end
end

function love.keyreleased(key)
	__KeyboardUse[key] = false
	print("Key:", key)
end