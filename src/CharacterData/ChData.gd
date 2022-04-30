class_name ChData
extends Resource


export var name := ""
export var max_health: int
export var max_stamina: int

var stats := {
	 "Name" : "Rodrigo",
	 "health" : max_health,
	"stamina" : max_stamina,
}

export var PWR: int
export var AGI: int
export var END: int
export var INT: int
export var WIS: int
export var CHA: int

var scores := [
		{ "label" : "PWR", "score" : PWR },
		{ "label" : "AGI", "score" : AGI },
		{ "label" : "END", "score" : END },
		{ "label" : "INT", "score" : INT },
		{ "label" : "WIS", "score" : WIS },
		{ "label" : "CHA", "score" : CHA },
	]
