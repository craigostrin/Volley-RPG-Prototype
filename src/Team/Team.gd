class_name Team
extends Node2D


var side := Side.LEFT

onready var characters := get_children()
var weapons := []
var teammates := []


func _ready() -> void:
	setup_team()


func setup_team() -> void:
	for ch in characters:
		ch.side = side
		
		if ch.is_weapon:
			weapons.append(ch)
		else:
			teammates.append(ch)


func hover(ch_slot: int) -> void:
	var ch_to_hover: Character = characters[ch_slot]
	for ch in characters:
		if not ch == ch_to_hover:
			ch.set_is_hovered(false)
		else:
			ch.set_is_hovered(true)


func select(ch_slot: int) -> void:
	var ch_to_select: Character = characters[ch_slot]
	ch_to_select.set_is_selected(true)


func get_ch_stats() -> Array:
	var stats_array := []
	
	for ch in characters:
		stats_array.append(ch.stats)
	
	if stats_array.empty():
		printerr("Empty character array.")
	
	return stats_array
