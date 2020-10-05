local o = mOnWardrobe
if o.additionalData == nil then
  o.additionalData = {}
end

local DressUpModel = CreateFrame("DressUpModel")

local HEAD = "INVTYPE_HEAD"
local SHOULDER = "INVTYPE_SHOULDER"
local BODY = "INVTYPE_BODY"
local CHEST = "INVTYPE_CHEST"
local ROBE = "INVTYPE_ROBE"
local WAIST = "INVTYPE_WAIST"
local LEGS = "INVTYPE_LEGS"
local FEET = "INVTYPE_FEET"
local WRIST = "INVTYPE_WRIST"
local HAND = "INVTYPE_HAND"
local CLOAK = "INVTYPE_CLOAK"
local WEAPON = "INVTYPE_WEAPON"
local SHIELD = "INVTYPE_SHIELD"
local WEAPON_2HAND = "INVTYPE_2HWEAPON"
local WEAPON_MAIN_HAND = "INVTYPE_WEAPONMAINHAND"
local RANGED = "INVTYPE_RANGED"
local RANGED_RIGHT = "INVTYPE_RANGEDRIGHT"
local WEAPON_OFF_HAND = "INVTYPE_WEAPONOFFHAND"
local HOLDABLE = "INVTYPE_HOLDABLE"
local TABARD = "INVTYPE_TABARD"
local BAG = "INVTYPE_BAG"

local inventorySlotsMap = {
  [HEAD] = {1},
  [SHOULDER] = {3},
  [BODY] = {4},
  [CHEST] = {5},
  [ROBE] = {5},
  [WAIST] = {6},
  [LEGS] = {7},
  [FEET] = {8},
  [WRIST] = {9},
  [HAND] = {10},
  [CLOAK] = {15},
  [WEAPON] = {16, 17},
  [SHIELD] = {17},
  [WEAPON_2HAND] = {16, 17},
  [WEAPON_MAIN_HAND] = {16},
  [RANGED] = {16},
  [RANGED_RIGHT] = {16},
  [WEAPON_OFF_HAND] = {17},
  [HOLDABLE] = {17},
  [TABARD] = {19},
}

local MISC = 0
local CLOTH = 1
local LEATHER = 2
local MAIL = 3
local PLATE = 4
local COSMETIC = 5

local armorTypeSlots = {
  [HEAD] = true,
  [SHOULDER] = true,
  [CHEST] = true,
  [ROBE] = true,
  [WRIST] = true,
  [HAND] = true,
  [WAIST] = true,
  [LEGS] = true,
  [FEET] = true
}

local classArmorTypeMap = {
  ["DEATHKNIGHT"] = PLATE,
  ["DEMONHUNTER"] = LEATHER,
  ["DRUID"] = LEATHER,
  ["HUNTER"] = MAIL,
  ["MAGE"] = CLOTH,
  ["MONK"] = LEATHER,
  ["PALADIN"] = PLATE,
  ["PRIEST"] = CLOTH,
  ["ROGUE"] = LEATHER,
  ["SHAMAN"] = MAIL,
  ["WARLOCK"] = CLOTH,
  ["WARRIOR"] = PLATE
}

o.getPlayerArmorTypeName = function()
  local playerArmorTypeID = classArmorTypeMap[select(2, UnitClass("player"))]
  return select(1, GetItemSubClassInfo(4, playerArmorTypeID))
end

o.getItemSlotName = function(itemLink)
  return select(4, GetItemInfoInstant(itemLink))
end

o.getItemSubClassName = function(itemLink)
  return select(3, GetItemInfoInstant(itemLink))
end

o.isArmorCosmetic = function(itemLink)
  return o.isArmorSubClassID(COSMETIC, itemLink)
end

o.isArmorSubClassID = function(subClassID, itemLink)
  local itemSubClass = o.getItemSubClassName(itemLink)
  if itemSubClass == nil then
    return
  end
  return select(1, GetItemSubClassInfo(4, subClassID)) == itemSubClass
end

o.isArmorAppropriateForPlayer = function(itemID, linkDifficulty)
  local itemLink = o.createLink(itemID, linkDifficulty)

  local playerArmorTypeID = o.getPlayerArmorTypeName()
  local slotName = o.getItemSlotName(itemLink)
  if slotName == nil then
    return
  end
  local isArmorCosmetic = o.isArmorCosmetic(itemLink)
  if isArmorCosmetic == nil then
    return
  end
  if armorTypeSlots[slotName] and isArmorCosmetic == false then
    return playerArmorTypeID == o.getItemSubClassName(itemLink)
  else
    return true
  end
end

o.getSourceID = function(itemID, linkDifficulty)
  local itemLink = o.createLink(itemID, linkDifficulty)
  local _, sourceID = C_TransmogCollection.GetItemInfo(itemLink)

  if (sourceID ~= nil) then
    return sourceID
  end

  local _, _, _, slotName = GetItemInfoInstant(itemLink)
  local slots = inventorySlotsMap[slotName]

  DressUpModel:SetUnit("player")
  DressUpModel:Undress()
  DressUpModel:TryOn(itemLink)
  for _, slot in pairs(slots) do
    sourceID = DressUpModel:GetSlotTransmogSources(slot)
    if sourceID and sourceID ~= 0 then
      return sourceID
    end
  end
end

o.getAppearanceID = function(itemID, linkDifficulty)
  local cacheString = itemID
  if linkDifficulty ~= nil then cacheString = cacheString .. "-" .. linkDifficulty end

  if mOnWDCache ~= nil and mOnWDCache.appearanceID ~= nil and mOnWDCache.appearanceID[cacheString] ~= nil then
    return mOnWDCache.appearanceID[cacheString]
  end

  local itemLink = o.createLink(itemID, linkDifficulty)
  local appID, _ = C_TransmogCollection.GetItemInfo(itemLink)

  if (appID ~= nil) then
    mOnWDCache.appearanceID[cacheString] = appID
    return appID
  end

  local source = o.getSourceID(itemID, linkDifficulty)
  if source then
    local _, appearanceID = C_TransmogCollection.GetAppearanceSourceInfo(source)
    mOnWDCache.appearanceID[cacheString] = appearanceID
    return appearanceID
  end
end

o.createLink = function(itemID, difficultyID, itemName)
  local itemString = "|cffff8000|Hitem:" .. itemID

  local difficultyPart = "0"
  if
    difficultyID == 2 or difficultyID == 5 or difficultyID == 6 or difficultyID == 11 or difficultyID == 15 or
      difficultyID == "H"
   then
    difficultyPart = "1:449"
  elseif difficultyID == 16 or difficultyID == 23 or difficultyID == "M" then
    difficultyPart = "1:450"
  elseif difficultyID == 7 or difficultyID == 17 or difficultyID == "LFR" then
    difficultyPart = "1:451"
  end

  itemString = itemString .. ":0:0:0:0:0:0:0:0:0:0:0:" .. difficultyPart .. ":0|h"
  itemString = itemString .. "[" .. (itemName or "Item") .. "]|h|r"
  return itemString
end

o.addAdditionalData = function(instances, useCoroutine)
  local counter = 0
  local blockSize = 50
  if instances == nil then
    instances = {}
  end

  for k, data in pairs(o.additionalData) do
    for instanceName, vv in pairs(o.categorization) do
      if vv[3] == k then
        for diff, diffData in pairs(data) do
          for source, itemIDs in pairs(diffData.items) do
            for i = 1, #itemIDs do
              local itemID = itemIDs[i]
              local appearanceID = o.getAppearanceID(itemID, diffData.linkDifficulty)
              if appearanceID and o.isArmorAppropriateForPlayer(itemID, diffData.linkDifficulty) then
                local sources = C_TransmogCollection.GetAppearanceSources(appearanceID)
                if sources then
                  local collected = o.isCollected(sources) and (mOnWDSave.completionistMode == false)
                  collected = collected or (o.isCollected(sources, itemID) and mOnWDSave.completionistMode)
                  if o.isBlacklisted(itemID) == false then
                    if instances[instanceName] == nil then
                      instances[instanceName] = {}
                      instances[instanceName]["collected"] = 0
                      instances[instanceName]["total"] = 0
                      instances[instanceName]["difficulties"] = {}
                    end

                    local diffs = o.difficulties[diff]
                    local foundDiff = nil
                    for j = 1, #diffs do
                      if instances[instanceName]["difficulties"][diffs[j]] then
                        foundDiff = diffs[j]
                      end
                    end
                    if foundDiff == nil then
                      foundDiff = diffs[1]
                    end

                    if instances[instanceName]["difficulties"][foundDiff] == nil then
                      instances[instanceName]["difficulties"][foundDiff] = {}
                      instances[instanceName]["difficulties"][foundDiff]["collected"] = 0
                      instances[instanceName]["difficulties"][foundDiff]["total"] = 0
                      instances[instanceName]["difficulties"][foundDiff]["bosses"] = {}
                    end

                    if instances[instanceName]["difficulties"][foundDiff]["bosses"][source] == nil then
                      instances[instanceName]["difficulties"][foundDiff]["bosses"][source] = {}
                      instances[instanceName]["difficulties"][foundDiff]["bosses"][source]["items"] = {}
                    end

                    if collected then
                      instances[instanceName]["collected"] = instances[instanceName]["collected"] + 1
                      instances[instanceName]["difficulties"][foundDiff]["collected"] =
                        instances[instanceName]["difficulties"][foundDiff]["collected"] + 1
                    else
                      table.insert(
                        instances[instanceName]["difficulties"][foundDiff]["bosses"][source]["items"],
                        {
                          link = o.createLink(itemID, diffData.linkDifficulty),
                          id = itemID,
                          visualID = appearanceID,
                          sourceID = sources[1].sourceID
                        }
                      )
                    end
                    instances[instanceName]["total"] = instances[instanceName]["total"] + 1
                    instances[instanceName]["difficulties"][foundDiff]["total"] =
                      instances[instanceName]["difficulties"][foundDiff]["total"] + 1
                  end
                end
              end
            end
          end

          if useCoroutine then
            counter = counter + 1
            if counter % blockSize == 0 then
              o.dotsString = o.dotsString .. "."
              if o.dotsString == "...." then
                o.dotsString = ""
              end
              coroutine.yield()
            end
          end
        end
      end
    end
  end

  return instances
end
