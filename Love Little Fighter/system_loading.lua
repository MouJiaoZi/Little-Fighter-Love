Loading = {}

local isLoading = false
local ui_bg = love.graphics.newImage("sprite/ui/loading_bg.png")
local loading_file = ""
local loading_channel = love.thread.getChannel("loading")
local character_thread_code = [[
-- Receive values sent via thread:start
local iID, sClassName, sFile = ...
Character:LoadCharacter(iID, sClassName, sFile)
loading_channel:push(sFile)
]]
local character_thread = love.thread.newThread(character_thread_code)

function Loading:StartLoading()
	isLoading = true
	return isLoading
end

function Loading:EndLoading()
	isLoading = false
	return isLoading
end

function Loading:IsLoading()
	return isLoading
end

function Loading:LoadCharacter(iID, sClassName, sFile)
	character_thread:start(iID, sClassName, sFile)
end

function Loading:Draw(d)
	if isLoading and ui_bg then--isLoading then
		love.graphics.draw(ui_bg, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, nil, 1, 1, ui_bg:getWidth() / 2, ui_bg:getHeight() / 2)
		love.graphics.print(loading_channel:pop(), 20, 20, nil, sx, sy)
		print(loading_channel:pop())
	end
end