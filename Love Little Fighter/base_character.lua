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
		if not pic[i].pic or not IsInt(pic[i].w, pic[i].h, pic[i].row, pic[i].col) then
			error("[Error]LoadCharacter(): Character:GetCharacterPicInfo() error!")
			return false
		end
		__CharacterInfo[iID].texture[i] = {}
		__CharacterInfo[iID].texture[i].texture = love.graphics.newImage(pic[i].pic)
		__CharacterInfo[iID].texture[i].maxFrame = 0
		local sw = __CharacterInfo[iID].texture[i].texture:getWidth()
		local sh = __CharacterInfo[iID].texture[i].texture:getHeight()
		for c=1, pic[i].col do
			for r=1, pic[i].row do
				local index = #__CharacterInfo[iID].texture[i] + 1
				__CharacterInfo[iID].texture[i][index] = love.graphics.newQuad((r - 1) * (pic[i].h + 1), (c - 1) * (pic[i].w + 1), pic[i].w, pic[i].h, sw, sh)
			end
		end
	end

	print("Create Character Sucesfully:", iID, name, avatar, ui_avatar)
	return true
end

--[[
LoadCharacter(64, "character_test", "script/character_test")
]]
function Character:LoadCharacter(iID, sClassName, sFile)
	if not sClassName or not sFile or not iID or not IsType("string", sClassName, sFile) or not IsInt(iID) or iID < 0 then
		error("[Error]LoadCharacter(int ID >= 0, string ClassName, string File without .lua).")
		return false
	end
	require(sFile)
	local character_class = loadstring("return "..sClassName)()
	if not IsType("table", character_class) then
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
			return {tbl[1].texture, tbl[1][1]}
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


--[[Character enum]]
local LFF_OBJECT_CHARACTER = {}

function Character:Kernel_SetCharacterInfo()
	for i=0, #__CharacterInfo do
		LFF_OBJECT_CHARACTER[i] = {}
		LFF_OBJECT_CHARACTER[i].player = 0 -- who can control this character, PlayerID from 1 to 4, 0 = AI
		LFF_OBJECT_CHARACTER[i].isHidden = true
		LFF_OBJECT_CHARACTER[i].isDead = false
		LFF_OBJECT_CHARACTER[i].team = 0  --0 = neutral, -1 = enemy in stage mode, 0 - 8 in versus mode, 1 or 2 in war mode
		LFF_OBJECT_CHARACTER[i].frame = 1
		LFF_OBJECT_CHARACTER[i].index = 0 -- index starts at 1, <= 0 means nothing
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
			local drawInfo = self:Kernel_GetCharacterFrame(id, frame)
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
	if IsType("table", info) then
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
		if IsInt(iFrame) and iFrame > 0 then
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
Which team the character belongs to, 0 = neutral, -1 = enemy in stage mode, 0 - 8 in versus mode, 1 or 2 in war mode
]]
function Character:SetTeam(iIndex, iTeam)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] and IsInt(iTeam) and iTeam >= -1 then
		LFF_OBJECT_CHARACTER_LIST[iIndex].team = iTeam
		return true
	else
		return false
	end
end

--[[
Who can control this character, PlayerID from 1 to 4, 0 = AI
]]
function Character:SetPlayer(iIndex, iPlayerID)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] and IsInt(iPlayerID) and iPlayerID >= 0 then
		LFF_OBJECT_CHARACTER_LIST[iIndex].player = iPlayerID
		return true
	else
		return false
	end
end

--[[
Set the given character's origin, may stuck the character
]]
function Character:SetAbsOrigin(iIndex, x, y, h)
	if LFF_OBJECT_CHARACTER_LIST[iIndex] and IsType("number", x, y, h) then
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


local loadfiles = loadfiles or require("data_chrarcter")
