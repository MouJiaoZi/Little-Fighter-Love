Loading = {}

local isLoading = false

function Loading:StartLoading()
	isLoading = true
	return isLoading
end

function Loading:EndLoading()
	isLoading = false
	return isLoading
end

function Loading:Draw(d)
	if isLoading then
		--
	end
end