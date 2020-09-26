Loading = {}

local isLoading = false
local ui_bg = love.graphics.newImage("sprite/ui/loading_bg.png")

function Loading:StartLoading()
	isLoading = true
	return isLoading
end

function Loading:EndLoading()
	isLoading = false
	return isLoading
end

function Loading:Draw(d)
	if true and ui_bg then--isLoading then
		love.graphics.draw(ui_bg, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, nil, 1, 1, ui_bg:getWidth() / 2, ui_bg:getHeight() / 2)
	end
end