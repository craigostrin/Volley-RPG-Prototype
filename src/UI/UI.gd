class_name UI
extends Control

signal hover_finished
signal hovered_slot_selected

var _active_side: int = Side.LEFT

onready var selec_indic: TextureRect = $SelectionIndicator


func _ready() -> void:
	selec_indic.connect("move_finished", self, "_on_selec_indic_move_finished")


# STAT DISPLAY
func update_stats(ch_dict: Dictionary) -> void:
	# update ch stat display on hover finished
	pass


# CHARACTER SELECTION
func select_hovered_slot() -> void:
	if selec_indic.ready_to_move:
		animate_selection()
		emit_signal("hovered_slot_selected")
	else:
		yield(selec_indic, "move_finished")
		animate_selection()
		emit_signal("hovered_slot_selected")


func animate_selection() -> void:
	#TODO
	pass


func move_hover_to(target_pos: Vector2) -> void:
	selec_indic.move_to(target_pos)


func reset_indic_to(pos: Vector2) -> void:
	selec_indic.warp_to(pos)


func _on_selec_indic_move_finished() -> void:
	emit_signal("hover_finished")
