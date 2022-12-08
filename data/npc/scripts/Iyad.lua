 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'A... aargh. I wish I had some e... earmuffs to put over this useless t... turban.' },
	{ text = 'Oh p.. please. P... lease let me fly us out of this c... cold.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, 'fly') then
			npcHandler:say('The different places we travel to are: {Darashia}, {Femor Hills}, {Edron} and {Kazordoon}', cid)
			return true
	end
	return true
end

-- Travel
local function addTravelKeyword(keyword, text, cost, destination)
	if keyword == 'farmine' then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Never heard about a place like this.'}, function(player) return player:getStorageValue(Storage.TheNewFrontier.Mission10) ~= 1 end)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a ride to ' .. text .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Hold on!', cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'You shouldn\'t miss the experience.', reset = true})
end

-- addTravelKeyword('farmine', 'Farmine', 50, Position(32983, 31539, 1))
addTravelKeyword('darashia', 'Darashia on Darama', 50, Position(33270, 32441, 6))
addTravelKeyword('darama', 'Darashia on Darama', 50, Position(33270, 32441, 6))
-- addTravelKeyword('svargrond', 'Svargrond', 50, Position(32253, 31097, 4))
addTravelKeyword('femor', 'Femor Hills', 50, Position(32536, 31837, 4))
addTravelKeyword('hills', 'Femor Hills', 50, Position(32536, 31837, 4))
addTravelKeyword('edron', 'Edron', 50, Position(33193, 31784, 3))
addTravelKeyword('kazordoon', 'Kazordoon', 50, Position(32588, 31941, 0))
addTravelKeyword('kaz', 'Kazordoon', 50, Position(32588, 31941, 0))

npcHandler:setMessage(MESSAGE_GREET, "Greetings, traveller |PLAYERNAME|. Where do you want me to {fly} you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
