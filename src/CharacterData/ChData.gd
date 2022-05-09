class_name ChData
extends Resource

# Characters are either weapons (benders) or teammates
# Weapons have an elemental type, and they excel at those types of actions
# FIRE : Attacking (spiking, morale)
# AIR  : Setting   (accuracy, timing, speed, trick plays)
# EARTH: Defense   (receiving, blocking)
# WATER: Cohesion  (morale, resources, recovery)

# Abilities are the skill scores

enum Type {
	FIRE,
	AIR,
	EARTH,
	WATER
}

export var name := ""
export var max_health: int
export var max_stamina: int
export var max_morale: int
export(Type) var type

# PLACEHOLDERS FOR THE REAL SHIT
# elements listed in order of helpfulness (primary, secondary)
export var spiking: int     # HIT   - fire, air, 
export var passing: int     # PASS  - earth, water
export var setting: int     # SET   - air, water
export var digging: int    # BLOC  - earth, air
export var agility: int      # CLUT  - air, fire
export var endurance: int      # SPRT  - water, any can be secondary


func get_stats() -> Dictionary:
	return {
		   "name" : name,
	 "max_health" : max_health,
	"max_stamina" : max_stamina,
	 "max_morale" : max_morale
}

func get_ability_scores() -> Array:
	return [
		{ "label" : "SPK"  , "score" : spiking  },
		{ "label" : "PAS"  , "score" : passing  },
		{ "label" : "SET"  , "score" : setting  },
		{ "label" : "DIG"  , "score" : digging  },
		{ "label" : "AGI"  , "score" : agility  },
		{ "label" : "END"  , "score" : endurance}
	]
