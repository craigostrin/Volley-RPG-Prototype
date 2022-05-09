class_name ActionData
extends Resource

# Phases = SERVE, RECEIVE, SET, SPIKE

export var action1 := ""
export var uses1   := 10
export var desc1   := ""
export var phases  := []

export var action2 := ""
export var uses2   := 10
export var desc2   := ""

export var action3 := ""
export var uses3   := 10
export var desc3   := ""

export var action4 := ""
export var uses4   := 10
export var desc4   := ""

export var action5 := ""
export var uses5   := 10
export var desc5   := ""

export var action6 := ""
export var uses6   := 10
export var desc6   := ""


func get_actions() -> Array:
	var actions := []
	
	if not action1 == "":
		actions.append(
			{ "label" : action1, "max_uses" : uses1 , "description" : desc1 }
		)
	if not action2 == "":
		actions.append(
			{ "label" : action2, "max_uses" : uses2 , "description" : desc2 }
		)
	if not action3 == "":
		actions.append(
			{ "label" : action3, "max_uses" : uses3 , "description" : desc3 }
		)
	if not action4 == "":
		actions.append(
			{ "label" : action4, "max_uses" : uses4 , "description" : desc4 }
		)
	if not action5 == "":
		actions.append(
			{ "label" : action5, "max_uses" : uses5 , "description" : desc5 }
		)
	if not action6 == "":
		actions.append(
			{ "label" : action6, "max_uses" : uses6 , "description" : desc6 }
		)
	
	return actions
