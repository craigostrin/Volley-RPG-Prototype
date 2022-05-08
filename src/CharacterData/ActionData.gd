class_name ActionData
extends Resource

#TODO what if they have less than 4 actions?

export var action1 := ""
export var uses1   := 10
export var desc1   := ""

export var action2 := ""
export var uses2   := 10
export var desc2   := ""

export var action3 := ""
export var uses3   := 10
export var desc3   := ""

export var action4 := ""
export var uses4   := 10
export var desc4   := ""


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
	
	return actions
