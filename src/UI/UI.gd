class_name UI
extends Control

signal hover_finished
signal hovered_slot_selected

var active_side: int setget _set_active_side
var is_ch_being_selected := false

var _active_pane: UIPane

onready var selec_indic: TextureRect    = $SelectionIndicator
onready var left_pane:   PanelContainer = $SidePanes/LeftPane
onready var right_pane:  PanelContainer = $SidePanes/RightPane


func _ready() -> void:
	selec_indic.connect("move_finished", self, "_on_selec_indic_move_finished")
	_active_pane = left_pane


# CH DISPLAY
func update_ch_display(ch_dict: Dictionary) -> void:
	_active_pane.update_ch_display(ch_dict)


# CHARACTER SELECTION
func select_hovered_slot() -> void:
	is_ch_being_selected = true
	if selec_indic.ready_to_move:
		animate_selection()
		emit_signal("hovered_slot_selected")
	else:
		yield(selec_indic, "move_finished")
		animate_selection()
		emit_signal("hovered_slot_selected")
	selec_indic.ready_to_move = false
	is_ch_being_selected = false


func activate_action_view(avail_actions: Array) -> void:
	_active_pane.swap_to_action_view(avail_actions)


func deselect() -> void:
	_active_pane.swap_to_ch_select_view()
	selec_indic.ready_to_move = true


func animate_selection() -> void:
	#TODO
	pass


func move_hover_to(target_pos: Vector2) -> void:
	selec_indic.move_to(target_pos)


func reset_indic_to(pos: Vector2) -> void:
	selec_indic.warp_to(pos)


func _on_selec_indic_move_finished() -> void:
	if not is_ch_being_selected:
		selec_indic.ready_to_move = true
	emit_signal("hover_finished")


func is_ready_to_hover() -> bool:
	return selec_indic.ready_to_move


func _set_active_side(val: int) -> void:
	if not val in Side.values():
		printerr("Error setting active_side on UI.gd.")
		return
	
	active_side = val
	_active_pane = left_pane if active_side == Side.LEFT else right_pane
