--[[

]]

__CharacterInfo = {}

local function CreateCharacter(tClass, iID)
	if __CharacterInfo[iID] then
		print("[Error]LoadCharacter(): the character id "..iID.." has exists!")
		return false
	end

	local id = iID
	local name = tClass.GetName and tClass:GetName() or base_character:GetName()
	local avatar = tClass.GetAvatar and tClass:GetAvatar() or base_character:GetAvatar()
	local ui_avatar = tClass.GetUIAvatar and tClass:GetUIAvatar() or base_character:GetUIAvatar()
	local info = tClass.GetCharacterInfo and tClass:GetCharacterInfo() or base_character:GetCharacterInfo()
	for k, v in pairs(base_character:GetCharacterInfo()) do
		if not info[k] then
			info[k] = v
		end
	end
	__CharacterInfo[iID] = {}
	__CharacterInfo[iID].Name = name
	__CharacterInfo[iID].avatar = love.graphics.newImage(avatar)
	__CharacterInfo[iID].ui_avatar = love.graphics.newImage(ui_avatar)
	__CharacterInfo[iID].info = info
	print("Create Character Sucesfully:", id, name, avatar, ui_avatar)
	return true
end

--[[
LoadCharacter(64, "character_test", "script/character_test")
]]
function LoadCharacter(iID, sClassName, sFile)
	if not sClassName or not sFile or not iID or type(sClassName) ~= "string" or type(sFile) ~= "string" or type(iID) ~= "number" or math.floor(iID) ~= math.ceil(iID) then
		print("[Error]LoadCharacter(int ID, string ClassName, string File without .lua).")
		return false
	end
	require(sFile)
	local character_class = loadstring("return "..sClassName)()
	if type(character_class) ~= "table" then
		print("[Error]LoadCharacter(): no such class found.")
		return false
	end
	CreateCharacter(character_class, iID)
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------

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

function base_character:GetCharacterInfo()
	local info = {}
	info.maxHealth = 500
	info.healthRegen = 2
	info.maxMana = 500
	info.manaRegen = 5
	info.walkSpeed = 30
	info.runSpeed = 100
	return info
end

CreateCharacter(base_character, 0)

require("data_chrarcter")