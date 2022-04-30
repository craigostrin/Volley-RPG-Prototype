class_name ChData
extends Resource


export var name := ""
export var max_health: int
export var max_stamina: int

export var PWR: int
export var AGI: int
export var END: int
export var INT: int
export var WIS: int
export var CHA: int

onready var scores := [ PWR, AGI, END, INT, WIS, CHA ]


func get_ability_scores() -> Array:
	for score_block in scores:
		
