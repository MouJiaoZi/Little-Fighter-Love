character_davis = {}

function character_davis:GetName()
	return "Davis"
end

function character_davis:GetAvatar()
	return "sprite/sys/davis_f.png"
end

function character_davis:GetUIAvatar()
	return "sprite/sys/davis_s.png"
end

function character_davis:GetCharacterData()
	local info = {}
	info.maxHealth = 600
	info.healthRegen = 42
	info.maxMana = 300
	return info
end

function character_davis:GetCharacterPicInfo()
	local info = {}
	info[1] = {pic = "sprite/sys/davis_0.png", w = 79, h = 79, row = 10, col = 7}
	info[2] = {pic = "sprite/sys/davis_1.png", w = 79, h = 79, row = 10, col = 7}
	info[3] = {pic = "sprite/sys/davis_2.png", w = 79, h = 79, row = 10, col = 7}
	return info
end