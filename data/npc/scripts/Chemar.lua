 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Ask me if you need letters or parcels. I\'ll deliver them via airmail, of course!' },
	{ text = 'Feel the wind in your hair during one of my carpet rides!' }
}

npcHandler:addModule(VoiceModule:new(voices))


local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if msgcontains(msg, 'fly') then
			npcHandler:say('The different places we travel to are: {Svargrond}, {Femor Hills}, {Edron} and {Kazordoon}', cid)
			return true
	end
	return true
end


-- Travel
local function addTravelKeyword(keyword, text, cost, destination)
	if keyword == 'farmine' then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Never heard about a place like this.'}, function(player) return player:getStorageValue(Storage.TheNewFrontier.Mission10) ~= 1 end)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a ride to ' .. string.titleCase(keyword) .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Hold on!', cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'You shouldn\'t miss the experience.', reset = true})
end

-- addTravelKeyword('farmine', 'Farmine', 50, Position(32983, 31539, 1))
-- addTravelKeyword('darashia', 'Darashia on Darama', 50, Position(33270, 32441, 6))
-- addTravelKeyword('darama', 'Darashia on Darama', 50, Position(33270, 32441, 6))
addTravelKeyword('svargrond', 'Svargrond', 50, Position(32253, 31097, 4))
addTravelKeyword('femor', 'Femor Hills', 50, Position(32536, 31837, 4))
addTravelKeyword('hills', 'Femor Hills', 50, Position(32536, 31837, 4))
addTravelKeyword('edron', 'Edron', 50, Position(33193, 31784, 3))
addTravelKeyword('kazordoon', 'Kazordoon', 50, Position(32588, 31941, 0))
addTravelKeyword('kaz', 'Kazordoon', 50, Position(32588, 31941, 0))

npcHandler:setMessage(MESSAGE_GREET, 'Daraman\'s blessings, traveller |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'It was a pleasure to help you, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'It was a pleasure to help you, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
