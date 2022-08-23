function onLogin(cid)
        if isPremium(cid) == TRUE then
                if getPlayerStorageValue(cid, 90907) == -1 then
                   setPlayerStorageValue(cid, 90907, 1)
                end
        elseif isPremium(cid) == FALSE then
                if getPlayerStorageValue(cid, 90907) == 1 then
                   setPlayerStorageValue(cid, 90907, -1)
                   doPlayerSetTown(cid, 2)
                   doTeleportThing(cid, {x = 32369, y = 32241, z = 7, stackpos = 1}, TRUE)
				   doPlayerSendTextMessage(cid, 22, "You have been teleported to Thais. Your premium has expired")
                end
        end
        return TRUE
end