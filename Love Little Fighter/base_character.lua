--[[

]]

Character = {}
local __CharacterInfo = {}

local function CreateCharacter(tClass, iID)
	if __CharacterInfo[iID] then
		error("[Error]LoadCharacter(): the character id "..iID.." has exists!")
		return false
	end

	__CharacterInfo[iID] = {}
	__CharacterInfo[iID].baseClass = tClass

	local name = tClass.GetName and tClass:GetName() or base_character:GetName()
	local avatar = tClass.GetAvatar and tClass:GetAvatar() or base_character:GetAvatar()
	local ui_avatar = tClass.GetUIAvatar and tClass:GetUIAvatar() or base_character:GetUIAvatar()
	__CharacterInfo[iID].Name = name
	__CharacterInfo[iID].avatar = love.graphics.newImage(avatar)
	__CharacterInfo[iID].ui_avatar = love.graphics.newImage(ui_avatar)

	local info = tClass.GetCharacterData and tClass:GetCharacterData() or base_character:GetCharacterData()
	for k, v in pairs(base_character:GetCharacterData()) do
		if not info[k] then
			info[k] = v
		end
	end
	__CharacterInfo[iID].info = info

	local pic = tClass.GetCharacterPicInfo and tClass:GetCharacterPicInfo() or base_character:GetCharacterPicInfo()
	__CharacterInfo[iID].texture = {}
	for i=1, #pic do
		if not pic[i].pic or  not pic[i].pic or  not pic[i].pic or  not pic[i].pic then
			error("[Error]LoadCharacter(): Character:GetCharacterPicInfo() error!")
			return false
		end
		__CharacterInfo[iID].texture[i] = {}
		__CharacterInfo[iID].texture[i].texture = love.graphics.newImage(pic[i].pic)
		__CharacterInfo[iID].texture[i].maxFrame = 0
		local sw = __CharacterInfo[iID].texture[i].texture:getWidth()
		local sh = __CharacterInfo[iID].texture[i].texture:getHeight()
		for r=1, pic[i].row do
			for c=1, pic[i].col do
				local index = #__CharacterInfo[iID].texture[i] + 1
				__CharacterInfo[iID].texture[i][index] = love.graphics.newQuad((c - 1) * (pic[i].w + 1), (r - 1) * (pic[i].h + 1), pic[i].w, pic[i].h, sw, sh)
			end
		end
		__CharacterInfo[iID].texture[i].maxFrame = __CharacterInfo[iID].texture[i].maxFrame + #__CharacterInfo[iID].texture[i]
	end

	print("Create Character Sucesfully:", iID, name, avatar, ui_avatar)
	return true
end

--[[
LoadCharacter(64, "character_test", "script/character_test")
]]
function Character:LoadCharacter(iID, sClassName, sFile)
	if not sClassName or not sFile or not iID or type(sClassName) ~= "string" or type(sFile) ~= "string" or type(iID) ~= "number" or math.floor(iID) ~= math.ceil(iID) then
		error("[Error]LoadCharacter(int ID, string ClassName, string File without .lua).")
		return false
	end
	require(sFile)
	local character_class = loadstring("return "..sClassName)()
	if type(character_class) ~= "table" then
		error("[Error]LoadCharacter(): no such class found.")
		return false
	end
	CreateCharacter(character_class, iID)
end

function Character:Kernel_GetCharacterFrame(iID, iFrame) --return: {loveImage, loveQuad}
	local tbl = __CharacterInfo[iID].texture
	local thisFrame = iFrame
	for i=1, #tbl do
		if thisFrame <= 0 then
			return nil
		end
		if thisFrame <= #tbl[i] then
			return {tbl[i].texture, tbl[i][thisFrame]}
		else
			thisFrame = thisFrame - #tbl[i]
		end
	end
end

-----------------------------------------------
-----------------------------------------------
-----------------------------------------------


--LFF_CHARACTER_STATE
LFF_CHARACTER_STATE_STAND = 1
LFF_CHARACTER_STATE_WALK = 2
LFF_CHARACTER_STATE_RUN = 3

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

CreateCharacter(base_character, 0)

require("data_chrarcter")


-----------------------------------------------
-----------------------------------------------
-----------------------------------------------

--[[Character enum]]
local LFF_OBJECT_CHARACTER = {}
for i=0, #__CharacterInfo do
	LFF_OBJECT_CHARACTER[i] = {}
	LFF_OBJECT_CHARACTER[i].isHidden = true
	LFF_OBJECT_CHARACTER[i].isDead = false
	LFF_OBJECT_CHARACTER[i].team = 0  --0 = neutral
	LFF_OBJECT_CHARACTER[i].frame = 1
	LFF_OBJECT_CHARACTER[i].index = -1
	LFF_OBJECT_CHARACTER[i].id = i
	LFF_OBJECT_CHARACTER[i].state = LFF_CHARACTER_STATE_STAND
	LFF_OBJECT_CHARACTER[i].x = 0
	LFF_OBJECT_CHARACTER[i].y = 0
	LFF_OBJECT_CHARACTER[i].h = 0
	LFF_OBJECT_CHARACTER[i].fightMaxHealth = __CharacterInfo[i].info.maxHealth
	LFF_OBJECT_CHARACTER[i].maxHealth = __CharacterInfo[i].info.maxHealth
	LFF_OBJECT_CHARACTER[i].health = LFF_OBJECT_CHARACTER[i].fightMaxHealth
	LFF_OBJECT_CHARACTER[i].maxMana = __CharacterInfo[i].info.maxMana
	LFF_OBJECT_CHARACTER[i].mana = LFF_OBJECT_CHARACTER[i].maxMana
	LFF_OBJECT_CHARACTER[i].walkSpeed = __CharacterInfo[i].info.walkSpeed
	LFF_OBJECT_CHARACTER[i].walkSpeedZ = __CharacterInfo[i].info.walkSpeedZ
	LFF_OBJECT_CHARACTER[i].runSpeed = __CharacterInfo[i].info.runSpeed
	LFF_OBJECT_CHARACTER[i].runSpeedZ = __CharacterInfo[i].info.runSpeedZ
	LFF_OBJECT_CHARACTER[i].heavyWalkSpeed = __CharacterInfo[i].info.heavyWalkSpeed
	LFF_OBJECT_CHARACTER[i].heavyWalkSpeedZ = __CharacterInfo[i].info.heavyWalkSpeedZ
	LFF_OBJECT_CHARACTER[i].heavyRunSpeed = __CharacterInfo[i].info.heavyRunSpeed
	LFF_OBJECT_CHARACTER[i].heavyRunSpeedZ = __CharacterInfo[i].info.heavyRunSpeedZ
	LFF_OBJECT_CHARACTER[i].jumpHeight = __CharacterInfo[i].info.jumpHeight
	LFF_OBJECT_CHARACTER[i].jumpDistance = __CharacterInfo[i].info.jumpDistance
	LFF_OBJECT_CHARACTER[i].jumpDistanceZ = __CharacterInfo[i].info.jumpDistanceZ
	LFF_OBJECT_CHARACTER[i].dashHeight = __CharacterInfo[i].info.dashHeight
	LFF_OBJECT_CHARACTER[i].dashDistance = __CharacterInfo[i].info.dashDistance
	LFF_OBJECT_CHARACTER[i].dashDistanceZ = __CharacterInfo[i].info.dashDistanceZ
	LFF_OBJECT_CHARACTER[i].rowingHeight = __CharacterInfo[i].info.rowingHeight
	LFF_OBJECT_CHARACTER[i].rowingDistance = __CharacterInfo[i].info.rowingDistance
	LFF_OBJECT_CHARACTER[i].__index = LFF_OBJECT_CHARACTER[i]
end
LFF_OBJECT_CHARACTER.__index = LFF_OBJECT_CHARACTER

local LFF_OBJECT_CHARACTER_LIST = {}

function Character:Kernel_DrawAllCharacters()
	for k, v in pairs(LFF_OBJECT_CHARACTER_LIST) do
		if not LFF_OBJECT_CHARACTER_LIST[k].isHidden then
			local id = LFF_OBJECT_CHARACTER_LIST[k].id
			local frame = LFF_OBJECT_CHARACTER_LIST[k].frame
			local x = LFF_OBJECT_CHARACTER_LIST[k].x
			local y = LFF_OBJECT_CHARACTER_LIST[k].y
			local drawInfo = Character:Kernel_GetCharacterFrame(id, frame)
			love.graphics.draw(drawInfo[1], drawInfo[2], x, y)
		end
	end
end

--[[
Create a new character object, you muse use Character:Spawn() to show it.
]]
function Character:New(iID, info)
	if not LFF_OBJECT_CHARACTER[iID] then
		error("[ERROR]Character:New(iID, info): No Such Character ID "..iID.." Found !!")
	end

	local obj = {}
	obj.id = iID
	if type(info) == "table" then
		for k, v in pairs(info) do
			obj[k] = v
		end
	end
	setmetatable(obj, LFF_OBJECT_CHARACTER[iID])
	table.insert(LFF_OBJECT_CHARACTER_LIST, obj)
	obj.index = table_maxn(LFF_OBJECT_CHARACTER_LIST)
	return obj.index
end

--[[
Spawn a character, makes it visible
]]
function Character:Spawn(iIndex, iFrame)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] then
		if type(iFrame) == "number" and iFrame > 0 then
			LFF_OBJECT_CHARACTER_LIST[iIndex].frame = iFrame
		end
		LFF_OBJECT_CHARACTER_LIST[iIndex].isHidden = false
		return true
	else
		return false
	end
end

--[[
Hide a character, makes it invisible
]]
function Character:Hide(iIndex)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] then
		LFF_OBJECT_CHARACTER_LIST[iIndex].isHidden = true
		return true
	else
		return false
	end
end

--[[
Remove this character from memory immediately
]]
function Character:Destroy(iIndex)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] then
		LFF_OBJECT_CHARACTER_LIST[iIndex] = nil
		return true
	else
		return false
	end
end

--[[
Set the given character's origin, may stuck the character
]]
function Character:SetAbsOrigin(iIndex, x, y, h)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] then
		LFF_OBJECT_CHARACTER_LIST[iIndex].x = x or LFF_OBJECT_CHARACTER_LIST[iIndex].x
		LFF_OBJECT_CHARACTER_LIST[iIndex].y = y or LFF_OBJECT_CHARACTER_LIST[iIndex].y
		LFF_OBJECT_CHARACTER_LIST[iIndex].h = h or LFF_OBJECT_CHARACTER_LIST[iIndex].h
		return true
	else
		return false
	end
end
function printlist()
	for k, v in pairs(LFF_OBJECT_CHARACTER_LIST) do
		print(k, v.id)
	end
end