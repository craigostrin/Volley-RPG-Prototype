class_name ActionData
extends Resource


export var action1 := ""
export var uses1   := 10

export var action2 := ""
export var uses2   := 10

export var action3 := ""
export var uses3   := 10

export var action4 := ""
export var uses4   := 10


func get_actions() -> Array:
	return [
		{ "label" : action1, "max_uses" : uses1 },
		{ "label" : action2, "max_uses" : uses2 },
		{ "label" : action3, "max_uses" : uses3 },
		{ "label" : action4, "max_uses" : uses4 },
	]
