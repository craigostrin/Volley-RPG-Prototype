extends Node

var _action_data: Dictionary


func _ready() -> void:
	# open file
	var file := File.new()
	file.open("res://action_database.json", file.READ)
	
	# parse content as json
	var content := file.get_as_text()
	_action_data = parse_json(content)


func get_value(action, field):
	if not _action_data.has(action):
		printerr("ActionDb does not contain that action.")
		return
	if not _action_data[action].has(field):
		printerr("ActionDb:" + action + " does not contain that field.")
		return
	
	return _action_data[action][field]
