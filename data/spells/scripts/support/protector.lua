local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, 10000)
setConditionParam(condition, CONDITION_PARAM_SUBID, 4)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELDPERCENT, 220)
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
addCombatCondition(combat, condition)

local disable = createConditionObject(CONDITION_PACIFIED)
setConditionParam(disable, CONDITION_PARAM_TICKS, 10000)
addCombatCondition(combat, disable)

local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_SUBID, 1)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, 10000)
addCombatCondition(combat, exhaust)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
