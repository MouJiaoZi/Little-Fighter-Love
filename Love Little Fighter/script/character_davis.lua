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

function character_davis:GetCharacterInfo()
	local info = {}
	info.maxHealth = 600
	info.healthRegen = 42
	info.maxMana = 300
	return info
end