local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

keywordHandler:addKeyword({'sell bow'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't buy used bows."})
keywordHandler:addKeyword({'sell crossbow'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't buy used crossbows."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am nothing but a humble fletcher. I am selling bows, crossbows, and ammunition. Do you need any of these?"})
keywordHandler:addKeyword({'fletcher'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am nothing but a humble fletcher. I am selling bows, crossbows, and ammunition. Do you need any of these?"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Edoch Ibn Ibrach."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You surely can buy a watch somewhere on this bazaar."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The world is vast and dangerous. Better prepare yourself with a bow before you travel out there."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I was there once to learn about their ways. Needless to say I was horrified and returned to Darashia as soon as possible."})

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'arrow'}, 					Cfarrow, 3)
shopModule:addBuyableItem({'power bolt'}, 					Cfpowerbolt, 7)
shopModule:addBuyableItem({'bow'}, 					Cfbow, 400)
shopModule:addSellableItem({'bow'}, 					Cfbow, 100)
shopModule:addBuyableItem({'bolt'}, 					Cfbolt, 4)
shopModule:addBuyableItem({'crossbow'}, 					Cfcrossbow, 500)
shopModule:addSellableItem({'crossbow'}, 					Cfcrossbow, 500)
shopModule:addBuyableItem({'spear'}, 					Cfspear, 9)

npcHandler:addModule(FocusModule:new())