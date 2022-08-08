local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)
combat:setArea(createCombatArea(AREA_CROSS6X6))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 6) + (maglevel * 4) + 32
	local max = (level / 7) + (maglevel * 11) + 40
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
