class_name Team
extends Node2D


export(Side.Enum) var side := Side.LEFT
var slots: int

# Characters arranged by Vector2 slot
#   (0, 0) = slot 0, (1, 0) = slot 1
#   (0, 1) = slot 2, (1, 1) = slot 3
#   (0, 2) = slot 4, (1, 2) = slot 5
# There will always be a backline and frontline player (1 row)
var characters := {}
var weapons := []
var teammates := []


func get_characters() -> void:
	var ch_array := get_children()
	
	var i := 0
	for slot in slots:
		characters[Vector2( i % 2, floor(i / 2) )] = ch_array[i]
		i += 1


func setup_team() -> void:
	for ch in characters.values():
		ch.side = side
		
		if ch.is_weapon:
			weapons.append(ch)
		else:
			teammates.append(ch)


#func hover(ch_slot: Vector2) -> void:
#	var ch_to_hover: Character = characters[ch_slot]
#	for ch in characters.values():
#		if not ch == ch_to_hover:
#			ch.set_is_hovered(false)
#		else:
#			ch.set_is_hovered(true)


func select(ch_slot: Vector2) -> Array:
	var ch_to_select: Character = characters[ch_slot]
	ch_to_select.set_is_selected(true)
	
	var avail_actions := ch_to_select.get_avail_actions()
	return avail_actions


func get_ch_stats() -> Array:
	var stats_array := []
	
	for ch in characters:
		stats_array.append(ch.stats)
	
	if stats_array.empty():
		printerr("Empty character array.")
	
	return stats_array
