base_character = {}

function base_character:GetName()
	return "Template"
end

function base_character:GetAvatar()
	return "sprite/template1/face.png"
end

function base_character:GetUIAvatar()
	return "sprite/template1/s.png"
end

function base_character:GetCharacterData()
	local info = {}
	info.maxHealth = 500
	info.healthRegen = 2
	info.maxMana = 500
	info.manaRegen = 1
	info.walkSpeed = 40
	info.walkSpeedZ = 20
	info.runSpeed = 80
	info.runSpeedZ = 13
	info.heavyWalkSpeed = 30
	info.heavyWalkSpeedZ = 15
	info.heavyRunSpeed = 50
	info.heavyRunSpeedZ = 8
	info.jumpHeight = 163
	info.jumpDistance = 80
	info.jumpDistanceZ = 30
	info.dashHeight = 110
	info.dashDistance = 150
	info.dashDistanceZ = 37.5
	info.rowingHeight = 20
	info.rowingDistance = 50
	return info
end

function base_character:GetCharacterPicInfo()
	local info = {}
	info[1] = {pic = "sprite/template1/0.png", w = 79, h = 79, row = 10, col = 7}
	info[2] = {pic = "sprite/template1/1.png", w = 79, h = 79, row = 10, col = 7}
	return info
end
